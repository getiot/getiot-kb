---
sidebar_position: 2
sidebar_label: PSoC6 RTT 硬件概览
slug: /rtt-psoc6-hardware-overview
---

# 英飞凌 PSoC6 RT-Thread 评估板硬件概览



PSoC™ 62 with CAPSENSE™ evaluation kit 开发板（以下简称 PSoC 6 RTT 开发板）是英飞凌（Infineon）联合 RT-Thread 发布一款面向物联网开发者的 32 位双核 MCU 开发套件，其默认内置 RT-Thread 物联网操作系统。本文主要介绍 PSoC 6 RTT 开发板的板载硬件资源。



## PSoC 6 RTT 板载资源

![](https://static.getiot.tech/PSoC6-RTT-hardware-overview-1.png)



- 主控制器：CY8C624ABZI-S2D42
  - 双核 Arm Cortex-M4（主频 150MHz）+ Arm Cortex-M0（主频 100MHz）；
  - 2MB 代码闪存和 1MB SRAM；
  - 8KB 数据闪存，提供与 EEPROM 类似的数据存储功能；
  - 从 48 引脚到到 100 引脚的封装选择；
  - 内部电压调节电路;
  - 增强型电容触摸感应单元（CTSU2）；
  - 12 位 ADC，12 位 DAC，低功耗比较器；
  - 32 位通用 PWM 定时器，16 位通用 PWM 定时器，低功耗异步通用定时器；
  - RTC 实时时钟。
- Micro SD Card：背面提供了一个 SD 卡插槽，可用于扩展存储容量。
- CAPSENSE™ 触摸滑条：CAPSENSE™ 电容和电感式触摸感应人机界面（HMI）技术，可为家电、工业、消费级和物联网产品等要求严苛的用户界面提供更强的性能和更低的功耗。增强型 HMI 改进了检测范围、手势检测和指向性功能，并加入针对未来先进触摸屏的悬停检测功能，可实现近距离传感等先进解决方案。
- Arduino 接口：提供标准 Arduino 接口，兼容市面上大多数的 Arduino 接口拓展板，极大的提高了开发板拓展性与可玩性。
- 板载 Psoc5 Dap-link 仿真调试器：带有 KitProg3 的板载调试器/编程器。



## CYW43012 Wi-Fi 模块

PSoC 6 RTT 作为物联网开发的评估板，肯定少不了无线通信模块。因此，官方发布了一款 **CYW43012 模块**，它是由英飞凌基于 CYW43012 开发的 SDIO 高速 Wi-Fi & 蓝牙二合一无线模块。

CYW43012 提供超低功耗的 Wi-Fi 和蓝牙连接，可延长可穿戴设备、智能家居产品和便携式音频应用的电池续航时间。同时，其先进的共存引擎可为 2.4 与 5GHz 双频 Wi-Fi 以及双模式蓝牙/低功耗蓝牙（BLE）5.0 应用同时提供最佳的组合性能。是适用于安全、低功耗、特性丰富的物联网产品的完美解决方案。

![](https://static.getiot.tech/PSoC6-RTT-board-entiry-1.jpg)

PSoC 6 RTT 开发板上一开始就预留了 CYW43012 模块的接口，只需要把模块插上去就好了，注意方向不要接错了。因为这个模块的工作电压是 1.8v，所以如果需要使用这个模块的话，需要手动切换 SDIO 接口的电压。在老版的开发板上预留了 1.8v 和 3.3v 切换的电阻。需要手动把 3.3v 的电阻换下来，然后短接 1.8v。

:::tip

新版的开发板，添加了 1.8v 和 3.3v 的切换开关，可以通过切换拨码开关完成 SDIO 接口电压的切换。

:::

![](https://static.getiot.tech/PSoC6-RTT-board-entiry-3.jpg)

CYW43012 Wi-Fi + Bluetooth 芯片的内部框图如下图所示。

![](https://static.getiot.tech/CYW43012-diagram.png)



## 资源链接

- [【PDF】PSoC 6 MCU: CY8C62x8, CY8C62xA Datasheet](https://www.infineon.com/dgdl/Infineon-PSOC_6_MCU_CY8C62X8_CY8C62XA-DataSheet-v17_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee7d03a70b1)
- [【PDF】IFX-PSoC6-RT-Thread Schematic](https://github.com/RT-Thread-Studio/sdk-bsp-cy8c624-infineon-evaluationkit/blob/main/documents/IFX-PSoC6-RT-Thread-sch.pdf)
- [CYW43012: 1x1 Dual-band Wi-Fi 4 (802.11n) + Bluetooth® 5.4 combo - Infineon Technologies](https://www.infineon.com/cms/en/product/wireless-connectivity/airoc-wi-fi-plus-bluetooth-combos/wi-fi-4-802.11n/cyw43012/)
- [基于 RT-Thread Studio 使用 cyw43012 模块 WiFi 功能](https://github.com/RT-Thread-Studio/sdk-bsp-cy8c624-infineon-evaluationkit/tree/main/projects/cyw43012_wifi_demo)
- [基于 RT-Thread Studio 使用 cyw43012 模块蓝牙功能](https://github.com/RT-Thread-Studio/sdk-bsp-cy8c624-infineon-evaluationkit/tree/main/projects/cyw43012_ble_demo)
- [英飞凌开发板上使用 cyw43012 模块进行 WIFI 通讯](https://club.rt-thread.org/ask/article/74bb091d04751d5a.html)
- [英飞凌开发板上使用 cyw43012 模块体验 BLE 开发](https://club.rt-thread.org/ask/article/28ae7191e4dc76c1.html)



