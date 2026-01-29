# Face Tracking Camera System

라즈베리 파이 기반 자동 얼굴 추적 카메라 시스템입니다. MediaPipe를 활용한 실시간 얼굴 감지와 서보 모터를 통한 카메라 자동 추적 기능을 제공합니다.

## 📋 목차

- [프로젝트 개요](#-프로젝트-개요)
- [주요 기능](#-주요-기능)
- [빠른 시작](#-빠른-시작)
- [시스템 요구사항](#-시스템-요구사항)
- [하드웨어 구성](#-하드웨어-구성)
- [소프트웨어 의존성](#-소프트웨어-의존성)
- [설치 방법](#-설치-방법)
- [사용 방법](#-사용-방법)
- [프로젝트 구조](#-프로젝트-구조)
- [설정 및 조정](#-설정-및-조정)
- [문제 해결](#-문제-해결)

## 🎯 프로젝트 개요

이 프로젝트는 사람의 얼굴을 자동으로 감지하고, 카메라 중앙에 얼굴이 위치하도록 서보 모터를 제어하는 시스템입니다. 
웹 브라우저를 통해 실시간 영상을 스트리밍하며, 얼굴 감지 시 LED로 상태를 표시합니다.

## ✨ 주요 기능

- **실시간 얼굴 감지**: MediaPipe를 활용한 빠르고 정확한 얼굴 인식
- **자동 카메라 추적**: 2축 서보 모터(Pan/Tilt)를 이용한 얼굴 자동 추적
- **웹 스트리밍**: HTTP 서버를 통한 실시간 영상 스트리밍 (포트 8080)
- **LED 상태 표시**: 얼굴 감지 여부를 LED로 시각적 피드백
- **커스텀 리눅스 드라이버**: 서보 모터 및 LED 제어를 위한 커널 모듈

## 🚀 빠른 시작

이미 설정이 완료된 경우:

```bash
# 1. src 디렉토리로 이동
cd src

# 2. 드라이버 로드 및 빌드
sudo ./init_drivers.sh

# 3. 프로그램 실행
cd ../exe
sudo ./auto_tracker

# 4. 브라우저에서 확인
# http://<라즈베리파이_IP>:8080

# 5. 종료 후 정리 (src 디렉토리에서)
cd ../src
sudo ./exit_drivers.sh
```

## 💻 시스템 요구사항

- **하드웨어**: Raspberry Pi (3/4/5 권장)
- **OS**: Raspberry Pi OS (Bullseye 이상)
- **카메라**: 라즈베리파이 카메라모듈 V2
- **메모리**: 최소 2GB RAM 권장

## 🔧 하드웨어 구성

### GPIO 핀 연결

| 부품 | GPIO 핀 | 설명 |
|------|---------|------|
| 서보 모터 1 (Pan) | GPIO 18 (PWM0) | 좌우 회전 |
| 서보 모터 2 (Tilt) | GPIO 19 (PWM1) | 상하 회전 |
| LED | GPIO 21 | 얼굴 감지 표시등 |

### 서보 모터 사양
- 모델: SG-90 (또는 호환 모델)
- 동작 각도: 0° ~ 180°
- PWM 주기: 20ms (50Hz)
- 펄스 폭: 0.5ms (0°) ~ 2.5ms (180°)

## 📦 소프트웨어 의존성

### 시스템 패키지
```bash
sudo apt-get update
sudo apt-get install -y \
    build-essential \
    cmake \
    git \
    pkg-config \
    python3-dev \
    python3-pip \
    libopencv-dev
```

### Python 라이브러리
```bash
pip3 install mediapipe opencv-python numpy --break-system-packages
```

### OpenCV 빌드
프로젝트에는 OpenCV 4.1.2 및 opencv_contrib가 포함되어 있습니다.
(이미 빌드되어 있다고 가정합니다)

### pybind11
```bash
pip3 install pybind11
```

## 🚀 설치 방법

### 1. PWM 오버레이 설정

`/boot/config.txt` 파일을 편집하여 PWM을 활성화합니다:

```bash
sudo nano /boot/config.txt
```

수정 내용:
```
# dtparam=audio=on  <-- 이 줄을 주석 처리하거나 off로 변경
dtoverlay=pwm-2chan,pin=18,func=2,pin2=19,func2=2
```

재부팅:
```bash
sudo reboot
```

### 2. 프로젝트 디렉토리 이동

```bash
cd /path/to/project/src
```

### 3. 빌드 및 드라이버 로드

프로젝트에 포함된 초기화 스크립트를 실행합니다:

```bash
sudo ./init_drivers.sh
```

이 스크립트는 다음 작업을 수행합니다:
- 프로젝트 빌드 (Makefile 실행)
- 기존 드라이버 제거
- 서보 드라이버 로드 (`servo_driver.ko`)
- LED 드라이버 로드 (`led_driver.ko`)
- 디바이스 파일 권한 설정 (`/dev/servo`, `/dev/led`)
- 실행 파일이 `../exe/auto_tracker`에 생성됩니다

## 🎮 사용 방법

### 빌드 및 드라이버 로드

src 디렉토리에서:

```bash
cd src
sudo ./init_drivers.sh
```

### 프로그램 실행

exe 디렉토리로 이동하여 실행:

```bash
cd ../exe
./auto_tracker
```

또는 src 디렉토리에서 직접:

```bash
../exe/auto_tracker
```

### 웹 인터페이스 접속

브라우저에서 다음 주소로 접속:
```
http://<라즈베리파이_IP>:8080
```

또는 로컬에서:
```
http://localhost:8080
```

### 프로그램 종료

`Ctrl + C`를 눌러 프로그램을 종료합니다.

### 드라이버 정리

프로그램 종료 후 드라이버를 언로드하고 빌드 파일을 정리하려면:

```bash
cd src
sudo ./exit_drivers.sh
```

이 스크립트는 다음 작업을 수행합니다:
- LED 드라이버 언로드 (`rmmod led_driver`)
- 서보 드라이버 언로드 (`rmmod servo_driver`)
- 빌드 파일 정리 (`make clean`)

## 📁 프로젝트 구조

```
project/
├── src/                  # 소스 코드 디렉토리
│   ├── main.cpp          # 메인 프로그램 (서보 초기화, 스레드 시작, 웹서버 실행)
│   ├── Tracker.cpp       # 얼굴 추적 로직 (MediaPipe + PID 제어)
│   ├── WebStream.cpp     # HTTP 서버 및 MJPEG 스트리밍
│   ├── servo.c           # 서보 제어 함수 (사용자 공간)
│   ├── servo_driver.c    # 서보 커널 드라이버 (PWM 제어)
│   ├── led.c             # LED 제어 함수 (사용자 공간)
│   ├── led_driver.c      # LED 커널 드라이버 (GPIO 제어)
│   ├── detector.py       # MediaPipe 얼굴 감지 모듈
│   ├── init_drivers.sh   # 빌드 및 드라이버 로드 스크립트
│   ├── exit_drivers.sh   # 드라이버 언로드 및 정리 스크립트
│   └── Makefile          # 빌드 설정 파일
│
├── inc/                  # 헤더 파일 디렉토리
│   ├── Tracker.h         # 얼굴 추적 헤더
│   ├── WebStream.h       # 웹 스트리밍 헤더
│   ├── Shared.h          # 공유 데이터 구조체 정의
│   ├── servo.h           # 서보 제어 헤더
│   ├── led.h             # LED 제어 헤더
│   └── httplib.h         # HTTP 서버 라이브러리 (cpp-httplib)
│
├── opencv/               # OpenCV 빌드 디렉토리
│   ├── opencv-4.1.2/     # OpenCV 소스 코드
│   └── opencv_contrib-4.1.2/  # OpenCV 추가 모듈
│
└── exe/                  # 실행 파일 디렉토리
    └── auto_tracker      # 컴파일된 실행 파일
```

## ⚙️ 설정 및 조정

### Tracker.cpp 내 파라미터

`src/Tracker.cpp` 파일을 편집하여 추적 동작을 조정할 수 있습니다:

```cpp
#define DEAD_ZONE 20        // 중앙 허용 오차 (픽셀)
#define KP_X 0.008          // Pan 축 비례 게인
#define KP_Y 0.008          // Tilt 축 비례 게인
#define PAN_MIN 0           // Pan 최소값 (0-100)
#define PAN_MAX 100         // Pan 최대값 (0-100)
#define TILT_MIN 30         // Tilt 최소값 (0-100)
#define TILT_MAX 100        // Tilt 최대값 (0-100)
#define DIR_X -1            // Pan 방향 (1 또는 -1)
#define DIR_Y -1            // Tilt 방향 (1 또는 -1)
```

### 초기 서보 위치

`inc/Shared.h`에서 초기 위치를 변경할 수 있습니다:

```cpp
SharedContext() : servo_fd(-1), current_pan(50.0), current_tilt(65.0), is_running(true) {}
```

### 카메라 해상도

`src/Tracker.cpp`에서 해상도를 조정:

```cpp
cap.set(CAP_PROP_FRAME_WIDTH, 640);
cap.set(CAP_PROP_FRAME_HEIGHT, 480);
cap.set(CAP_PROP_FPS, 30);
```

### GPIO 핀 변경

GPIO 핀을 변경하려면:
- **LED 핀**: `src/led_driver.c`의 `LED_GPIO_PIN` 수정
- **서보 핀**: `/boot/config.txt`의 PWM 오버레이 설정 수정

## 🔍 문제 해결

### 드라이버 로드 실패

**증상**: `init_drivers.sh` 실행 시 드라이버 로드 실패

**해결방법**:
1. PWM 오버레이가 제대로 설정되었는지 확인
   ```bash
   sudo cat /boot/config.txt | grep pwm
   ```
2. 재부팅 후 재시도
3. 커널 로그 확인
   ```bash
   sudo dmesg | tail -20
   ```

### 카메라 열기 실패

**증상**: "Error: Could not open camera!"

**해결방법**:
1. 카메라 연결 확인
   ```bash
   ls /dev/video*
   ```
2. 카메라 권한 확인
   ```bash
   sudo usermod -aG video $USER
   ```
3. 다른 프로그램에서 카메라를 사용 중인지 확인

### 디바이스 파일 접근 권한 오류

**증상**: "Failed to open /dev/servo"

**해결방법**:
```bash
sudo chmod 666 /dev/servo
sudo chmod 666 /dev/led
```

또는 `init_drivers.sh`를 다시 실행

### 서보 모터가 움직이지 않음

**해결방법**:
1. GPIO 연결 확인 (18번, 19번 핀)
2. 서보 모터 전원 공급 확인 (5V, 충분한 전류)
3. 드라이버 로드 확인
   ```bash
   lsmod | grep servo
   ```

### LED가 켜지지 않음

**해결방법**:
1. GPIO 21번 핀 연결 확인
2. LED 극성 확인 (긴 다리: +, 짧은 다리: -)
3. 적절한 저항 사용 (220Ω ~ 1kΩ 권장)

### Python 모듈 import 오류

**증상**: "ModuleNotFoundError: No module named 'mediapipe'"

**해결방법**:
```bash
pip3 install mediapipe opencv-python numpy
```

### 메모리 부족 에러

**증상**: 실행 중 프로그램이 종료됨

**해결방법**:
1. MJPG 압축 사용 확인 (Tracker.cpp에 이미 적용됨)
2. 해상도 낮추기 (640x480 → 320x240)
3. 스왑 메모리 증가
   ```bash
   sudo dphys-swapfile swapoff
   sudo nano /etc/dphys-swapfile  # CONF_SWAPSIZE=1024
   sudo dphys-swapfile setup
   sudo dphys-swapfile swapon
   ```

## 📝 추가 정보

### 서보 각도 범위 설명

- **value1, value2**: 0~100 범위의 값
- **실제 각도**: 0~180도로 변환
- **value2 (Tilt)**: 반전 적용 (100 → 0도, 0 → 180도)

### 웹 스트리밍 프로토콜

- **형식**: MJPEG (Motion JPEG)
- **경로**: `/video`
- **업데이트 주기**: 약 30fps (33ms 간격)

## 📄 라이선스

각 컴포넌트의 라이선스:
- 커널 드라이버: GPL
- OpenCV: Apache 2.0
- MediaPipe: Apache 2.0
- cpp-httplib: MIT

## 👥 기여

버그 리포트나 기능 제안은 이슈로 등록해주세요.

## 🙏 감사의 말

- OpenCV 커뮤니티
- MediaPipe 팀
- cpp-httplib 개발자

---

**개발 환경**: Raspberry Pi OS, OpenCV 4.1.2, MediaPipe, C++17, Python 3  
**최종 업데이트**: 2026-01-29
