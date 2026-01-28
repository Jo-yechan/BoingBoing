# ==========================================
# 1. 디렉터리 설정 (src/Makefile 기준)
# ==========================================
CUR_DIR = .
INC_DIR = ../inc
OBJ_DIR = ../obj
EXE_DIR = ../exe

# ==========================================
# 2. 파일 및 타겟 설정
# ==========================================

# 최종 실행 파일 경로 및 이름
TARGET_APP = $(EXE_DIR)/auto_tracker

# 커널 모듈 빌드 대상 (확장자는 .o로 적어야 .ko가 생성됨)
obj-m += servo_driver.o led_driver.o

# 소스 파일 목록 (현재 src 폴더 내)
SRCS_CPP = main.cpp Tracker.cpp WebStream.cpp
SRCS_C   = servo.c led.c

# 오브젝트 파일 목록 (소스 파일을 ../obj 폴더 경로의 .o 파일로 매핑)
# 예: main.cpp -> ../obj/main.o
OBJS  = $(addprefix $(OBJ_DIR)/, $(SRCS_CPP:.cpp=.o))
OBJS += $(addprefix $(OBJ_DIR)/, $(SRCS_C:.c=.o))

# 컴파일러 및 플래그 설정
CXX      = g++
# -I$(INC_DIR) 추가: ../inc 폴더의 헤더파일을 참조함
CXXFLAGS = -I. -I$(INC_DIR) $(shell pkg-config --cflags opencv4) -Wall -O2
LDFLAGS  = $(shell pkg-config --libs opencv4) -lpthread

# 커널 모듈 빌드 경로 설정
KDIR := /lib/modules/$(shell uname -r)/build
PWD  := $(shell pwd)

# ==========================================
# 3. 빌드 규칙
# ==========================================

.PHONY: all clean modules app

# 'make' 입력 시 실행되는 기본 타겟
all: modules app

# 3-1. 커널 모듈 빌드 (.ko 파일은 현재 src 폴더에 생성됨)
# KBUILD_EXTRA_SYMBOLS를 사용하여 .o 파일을 obj 디렉터리로 이동
modules:
	@mkdir -p $(OBJ_DIR)
	$(MAKE) -C $(KDIR) M=$(PWD) modules
	@echo "  정리 중: .o 파일들을 $(OBJ_DIR)로 이동"
	@mv -f *.o $(OBJ_DIR)/ 2>/dev/null || true
	@mv -f .*.cmd $(OBJ_DIR)/ 2>/dev/null || true
	@mv -f *.mod $(OBJ_DIR)/ 2>/dev/null || true
	@mv -f *.mod.c $(OBJ_DIR)/ 2>/dev/null || true
	@mv -f Module.symvers $(OBJ_DIR)/ 2>/dev/null || true
	@mv -f modules.order $(OBJ_DIR)/ 2>/dev/null || true
	@echo "✓ 커널 모듈 빌드 완료 (.ko 파일만 src에 유지)"

# 3-2. C++ 앱 빌드
app: $(TARGET_APP)

# 최종 실행 파일 링크 (오브젝트 파일들을 합침)
$(TARGET_APP): $(OBJS)
	@echo "  MKDIR   $(EXE_DIR)"
	@mkdir -p $(EXE_DIR)
	@echo "  LINK    $@"
	@$(CXX) -o $@ $(OBJS) $(LDFLAGS)

# C++ 소스 컴파일 규칙 (../obj 폴더에 .o 생성)
$(OBJ_DIR)/%.o: %.cpp
	@echo "  MKDIR   $(OBJ_DIR)"
	@mkdir -p $(OBJ_DIR)
	@echo "  CXX     $<"
	@$(CXX) -c $< -o $@ $(CXXFLAGS)

# C 소스 컴파일 규칙 (../obj 폴더에 .o 생성)
$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(OBJ_DIR)
	@echo "  CXX(C)  $<"
	@$(CXX) -c $< -o $@ $(CXXFLAGS)

# ==========================================
# 4. 정리 (Clean)
# ==========================================
clean:
	@echo "Cleaning up..."
	$(MAKE) -C $(KDIR) M=$(PWD) clean
	rm -f *.ko
	rm -f $(OBJ_DIR)/*
	rm -f $(EXE_DIR)/*
	@echo "✓ 정리 완료 (obj, exe 디렉터리는 유지)"