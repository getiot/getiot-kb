---
sidebar_position: 23
sidebar_label: HTTP 通信
---

# 潘多拉 RT-Thread HTTP 通信



## 实验概述

本实验使用潘多拉 IoT 开发板的 WiFi 模块，基于 WebClient 软件包完成 HTTP 协议 GET 和 POST 请求，并且接收响应的数据。

[**HTTP**](/http/http-intro/) 是互联网上应用最为广泛的一种网络协议，由于其简捷、快速的使用方式，适用于分布式和合作式超媒体信息系统。HTTP 协议是基于 TCP/IP 协议的网络应用层协议，默认端口为 80 端口。协议最新版本是 HTTP 2.0，目前是用最广泛的是 HTTP 1.1。

## 硬件连接

潘多拉 IoT Board 板载的一个 WiFi 模块，它是正基公司的 AP6181 WiFi 模组，集成了 IEEE 802.11 b/g/n MAC 、基带、射频以及功率放大器、电源管理装置、SDIO 2.0 接口，原理图如下。

![](https://static.getiot.tech/pandora-board-schematic-ap6181.png#center)



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <wlan_mgnt.h>
#include <wifi_config.h>
#include <webclient.h>

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

#define HTTP_GET_URL "http://www.rt-thread.com/service/rt-thread.txt"
#define HTTP_POST_URL "http://www.rt-thread.com/service/echo"

static struct rt_semaphore net_ready;
const char *post_data = "RT-Thread is an open source IoT operating system from China!";

extern void wlan_ready_handler(int event, struct rt_wlan_buff *buff, void *parameter);
extern void wlan_station_disconnect_handler(int event, struct rt_wlan_buff *buff, void *parameter);
extern int webclient_get_data(void);
extern int webclient_post_data(void);

int main(void)
{
    int result = RT_EOK;

    /* 初始化 wlan 自动连接功能 */
    wlan_autoconnect_init();

    /* 使能 wlan 自动连接功能 */
    rt_wlan_config_autoreconnect(RT_TRUE);

    /* 创建 'net_ready' 信号量 */
    result = rt_sem_init(&net_ready, "net_ready", 0, RT_IPC_FLAG_FIFO);
    if (result != RT_EOK)
    {
        return -RT_ERROR;
    }

    /* 注册 wlan 连接网络成功的回调，wlan 连接网络成功后释放 'net_ready' 信号量 */
    rt_wlan_register_event_handler(RT_WLAN_EVT_READY, wlan_ready_handler, RT_NULL);
    /* 注册 wlan 网络断开连接的回调 */
    rt_wlan_register_event_handler(RT_WLAN_EVT_STA_DISCONNECTED, wlan_station_disconnect_handler, RT_NULL);

    /* 等待 wlan 连接网络成功 */
    result = rt_sem_take(&net_ready, RT_WAITING_FOREVER);
    if (result != RT_EOK)
    {
        LOG_E("Wait net ready failed!");
        rt_sem_delete(&net_ready);
        return -RT_ERROR;
    }

    /* HTTP GET 请求发送 */
    webclient_get_data();
    /* HTTP POST 请求发送 */
    webclient_post_data();
}

/**
 * The callback of network ready event
 */
void wlan_ready_handler(int event, struct rt_wlan_buff *buff, void *parameter)
{
    rt_sem_release(&net_ready);
}

/**
 * The callback of wlan disconected event
 */
void wlan_station_disconnect_handler(int event, struct rt_wlan_buff *buff, void *parameter)
{
    LOG_I("disconnect from the network!");
}

/* HTTP client download data by GET request */
int webclient_get_data(void)
{
    unsigned char *buffer = RT_NULL;
    int length = 0;

    length = webclient_request(HTTP_GET_URL, RT_NULL, RT_NULL, &buffer);
    if (length < 0)
    {
        LOG_E("webclient GET request response data error.");
        return -RT_ERROR;
    }

    LOG_D("webclient GET request response data :");
    LOG_D("%s", buffer);

    web_free(buffer);
    return RT_EOK;
}

/* HTTP client upload data to server by POST request */
int webclient_post_data(void)
{
    unsigned char *buffer = RT_NULL;
    int length = 0;

    length = webclient_request(HTTP_POST_URL, RT_NULL, post_data, &buffer);
    if (length < 0)
    {
        LOG_E("webclient POST request response data error.");
        return -RT_ERROR;
    }

    LOG_D("webclient POST request response data :");
    LOG_D("%s", buffer);

    web_free(buffer);
    return RT_EOK;
}
```

完整代码：[20_iot_http_client](https://github.com/RT-Thread/IoT_Board/tree/master/examples/20_iot_http_client)



## 编译运行

添加 WebClient 软件包，具体路径如下：

```bash
RT-Thread online packages  --->
  IoT - internet of things  --->
  [*] WebClient: A HTTP/HTTPS Client for RT-Thread  --->
```

下载软件包

```bash
pkgs --update
```

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
  60960	    644	   1968	  63572	   f854	rtthread-stm32l4xx.elf
scons: done building targets.
```

将 bin 文件上传到 STM32

```bash
st-flash write rt-thread.bin 0x8000000
```

打开串口终端，输出如下内容

```basic
 \ | /
- RT -     Thread Operating System
 / | \     4.0.1 build Jan  4 2022
 2006 - 2019 Copyright by rt-thread team
lwIP-2.0.2 initialized!
[I/sal.skt] Socket Abstraction Layer initialize success.
[SFUD] Find a Winbond flash chip. Size is 16777216 bytes.
[SFUD] w25q128 flash device is initialize success.
msh />[I/FAL] RT-Thread Flash Abstraction Layer (V0.2.0) initialize success.
[I/OTA] RT-Thread OTA package(V0.1.3) initialize success.
[I/OTA] Verify 'wifi_image' partition(fw ver: 1.0, timestamp: 1529386280) success.
[I/WLAN.dev] wlan init success
[I/WLAN.lwip] eth device init ok name:w0
[Flash] EasyFlash V3.2.1 is initialize success.
[Flash] You can get the latest version on https://github.com/armink/EasyFlash .
[I/WLAN.mgnt] wifi connect success ssid:FCTC_89
[I/WLAN.lwip] Got IP address : 192.168.3.183
[D/main] webclient GET request response data :
[D/main] RT-Thread is an open source IoT operating system from China, which has strong scalability: from a tiny kernel running on a tiny cor.

[D/main] webclient POST request response data :
[D/main] RT-Thread is an open source IoT operating system from China!
```

**注意**：首次使用需要输入 `wifi join` 命令连接 WiFi 网络，之后开发板会自动连上 WiFi

```bash
wifi join [SSID] [PASSWORD]
```



## 思考总结

本实验的 HTTP 功能由 WebClient 软件包提供，它是 RT-Thread 自主研发的，基于 HTTP 协议的客户端实现，提供了设备与 HTTP 服务器的通讯的基本功能。具有如下特点：

- **支持 IPV4/IPV6 地址**

  WebClient 软件包会自动根据传入的 URI 地址的格式判断是 IPV4 地址或 IPV6 地址，并且从中解析出连接服务器需要的信息，提高代码兼容性。

- **支持 GET/POST 请求方法**

  目前 WebClient 软件包支持 HTTP 协议 GET 和 POST 请求方法，这也是嵌入式设备最常用到的两个命令类型，满足设备开发需求。

- **支持文件的上传和下载功能**

  WebClient 软件包提供文件上传和下载的接口函数，方便用户直接通过 GET/POST 请求方法上传本地文件到服务器或者下载服务器文件到本地。

- **支持 HTTPS 加密传输**

  WebClient 软件包可以采用 TLS 加密方式传输数据，保证数据的安全性和完整性。

- **完善的头部数据添加和处理方式**

  WebClient 软件包中提供简单的添加发送请求头部信息的方式，方便用于快速准确的拼接头部信息。

在示例程序中，设备成功接入网络之后，会自动顺序的执行 `webclient_get_test()` 和 `webclient_post_test()` 函数，通过 HTTP 协议发送 GET 和 POST 请求。

