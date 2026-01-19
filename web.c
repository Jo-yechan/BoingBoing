#include "web.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <time.h>
#include <locale.h>

// 전역 변수 정의
client_info clients[MAX_CLIENTS];
int client_count = 0;
pthread_mutex_t clients_mutex = PTHREAD_MUTEX_INITIALIZER;
volatile int is_run = 1;

static int cmd_sock = -1; 
static int web_sock = -1;

// 연결된 SSE 클라이언트들에게만 메시지 브로드캐스트
void broadcast_message(const char* message) {
    pthread_mutex_lock(&clients_mutex);
    char sse_message[BUFFER_SIZE];
    time_t now = time(NULL);
    struct tm* t = localtime(&now);
    
    char clean_msg[BUFFER_SIZE/2];
    strncpy(clean_msg, message, sizeof(clean_msg) - 1);
    clean_msg[sizeof(clean_msg) - 1] = '\0';
    
    size_t len = strlen(clean_msg);
    if (len > 0 && clean_msg[len-1] == '\n') clean_msg[len-1] = '\0';

    snprintf(sse_message, sizeof(sse_message),
             "data: {\"message\": \"%s\", \"time\": \"%02d:%02d:%02d\"}\n\n",
             clean_msg, t->tm_hour, t->tm_min, t->tm_sec);
    
    for(int i = 0; i < client_count; i++) {
        if(send(clients[i].sock, sse_message, strlen(sse_message), MSG_NOSIGNAL) < 0) {
            close(clients[i].sock);
            memmove(&clients[i], &clients[i+1], (client_count - i - 1) * sizeof(client_info));
            client_count--;
            i--; 
        }
    }
    pthread_mutex_unlock(&clients_mutex);
}

void add_client(int sock, struct sockaddr_in addr) {
    pthread_mutex_lock(&clients_mutex);
    if (client_count < MAX_CLIENTS) {
        clients[client_count].sock = sock;
        clients[client_count].addr = addr;
        client_count++;
    } else {
        close(sock);
    }
    pthread_mutex_unlock(&clients_mutex);
}

// 클라이언트 핸들러
void* handle_web_client(void* arg) {
    client_info* client_temp = (client_info*)arg;
    int sock = client_temp->sock;
    struct sockaddr_in addr = client_temp->addr;
    free(client_temp);

    char buffer[BUFFER_SIZE];
    int bytes_read = recv(sock, buffer, BUFFER_SIZE - 1, 0);
    if (bytes_read <= 0) {
        close(sock);
        return NULL;
    }
    buffer[bytes_read] = '\0';

    // 1. SSE 요청 (/events)
    if (strncmp(buffer, "GET /events", 11) == 0) {
        const char* sse_header =
            "HTTP/1.1 200 OK\r\n"
            "Content-Type: text/event-stream; charset=utf-8\r\n"
            "Cache-Control: no-cache\r\n"
            "Connection: keep-alive\r\n"
            "Access-Control-Allow-Origin: *\r\n"
            "\r\n";
        send(sock, sse_header, strlen(sse_header), MSG_NOSIGNAL);
        add_client(sock, addr);
        return NULL; 
    }

    // 2. HTML 페이지 요청
    if (strstr(buffer, "GET / ") || strstr(buffer, "GET /index.html")) {
        const char* html = 
"<!DOCTYPE html>\n"
"<html lang=\"ko\">\n"
"<head>\n"
"    <meta charset=\"UTF-8\">\n"
"    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
"    <title>라즈베리파이 모니터</title>\n"
"    <style>\n"
"        body { font-family: sans-serif; background: #f0f2f5; display: flex; justify-content: center; padding: 20px; }\n"
"        .container { width: 100%; max-width: 500px; background: white; padding: 30px; border-radius: 20px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }\n"
"        .status { padding: 15px; border-radius: 10px; text-align: center; margin-bottom: 20px; font-weight: bold; }\n"
"        .connected { background: #d4edda; color: #155724; }\n"
"        .disconnected { background: #f8d7da; color: #721c24; }\n"
"        .msg-box { height: 300px; overflow-y: auto; background: #fafafa; border: 1px solid #ddd; padding: 10px; border-radius: 10px; }\n"
"        .msg-item { background: white; padding: 10px; margin-bottom: 8px; border-radius: 8px; border-left: 4px solid #007bff; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }\n"
"        .time { font-size: 12px; color: #888; margin-top: 4px; }\n"
"    </style>\n"
"</head>\n"
"<body>\n"
"    <div class=\"container\">\n"
"        <h2 style=\"text-align:center\">📡 실시간 감지 모니터</h2>\n"
"        <div id=\"status\" class=\"status disconnected\">연결 대기중...</div>\n"
"        <div id=\"messages\" class=\"msg-box\"></div>\n"
"    </div>\n"
"    <script>\n"
"        const statusDiv = document.getElementById('status');\n"
"        const msgDiv = document.getElementById('messages');\n"
"        let eventSource = null;\n"
"\n"
"        function connect() {\n"
"            const url = window.location.protocol + '//' + window.location.host + '/events';\n"
"            console.log('연결 시도:', url);\n"
"            if(eventSource) eventSource.close();\n"
"            eventSource = new EventSource(url);\n"
"            eventSource.onopen = () => {\n"
"                statusDiv.textContent = '🟢 서버와 연결됨';\n"
"                statusDiv.className = 'status connected';\n"
"            };\n"
"            eventSource.onmessage = (e) => {\n"
"                const data = JSON.parse(e.data);\n"
"                const item = document.createElement('div');\n"
"                item.className = 'msg-item';\n"
"                item.innerHTML = `<div>${data.message}</div><div class=\"time\">${data.time}</div>`;\n"
"                msgDiv.insertBefore(item, msgDiv.firstChild);\n"
"            };\n"
"            eventSource.onerror = () => {\n"
"                statusDiv.textContent = '🔴 연결 끊김 (재접속 중...)';\n"
"                statusDiv.className = 'status disconnected';\n"
"                eventSource.close();\n"
"                setTimeout(connect, 3000);\n"
"            };\n"
"        }\n"
"        connect();\n"
"    </script>\n"
"</body>\n"
"</html>\n";
        
        char header[BUFFER_SIZE];
        snprintf(header, sizeof(header), 
            "HTTP/1.1 200 OK\r\n"
            "Content-Type: text/html; charset=utf-8\r\n"
            "Content-Length: %ld\r\n"
            "Connection: close\r\n\r\n", strlen(html));
        send(sock, header, strlen(header), MSG_NOSIGNAL);
        send(sock, html, strlen(html), MSG_NOSIGNAL);
    }
    else {
        const char* not_found = "HTTP/1.1 404 Not Found\r\nConnection: close\r\n\r\n";
        send(sock, not_found, strlen(not_found), MSG_NOSIGNAL);
    }
    close(sock);
    return NULL;
}

// 웹 서버 스레드
void* web_server_thread(void* arg) {
    (void)arg;
    web_sock = socket(AF_INET, SOCK_STREAM, 0);
    struct sockaddr_in addr;
    int opt = 1;
    setsockopt(web_sock, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
    
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = INADDR_ANY;
    addr.sin_port = htons(WEB_PORT);
    
    if(bind(web_sock, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
        perror("Web Bind Failed");
        return NULL;
    }
    listen(web_sock, 10);
    
    printf("웹 서버 시작됨: http://(라즈베리파이IP):%d\n", WEB_PORT);

    while (is_run) {
        socklen_t len = sizeof(addr);
        int client_sock = accept(web_sock, (struct sockaddr*)&addr, &len);
        if (client_sock < 0) continue;

        client_info* new_client = malloc(sizeof(client_info));
        new_client->sock = client_sock;
        new_client->addr = addr;

        pthread_t t;
        pthread_create(&t, NULL, handle_web_client, new_client);
        pthread_detach(t);
    }
    close(web_sock);
    return NULL;
}

// 명령 서버 스레드
void* cmd_server_thread(void* arg) {
    (void)arg;
    cmd_sock = socket(AF_INET, SOCK_STREAM, 0);
    int opt = 1;
    setsockopt(cmd_sock, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
    struct sockaddr_in addr = {0};
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = INADDR_ANY;
    addr.sin_port = htons(CMD_PORT);
    
    bind(cmd_sock, (struct sockaddr*)&addr, sizeof(addr));
    listen(cmd_sock, 5);
    
    while(is_run) {
        int client = accept(cmd_sock, NULL, NULL);
        if(client < 0) continue;
        char buf[BUFFER_SIZE];
        int len = read(client, buf, sizeof(buf)-1);
        if(len > 0) {
            buf[len] = 0;
            broadcast_message(buf);
        }
        close(client);
    }
    close(cmd_sock);
    return NULL;
}
