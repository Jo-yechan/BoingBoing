#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include "servo.h"

int main() {
    int fd, input1, input2;
    char line[100];
    printf("========================================\n");
    printf(" Dual SG-90 Servo Motor Control\n");
    printf(" GPIO18 (Motor1) & GPIO19 (Motor2)\n");
    printf("========================================\n");
    // 디바이스 파일 열기
    fd = open(DEVICE_PATH, O_WRONLY);
    if (fd < 0) {
        perror("Failed to open /dev/servo");
        printf("\nTroubleshooting:\n");
        printf("1. Check if driver is loaded: lsmod | grep servo\n");
        printf("2. Load driver: sudo insmod servo_driver.ko\n");
        printf("3. Check device file: ls -l /dev/servo\n");
        return 1;
    }
    printf("Device opened successfully!\n");
    printf("Enter two values 0-100 separated by space (or 'q' to quit)\n");
    printf(" 0 = 0° (full left)\n");
    printf(" 50 = 90° (center)\n");
    printf(" 100 = 180° (full right)\n");
    printf("----------------------------------------\n\n");
    // 메인 루프
    while (1) {
        printf("Enter Motor1 Motor2 (0-100 0-100) or 'q' to quit: ");
        fflush(stdout);
        if (fgets(line, sizeof(line), stdin) == NULL) {
            break;
        }
        line[strcspn(line, "\n")] = 0;
        if (strcmp(line, "q") == 0 || strcmp(line, "Q") == 0) {
            printf("Exiting...\n");
            break;
        }
        // 두 개의 숫자 파싱
        char *token1 = strtok(line, " ");
        char *token2 = strtok(NULL, " ");
        if (token1 == NULL || token2 == NULL) {
            printf("Error: Please enter two values separated by space\n");
            printf("Example: 50 75\n\n");
            continue;
        }
        char *endptr1, *endptr2;
        input1 = strtol(token1, &endptr1, 10);
        input2 = strtol(token2, &endptr2, 10);
        if (*endptr1 != '\0' || *endptr2 != '\0') {
            printf("Error: Invalid input (not numbers)\n\n");
            continue;
        }
        // 서보 제어
        if (set_servo_angles(fd, input1, input2) == 0) {
            usleep(100000);
        }
        printf("\n");
    }
    // 종료 전 중립 위치로 이동
    printf("\nResetting both servos to center position...\n");
    set_servo_angles(fd, 50, 50);
    close(fd);
    printf("Device closed. Goodbye!\n");
    return 0;
}
