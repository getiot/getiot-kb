---
sidebar_position: 5
sidebar_label: PSoC6 RTT 评估板 Wi-Fi
slug: /rtt-psoc6-wifi
---

# 英飞凌 PSoC6 评估板 Wi-Fi 功能

PSoC™ 62 with CAPSENSE™ evaluation kit 开发板（以下简称 PSoC 6 RTT 开发板）是英飞凌（Infineon）联合 RT-Thread 发布一款面向物联网开发者的 32 位双核 MCU 开发套件，其默认内置 RT-Thread 物联网操作系统。本文主要介绍该平台的 Wi-Fi 配件 —— CYW43012 模块的使用，并通过 RT-Thread Studio 快速开发基于 Wi-Fi 无线通讯应用程序。

## CYW43012 模块

CYW43012 模块是由英飞凌基于 CYW43012 开发的 SDIO 高速 Wi-Fi & 蓝牙模块。CYW43012 提供超低功耗的 Wi-Fi®和蓝牙®连接，可延长可穿戴设备、智能家居产品和便携式音频应用的电池续航时间。同时，其先进的共存引擎可为 2.4 与 5-GHz 双频 Wi-Fi 以及双模式蓝牙/低功耗蓝牙（BLE）5.0 应用同时提供最佳的组合性能。

![](https://static.getiot.tech/PSoC6-RTT-board-entiry-1.jpg)

### 硬件连接

PSoC 6 RTT 开发板上一开始就预留了这款模块的接口，只需要把模块插上去就好了，注意方向不要接错了。因为这个模块的工作电压是 1.8v，所以如果需要使用这个模块的话，需要手动切换 sdio 接口的电压。在老版的开发板上预留了 1.8v 和 3.3v 切换的电阻。需要手动把 3.3v 的电阻换下来，然后短接 1.8v。



## 应用示例

使用 RT-Thread Studio 创建对应的示例工程。编译、下载并复位开发板，让程序运行起来了。

打开终端，执行 `wifi scan` 扫描 Wi-Fi 热点。

```bash
msh >wifi scan
             SSID                      MAC            security    rssi chn Mbps
------------------------------- -----------------  -------------- ---- --- ----
TP-LINK_69F6                    58:41:20:3f:69:f6  WPA2_AES_PSK   -89    6    0
CMCC-dy73                       b8:e3:b1:0d:b4:50  WPA2_MIXED_PSK -85    9    0
Rudy-Lab                        5c:02:14:d3:ef:97  WPA2_MIXED_PSK -39   10    0
```

通过 `wifi join` 命令加入 Wi-Fi 热点。

```bash
msh >wifi join Rudy-Lab ********
[I/WLAN.mgnt] wifi connect success ssid:Rudy-Lab
msh >[I/WLAN.lwip] Got IP address : 192.168.2.78
```

这样就可以在英飞凌开发板上使用 cyw43012 模块进行网络开发了。



### 测试

使用 `ping` 命令可以测试网络是否通畅，同时会输出网络延迟信息，可以作为网络延迟的简单测试工具。

```bash
msh >ping getiot.tech
60 bytes from 42.192.64.149 icmp_seq=0 ttl=51 time=39 ms
60 bytes from 42.192.64.149 icmp_seq=1 ttl=51 time=42 ms
60 bytes from 42.192.64.149 icmp_seq=2 ttl=51 time=45 ms
60 bytes from 42.192.64.149 icmp_seq=3 ttl=51 time=43 ms
```

可以 ping 通 getiot.tech，说明 TCP/IP 协议基本没有太大问题（域名解析 OK，而且可以发送数据到公网主机）。



## 参考

- [基于 RT-Thread Studio 使用 cyw43012 模块 wifi 功能](https://github.com/RT-Thread-Studio/sdk-bsp-cy8c624-infineon-evaluationkit/tree/main/projects/cyw43012_wifi_demo)
- [英飞凌开发板上使用 cyw43012 模块进行 WIFI 通讯](https://club.rt-thread.org/ask/article/74bb091d04751d5a.html)

