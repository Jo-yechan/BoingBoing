// WebStream.cpp
#include "WebStream.h"
#include "httplib.h"
#include <thread>
#include <vector>

using namespace httplib;
using namespace cv;
using namespace std;

void start_web_server(SharedContext* ctx, int port) {
    Server svr;

    svr.Get("/", [](const Request& req, Response& res) {
        res.set_content("<html><body><h1>Servo Face Tracker</h1><img src='/video' style='width:640px;'></body></html>", "text/html");
    });

    svr.Get("/video", [&](const Request& req, Response& res) {
        res.set_content_provider(
            "multipart/x-mixed-replace; boundary=frame",
            [&](size_t offset, DataSink& sink) {
                Mat frame_to_send;
                
                // 프레임 복사
                {
                    lock_guard<mutex> lock(ctx->frame_mutex);
                    if (ctx->latest_frame.empty()) {
                        this_thread::sleep_for(chrono::milliseconds(10));
                        return true;
                    }
                    frame_to_send = ctx->latest_frame.clone();
                }

                vector<uchar> buffer;
                imencode(".jpg", frame_to_send, buffer);
                
                string part_header = "--frame\r\nContent-Type: image/jpeg\r\n\r\n";
                sink.write(part_header.c_str(), part_header.size());
                sink.write(reinterpret_cast<const char*>(buffer.data()), buffer.size());
                sink.write("\r\n", 2);

                this_thread::sleep_for(chrono::milliseconds(33));
                return true;
            }
        );
    });

    printf("Web Server started at http://localhost:%d\n", port);
    svr.listen("0.0.0.0", port);
}
