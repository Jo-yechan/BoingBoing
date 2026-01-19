# 커널 모듈
obj-m += servo_driver.o

# 사용자 앱 1: 수동 제어
APP_MAIN = servo_app
APP_MAIN_SRCS = servo_app.c servo.c
APP_MAIN_OBJS = $(APP_MAIN_SRCS:.c=.o)

# 사용자 앱 2: 랜덤 제어 (추가됨)
APP_RANDOM = servo_random_app
APP_RANDOM_SRCS = servo_random_app.c servo.c
APP_RANDOM_OBJS = $(APP_RANDOM_SRCS:.c=.o)

KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

.PHONY: all clean

# 'make' 입력 시 모듈과 두 앱 모두 빌드
all: modules $(APP_MAIN) $(APP_RANDOM)

# 커널 모듈 빌드
modules:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

# 사용자 앱 1 빌드 (servo_app)
$(APP_MAIN): $(APP_MAIN_OBJS)
	gcc -o $(APP_MAIN) $(APP_MAIN_OBJS)

# 사용자 앱 2 빌드 (servo_random)
$(APP_RANDOM): $(APP_RANDOM_OBJS)
	gcc -o $(APP_RANDOM) $(APP_RANDOM_OBJS)

# 공통 오브젝트 파일 규칙 (.c -> .o)
%.o: %.c
	gcc -c $< -o $@

# 정리 (모듈 및 두 앱 모두 삭제)
clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
	$(RM) $(APP_MAIN) $(APP_MAIN_OBJS)
	$(RM) $(APP_RANDOM) $(APP_RANDOM_OBJS)
