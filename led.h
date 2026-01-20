// led.h
#ifndef LED_H
#define LED_H

// 함수 선언
int led_init(void);                 // LED 장치 열기
void led_on(int fd);                // LED 켜기
void led_off(int fd);               // LED 끄기
void led_close(int fd);             // LED 장치 닫기

#endif // LED_H
