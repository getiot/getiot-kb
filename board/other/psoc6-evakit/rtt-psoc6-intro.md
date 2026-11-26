---
sidebar_position: 1
sidebar_label: PSoC6 RTT 评估板简介
slug: /rtt-psoc6-intro
---

# 英飞凌 PSoC6 RT-Thread 评估板简介



## 概述

2023年，英飞凌（Infineon）联合 RT-Thread 发布了一款 PSoC™ 62 with CAPSENSE™ evaluation kit 开发板 （以下简称 PSoC 6 RTT 开发板），该开发套件默认内置 RT-Thread 物联网操作系统。PSoC 6 RTT 开发板具有丰富的软硬件资源和低成本优势，兼容 Arduino 接口，助力开发者教育评估以及实现创意开发。

PSoC 6 RTT 开发板的主控制器是 PSoC™ 62 系列的 CY8C624ABZI-S2D42，该系列是 Arm-Cortex-M4 和 Arm-Cortex-M0 的双核组合。具体来说，它包括具有单周期乘法的150MHz Arm Cortex-M4F 核心（浮点和存储器保护单元）和 100-MHz Cortex M0+ 核心，带单周期乘法和内存保护单元 MPU，可以充分发挥 PSoC6 双核芯片性能。另外，还具有可编程数字和模拟资源以及一流的用于触摸的 CAPSENSE™ 技术。

![](https://static.getiot.tech/psoc6-evakit-board-1.png)

英飞凌的 PSoC™ 62 系列芯片专为物联网应用而设计，广泛用于可穿戴设备、智能家居、工业物联网、便携式医疗设备等领域。同时，PSoC 6 RTT 开发板提供标准 Arduino 接口，兼容市面上大多数的 Arduino 接口拓展板，极大的提高了开发板拓展性与可玩性。通过 PSoC 6 RTT 开发板学习，可掌握物联网应用的开发方法，释放你的创造力！

:::tip

2020年4月16日，英飞凌科技股份公司（Infineon）正式宣布收购赛普拉斯半导体公司（Cypress）。此后，赛普拉斯成为英飞凌的一部分。PSoC 6 系列微控制器最早是赛普拉斯推出的 MCU，也是业界首款专为 IoT 终端市场开发的双核处理平台，无缝集成了 IoT 终端应用关键的硬件安全与连接功能。

:::



## 硬件特性

简单来说，PSoC 6 RTT 开发板具有如下硬件特性：

- MCU：CY8C624ABZI-S2D42
  - Cortex-M4（主频 150MHz）
  - Cortex-M0（主频 100MHz）
  - 2MB Flash 和 1MB SRAM
- 板载资源
  - Micro SD Card
  - CAPSENSE™ 触摸滑条
  - Arduino 接口
  - 带有 KitProg3 的板载调试器/编程器



## PSoC™ 62 产品特性

PSoC™ 62 支持高达 2MB 的闪存、1MB 的片上 SRAM 和高达 104 个 GPIO。该系列产品具有如下特性：

- 40nm工艺的单芯片双核架构（ARM® Cortex®-M4 and ARM Cortex®-M0+）；
- 领先的超低功耗设计 ACTIVE 工作模式 22-μA/MHz 和睡眠模式 4.5-μA；
- 片内 1MB Flash，288KB SRAM，QSPI 接口可以外扩 Flash 和 RAM，支持 XIP 功能；
- 可编程灵活的高集成度的架构，包括模拟运放、ADC、DAC、比较器，数字的串行通讯接口 I2C、SPI、UART、I2S、USB；
- 支持 Bluetooth5.0 低功耗蓝牙 BLE 实现无线互联；
- 集成了业内领先的电容触摸技术 CapSense® ，支持自容和互容模式；
- 支持高达 8 路的 PDM-PCM 数字麦克风阵列；
- 内置安全加密引擎确保可信任的执行环境 Trusted Execution Environment (TEE) 的数据安全性；
- 支持高达104 个 GPIO。

![](https://static.getiot.tech/PSoC62xA-features.png)

PSoC 6 有单核和双核 MCU，你可以在[这里](https://www.infineon.com/cms/cn/product/microcontroller/32-bit-psoc-arm-cortex-microcontroller/psoc-6-32-bit-arm-cortex-m4-mcu/)查看 PSoC 6 系列所有产品的详细介绍。



## 资源链接

- [【PDF】PSoC 6 MCU: CY8C62x8, CY8C62xA Datasheet](https://www.infineon.com/dgdl/Infineon-PSOC_6_MCU_CY8C62X8_CY8C62XA-DataSheet-v17_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee7d03a70b1)

