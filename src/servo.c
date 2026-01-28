// servo.c
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include "servo.h"

int set_servo_angles(int fd, int value1, int value2) {
    if (value1 < 0 || value1 > 100 || value2 < 0 || value2 > 100) {
        printf("Error: Input out of range (0-100)\n");
        return -1;
    }

    // [수정 후] 19번 핀(value2) 반전
    int angle1 = value1 * 180 / 100;              // 18번: 정방향 (0->0도, 100->180도)
    int angle2 = (100 - value2) * 180 / 100;      // 19번: 역방향 (0->180도, 100->0도)

    // "angle1 angle2" 형식으로 전송
    char buf[32];
    int len = snprintf(buf, sizeof(buf), "%d %d", angle1, angle2);

    if (write(fd, buf, len) != len) {
        perror("Failed to write angles to servo");
        return -1;
    }

    printf("✓ Motor 1 (Pin 18): %d%% (angle: %d°)\n", value1, angle1);
    printf("✓ Motor 2 (Pin 19): %d%% (angle: %d°)\n", value2, angle2);

    return 0;
}
