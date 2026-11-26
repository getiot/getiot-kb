---
sidebar_position: 1
slug: /libgps
---

# libgps 使用教程



Libgps 是一个服务库，它支持与 gpsd 的实例进行通信，从而获得 GPS 定位信息。在编译时需要增加链接选项 -lgps，有些系统可能还需要 -lm。

关于 GPSD 的介绍和使用请参考《[Linux 使用 gpsd 获取 GPS 数据](/linux-note/linux-get-gps-data-using-gpsd/)》。



## 安装

```bash
sudo apt install libgps libgps-dev
```



## API 总览

**头文件**

```c
#include <gps.h>
```

这样可以根据 gps.h 中的 API 获得 GPS 数据。

**接口函数**

```c
int gps_open(char * server, char * port, struct gps_data_t * gpsdata)

int gps_send(struct gps_data_t * gpsdata, char * fmt, ...)

int gps_read(struct gps_data_t * gpsdata, char * message,
             int message_size)

bool gps_waiting(const struct gps_data_t * gpsdata, int timeout)

char * gps_data(const struct gps_data_t * gpsdata)

int gps_unpack(char * buf, struct gps_data_t * gpsdata)

int gps_close(struct gps_data_t * gpsdata)

int gps_stream(struct gps_data_t * gpsdata, unsigned int flags,
               void * data)

int gps_mainloop(struct gps_data_t * gpsdata, int timeout,
                 void (* hook)(struct gps_data_t *gpsdata))

const char * gps_errstr(int err)
```



## 示例程序

完整代码：[linux-c/peripherals/gps/read_gps_data.c](https://github.com/getiot/linux-c/blob/main/peripherals/gps/read_gps_data.c)

```c showLineNumbers title="read_gps_data.c"
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <gps.h>
#include <math.h>

#define SERVER_NAME         "localhost"
#define SERVER_PORT         "2947"

int main(void) 
{
    struct gps_data_t g_gpsdata;
    int ret;

    // 1) Try GPS open
    ret = gps_open(SERVER_NAME,SERVER_PORT, &g_gpsdata);
    if(ret != 0) {
        printf("[GPS] Can't open...bye!\r\n");
        return -1;
    }

    // 2) Enable the JSON stream - we enable the watch as well
    gps_stream(&g_gpsdata, WATCH_ENABLE | WATCH_JSON, NULL);

    // 3) Wait for data from GPSD
    while (gps_waiting(&g_gpsdata, 5000000)) {

        sleep(1);

        if (-1 == gps_read(&g_gpsdata, NULL, 0)) {
            printf("Read error!! Exiting...\n");
            break;
        }

        if (g_gpsdata.status != STATUS_FIX) {
            printf("Waiting for fix...\n");
            continue;
        }
        
        if(isfinite(g_gpsdata.fix.latitude) && isfinite(g_gpsdata.fix.longitude)) {
            printf("[GPS DATA] Time = %ld.%06ld, Latitude = %lf, Longitude = %lf, Used satellites = %d, Mode = %d\n", 
                    g_gpsdata.online.tv_sec, g_gpsdata.online.tv_nsec/1000, g_gpsdata.fix.latitude, 
                    g_gpsdata.fix.longitude, g_gpsdata.satellites_used, g_gpsdata.fix.mode);        
        }
        else {
            printf(".");
        }
    }

    // Close gracefully...
    gps_stream(&g_gpsdata, WATCH_DISABLE, NULL);
    gps_close(&g_gpsdata);
    return 0;
}
```

将上述代码保存为 read_gps_data.c 文件，执行下面命令编译程序。

```bash
gcc read_gps_data.c -lgps -o read_gps_data
```

在运行 read_gps_data 程序之前，需要确保你的 GPS 设备已经连接上，并且正确启动 gpsd 守护进程（参考《[Linux 使用 gpsd 获取 GPS 数据](/linux-note/linux-get-gps-data-using-gpsd/)》）。例如，GPS 设备对应串口 /dev/ttyUSB0：

```bash
gpsd /dev/ttyUSB0
```

启动 read_gps_data 程序，运行结果如下：

```bash
$ ./read_gps_data 
Waiting for fix...
Waiting for fix...
Waiting for fix...
[GPS DATA] Time = 1671085277.017889, Latitude = 23.160211, Longitude = 113.493912, Used satellites = 0, Mode = 3
[GPS DATA] Time = 1671085278.018173, Latitude = 23.160211, Longitude = 113.493912, Used satellites = 0, Mode = 3
[GPS DATA] Time = 1671085279.018448, Latitude = 23.160211, Longitude = 113.493911, Used satellites = 0, Mode = 3
[GPS DATA] Time = 1671085280.018713, Latitude = 23.160211, Longitude = 113.493911, Used satellites = 0, Mode = 3
[GPS DATA] Time = 1671085281.018988, Latitude = 23.160211, Longitude = 113.493911, Used satellites = 0, Mode = 3
```



