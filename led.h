// led.h
#ifndef LED_H
#define LED_H

#ifdef __cplusplus
extern "C" {
#endif

// (void) 로 변경됨
int led_init(void);
void led_on(void);
void led_off(void);
void led_close(void);

#ifdef __cplusplus
}
#endif

#endif
