---
sidebar_position: 27
sidebar_label: netutils 网络工具
---

# 潘多拉 RT-Thread 网络工具使用



## 实验概述

本实验主要介绍如何在 IoT Board 开发板上使用 RT-Thread 的 netutils 软件包的各种功能，包括 ping、ntp、tftp、iperf 等实用功能。

netutils 是一个包含众多简洁好用网络工具的软件包，利用该软件包，可以给开发者在调试网络功能时带来很多便利。当需要使用一些调试网络的小工具时，只需要拥有 netutils 软件包就够了，堪称网络功能调试界的瑞士军刀。

本实验需要依赖 IoTBoard 板卡上的 WiFi 模块完成网络通信，因此请确保硬件平台上的 WiFi 模组可以正常工作。可参考《[潘多拉 RT-Thread WiFi 管理](/pandora/rtt-pandora-wifi-manager/)》。



## 硬件连接

潘多拉 IoT Board 板载的一个 WiFi 模块，它是正基公司的 AP6181 WiFi 模组，集成了 IEEE 802.11 b/g/n MAC 、基带、射频以及功率放大器、电源管理装置、SDIO 2.0 接口，原理图如下。

![](https://static.getiot.tech/pandora-board-schematic-ap6181.png#center)



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。main.c 主要配置 wlan 的自动连接功能并开启自动连接，以及文件系统功能的初始化。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <wlan_mgnt.h>
#include <dfs_fs.h>
#include <fal.h>
#include "wifi_config.h"

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

#define FS_PARTITION_NAME "filesystem"

int fs_init();

int main(void)
{
    /* 配置 wlan 自动连接功能的依赖项 */
    wlan_autoconnect_init();

    /* 开启 wlan 自动连接 */
    rt_wlan_config_autoreconnect(RT_TRUE);
    /* 初始化文件系统 */
    fs_init();

    return 0;
}

int fs_init()
{
    /* Create a block device on the file system partition of spi flash */
    struct rt_device *flash_dev = fal_blk_device_create(FS_PARTITION_NAME);
    if (flash_dev == NULL)
    {
        LOG_E("Can't create a block device on '%s' partition.", FS_PARTITION_NAME);
    }
    else
    {
        LOG_D("Create a block device on the %s partition of flash successful.", FS_PARTITION_NAME);
    }

    /* mount the file system from "filesystem" partition of spi flash. */
    if (dfs_mount(FS_PARTITION_NAME, "/", "elm", 0, 0) == 0)
    {
        LOG_D("Filesystem initialized!");
    }
    else
    {
        LOG_E("Failed to initialize filesystem!");
        LOG_E("You should create a filesystem on the block device first!");
    }

    return 0;
}
```

完整代码：[24_iot_netutils](https://github.com/RT-Thread/IoT_Board/tree/master/examples/24_iot_netutils)



## 编译运行

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
 401576	   2576	  43984	 448136	  6d688	rtthread-stm32l4xx.elf
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
 / | \     4.0.1 build Jan  7 2022
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
[I/FAL] The FAL block device (filesystem) created successfully
[D/main] Create a block device on the filesystem partition of flash successful.
[D/main] Filesystem initialized!
[I/WLAN.mgnt] wifi connect success ssid:FCTC_89
[I/WLAN.lwip] Got IP address : 192.168.3.183
```

由于在使用 TFTP 功能向系统内传输文件时需要文件系统的支持，所以系统在初始化时会进行文件系统相关功能的初始化。如果在指定的存储器分区上没有可挂载文件系统，可能会出现文件系统挂载失败的情况。此时需要在 msh 中执行下面命令，在存储设备中名为 “filesystem” 的分区上创建 elm 类型的文件系统。

```bash
mkfs -t elm filesystem
```

如果用户在此例程前已经为设备配置过网络，并且开启了自动连接网络功能，设备上电后会自动连接网络，网络连接成功后直接执行 mbedTLS 例程。否则，应当先使用下面 MSH 命令配置 WiFi 网络。

```bash
wifi join [SSID] [PASSWORD]
```



## netutils 软件包

在使用 RT-Thread netutils 软件包之前，先简单了解一下它包含的工具和功能。

| 工具    | 类型     | 描述                                                         |
| ------- | -------- | ------------------------------------------------------------ |
| Ping    | 调试测试 | 利用 “ping” 命令可以检查网络是否连通，可以很好地帮助我们分析和判定网络故障 |
| NTP     | 时间同步 | 网络时间协议                                                 |
| TFTP    | 文件传输 | TFTP 是一个传输文件的简单协议，比 FTP 还要轻量级             |
| Iperf   | 性能测试 | 测试最大 TCP 和 UDP 带宽性能，可以报告带宽、延迟抖动和数据包丢失 |
| NetIO   | 性能测试 | 测试网络的吞吐量的工具                                       |
| Telnet  | 远程访问 | 可以远程登录到 RT-Thread 的 Finsh/MSH Shell                  |
| tcpdump | 网络调试 | tcpdump 是 RT-Thread 基于 lwIP 的网络抓包工具                |

netutils 软件包文件结构如下所示：

```bash
netutils
├── iperf        # iperf 网络性能测试
├── netio        # netio 网络吞吐量测试
├── ntp          # ntp 时间同步功能
├── ping         # ping 功能
├── tcpdump      # 网络抓包工具
├── telnet       # telnet 服务器
├── tftp         # TFTP 功能
└── tools        # 网络测试工具
```

### Ping 工具

Ping 是一种网络诊断工具，用来测试数据包能否通过 IP 协议到达特定主机。估算与主机间的丢失数据包率（丢包率）和数据包往返时间。Ping 支持访问 IP 地址或域名 ，使用 Finsh/MSH 命令进行测试，大致使用效果如下：

```bash
msh />ping getiot.tech
60 bytes from 42.192.64.149 icmp_seq=0 ttl=51 time=46 ms
60 bytes from 42.192.64.149 icmp_seq=1 ttl=51 time=45 ms
60 bytes from 42.192.64.149 icmp_seq=2 ttl=51 time=49 ms
60 bytes from 42.192.64.149 icmp_seq=3 ttl=51 time=45 ms
```

### NTP 工具

NTP 是网络时间协议（Network Time Protocol），它是用来同步网络中各个计算机时间的协议。在 netutils 软件包实现了 NTP 客户端，连接上网络后，可以获取当前 UTC 时间，并更新至 RTC 中。

开启 RTC 设备后，可以使用下面的命令同步 NTP 的本地时间至 RTC 设备。Finsh/MSH 命令效果如下：

```bash
msh />ntp_sync    # 同步 NTP 网络时间到 RTC 设备
Get local time from NTP server: Fri Jan  7 13:08:52 2022
The system time is updated. Timezone is 8.
msh />date        # 打印当前时间
Fri Jan  7 13:08:59 2022
```

### TFTP 工具

TFTP（Trivial File Transfer Protocol，简单文件传输协议）是 TCP/IP 协议族中的一个用来在客户机与服务器之间进行简单文件传输的协议，提供不复杂、开销不大的文件传输服务，端口号为 69 ，比传统的 FTP 协议要轻量级很多，适用于小型的嵌入式产品上。

在传输文件前，需要在 RT-Thread 上使用 Finsh/MSH 命令来启动 TFTP 服务器：

```bash
msh />tftp_server
TFTP server start successfully.
msh />
```

为了完成本实验，我们还需要一个 TFTP 客户端配合测试，如果你使用 Ubuntu，可以使用下面命令安装：

```bash
sudo apt install tftp-hpa
```

参考 [Ubuntu 搭建 TFTP 服务](/ubuntu/ubuntu-tftp/)。

注意，由于 RT-Thread 默认开启 `DFS_USING_WORKDIR` 选项，此时相对路径是基于 Finsh/MSH 当前进入的目录。所以，使用相对路径时，务必提前切换好目录。

### Iperf 工具

Iperf 是一个网络性能测试工具，可用于测试最大 TCP 和 UDP 带宽性能，具有多种参数和 UDP 特性，可以根据需要调整，可以报告带宽、延迟抖动和数据包丢失。

Iperf 使用的是主从式架构，即一端是服务器，另一端是客户端。在 netutils 软件包中，Iperf 实现了 TCP 服务器模式和客户端模式，暂不支持 UDP 测试，下面将具体讲解这两种模式的使用方法。

为了完成本实验，我们需要在 PC 端安装 Jperf 工具，如果你使用 Ubuntu 系统，可参考 [Ubuntu 安装 Jperf 工具](/ubuntu/ubuntu-jperf/)。

**1、Iperf 服务器模式**

在 RT-Thread 上启动 Iperf 服务器，执行如下命令：

```bash
iperf -s -p 5001
```

参数 -s 的意思是表示作为服务器启动，参数 -p 表示监听 5001 端口。

然后打开 Jperf 软件，选择 Client 模式，输入潘多拉 IoT 开发板的 IP 地址和端口号（5001），点击 Run Iperf! 按钮开始测试。

![](https://static.getiot.tech/rt-thread-netutils-iperf-Jperf-Client.png#center)

**2、Iperf 客户端模式**

下面使用 Jperf 作为服务器，潘多拉 IoT 开发板作为客户端。首先打开 Jperf 软件，选择 Server 模式，修改端口号为 5001，点击 Run Iperf! 开启服务器。

接下来在 RT-Thread 上启动 Iperf 客户端，启动之前需要先停止之前启动的 Iperf 服务器：

```bash
iperf --stop
```

然后启动 Iperf 客户端：

```bash
iperf -c 192.168.3.85 -p 5001
```

参数 -c 表示作为客户端启动，后面需要加运行服务器端的 PC 的 IP 地址，参数 -p 表示连接 5001 端口。等待测试结束，数据会在 shell 界面和 JPerf 软件上显示。

```bash
msh />iperf -c 192.168.3.85 -p 5001
msh />Connect to iperf server successful!
856.1650 Mbps!
856.9940 Mbps!
856.5410 Mbps!
856.7060 Mbps!
856.5400 Mbps!
```

Jperf 界面显示的测试数据

![](https://static.getiot.tech/rt-thread-netutils-iperf-Jperf-Server.png#center)



## 思考总结

RT-Thread 的 netutils 软件包包含了非常使用的网络工具，本文只是介绍了其中一部分。除了上述常用的网络工具，netutils 软件包也提供一些开发调试中比较实用的网络工具，如 NetIO 工具、Telnet 工具和 tcpdump 工具。这些工具的使用方法可以参考软件包功能目录下的说明文件。
