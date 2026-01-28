CUR_DIR = .
INC_DIR = ../inc
OBJ_DIR = ../obj
EXE_DIR = ../exe

TARGET_APP = $(EXE_DIR)/auto_tracker

# 커널 모듈
obj-m += servo_driver.o led_driver.o
KDIR := /lib/modules/$(shell uname -r)/build
PWD  := $(shell pwd)

# 소스 설정
SRCS_CPP = main.cpp Tracker.cpp WebStream.cpp
SRCS_C   = servo.c led.c
OBJS = $(addprefix $(OBJ_DIR)/, $(SRCS_CPP:.cpp=.o)) $(addprefix $(OBJ_DIR)/, $(SRCS_C:.c=.o))

# 컴파일 플래그 (Python Embedding 필수 설정)
CXX = g++
# 핵심: -fPIC를 추가합니다.
PY_CFLAGS = $(shell python3-config --cflags) -I/home/iam/.local/lib/python3.9/site-packages/pybind11/include
PY_LDFLAGS = $(shell python3-config --ldflags --embed)

# CXXFLAGS 맨 앞에 -fPIC 추가
CXXFLAGS = -fPIC -I. -I$(INC_DIR) $(shell pkg-config --cflags opencv4) $(PY_CFLAGS) -Wall -O2
LDFLAGS = $(shell pkg-config --libs opencv4) $(PY_LDFLAGS) -lpthread

.PHONY: all clean modules app

all: modules app

modules:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

app: $(TARGET_APP)

$(TARGET_APP): $(OBJS)
	@mkdir -p $(EXE_DIR)
	$(CXX) -o $@ $(OBJS) $(LDFLAGS)

$(OBJ_DIR)/%.o: %.cpp
	@mkdir -p $(OBJ_DIR)
	$(CXX) -c $< -o $@ $(CXXFLAGS)

$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(OBJ_DIR)
	$(CXX) -c $< -o $@ $(CXXFLAGS)

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
	rm -rf $(OBJ_DIR)/*.o $(TARGET_APP) *.ko