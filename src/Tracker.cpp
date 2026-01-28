#include <pybind11/embed.h>
#include <pybind11/stl.h>
#include "Tracker.h"
#include "servo.h"
#include "led.h"
#include <iostream>

namespace py = pybind11;
using namespace std;
using namespace cv;

// 설정 파라미터
#define DEAD_ZONE 20
#define KP_X 0.008
#define KP_Y 0.008
#define PAN_MIN 0
#define PAN_MAX 100
#define TILT_MIN 30
#define TILT_MAX 100
#define DIR_X -1
#define DIR_Y -1

static double clamp(double value, double min, double max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
}

static void update_servos(SharedContext* ctx, int error_x, int error_y) {
    bool moved = false;
    if (abs(error_x) > DEAD_ZONE) {
        ctx->current_pan += (error_x * KP_X * DIR_X);
        moved = true;
    }
    if (abs(error_y) > DEAD_ZONE) {
        ctx->current_tilt += (error_y * KP_Y * DIR_Y);
        moved = true;
    }
    if (moved) {
        ctx->current_pan = clamp(ctx->current_pan, PAN_MIN, PAN_MAX);
        ctx->current_tilt = clamp(ctx->current_tilt, TILT_MIN, TILT_MAX);
        if (ctx->servo_fd >= 0) {
            set_servo_angles(ctx->servo_fd, (int)ctx->current_pan, (int)ctx->current_tilt);
        }
    }
}

void process_tracking_loop(SharedContext* ctx) {
    // 1. 파이썬 인터프리터 초기화
    py::scoped_interpreter guard{}; 
    py::module_ sys = py::module_::import("sys");
    sys.attr("path").cast<py::list>().append("."); // 현재 경로 추가

    // 2. detector.py의 FaceDetector 클래스 로드
    py::object detector;
    try {
        py::module_ detector_mod = py::module_::import("detector");
        detector = detector_mod.attr("FaceDetector")();
    } catch (py::error_already_set &e) {
        cerr << "Python Error: " << e.what() << endl;
        return;
    }

    VideoCapture cap(0, CAP_V4L2); // V4L2 백엔드를 강제로 씁니다.

    if (!cap.isOpened()) {
        cerr << "Error: Could not open camera!" << endl;
        return;
    }

    // ★ 핵심: MJPG로 압축해서 받으면 메모리 에러 해결됨
    cap.set(CAP_PROP_FOURCC, VideoWriter::fourcc('M', 'J', 'P', 'G'));

    // 해상도
    cap.set(CAP_PROP_FRAME_WIDTH, 640);
    cap.set(CAP_PROP_FRAME_HEIGHT, 480);
    cap.set(CAP_PROP_FPS, 30);

    Mat frame;
    cout << ">> C++ Main Loop with MediaPipe Started..." << endl;

    while (ctx->is_running) {
        cap >> frame;
        if (frame.empty()) break;

        // 3. 파이썬 감지 함수 호출
        py::list result = detector.attr("detect")(
            py::memoryview::from_memory(frame.data, frame.total() * frame.elemSize()),
            frame.rows, frame.cols
        );

        bool detected = result[0].cast<bool>();
        int obj_x = result[1].cast<int>();
        int obj_y = result[2].cast<int>();

        if (detected) {
            led_on();
            int errX = obj_x - (frame.cols / 2);
            int errY = obj_y - (frame.rows / 2);
            update_servos(ctx, errX, errY);
            
            // 시각화
            rectangle(frame, Rect(obj_x-50, obj_y-50, 100, 100), Scalar(0, 255, 0), 2);
        } else {
            led_off();
        }

        // 프레임 공유
        {
            lock_guard<mutex> lock(ctx->frame_mutex);
            ctx->latest_frame = frame.clone();
        }
        this_thread::sleep_for(chrono::milliseconds(10));
    }
}