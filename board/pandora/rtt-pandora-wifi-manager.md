---
sidebar_position: 19
sidebar_label: WiFi 管理
---

# 潘多拉 RT-Thread WiFi 管理



## 实验概述

本实验使用 RT-Thread Wlan Manager 对 WiFi 网络管理，展示 WiFi 热点扫描、Join 网络、WiFi 自动连接以及 WiFi Event 处理等功能。



## 硬件连接

潘多拉 IoT Board 板载的一个 WiFi 模块，它是正基公司的 AP6181 WiFi 模组，集成了 IEEE 802.11 b/g/n MAC 、基带、射频以及功率放大器、电源管理装置、SDIO 2.0 接口，原理图如下。

![](https://static.getiot.tech/pandora-board-schematic-ap6181.png#center)



## 示例代码

程序主要流程：首先调用 Scan 接口扫描周围环境中的 AP（Access Point ，即无线访问热点），并打印扫描结果；然后连接一个测试用的 AP（名字 test_ssid，密码 12345678），并等待联网成功，打印网络信息；接着在等待 5 秒之后，断开和 AP 的连接；最后，调用接口初始化自动连接的相关配置，开启自动连接功能。在开启自动连接之后，Wlan Manager 会根据存储介质中的历史记录进行 AP 连接。

![](https://static.getiot.tech/pandora-wlan-manager-process.png#center)

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

注意：将 `WLAN_SSID` 和 `WLAN_PASSWORD` 修改为你的 WiFi 接入点名称和密码。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <rtdevice.h>
#include <board.h>
#include <msh.h>

#include "drv_wlan.h"
#include "wifi_config.h"

#include <stdio.h>
#include <stdlib.h>

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

#define WLAN_SSID "test_ssid"
#define WLAN_PASSWORD "12345678"
#define NET_READY_TIME_OUT (rt_tick_from_millisecond(15 * 1000))

static void print_scan_result(struct rt_wlan_scan_result *scan_result);
static void print_wlan_information(struct rt_wlan_info *info);

static struct rt_semaphore net_ready;

void wlan_ready_handler(int event, struct rt_wlan_buff *buff, void *parameter)
{
    rt_sem_release(&net_ready);
}

/* 断开连接回调函数 */
void wlan_station_disconnect_handler(int event, struct rt_wlan_buff *buff, void *parameter)
{
    LOG_I("disconnect from the network!");
}

int main(void)
{
    int result = RT_EOK;
    struct rt_wlan_info info;
    struct rt_wlan_scan_result *scan_result;

    /* 等待 500 ms 以便 wifi 完成初始化 */
    rt_hw_wlan_wait_init_done(500);

    /* 扫描热点 */
    LOG_D("start to scan ap ...");
    /* 执行同步扫描 */
    scan_result = rt_wlan_scan_sync();
    if (scan_result)
    {
        LOG_D("the scan is complete, results is as follows: ");
        /* 打印扫描结果 */
        print_scan_result(scan_result);
        /* 清除扫描结果 */
        rt_wlan_scan_result_clean();
    }
    else
    {
        LOG_E("not found ap information ");
        return -1;
    }

    /* 热点连接 */
    LOG_D("start to connect ap ...");
    rt_sem_init(&net_ready, "net_ready", 0, RT_IPC_FLAG_FIFO);

    /* 注册 wlan ready 回调函数 */
    rt_wlan_register_event_handler(RT_WLAN_EVT_READY, wlan_ready_handler, RT_NULL);
    /* 注册 wlan 断开回调函数 */
    rt_wlan_register_event_handler(RT_WLAN_EVT_STA_DISCONNECTED, wlan_station_disconnect_handler, RT_NULL);
    result = rt_wlan_connect(WLAN_SSID, WLAN_PASSWORD);
    if (result == RT_EOK)
    {
        rt_memset(&info, 0, sizeof(struct rt_wlan_info));
        /* 获取当前连接热点信息 */
        rt_wlan_get_info(&info);
        LOG_D("station information:");
        print_wlan_information(&info);
        /* 等待成功获取 IP */
        result = rt_sem_take(&net_ready, NET_READY_TIME_OUT);
        if (result == RT_EOK)
        {
            LOG_D("networking ready!");
            msh_exec("ifconfig", rt_strlen("ifconfig"));
        }
        else
        {
            LOG_D("wait ip got timeout!");
        }
        /* 回收资源 */
        rt_wlan_unregister_event_handler(RT_WLAN_EVT_READY);
        rt_sem_detach(&net_ready);
    }
    else
    {
        LOG_E("The AP(%s) is connect failed!", WLAN_SSID);
    }

    rt_thread_mdelay(5000);

    LOG_D("ready to disconect from ap ...");
    rt_wlan_disconnect();

    /* 自动连接 */
    LOG_D("start to autoconnect ...");
    /* 初始化自动连接配置 */
    wlan_autoconnect_init();
    /* 使能 wlan 自动连接 */
    rt_wlan_config_autoreconnect(RT_TRUE);

    return 0;
}

static void print_scan_result(struct rt_wlan_scan_result *scan_result)
{
    char *security;
    int index, num;

    num = scan_result->num;
    /* 有规则的排列扫描到的热点 */
    rt_kprintf("             SSID                      MAC            security    rssi chn Mbps\n");
    rt_kprintf("------------------------------- -----------------  -------------- ---- --- ----\n");
    for (index = 0; index < num; index++)
    {
        rt_kprintf("%-32.32s", &scan_result->info[index].ssid.val[0]);
        rt_kprintf("%02x:%02x:%02x:%02x:%02x:%02x  ",
                   scan_result->info[index].bssid[0],
                   scan_result->info[index].bssid[1],
                   scan_result->info[index].bssid[2],
                   scan_result->info[index].bssid[3],
                   scan_result->info[index].bssid[4],
                   scan_result->info[index].bssid[5]);
        switch (scan_result->info[index].security)
        {
        case SECURITY_OPEN:
            security = "OPEN";
            break;
        case SECURITY_WEP_PSK:
            security = "WEP_PSK";
            break;
        case SECURITY_WEP_SHARED:
            security = "WEP_SHARED";
            break;
        case SECURITY_WPA_TKIP_PSK:
            security = "WPA_TKIP_PSK";
            break;
        case SECURITY_WPA_AES_PSK:
            security = "WPA_AES_PSK";
            break;
        case SECURITY_WPA2_AES_PSK:
            security = "WPA2_AES_PSK";
            break;
        case SECURITY_WPA2_TKIP_PSK:
            security = "WPA2_TKIP_PSK";
            break;
        case SECURITY_WPA2_MIXED_PSK:
            security = "WPA2_MIXED_PSK";
            break;
        case SECURITY_WPS_OPEN:
            security = "WPS_OPEN";
            break;
        case SECURITY_WPS_SECURE:
            security = "WPS_SECURE";
            break;
        default:
            security = "UNKNOWN";
            break;
        }
        rt_kprintf("%-14.14s ", security);
        rt_kprintf("%-4d ", scan_result->info[index].rssi);
        rt_kprintf("%3d ", scan_result->info[index].channel);
        rt_kprintf("%4d\n", scan_result->info[index].datarate / 1000000);
    }
    rt_kprintf("\n");
}

static void print_wlan_information(struct rt_wlan_info *info)
{
    LOG_D("SSID : %-.32s", &info->ssid.val[0]);
    LOG_D("MAC Addr: %02x:%02x:%02x:%02x:%02x:%02x", info->bssid[0],
          info->bssid[1],
          info->bssid[2],
          info->bssid[3],
          info->bssid[4],
          info->bssid[5]);
    LOG_D("Channel: %d", info->channel);
    LOG_D("DataRate: %dMbps", info->datarate / 1000000);
    LOG_D("RSSI: %d", info->rssi);
}
```

完整代码：[16_iot_wifi_manager](https://github.com/RT-Thread/IoT_Board/tree/master/examples/16_iot_wifi_manager)



## 编译运行

开启 WiFi 选项

![](https://static.getiot.tech/pandora-rtt-scons-menuconfig-enable-wifi.png#center)

下载软件包

```bash
$ pkgs --update
==============================>  WLAN_WICED v1.0.1 is downloaded successfully. 
==============================>  EASYFLASH v4.1.0 is downloaded successfully. 
==============================>  FAL v0.5.0 is downloaded successfully. 
==============================>  STM32_SDIO v1.0.2 is downloaded successfully. 
Operation completed successfully.
```

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
 345732	   2460	  43584	 391776	  5fa60	rtthread-stm32l4xx.elf
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
```

打印扫描结果

```bash
[D/main] start to scan ap ...
[E/SDIO] err:0x00400404, CTIMEOUT  cmd:53 arg:0x94404004 rw:w len:4 blksize:4
[D/main] the scan is complete, results is as follows: 
             SSID                      MAC            security    rssi chn Mbps
------------------------------- -----------------  -------------- ---- --- ----
FCTC_89                         78:11:dc:38:f0:c0  WPA2_MIXED_PSK -30    1  144
EZVIZ_D91768381                 60:23:a4:d5:c5:a8  WPA2_AES_PSK   -70    6   65
EZVIZ_D96630777                 60:23:a4:d6:2c:0b  WPA2_AES_PSK   -82    6   65
CMCC-dy73                       b8:e3:b1:0d:b4:50  WPA2_MIXED_PSK -87    8  144
Tineco_3296                     8e:ce:4e:ea:d0:bc  OPEN           -88    1   54
CMCC-123                        34:55:94:9b:a4:de  WPA2_AES_PSK   -88    3  300
Rudy-Lab                        5c:02:14:d3:ef:97  WPA2_MIXED_PSK -88   10  144
```

连接 WiFi 网络

```bash
[D/main] start to connect ap ...
[I/WLAN.mgnt] wifi connect success ssid:FCTC_89
[D/main] station information:
[D/main] SSID : FCTC_89
[D/main] MAC Addr: 78:11:dc:38:f0:c0
[D/main] Channel: 1
[D/main] DataRate: 144Mbps
[D/main] RSSI: -30
[D/main] networking ready!
network interface device: w0 (Default)
MTU: 1500
MAC: 18 93 7f 7f 61 94 
FLAGS: UP LINK_UP INTERNET_DOWN DHCP_ENABLE ETHARP BROADCAST IGMP
ip address: 192.168.3.183
gw address: 192.168.3.1
net mask  : 255.255.255.0
dns server #0: 192.168.3.1
dns server #1: 0.0.0.0
[I/WLAN.lwip] Got IP address : 192.168.3.183
```

断开 WiFi 连接

```bash
warning: tcpip stack is close to end of stack address.
warning: tcpip stack is close to end of stack address.
[D/main] ready to disconect from ap ...
[I/main] disconnect from the network!
[I/WLAN.mgnt] disconnect success!
```

自动重连

```bash
[D/main] start to autoconnect ...
[Flash] EasyFlash V3.2.1 is initialize success.
[Flash] You can get the latest version on https://github.com/armink/EasyFlash .
[I/WLAN.mgnt] wifi connect success ssid:FCTC_89
[I/WLAN.lwip] Got IP address : 192.168.3.183
```

查看网卡状态

```bash
msh />ifconfig
network interface device: w0 (Default)
MTU: 1500
MAC: 18 93 7f 7f 61 94 
FLAGS: UP LINK_UP INTERNET_UP DHCP_ENABLE ETHARP BROADCAST IGMP
ip address: 192.168.3.183
gw address: 192.168.3.1
net mask  : 255.255.255.0
dns server #0: 192.168.3.1
dns server #1: 0.0.0.0
```

测试网络连通性

```bash
msh />ping getiot.tech
60 bytes from 42.192.64.149 icmp_seq=0 ttl=51 time=46 ms
60 bytes from 42.192.64.149 icmp_seq=1 ttl=51 time=45 ms
60 bytes from 42.192.64.149 icmp_seq=2 ttl=51 time=44 ms
60 bytes from 42.192.64.149 icmp_seq=3 ttl=51 time=44 ms
```



## MSH 命令

为了方便用户验证 WiFi 功能是否正常，配置 WiFi 网络，RT-Thread 提供了 wifi 相关的 shell 命令。

```bash
wifi                       # 打印帮助
wifi help                  # 查看帮助
wifi join SSID [PASSWORD]  # 连接 wifi，SSDI 为空，使用配置自动连接
wifi ap   SSID [PASSWORD]  # 建立热点
wifi scan                  # 扫描全部热点
wifi disc                  # 断开连接
wifi ap_stop               # 停止热点
wifi status                # 打印 wifi 状态 sta + ap
wifi smartconfig           # 启动配网功能
```



## 思考总结

通过本实验，我们学习了 WiFi 网络扫描、联网、开启自动连接等功能。WiFi 功能的实现有赖 WiFi 模组库和驱动的支持。其中，AP6181 WiFi 模组使用 Cypress 公司的 WICED 软件包，这部分代码已经在 RT-Thread 上完成移植和适配，以库文件的形式提供。用户仅需调用 RT-Thread Wlan Manager 层 API 即可轻松操作。

WiFi 驱动位于 drivers/drv_wlan.c 中，主要完成 WiFi 库的初始化，以及 WiFi 固件的读取。本例中 WiFi 固件存储于外部 NorFlash 的 wifi_imager 分区，程序启动时从 Flash 读取固件，然后通过 SDIO 传输至 AP6181 WiFi 模组。

drv_wlan.c 中实现了两个重要的接口，完成 WiFi 固件的读取，并在 WiFi 库中被调用。

```c showLineNumbers
int wiced_platform_resource_size(int resource);
```

获取 WiFi 固件的大小。该接口用于从偏移位置读取指定大小的固件到 buffer 中，返回值为实际读取的固件大小。

```c showLineNumbers
int wiced_platform_resource_read(int resource, 
                                 uint32_t offset, 
                                 void *buffer,
                                 uint32_t buffer_size);
```

本实验中用到的 AP6181 WiFi 模组，需要配合专用 WiFi 固件使用。开发板在出厂前已经烧录过 WiFi 固件，默认存储在外部 Flash。如果固件被不慎擦除，请参考 UM3001《IoT-Board WiFi 固件下载》，进行重新烧录。

