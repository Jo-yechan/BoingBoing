// tracker_wrapper.cpp
#include <pybind11/pybind11.h>
#include "servo.h" // 기존 servo.h
#include "led.h"   // 기존 led.h
#include <cmath>
#include <iostream>
#include <fcntl.h> 

namespace py = pybind11;

// --- 기존 설정 파라미터 ---
#define DEAD_ZONE 20
#define KP_X 0.005
#define KP_Y 0.008
#define PAN_MIN 0
#define PAN_MAX 100
#define TILT_MIN 55
#define TILT_MAX 100
#define DIR_X -1
#define DIR_Y -1

// Helper 함수
static double clamp(double value, double min, double max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
}

// 하드웨어 제어 클래스 (Python에서 이 클래스를 생성해서 사용)
class HardwareController {
public:
    int servo_fd = -1;
    double current_pan = 50.0;
    double current_tilt = 70.0;

    HardwareController() {
        // 1. LED 초기화
        if (led_init() < 0) {
            std::cerr << "[C++] Warning: LED init failed\n";
        }

        // 2. 서보 초기화 (기존 main.cpp 방식 적용)
        servo_fd = open("/dev/servo", O_WRONLY); 
        if (servo_fd < 0) {
            std::cerr << "[C++] Error: Failed to open /dev/servo.\n";
        } else {
            // 초기 위치 설정
            set_servo_angles(servo_fd, (int)current_pan, (int)current_tilt);
        }
        
        std::cout << "[C++] Hardware Controller Initialized.\n";
    }

    ~HardwareController() {
        // 소멸자에서 정리
        led_off();
        if (servo_fd >= 0) {
            // servo_close(servo_fd); // 필요시 구현
        }
        std::cout << "[C++] Hardware Controller Released." << std::endl;
    }

    // Python에서 얼굴 감지 결과를 받아 서보/LED를 업데이트하는 함수
    void update(bool face_detected, int error_x, int error_y) {
        if (face_detected) {
            led_on();

            bool moved = false;
            // X축 이동
            if (std::abs(error_x) > DEAD_ZONE) {
                current_pan += (error_x * KP_X * DIR_X);
                moved = true;
            }
            // Y축 이동
            if (std::abs(error_y) > DEAD_ZONE) {
                current_tilt += (error_y * KP_Y * DIR_Y);
                moved = true;
            }

            if (moved) {
                current_pan = clamp(current_pan, PAN_MIN, PAN_MAX);
                current_tilt = clamp(current_tilt, TILT_MIN, TILT_MAX);

                if (servo_fd >= 0) {
                    set_servo_angles(servo_fd, (int)current_pan, (int)current_tilt);
                }
            }
        } else {
            led_off();
        }
    }
};

// Pybind11 모듈 정의
PYBIND11_MODULE(tracker_hw, m) {
    m.doc() = "Face Tracker Hardware Controller Plugin";

    py::class_<HardwareController>(m, "Controller")
        .def(py::init<>())
        .def("update", &HardwareController::update, 
             "Update servos based on face detection",
             py::arg("face_detected"), py::arg("error_x"), py::arg("error_y"));
}