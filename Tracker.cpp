// Tracker.cpp
#include "Tracker.h"
#include "servo.h"
#include "led.h"       // ★ [추가] LED 헤더
#include <iostream>
#include <vector>
#include <unistd.h>
#include <thread>

using namespace std;
using namespace cv;

// --- 설정 파라미터 ---
#define DEAD_ZONE 20
#define KP_X 0.005
#define KP_Y 0.008
#define PAN_MIN 0
#define PAN_MAX 100
#define TILT_MIN 55
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
    String face_cascade_name = "/usr/share/opencv4/haarcascades/haarcascade_frontalface_alt.xml";
    CascadeClassifier face_cascade;
    
    if (!face_cascade.load(face_cascade_name)) {
        if (!face_cascade.load("haarcascade_frontalface_alt.xml")) {
             cerr << "--(!)Error loading face cascade\n";
             return;
        }
    }

    VideoCapture cap(0);
    if (!cap.isOpened()) {
        cerr << "--(!)Error opening video capture\n";
        return;
    }
    cap.set(CAP_PROP_FRAME_WIDTH, 640);
    cap.set(CAP_PROP_FRAME_HEIGHT, 640);

    Mat frame, frame_gray;
    vector<Rect> faces;

    cout << ">> Tracking Thread Started..." << endl;

    while (ctx->is_running) {
        cap >> frame;
        if (frame.empty()) break;

        cvtColor(frame, frame_gray, COLOR_BGR2GRAY);
        equalizeHist(frame_gray, frame_gray);

        face_cascade.detectMultiScale(frame_gray, faces, 1.1, 2, 0 | CASCADE_SCALE_IMAGE, Size(30, 30));

        int center_x = frame.cols / 2;
        int center_y = frame.rows / 2;

        // ★ [수정] 감지 여부에 따른 LED 제어
        if (!faces.empty()) {
            led_on();   // 인자 없이 호출
            
            Rect face = faces[0];
            rectangle(frame, face, Scalar(0, 255, 0), 2);
            
            int obj_x = face.x + face.width / 2;
            int obj_y = face.y + face.height / 2;
            int errX = obj_x - center_x;
            int errY = obj_y - center_y;

            circle(frame, Point(obj_x, obj_y), 5, Scalar(0, 0, 255), -1);
            line(frame, Point(center_x, center_y), Point(obj_x, obj_y), Scalar(0, 255, 255), 2);

            update_servos(ctx, errX, errY);
        } 
        else {
            led_off();  // 인자 없이 호출
        }

        {
            lock_guard<mutex> lock(ctx->frame_mutex);
            ctx->latest_frame = frame.clone();
        }
        
        this_thread::sleep_for(chrono::milliseconds(10));
    }
}
