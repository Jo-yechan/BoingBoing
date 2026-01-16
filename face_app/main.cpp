#include <opencv2/opencv.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/objdetect.hpp>
#include <iostream>
#include <vector>
#include "httplib.h"

using namespace std;
using namespace cv;
using namespace httplib;

// ==========================================
// [팀원 공유용] 서보모터 제어를 위한 오차 변수
// ==========================================
// errX > 0 : 얼굴이 화면 오른쪽 -> 카메라를 오른쪽으로 돌려야 함
// errX < 0 : 얼굴이 화면 왼쪽 -> 카메라를 왼쪽으로 돌려야 함
// errY > 0 : 얼굴이 화면 아래쪽 -> 카메라를 아래로 내려야 함
// errY < 0 : 얼굴이 화면 위쪽 -> 카메라를 위로 올려야 함
int errX = 0;
int errY = 0;
// ==========================================

String face_cascade_name = "/usr/local/share/opencv4/haarcascades/haarcascade_frontalface_alt.xml";
String eyes_cascade_name = "/usr/local/share/opencv4/haarcascades/haarcascade_eye.xml";
CascadeClassifier face_cascade;
CascadeClassifier eyes_cascade;
VideoCapture cap;

void detectAndDraw(Mat& frame) {
    vector<Rect> faces;
    Mat frame_gray;

    cvtColor(frame, frame_gray, COLOR_BGR2GRAY);
    equalizeHist(frame_gray, frame_gray);

    // 얼굴 검출
    face_cascade.detectMultiScale(frame_gray, faces, 1.1, 2, 0 | CASCADE_SCALE_IMAGE, Size(30, 30));

    // 화면의 중심 좌표 구하기
    Point center_of_frame(frame.cols / 2, frame.rows / 2);

    // 화면 중앙에 파란색 십자가 그리기 (기준점 확인용)
    line(frame, Point(center_of_frame.x - 10, center_of_frame.y), Point(center_of_frame.x + 10, center_of_frame.y), Scalar(255, 0, 0), 2);
    line(frame, Point(center_of_frame.x, center_of_frame.y - 10), Point(center_of_frame.x, center_of_frame.y + 10), Scalar(255, 0, 0), 2);

    // 얼굴이 감지되지 않았을 때는 오차를 0으로 초기화 (선택 사항)
    if (faces.empty()) {
        errX = 0;
        errY = 0;
    }

    for (size_t i = 0; i < faces.size(); i++) {
        // 1. 얼굴에 초록색 사각형 그리기
        rectangle(frame, faces[i], Scalar(0, 255, 0), 2);

        // 2. 얼굴의 중심 좌표 구하기
        Point center_of_face(faces[i].x + faces[i].width / 2, faces[i].y + faces[i].height / 2);
        
        // 얼굴 중심에 빨간 점 찍기
        circle(frame, center_of_face, 5, Scalar(0, 0, 255), -1);

        // 3. 오차(Error) 계산: [얼굴 중심] - [화면 중심]
        errX = center_of_face.x - center_of_frame.x;
        errY = center_of_face.y - center_of_frame.y;

        // 4. 화면 중심에서 얼굴 중심까지 노란선 그리기 (오차 시각화)
        line(frame, center_of_frame, center_of_face, Scalar(0, 255, 255), 2);

        // 5. 터미널에 오차 값 출력 (디버깅용)
        // 실제 서보모터 팀원은 이 errX, errY 변수 값을 가져다 쓰면 됩니다.
        printf("Face detected! Error X: %d, Error Y: %d\n", errX, errY);

        // (옵션) 눈 검출 로직은 그대로 유지
        Mat faceROI = frame_gray(faces[i]);
        vector<Rect> eyes;
        eyes_cascade.detectMultiScale(faceROI, eyes, 1.1, 2, 0 | CASCADE_SCALE_IMAGE, Size(30, 30));
        for (size_t j = 0; j < eyes.size(); j++) {
            Point eye_center(faces[i].x + eyes[j].x + eyes[j].width / 2, faces[i].y + eyes[j].y + eyes[j].height / 2);
            int radius = cvRound((eyes[j].width + eyes[j].height) * 0.25);
            circle(frame, eye_center, radius, Scalar(255, 0, 0), 4);
        }
        
        // 여러 얼굴이 잡혀도 첫 번째(보통 가장 큰) 얼굴만 추적하고 반복문 종료
        // (서보모터가 여러 명을 동시에 따라갈 순 없으므로)
        break; 
    }
}

int main(int argc, char** argv) {
    if (!face_cascade.load(face_cascade_name)) { printf("--(!)Error loading face cascade\n"); return -1; }
    if (!eyes_cascade.load(eyes_cascade_name)) { printf("--(!)Error loading eyes cascade\n"); return -1; }

    cap.open(0);
    if (!cap.isOpened()) { printf("--(!)Error opening video capture\n"); return -1; }

    // 프레임 크기를 줄이면 처리 속도(FPS)가 빨라집니다. (권장)
    cap.set(CAP_PROP_FRAME_WIDTH, 320);
    cap.set(CAP_PROP_FRAME_HEIGHT, 240);

    Server svr;

    svr.Get("/", [](const Request& req, Response& res) {
        res.set_content("Go to <a href='/video'>/video</a> to see the tracking stream.", "text/html");
    });

    svr.Get("/video", [&](const Request& req, Response& res) {
        res.set_content_provider(
            "multipart/x-mixed-replace; boundary=frame",
            [&](size_t offset, DataSink& sink) {
                Mat frame;
                cap >> frame;
                if (frame.empty()) return false;

                detectAndDraw(frame); // 여기서 errX, errY가 계속 갱신됩니다.

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

    printf("Web Server started at http://localhost:8080/video\n");
    svr.listen("0.0.0.0", 8080);
    return 0;
}
