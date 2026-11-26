---
sidebar_position: 1
sidebar_label: ART-Pi 简介
---

# ART-Pi 开发板简介

ART-Pi 是一款运行 RT-Thread 物联网操作系统的开源硬件平台。ART-Pi 能很好的满足绝大多数开发人员的 DIY 想法，其具备性能强大的主控、实用的外设、丰富的扩展接口，是 RT-Thread 团队耗时半年精心打磨出来的精品，也是学习、DIY、产品原型验证的不二之选。

![](https://static.getiot.tech/artpi-board-banner-1.png#center)



## 硬件资源

### 硬件整体框架

![](https://static.getiot.tech/artpi-hardware-framework.png#center)



### 板载资源

- STM32H750XBH6：Cortex-M7内核，主频高达 480Mhz，具有 16KB I/D Cache，1Mbytes RAM
- 板载 ST-LINK/V2.1
- NOR Flash
  - 16-Mbytes SPI FLASH（W25Q128）
  - 8-Mbytes QSPI FLASH（W25Q64）
- SDRAM：32MB
- AP6212：SDIO WIFI + HDC UART BuleTooth
- USB OTG（Type-C 接口）
- SDIO TF Card 插槽
- RGB888 FPC connector
- LEDs
  - D1（蓝色）：3.3 V Power-on 指示灯
  - D2（红色 + 蓝色）：用户指示灯
  - D4（红色 + 蓝色）：ST-LINK 指示灯
- 按键：user 按键、reset 按键
- 树莓派扩展接口
- ART 扩展接口



### 扩展接口

- 4 路 UART（LPUART）
- 3 路 SPI
- 2 路 I2C
- 1 路 USB-FS
- 1 路 ETH
- 1 路 SAI
- 1 路 DCMI
- 2 路 CANFD
- 超过 5 路 ADC（支持差分输入 ADC）
- 超过 15 路 PWM（支持高精度定时器 HRTIM）



## 软件资源

### SDK

你可以直接在 Github 或 Gitee 代码托管平台下载 ART-Pi 的 SDK，地址如下。

- github 仓库地址：[https://github.com/RT-Thread-Studio/sdk-bsp-stm32h750-realthread-artpi](https://github.com/RT-Thread-Studio/sdk-bsp-stm32h750-realthread-artpi)
- gitee 仓库地址：[https://gitee.com/mirrors/ART-Pi](https://gitee.com/mirrors/ART-Pi)

也可以在 RT-Thread Studio 里下载 SDK，打开资源管理器，勾选 STM32H750-RT-ART-Pi，点击安装。



## 相关链接

- [ART-Pi 项目官网](https://art-pi.github.io/website/)

