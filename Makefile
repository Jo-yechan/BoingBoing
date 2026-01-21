# ==========================================
# 1. 설정 변수
# ==========================================

# 최종 실행 파일 이름
TARGET_APP = auto_tracker

# 커널 모듈 빌드 대상 (확장자는 .o로 적어야 .ko가 생성됨)
# 여기에 led_driver.o 추가됨
obj-m += servo_driver.o led_driver.o

# 빌드 부산물(.o 파일 등)을 모아둘 폴더
BUILD_DIR = build

# 소스 파일 목록
# (C++ 파일과 C 파일을 구분해서 등록)
SRCS_CPP = main.cpp Tracker.cpp WebStream.cpp
# 여기에 led.c 추가됨
SRCS_C   = servo.c led.c

# 오브젝트 파일 목록 (소스 파일을 build 폴더 경로의 .o 파일로 매핑)
# 예: main.cpp -> build/main.o
OBJS  = $(addprefix $(BUILD_DIR)/, $(SRCS_CPP:.cpp=.o))
OBJS += $(addprefix $(BUILD_DIR)/, $(SRCS_C:.c=.o))

# 컴파일러 및 플래그 설정
CXX      = g++
CXXFLAGS = -I. $(shell pkg-config --cflags opencv4) -Wall -O2
LDFLAGS  = $(shell pkg-config --libs opencv4) -lpthread

# 커널 모듈 빌드 경로 설정
KDIR := /lib/modules/$(shell uname -r)/build
PWD  := $(shell pwd)

# ==========================================
# 2. 빌드 규칙
# ==========================================

.PHONY: all clean modules app

# 'make' 입력 시 실행되는 기본 타겟
all: modules app

# 2-1. 커널 모듈 빌드
modules:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

# 2-2. C++ 앱 빌드 (auto_tracker)
app: $(TARGET_APP)

# 최종 실행 파일 링크 (오브젝트 파일들을 합침)
$(TARGET_APP): $(OBJS)
	@echo "  LINK    $@"
	@$(CXX) -o $@ $(OBJS) $(LDFLAGS)

# C++ 소스 컴파일 규칙 (build 폴더에 .o 생성)
$(BUILD_DIR)/%.o: %.cpp
	@mkdir -p $(BUILD_DIR)
	@echo "  CXX     $<"
	@$(CXX) -c $< -o $@ $(CXXFLAGS)

# C 소스 컴파일 규칙 (build 폴더에 .o 생성)
# servo.c, led.c를 C++ 프로젝트와 섞어 쓰므로 g++로 컴파일하여 링크 에러 방지
$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(BUILD_DIR)
	@echo "  CXX(C)  $<"
	@$(CXX) -c $< -o $@ $(CXXFLAGS)

# ==========================================
# 3. 정리 (Clean)
# ==========================================
clean:
	@echo "Cleaning up..."
	$(MAKE) -C $(KDIR) M=$(PWD) clean
	rm -rf $(BUILD_DIR)
	rm -f $(TARGET_APP)
