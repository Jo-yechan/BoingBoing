// Shared.h
#ifndef SHARED_H
#define SHARED_H

#include <opencv2/opencv.hpp>
#include <mutex>
#include <atomic>

// 스레드 간 공유할 데이터 컨텍스트
struct SharedContext {
    int servo_fd;               // 서보 드라이버 파일 디스크립터
    double current_pan;         // 현재 Pan 각도
    double current_tilt;        // 현재 Tilt 각도
    
    cv::Mat latest_frame;       // 웹으로 보낼 최신 프레임
    std::mutex frame_mutex;     // 프레임 보호용 뮤텍스
    std::atomic<bool> is_running; // 프로그램 종료 플래그

    SharedContext() : servo_fd(-1), current_pan(50.0), current_tilt(65.0), is_running(true) {}
};

#endif
