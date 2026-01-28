#!/bin/bash

echo "========================================"
echo ">>> 드라이버 제거 및 정리 시작..."
echo "========================================"

echo ""
echo "[1/2] 드라이버 언로드 중..."
# 1. LED 드라이버 제거
# (2>/dev/null은 에러 메시지를 숨기는 기능입니다. 이미 없으면 조용히 넘어갑니다.)
sudo rmmod led_driver 2>/dev/null
if [ $? -eq 0 ]; then
    echo "✓ led_driver 제거 완료"
else
    echo "! led_driver가 이미 없거나 제거에 실패했습니다."
fi

# 2. 서보 드라이버 제거
sudo rmmod servo_driver 2>/dev/null
if [ $? -eq 0 ]; then
    echo "✓ servo_driver 제거 완료"
else
    echo "! servo_driver가 이미 없거나 제거에 실패했습니다."
fi

echo ""
echo "[2/2] 빌드 파일 정리 중..."
# 3. make clean 실행
if make clean; then
    echo "✓ 빌드 파일 정리 완료"
else
    echo "! make clean 실패 (이미 정리되었을 수 있음)"
fi

echo ""
echo "========================================"
echo ">>> 모든 정리 완료!"
echo "========================================"