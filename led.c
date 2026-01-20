// led.c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include "led.h"

// ★ 주의: led_driver.c의 DEVICE_NAME과 일치해야 함!
#define DEVICE_PATH "/dev/led" 

int led_init(void) {
    int fd = open(DEVICE_PATH, O_WRONLY);
    if (fd < 0) {
        perror("LED Driver Open Failed");
        return -1;
    }
    return fd;
}

void led_on(int fd) {
    // 드라이버에 '1'을 써서 켬
    char buf = '1';
    write(fd, &buf, 1);
}

void led_off(int fd) {
    // 드라이버에 '0'을 써서 끔
    char buf = '0';
    write(fd, &buf, 1);
}

void led_close(int fd) {
    if (fd >= 0) {
        close(fd);
    }
}
