#!/bin/bash

echo "========================================"
echo ">>> 빌드 및 드라이버 초기화 시작..."
echo "========================================"

# 1. make 실행
echo ""
echo "[1/4] 빌드 중..."
if make; then
    echo "✓ 빌드 성공"
else
    echo "✗ 빌드 실패! 중단합니다."
    exit 1
fi

echo ""
echo "[2/4] 기존 드라이버 제거 중..."
# 2. 혹시 이미 켜져 있다면 제거 (에러 무시)
sudo rmmod servo_driver 2>/dev/null && echo "  - servo_driver 제거됨" || echo "  - servo_driver 없음"
sudo rmmod led_driver 2>/dev/null && echo "  - led_driver 제거됨" || echo "  - led_driver 없음"

echo ""
echo "[3/4] 드라이버 로드 중..."
# 3. 서보 드라이버 로드
if sudo insmod servo_driver.ko; then
    echo "✓ servo_driver 로드됨"
else
    echo "✗ servo_driver 로드 실패! (파일이 있는지 확인하세요)"
    exit 1
fi

# 4. LED 드라이버 로드
if sudo insmod led_driver.ko; then
    echo "✓ led_driver 로드됨"
else
    echo "✗ led_driver 로드 실패!"
    exit 1
fi

echo ""
echo "[4/4] 디바이스 권한 설정 중..."
# 5. 권한 설정 (핵심! 이거 안 하면 실행할 때 에러 남)
# 디바이스가 생성될 때까지 아주 잠깐 대기
sleep 0.1
sudo chmod 666 /dev/servo
sudo chmod 666 /dev/led

echo "✓ 권한 설정 완료 (chmod 666)"
echo ""
echo "========================================"
echo ">>> 모든 준비 완료!"
echo ">>> 실행: ../exe/auto_tracker"
echo "========================================"