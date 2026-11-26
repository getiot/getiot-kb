---
sidebar_position: 6
sidebar_label: PSoC6 RTT 评估板蓝牙 BLE
slug: /rtt-psoc6-bluetooth
---

# 英飞凌 PSoC6 评估板蓝牙 BLE 功能

PSoC™ 62 with CAPSENSE™ evaluation kit 开发板（以下简称 PSoC 6 RTT 开发板）是英飞凌（Infineon）联合 RT-Thread 发布一款面向物联网开发者的 32 位双核 MCU 开发套件，其默认内置 RT-Thread 物联网操作系统。本文主要介绍该平台的 Wi-Fi 配件 —— CYW43012 模块的使用，并通过 RT-Thread Studio 快速开发基于蓝牙 BLE 无线通讯应用程序。



## CYW43012 模块

CYW43012 模块是由英飞凌基于 CYW43012 开发的 SDIO 高速 Wi-Fi & 蓝牙模块。CYW43012 提供超低功耗的 Wi-Fi®和蓝牙®连接，可延长可穿戴设备、智能家居产品和便携式音频应用的电池续航时间。同时，其先进的共存引擎可为 2.4 与 5-GHz 双频 Wi-Fi 以及双模式蓝牙/低功耗蓝牙（BLE）5.0 应用同时提供最佳的组合性能。

![](https://static.getiot.tech/PSoC6-RTT-board-entiry-1.jpg)

### 硬件连接

PSoC 6 RTT 开发板上一开始就预留了这款模块的接口，只需要把模块插上去就好了，注意方向不要接错了。因为这个模块的工作电压是 1.8v，所以如果需要使用这个模块的话，需要手动切换 sdio 接口的电压。在老版的开发板上预留了 1.8v 和 3.3v 切换的电阻。需要手动把 3.3v 的电阻换下来，然后短接 1.8v。



## 应用示例

下载并复位开发板，让程序运行起来，可以看到，BLE 固件已经正常初始化了。

```bash
Bluetooth Stack Initalization Successful
```

稍等一会等待蓝牙模块初始化完成。

### 体验 hello 示例

安装英飞凌 蓝牙连接 APP —— [AIROC Bluetooth Connect App](https://www.infineon.com/cms/en/design-support/tools/utilities/wireless-connectivity/cysmart-mobile-app/)。

关于示例demo的详细介绍可以参考 https://github.com/Infineon/mtb-example-btstack-freertos-hello-sensor



## 参考

- [基于 RT-Thread Studio 使用 cyw43012 模块蓝牙功能](https://github.com/RT-Thread-Studio/sdk-bsp-cy8c624-infineon-evaluationkit/tree/main/projects/cyw43012_ble_demo)
- [英飞凌开发板上使用 cyw43012 模块体验 BLE 开发](https://club.rt-thread.org/ask/article/28ae7191e4dc76c1.html)

