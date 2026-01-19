#ifndef WEB_H
#define WEB_H

#include <netinet/in.h>
#include <pthread.h>

#define WEB_PORT 8080
#define CMD_PORT 9090
#define BUFFER_SIZE 4096
#define MAX_CLIENTS 10

// SSE 클라이언트 정보
typedef struct {
    int sock;
    struct sockaddr_in addr;
} client_info;

// 전역 변수 선언
extern client_info clients[MAX_CLIENTS];
extern int client_count;
extern pthread_mutex_t clients_mutex;
extern volatile int is_run;

// 함수 선언
void broadcast_message(const char* message);
void add_client(int sock, struct sockaddr_in addr);
void* handle_web_client(void* arg);
void* web_server_thread(void* arg);
void* cmd_server_thread(void* arg);

#endif
