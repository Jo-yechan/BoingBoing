#include "web.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <locale.h>

static pthread_t web_thread;
static pthread_t cmd_thread;

void signal_handler(int sig) {
    (void)sig;
    is_run = 0;
    printf("\n서버 종료.\n");
    exit(0);
}

int main() {
    setlocale(LC_ALL, "ko_KR.UTF-8");
    signal(SIGINT, signal_handler);
    
    system("fuser -k -n tcp 8080 9090 > /dev/null 2>&1");

    pthread_create(&web_thread, NULL, web_server_thread, NULL);
    pthread_create(&cmd_thread, NULL, cmd_server_thread, NULL);

    printf("\n========================================\n");
    printf("🚀 서버 실행 중! (Ctrl+C로 종료)\n");
    printf("1. 웹 접속: 브라우저 주소창에 라즈베리파이 IP:8080\n");
    printf("2. 메시지 입력: 터미널에 입력 후 엔터\n");
    printf("========================================\n\n");

    char input[BUFFER_SIZE];
    while(is_run) {
        if(fgets(input, sizeof(input), stdin)) {
            if(strlen(input) > 1) broadcast_message(input);
        }
    }
    return 0;
}
