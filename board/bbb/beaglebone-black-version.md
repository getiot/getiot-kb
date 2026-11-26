---
sidebar_position: 2
---

# BeagleBone Black 硬件版本



## BeagleBone Black

BeagleBone Black（BBB）是 BeagleBoard 小组在 2012 年下半年设计的 BeagleBone 升级版，它继承了 BeagleBone 的体积并增加了相当多有用的功能，并且售价从 89 美元降到 45 美元，因此它也变成一个性价比极高开源硬件。

![](https://static.getiot.tech/beaglebone-black-interface.jpg#center)



## BeagleBone Blue

BeagleBone Blue 是一款经济型的全功能机器人控制器，旨在为机器人开发提供一套标准参考设计原型。BeagleBone Blue 具有高效灵活的连网能力，通过实时操作系统 Linux 和其自身丰富的外设，可快速实现构建移动机器人。

![](https://static.getiot.tech/beaglebone-blue-layout.png#center)

**设计优势**

BeagleBone Blue 的设计优势在于提供了众多接口，使其具有强大的连接能力。包括：

- 电池方面：开发板的 2 个电池的 LiPo 支持平衡，可使用 6-16V 的充电器输入；
- 无线方面：主要是802.11、蓝牙4.1和蓝牙；
- 电动机控制方面：8 路 6V 的伺服系统，4 个直流电机驱动；
- 传感器方面：九轴的 IMU 和气压计；
- 连接性方面：高速 USB 2.0 Host 和 Client；
- 其他简单的连接接口：GPS、DSM2 无线电、UART、SPI、I2C、模拟、按钮、LED 等。

除此之外，BeagleBone Blue 在软件开发方面还具有如下优势：

1. 这款开发板可以支持多种编程方法，包括支持集成传感器和驱动器的 CAPI（应用程序接口）；
2. 开发板可以为面向无人机、多旋翼飞行器和探测车的 Ardupilot 开源自动驾驶软件提供主流支持；
3. 机器人操作系统 ROS 不断集成，可支持在 Python 和整个网络上进行高级编程。



## BeagleBone Green

BeagleBone Green（BBG）是 SeeedStudio 和 BeagleBoard 社区共同开发的硬件平台，是专为开发者和业余爱好者设计的、低成本、开源、社区支持的开发平台。 它基于经典版 BeagleBone Black 的开源硬件设计，并做了差异化设计。包括移除了板载 HDMI，增加了两个 Grove 连接器，使其更容易连接到大量 Grove 传感器系列，更合适于物联网产品开发。

![](https://static.getiot.tech/beaglebone-green-layout.png#center)



## BeagleBone Green Wireless

BeagleBone Green Wireless（BBGW）同样是 SeeedStudio 和 BeagleBoard 社区共同努力的成果。它具有很高的辨识度，在 BeagleBone Green 的基础上移除了以太网接口，增加了高性能的 WiFi 和 蓝牙接口，为开发者提供了灵活的无线网络连接功能。

![](https://static.getiot.tech/beaglebone-green-wireless-layout.png#center)



## PocketBeagle

PocketBeagle 是 BeagleBoard 社区在 2017 年推出的一款非常小巧的开发套件，官方给出的尺寸是 56mm x 35mm x 5mm，售价 25 美元。

PocketBeagle 包含一个 1GHz 处理器，灵活的外设接口能够更好地与外设进行连接。适用于游戏、3D打印，机器人和其他电子项目。

![](https://static.getiot.tech/pocket-beagle-layout.jpg#center)



## BeagleBone AI

BeagleBone AI 是 BeagleBoard 社区在 2019 年推出的开发套件，它是一款面向开发人员构建人工智能和计算机视觉应用的高端主板。该板具有与流行且便宜的 BeagleBone Black 相同的外形尺寸，但具有更高的规格。

![](https://static.getiot.tech/beaglebone-AI-layout.png#center)

板载资源方面，核心处理器 TI AM5729 是一个异构 SoC，它由双核 Arm Cortex A15 的 CPU 和双核 Arm Cortex M4 MCU 组成，可充当图像处理单元。在图形方面，GPU 是双核 PowerVR SGX544 3D 单元，还有一个 Vivante GC320 Core 2D 加速器。存储器则升级为 1GB RAM 和 16GB 板载 eMMC 闪存，网络连接支持以太网、Wif 和蓝牙。另外带有高速接口，用于电源的 USB Type-C 端口和双角色控制器，以及 USB Type-A 主机。

BeagleBone AI 的设计目的是为了填补小型 SBC 和更强大的工业计算机之间的空白，帮助实现工业、商业和家庭应用的自动化。



## BeagleV

BeagleV 是 SeeedStudio 和 StarFive 协作研发，并联合 BeagleBoard 社区于 2021 年共同发布的一款基于 RISC-V 的开源硬件。

星光系列（BeagleV™）单板计算机被认为是全球开源领域的一款革命性产品，是 RISC-V 架构的第一款实用级 Linux 电脑。BeagleV 于2021年3月初上线正式开启全球预售，计划2021年9月份实现全面量产供应，售价为 149 美元。

![](https://static.getiot.tech/BeagleV-Linux-RISC-V-SBC.jpg#center)



## 板卡对比

目前市面上最常见的是 BeagleBone Black（BBB）、BeagleBone Green（BBG）和 BeagleBone Green Wireless（BBGW）三款 BeagleBone 开发板，下面列出三款板子的大致情况，供开发者参考。

|          |                  BBB                   |                  BBG                   |                  BBGW                  |
| :------: | :------------------------------------: | :------------------------------------: | :------------------------------------: |
|  处理器  |       AM3358 1GHz ARM Cortex-A8        |       AM3358 1GHz ARM Cortex-A8        |       AM3358 1GHz ARM Cortex-A8        |
|   内存   |             512MB DDR3 RAM             |             512MB DDR3 RAM             |             512MB DDR3 RAM             |
|  Flash   | 4GB 8-bit eMMc on-board flash storage  | 4GB 8-bit eMMc on-board flash storage  | 4GB 8-bit eMMc on-board flash storage  |
| 图形加速 |        3D graphics accelerator         |        3D graphics accelerator         |        3D graphics accelerator         |
| 浮点运算 |    NEON floating-point accelerator     |    NEON floating-point accelerator     |    NEON floating-point accelerator     |
|   PRU    |     2x PRU 32-bit microcontrollers     |     2x PRU 32-bit microcontrollers     |     2x PRU 32-bit microcontrollers     |
|   电源   | USB Client for power and communication | USB Client for power and communication | USB Client for power and communication |
|   USB    |              1x USB Host               |              1x USB Host               |              4x USB Host               |
|   网络   |                Ethernet                |                Ethernet                |         802.11 b/g/n & BLE 4.1         |
|   GPIO   |         2x 46 pin GPIO headers         |         2x 46 pin GPIO headers         |         2x 46 pin GPIO headers         |
|   其他   |               HDMI port                |          2x Grove connectors           |          2x Grove connectors           |

注：PRU 是 Programmable Real-time Unit 的缩写，即“可编程实时单元”，是 Cotex A8 内核中的一个子系统，它可运行在 1/2 CPU 时钟频率下，具有本地的指令和数据 RAM，并可寻址访问整个片上系统资源。





