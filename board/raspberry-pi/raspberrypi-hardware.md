---
sidebar_position: 2
authors: [luhuadong]
---

# 树莓派硬件概述

树莓派（Raspberry Pi）自从 2012 年推出以来，已经发布了多个硬件版本，每一代都有不同的特性和适用场景。本文是对主要树莓派硬件版本的整理，方便你快速了解它们的差异和特点。



## 标准树莓派硬件版本一览

### Raspberry Pi 1 系列（2012）

- **型号**：Model A、Model B、Model A+、Model B+
- **CPU**：700 MHz 单核 ARM11
- **RAM**：256MB / 512MB
- **接口**：USB 2.0、HDMI、GPIO（26 或 40 针）
- **特点**：第一代产品，性能有限，但非常适合学习基础电子和 Linux。



### Raspberry Pi 2（2015）

- **型号**：Model B
- **CPU**：900 MHz 四核 ARM Cortex-A7
- **RAM**：1GB
- **接口**：和 B+ 相似
- **特点**：首次引入四核处理器，运行更流畅，适合轻量级桌面和 IoT 项目。



### Raspberry Pi 3 系列（2016–2018）

- **型号**：Model B、Model B+
- **CPU**：1.2GHz / 1.4GHz 四核 ARM Cortex-A53
- **RAM**：1GB
- **无线**：Wi-Fi 802.11n / ac，蓝牙 4.1 / 4.2
- **特点**：首次内置无线功能，更适合做媒体中心、服务器和物联网设备。



### Raspberry Pi 4 系列（2019）

- **型号**：Model B（2GB / 4GB / 8GB RAM 版本）
- **CPU**：1.5GHz 四核 ARM Cortex-A72
- **RAM**：2GB / 4GB / 8GB
- **接口**：USB 3.0、千兆网口、双 Micro-HDMI
- **特点**：性能飞跃，可以运行完整 Linux 桌面系统，适合高性能项目和轻量服务器。



### Raspberry Pi 400（2020）

- **类型**：键盘集成型
- **CPU**：1.8GHz 四核 ARM Cortex-A72
- **RAM**：4GB
- **特点**：将树莓派集成到键盘中，更适合教育和编程学习。



### Raspberry Pi Zero 系列（超低功耗）

- **Zero（2015）**：1GHz 单核，512MB RAM，无无线
- **Zero W（2017）**：加入 Wi-Fi 和蓝牙
- **Zero 2 W（2021）**：升级为四核 Cortex-A53，性能提升大

**特点**：尺寸小巧、功耗低，适合便携式设备、嵌入式项目等。



### Raspberry Pi 5（2023）

- **CPU**：2.4GHz 四核 ARM Cortex-A76
- **GPU**：VideoCore VII，支持双 4K 显示
- **RAM**：4GB / 8GB LPDDR4X
- **存储**：支持 PCIe 2.0（扩展 SSD 等）
- **特点**：大幅提升性能，适合桌面应用、高级项目开发。



## Raspberry Pi Pico 系列概览

除了功能完整的树莓派电脑板（如 Pi 4、Pi 5 等），树莓派基金会还推出了面向微控制器项目的 **Raspberry Pi Pico 系列**，这一系列专为嵌入式开发、低功耗控制类项目设计，非常适合 Maker 玩硬件。

:::tip

Pico 系列不像传统树莓派那样运行 Linux，而是运行裸机程序或实时操作系统（如 FreeRTOS、TinyUSB 等），更类似于 Arduino 的风格，适合对时间精度和硬件控制要求较高的项目。

:::



### Raspberry Pi Pico（2021）

- **主控芯片**：RP2040（树莓派官方首颗 MCU）
- **核心**：双核 ARM Cortex-M0+ @ 133MHz
- **内存**：264KB SRAM
- **闪存**：2MB（外置）
- **接口**：
  - 26 个多功能 GPIO（3 个 ADC）
  - SPI / I2C / UART / PWM / USB 1.1（Device 模式）
- **特色**：
  - 拥有 **PIO（可编程 I/O）** 模块，可实现软 UART、DVI 输出等高级功能
  - 极低功耗，适合电池供电项目
  - 编程语言支持 C/C++ 和 MicroPython



### Raspberry Pi Pico W（2022）

- **在 Pico 基础上增加**：
  - Wi-Fi（2.4GHz，基于 Infineon CYW43439）
- **特点**：
  - 非常适合无线传感器、物联网项目
  - 尺寸与 Pico 相同，兼容大多数 Pico 扩展板



### Raspberry Pi Pico H / WH

- **区别**：
  - “H” 表示预焊接排针，适合不想自己焊接的用户
  - “WH” 是 “W” 的预焊排针版本（无线 + 排针）
- **其他功能一致**



## 总结建议

如果你正在考虑做一些如家居自动化、摄像头监控、机器人等项目，或者想学习嵌入式 Linux 和 Python 开发，那么可以选择标准树莓派，目前最新版本是 Raspberry Pi 5。

| 用途                     | 推荐版本                      |
| ------------------------ | ----------------------------- |
| 入门电子项目、GPIO 学习  | Raspberry Pi 3 B+、Pi 4       |
| 嵌入式、便携式设备       | Raspberry Pi Zero W、Zero 2 W |
| 桌面、媒体中心、轻服务器 | Raspberry Pi 4、Pi 5          |
| 编程教育、学生用机       | Raspberry Pi 400              |

如果你最近正考虑做一些传感器、按键、LED、机器人、遥控器类的项目，不需要 Linux 系统，并且对低功耗和实时性要求较高，那么 Pico 会是一个非常轻巧好用的起点。而且 Pico 的 C/C++ SDK 和 MicroPython 文档也非常完整，非常适合 Maker 深入学习嵌入式开发。

| 项目方向                   | 推荐型号                                |
| -------------------------- | --------------------------------------- |
| 学习嵌入式编程 / GPIO 控制 | Raspberry Pi Pico                       |
| 无线传感器 / IoT 控制器    | Raspberry Pi Pico W / Pico WH           |
| 电池供电、超低功耗         | Raspberry Pi Pico（适合睡眠唤醒类任务） |
| 自定义协议 / 高速 GPIO     | Raspberry Pi Pico（利用 PIO 实现）      |

Raspberry Pi Pico 与标准树莓派的区别如下表所示：

|   特性   |           树莓派电脑系列           |                 Pico 系列                  |
| :------: | :--------------------------------: | :----------------------------------------: |
| 操作系统 |               Linux                |             无操作系统（裸机）             |
|  处理器  |        高性能 ARM Cortex-A         |             嵌入式 Cortex-M0+              |
|   存储   |          SD 卡或板载 eMMC          |                 板载 Flash                 |
|   通信   |      USB / Wi-Fi / LAN / 蓝牙      |      USB Device / Wi-Fi（仅 Pico W）       |
| 适用方向 | 桌面级应用、媒体、服务器、机器人等 | 低功耗控制器、传感器、实时控制、电机驱动等 |

