// servo.h
#ifndef SERVO_H
#define SERVO_H

#define DEVICE_PATH "/dev/servo"

int set_servo_angles(int fd, int value1, int value2);

#endif // SERVO_H
