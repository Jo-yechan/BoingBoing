#!/bin/bash

echo ">>> 드라이버 초기화를 시작합니다..."

# 1. 혹시 이미 켜져 있다면 제거 (에러 무시)
sudo rmmod servo_driver 2>/dev/null
sudo rmmod led_driver 2>/dev/null

# 2. 서보 드라이버 로드
if sudo insmod servo_driver.ko; then
    echo "✓ servo_driver 로드됨"
else
    echo "✗ servo_driver 로드 실패! (파일이 있는지 확인하세요)"
    exit 1
fi

# 3. LED 드라이버 로드
if sudo insmod led_driver.ko; then
    echo "✓ led_driver 로드됨"
else
    echo "✗ led_driver 로드 실패!"
    exit 1
fi

# 4. 권한 설정 (핵심! 이거 안 하면 실행할 때 에러 남)
# 디바이스가 생성될 때까지 아주 잠깐 대기
sleep 0.1
sudo chmod 666 /dev/servo
sudo chmod 666 /dev/led

echo "✓ 권한 설정 완료 (chmod 666)"
echo ">>> 준비 완료! ./auto_tracker 를 실행하세요."
