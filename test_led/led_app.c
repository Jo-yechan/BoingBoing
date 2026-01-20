// led_app.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "led.h"  // 우리가 만든 헤더 포함

void print_usage(const char *prog_name) {
    printf("Usage: %s <on|off|blink>\n", prog_name);
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        print_usage(argv[0]);
        return 1;
    }

    // 1. LED 초기화 (장치 열기)
    int fd = led_init();
    if (fd < 0) {
        return 1; // 실패 시 종료
    }

    // 2. 명령행 인자에 따라 동작 수행
    if (strcmp(argv[1], "on") == 0) {
        led_on(fd);
        printf("LED turned ON\n");
    } 
    else if (strcmp(argv[1], "off") == 0) {
        led_off(fd);
        printf("LED turned OFF\n");
    } 
    else if (strcmp(argv[1], "blink") == 0) {
        printf("Blinking LED (Press Ctrl+C to stop)...\n");
        while (1) {
            led_on(fd);
            sleep(1);
            led_off(fd);
            sleep(1);
        }
    } 
    else {
        print_usage(argv[0]);
        led_close(fd); // 종료 전 닫기
        return 1;
    }

    // 3. LED 장치 닫기 (정리)
    led_close(fd);
    return 0;
}
