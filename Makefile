# 빌드할 커널 모듈 목록 (확장자는 .o로 적어야 .ko가 생성됩니다)
obj-m += servo_driver.o led_driver.o

# 커널 빌드 경로 및 현재 경로 변수
KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

.PHONY: all clean

# 기본 타겟: 모듈 빌드만 실행
all: modules

# 커널 모듈 빌드 규칙
modules:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

# 정리(Clean) 규칙
clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
