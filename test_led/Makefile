# 커널 모듈 대상
obj-m += led_driver.o

# 변수 설정
KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)
APP := led_app

# ★ 수정된 부분: led_app을 만들 때 led_app.c와 led.c를 같이 컴파일
APP_SRCS := led_app.c led.c
CC := gcc

all: driver app

# 커널 모듈 빌드
driver:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

# 유저 앱 빌드
app:
	$(CC) -o $(APP) $(APP_SRCS)

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
	rm -f $(APP)
