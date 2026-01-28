// led.c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include "led.h"

// ★ 주의: led_driver.c의 DEVICE_NAME과 일치해야 함!
#define DEVICE_PATH "/dev/led"

// 이 파일 내부에서만 사용하는 '숨겨진' 전역 변수
static int led_fd = -1;

int led_init(void) {
    // 1. 이미 열려있으면 닫고 다시 열기 (안전장치)
    if (led_fd >= 0) {
        close(led_fd);
    }

    // 2. static 변수(led_fd)에 직접 저장
    led_fd = open(DEVICE_PATH, O_WRONLY);
    
    if (led_fd < 0) {
        perror("LED Driver Open Failed");
        return -1;
    }
    
    return 0; // 성공 시 0 반환 (fd를 밖으로 꺼내지 않음)
}

// 인자가 없어진 것 확인하세요!
void led_on(void) {
    if (led_fd >= 0) {
        char buf = '1';
        write(led_fd, &buf, 1);
    }
}

// 인자가 없어진 것 확인하세요!
void led_off(void) {
    if (led_fd >= 0) {
        char buf = '0';
        write(led_fd, &buf, 1);
    }
}

// 인자가 없어진 것 확인하세요!
void led_close(void) {
    if (led_fd >= 0) {
        // 끄고 닫는 것이 안전함
        char buf = '0';
        write(led_fd, &buf, 1);
        
        close(led_fd);
        led_fd = -1; // 초기화
    }
}
