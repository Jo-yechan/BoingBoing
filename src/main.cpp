#include <iostream>
#include <fcntl.h>
#include <unistd.h>
#include <thread>
#include "Shared.h"
#include "Tracker.h"
#include "WebStream.h"
#include "servo.h"
#include "led.h"

using namespace std;

int main() {
    // 1. 공유 컨텍스트 생성
    SharedContext ctx;

    // 2. 서보 드라이버 열기 (에러가 났던 servo_init 대신 직접 open 사용)
    ctx.servo_fd = open("/dev/servo", O_WRONLY);
    if (ctx.servo_fd < 0) {
        cerr << "Error: Failed to open /dev/servo. (Try: sudo chmod 666 /dev/servo)" << endl;
        return -1;
    }

    // 3. LED 초기화
    if (led_init() < 0) {
        cout << "Warning: LED init failed (Check /dev/led)" << endl;
    }

    // 초기 위치 설정 (50, 70 등 원하는 초기값)
    set_servo_angles(ctx.servo_fd, (int)ctx.current_pan, (int)ctx.current_tilt);

    // 4. 트래킹 스레드 시작 (이 안에서 파이썬 MediaPipe가 돌아감)
    thread tracker_thread(process_tracking_loop, &ctx);
    tracker_thread.detach();

    // 5. 웹 서버 시작 (8080 포트)
    cout << ">> Web Server starting on port 8080..." << endl;
    start_web_server(&ctx, 8080);

    // 6. 종료 처리
    ctx.is_running = false;
    
    led_off();
    led_close();
    if (ctx.servo_fd >= 0) close(ctx.servo_fd);

    return 0;
}