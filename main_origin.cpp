// main.cpp
#include <iostream>
#include <fcntl.h>
#include <unistd.h>
#include <thread>
#include "Shared.h"
#include "Tracker.h"
#include "WebStream.h"
#include "servo.h"

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

    // 초기 위치 설정
    set_servo_angles(ctx.servo_fd, (int)ctx.current_pan, (int)ctx.current_tilt);

    // 3. 트래킹 스레드 시작
    thread tracker_thread(process_tracking_loop, &ctx);
    tracker_thread.detach();

    // 4. 웹 서버 시작 (여기서 블로킹 됨)
    start_web_server(&ctx, 8080);

    // 5. 종료 처리 (실제로는 웹서버가 종료되면 도달)
    ctx.is_running = false;
    if (tracker_thread.joinable()) tracker_thread.join();
    close(ctx.servo_fd);

    return 0;
}
