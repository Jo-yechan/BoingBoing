// servo_random.c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include "servo.h"  // 기존 헤더 파일 재사용

// ==========================================
// [설정] 여기 숫자를 수정하세요
// ==========================================
int total_moves = 5;       // 랜덤 동작을 수행할 횟수
int delay_ms = 1000;       // 동작 사이의 대기 시간 (밀리초 단위, 1000 = 1초)
// ==========================================

int main() {
    int fd;
    int i;
    int val1, val2;

    // 랜덤값 생성을 위한 시드 초기화 (현재 시간 기준)
    srand(time(NULL));

    // 디바이스 파일 열기
    fd = open(DEVICE_PATH, O_WRONLY);
    if (fd < 0) {
        perror("Failed to open /dev/servo");
        return 1;
    }

    printf("=== Random Servo Control Started ===\n");
    printf("Total moves: %d, Delay: %d ms\n\n", total_moves, delay_ms);

    for (i = 0; i < total_moves; i++) {
        // 0 ~ 100 사이의 랜덤 값 생성
        val1 = rand() % 101; 
        val2 = rand() % 101;

        printf("[%d/%d] Generated Random Values: %d %d\n", i + 1, total_moves, val1, val2);

        // 서보 제어 (servo.c에 있는 함수 사용 - 반전 로직 자동 적용됨)
        set_servo_angles(fd, val1, val2);

        // 설정한 시간만큼 대기 (마이크로초 단위이므로 * 1000)
        usleep(delay_ms * 1000);
    }

    // 종료 전 안전하게 중앙(50, 50)으로 복귀
    printf("\nDone! Resetting to center (50 50).\n");
    set_servo_angles(fd, 50, 50);

    close(fd);
    return 0;
}
