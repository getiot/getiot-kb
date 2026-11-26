---
sidebar_position: 1
---

# BeagleBone Black 简介



![](https://static.getiot.tech/beaglebone-black-enhanced.jpg#center)



## 发展历程

第一代 BeagleBoard 开发板推出于 2008 年，第三代开发板被命名为 BeagleBone，从这一代开始将 GPIO 口统一放置到开发板的两侧了。BeagleBone Black 诞生于2013年，它是继 BeagleBone 后的新版本，中国版的价格是 399 RMB。

BeagleBoard 家族的开发板均采用德州仪器的 ARM 处理器，BeagleBoard 系列开发板的一大优点是它的开源硬件设计及默认运行开源软件。这意味着 BeagleBoard 所有版本的设计原理图都是开放的，这些设计可以被任何人复制、修改和使用。

官网：[beagleboard.org](https://beagleboard.org)



## 板卡资源

BeagleBone Black Rev.C 是一款基于 AM335x 处理器的开发套件，它集成了 ARM Cortex™-A8 内核，处理速度高达 1GHz，并有丰富的外设。可扩展的接口有以太网、USB、 OTG、TF 卡、串口、JTAG、D 型 HDMI、ADC、I2C、SPI、PWM 及 LCD。可用于满足各种不同的场景需求，如家居工业自动化、消费医疗电子、打印机、 智能收费系统、自动售货机测重系统、教育终端以及高端玩具。

![](https://static.getiot.tech/beaglebone-black-layout.png#center)



### 常规参数

- 板卡尺寸： 86.36 mm×54.61mm
- 工作温度：0 ~ 70℃
- 工作湿度：20% ~ 90%（Non-Condensing）
- 供电电压：5V/0.35A

### AM335x 处理器

- 集成 1GHz ARM Cortex™-A8 内核
- 集成 NEON™ SIMD 协处理器
- 集成 SGX530 图形引擎
- 集成实时可编程子系统单元（PRU）
- 集成 32KB 指令缓存和32KB数据缓存，支持奇偶校验
- 集成 256KB 二级缓存，支持错误校验码

### 板载内存

- 4GB 8位 eMMC 板载闪存
- 512MB DDR3 SDRAM 存储器

### 板载接口

- 1 个 D 型 HDMI 接口（16 位颜色与音频输出）
- 1 个 LCD 接口（24-bit 输出，P8 接口输出）
- 1 个 10/100M 以太网接口（RJ45 接头）
- 1 个带 PHY 的高速 USB 2.0 OTG 接口（Mini USB type-B 接头）
- 1 个带 PHY 的高速 USB 2.0 HOST 接口（USB type-A 接头）
- 1 个 TF 卡槽（兼容 SD/MMC）
- 1 个 3 线调试串口（6 引脚 2.54 接头）
- 1 个 D 型 HDMI 接口
- 2 个扩展接口，可接 LCD、 UART、eMMC、ADC、I2C、SPI 及 PWM 等外设
- 1 个 JTAG 接口（可选，20 引脚标准接口, 默认不焊接）

### 按键 & 灯

- 1 个启动选择按键
- 1 个电源开关
- 1 个复位开关
- 1 个 LED 电源指示灯
- 4 个常规指示灯（用户自定义）

### 操作系统

- Debian
- Angstrom
- Yocto
- Ubuntu
- Android



## 扩展接口

BeagleBone Black Rev.C 两侧的 46 pin 扩展接口定义如下。

![](https://static.getiot.tech/Beaglebone-Black-pinout-diagram.png#center)



## 学习资料

- [https://elinux.org/BeagleBone](https://elinux.org/BeagleBone)（官方 wiki）
- [https://elinux.org/Beagleboard:BeagleBoneBlack](https://elinux.org/Beagleboard:BeagleBoneBlack)
- [http://derekmolloy.ie/beaglebone/](http://derekmolloy.ie/beaglebone/)
- [https://www.element14.com/community/community/designcenter/single-board-computers/next-genbeaglebone/blog](https://www.element14.com/community/community/designcenter/single-board-computers/next-genbeaglebone/blog)
- [http://beaglebone.cameon.net/home](http://beaglebone.cameon.net/home)
- [https://makezine.com/projects/get-started-with-beaglebone/](https://makezine.com/projects/get-started-with-beaglebone/)
- [https://toptechboy.com/beaglebone-black/](https://toptechboy.com/beaglebone-black/)



