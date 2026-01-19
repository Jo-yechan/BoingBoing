// servo.h
#ifndef SERVO_H
#define SERVO_H

#define DEVICE_PATH "/dev/servo"
// [핵심] C++ 컴파일러(g++)가 볼 때만 이 부분이 작동하도록 함
#ifdef __cplusplus
extern "C" {
#endif

// 여기에 C 함수들을 선언합니다
int set_servo_angles(int fd, int value1, int value2);

// [핵심] C++일 때 닫는 괄호
#ifdef __cplusplus
}
#endif

#endif
