#include <opencv2/opencv.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/objdetect.hpp>
#include <iostream>
#include <vector>
#include <fcntl.h>      // 파일 제어
#include <unistd.h>     // close 함수 등
#include "httplib.h"    // 웹 서버 헤더
#include "servo.h"      // 서보 모터 제어 헤더
using namespace std;
using namespace cv;
using namespace httplib;
// ==========================================
// [설정] 서보 트래킹 파라미터
// ==========================================
#define DEAD_ZONE 20       // 오차 허용 범위 (픽셀)
#define KP_X 0.03          // X축 민감도
#define KP_Y 0.03          // Y축 민감도
// ★ [수정됨] 각 모터별 범위 분리 설정 ★
// 18번 핀 (Pan/X축/좌우) 범위: 0 ~ 100
#define PAN_MIN 0
#define PAN_MAX 100
// 19번 핀 (Tilt/Y축/상하) 범위: 30 ~ 70 (원하는 만큼 줄이세요)
#define TILT_MIN 55       // 너무 아래로 안 내려가게 제한
#define TILT_MAX 100        // 너무 위로 안 올라가게 제한
// 방향 설정 (-1 or 1)
#define DIR_X -1
#define DIR_Y 1
// 서보 제어 변수 (초기값 50, 50)
int servo_fd = -1;
double current_pan = 50.0;
double current_tilt = 50.0;
// OpenCV 변수
String face_cascade_name = "/usr/share/opencv4/haarcascades/haarcascade_frontalface_alt.xml";
CascadeClassifier face_cascade;
VideoCapture cap;
// ==========================================
// [함수] 값 범위 제한 유틸리티
// ==========================================
double clamp(double value, double min, double max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
}
// ==========================================
// [함수] 서보 모터 이동 로직
// ==========================================
void update_servos(int error_x, int error_y) {
    bool moved = false;
    // 1. X축 (Pan) 이동 계산
    if (abs(error_x) > DEAD_ZONE) {
        current_pan += (error_x * KP_X * DIR_X);
        moved = true;
    }
    // 2. Y축 (Tilt) 이동 계산
    if (abs(error_y) > DEAD_ZONE) {
        current_tilt += (error_y * KP_Y * DIR_Y);
        moved = true;
    }
    if (moved) {
        // ★ [수정됨] 각 축별로 다른 제한값 적용 ★
        current_pan = clamp(current_pan, PAN_MIN, PAN_MAX);    // 18번 핀 (0~100)
        current_tilt = clamp(current_tilt, TILT_MIN, TILT_MAX); // 19번 핀 (30~70)
        // 실제 드라이버로 값 전송
        if (servo_fd >= 0) {
            // 정수로 변환하여 전달
            set_servo_angles(servo_fd, (int)current_pan, (int)current_tilt);
        }
    }
}
// ==========================================
// [함수] 얼굴 검출 및 오차 계산
// ==========================================
void detectAndDraw(Mat& frame) {
    vector<Rect> faces;
    Mat frame_gray;
    cvtColor(frame, frame_gray, COLOR_BGR2GRAY);
    equalizeHist(frame_gray, frame_gray);
    // 얼굴 검출
    face_cascade.detectMultiScale(frame_gray, faces, 1.1, 2, 0 | CASCADE_SCALE_IMAGE, Size(30, 30));
    // 화면 중심 좌표
    int center_x = frame.cols / 2;
    int center_y = frame.rows / 2;
    int errX = 0;
    int errY = 0;
    if (!faces.empty()) {
        // 첫 번째 얼굴만 추적
        Rect face = faces[0];
        // 시각화 (웹 화면용 박스 그리기)
        rectangle(frame, face, Scalar(0, 255, 0), 2);
        // 얼굴 중심 좌표
        int obj_x = face.x + face.width / 2;
        int obj_y = face.y + face.height / 2;
        // 오차 계산
        errX = obj_x - center_x;
        errY = obj_y - center_y;
        // 시각화: 중심점 및 연결선
        circle(frame, Point(obj_x, obj_y), 5, Scalar(0, 0, 255), -1);
        line(frame, Point(center_x, center_y), Point(obj_x, obj_y), Scalar(0, 255, 255), 2);
        // 서보모터 업데이트 요청
        update_servos(errX, errY);
    }
}
// ==========================================
// [Main]
// ==========================================
int main(int argc, char** argv) {
    // 1. 서보 드라이버 열기
    servo_fd = open("/dev/servo", O_WRONLY);
    if (servo_fd < 0) {
        printf("Error: Failed to open /dev/servo. (Try: sudo chmod 666 /dev/servo)\n");
        return -1;
    }
    // 초기화: 중앙(50, 50)으로 이동.
    // 만약 50이 TILT 범위 밖이라면 초기값을 수정하세요.
    set_servo_angles(servo_fd, 50, 50);
    // 2. Cascade 로드
    if (!face_cascade.load(face_cascade_name)) {
        if (!face_cascade.load("haarcascade_frontalface_alt.xml")) {
             printf("--(!)Error loading face cascade\n");
             return -1;
        }
    }
    // 3. 카메라 열기
    cap.open(0);
    if (!cap.isOpened()) { printf("--(!)Error opening video capture\n"); return -1; }
    cap.set(CAP_PROP_FRAME_WIDTH, 640);
    cap.set(CAP_PROP_FRAME_HEIGHT, 640);
    // 4. 웹 서버 설정
    Server svr;
    svr.Get("/", [](const Request& req, Response& res) {
        res.set_content("<html><body><h1>Servo Face Tracker</h1><img src='/video' style='width:640px;'></body></html>", "text/html");
    });
    svr.Get("/video", [&](const Request& req, Response& res) {
        res.set_content_provider(
            "multipart/x-mixed-replace; boundary=frame",
            [&](size_t offset, DataSink& sink) {
                Mat frame;
                cap >> frame;
                if (frame.empty()) return false;
                // 감지 및 서보 이동
                detectAndDraw(frame);
                // 이미지 인코딩 (JPG)
                vector<uchar> buffer;
                imencode(".jpg", frame, buffer);
                string part_header = "--frame\r\nContent-Type: image/jpeg\r\n\r\n";
                sink.write(part_header.c_str(), part_header.size());
                sink.write(reinterpret_cast<const char*>(buffer.data()), buffer.size());
                sink.write("\r\n", 2);
                return true;
            }
        );
    });
    printf("Web Server started at http://localhost:8080\n");
    svr.listen("0.0.0.0", 8080);
    // 종료 처리
    close(servo_fd);
    return 0;
}