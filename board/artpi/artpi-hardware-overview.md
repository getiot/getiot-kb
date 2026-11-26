---
sidebar_position: 2
---

# ART-Pi 硬件概览

![](https://static.getiot.tech/artpi-cover-02.jpeg#center)



## 硬件配置

- STM32H750XBH6：Cortex-M7 内核，主频高达 480MHz，具有 16KB I/D Cache，1MB RAM。
- Flash 存储器：W25Q128，W25Q64
- 无线芯片：AP6212，支持 WiFi 和 Bluetooth
- USB-OTG（Type-C 接口）
- 按键：1个用户按键，1个复位按键
- LCD（RGB 888 接口）
- SDRAM（32M）
- SD Card
- 树莓派扩展接口
- 板载 ST-Link V2.1



## 扩展引脚

ART-Pi 左右两侧分别有一个 40 pin 的扩展接口，接口定义如下：

![](https://static.getiot.tech/artpi-two-40pins-pinout.png#center)

其中，P1 排针扩展引脚与树莓派是兼容的，并且在树莓派原有基础上增加了 FDCAN 复用功能。实际上，上图只是标出了部分功能，ART-Pi 很多 IO 复用功能并未列出，开发者可按需对照芯片的数据手册去查表使用。

总的来说，P1 和 P2 扩展接口可以提供：

- 4 路 UART（支持 LPUART）
- 3 路 SPI
- 2 路 I2C
- 1 路 USB-FS
- 1 路 ETH
- 1 路 SAI
- 1 路 DCMI
- 2 路 CAN FD
- 超过 15 路 ADC（支持差分输入 ADC）
- 超过 15 路 PWM（支持高精度定时器 HRTIM）



## 扩展板

目前，RT-Thread 官方为 ART-Pi 提供了两块扩展板，分别是工控扩展板 Industry-IO 和多媒体扩展板 Media-IO。

![](https://static.getiot.tech/artpi-cover-09.jpeg#center)

类似于 Arduino 扩展板，ART-Pi 的扩展板可以以层叠的方式连接使用。

![](https://static.getiot.tech/artpi-cover-07.jpeg#center-500)

