---
sidebar_position: 2
---

# ESP32-S3-BOX 概览

![](https://static.getiot.tech/ESP32-S3-BOX-banner.webp#center)

## 介绍

ESP32-S3-BOX 是乐鑫信息科技推出的一款 AIoT 应用开发板，搭载支持 AI 加速的 ESP32-S3 的内置 512 KB SRAM 之外，还集成了 16 MB QSPI Flash 和 8 MB Octal PSRAM。它板载一块配置电容触摸面板的 2.4 寸显示屏（分辨率 320 x 240），双麦克风，一个扬声器和两个用于硬件拓展的 Pmod 兼容接口。Pmod 接口共包含 16 个可编程 GPIO，能够为外设提供 3.3V 供电。同时，ESP32-S3-BOX 还提供了 Type-C USB 连接器，可用作 5V 电源输入和串口/JTAG 调试。

ESP32-S3-BOX 凭借 ESP32-S3 强大的 AI 加速能力、改进的 PSRAM 接口和丰富的外围设备，通过乐鑫丰富的 SDK 和解决方案，能够轻松构建在线和离线语音助手、智能语音设备、HMI 触摸屏设备、控制面板、多协议网关等多样的应用。



## 按键和接口

下图展示了 ESP32-S3-BOX 的按键和接口，以及每个部分的详细说明。

![](https://static.getiot.tech/ESP32-S3-BOX-overview.webp#center)

从上到下分别是：

- Mute Button：按下后设备语音唤醒和识别功能被禁用，再次按下恢复语音功能。
- Mute LED：禁用设备语音唤醒和识别功能时，此灯亮，恢复后此灯灭。
- Power LED：给设备供电时，此灯保持常亮。
- Microphone：两个麦克风用于声音信号输入，支持远场语音交互。
- Boot Mode Button：下载按键。按住 Boot 按键的同时按一下 Reset 按键进入“固件下载”模式，通过串口下载固件。
- USB Type-C 接口：5V 电源接口，串口调试和 JTAG 调试。
- Reset Button：复位按键。
- Speaker：1 watt 喇叭，用于音频播放。
- 5V Input From Dock：提供额外 5V 供电，与 USB Type-C 接口 5V 供电二选一。
- Pmod 兼容接口：可直接插入小型 I/O 接口板，拓展外设模块，比如 MicroSD 模块、传感器模块、LED 模块等。（参考 [Digilent Pmod™](https://digilent.com/reference/pmod/start)）



## 开始使用

ESP32-S3-BOX 为用户提供了一个基于语音助手 + 触摸屏控制、传感器、红外控制器和智能 Wi-Fi 网关等功能，开发和控制智能家居设备的平台。ESP32-S3-BOX 出厂支持语音唤醒和离线中英文命令词识别，通过使用乐鑫丰富的 SDK 和例程，用户能够轻松构建在线和离线语音助手、智能语音设备、HMI 触摸屏设备、控制面板、多协议网关等多样的应用。

ESP32-S3-BOX 的 SDK 包含可重构的 AI 语音交互功能，支持用户通过自定义命令词控制智能设备。本文的内容仅为你简要介绍 ESP32-S3-BOX 能实现的参考功能，让你了解如何开始使用开发板。一旦你完成阅读下面的指南，你可以尝试自己开发应用。让我们开始旅程吧！



## 参考

- [ESP32-S3-BOX](https://github.com/espressif/esp-box/blob/master/docs/hardware_overview/esp32_s3_box/hardware_overview_for_box_cn.md)

