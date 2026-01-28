// main.cpp
#include <iostream>
#include <fcntl.h>
#include <unistd.h>
#include <thread>
#include "Shared.h"
#include "Tracker.h"
#include "WebStream.h"
#include "servo.h"
#include "led.h"       // ★ [필수] LED 헤더 포함

using namespace std;

int main() {
    // 1. 공유 컨텍스트 생성
    SharedContext ctx;

    // 2. 서보 드라이버 열기
    ctx.servo_fd = open("/dev/servo", O_WRONLY);
    if (ctx.servo_fd < 0) {
        cerr << "Error: Failed to open /dev/servo. (Try: sudo chmod 666 /dev/servo)" << endl;
        return -1;
    }

    // ★ [수정 1] ctx에 넣지 않고 독립적으로 초기화
    if (led_init() < 0) {
        cout << "Warning: LED init failed (Check /dev/led)" << endl;
    }

    // 초기 위치 설정
    set_servo_angles(ctx.servo_fd, (int)ctx.current_pan, (int)ctx.current_tilt);

    // 3. 트래킹 스레드 시작
    thread tracker_thread(process_tracking_loop, &ctx);
    tracker_thread.detach();

    // 4. 웹 서버 시작 (블로킹)
    start_web_server(&ctx, 8080);

    // 5. 종료 처리
    ctx.is_running = false;
    if (tracker_thread.joinable()) tracker_thread.join();
    
    // ★ [수정 2] 인자 없이 깔끔하게 호출
    led_off();
    led_close();

    close(ctx.servo_fd);

    return 0;
}
