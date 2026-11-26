---
sidebar_position: 25
---

# nanoDLA 开源逻辑分析仪

![nanoDLA 开源逻辑分析仪](https://static.getiot.tech/nanoDLA-01.jpg#center)

nanoDLA 是一款非常迷你的开源逻辑分析仪，它基于英飞凌（已收购 Cypress）的 Cypress CY7C68013A（简称 FX2LP）芯片方案实现，最高可支持 24Mhz 8 通道同时采样，可应对普通的 UART、I2C 和低速的 SPI 协议。



## 硬件核心

FX2LP是一颗带有 USB 2.0 高速接口的 51 单片机，由于 51 单片机的主频并不高，难以承载 USB 480Mbps 的高速通信，因此 FX2LP 芯片上设计了一个被称为 GPIF 的 IP 核。通过 GPIF 就可以不需要 CPU 的干预，在 GPIO 和 USB 之间直接进行高速的数据传输，而且 GPIF 可以进行编程配置来实现不同协议的支持，非常灵活。

至今你仍然可以在多处看到这颗芯片的身影，典型的如 FPGA 和 PC 之间的数据传输的场景。逻辑分析仪是 FX2LP 的一个常见应用，例如，dslogic 和 PC 之间就是通过一颗 FX2LP 芯片实现高速传输。



## 开源固件

随着开源社区 sigrok 的发展，FX2LP上已经可以完全可以运行开源的固件 [**fx2lafw**](https://github.com/sigrokproject/sigrok-firmware-fx2lafw)，配合开源上位机 PulseView 进行工作。



## 开源上位机

PulseView 是 sigrok 开源软件组织的一款产品，就是我们常说的上位机软件。 PulseView 支持的多种 USB 虚拟仪器，其中逻辑分析仪就达 40 多种，能够解析的通讯协议多达 90 种。

实际上，PulseView 的功能已经非常强大，不逊色于目前的商用的上位机软件。PulseView 不仅简单易用，而且最重要的是开源，这意味着你可以随时自己修改代码，增加新的协议支持或者新功能。

![PulseView 上位机](https://static.getiot.tech/PulseView_I2C_DS1307_Decode.png#center)



## 相关链接

- FX2LP 手册：[https://www.cypress.com/products/ez-usb-fx2lp](https://www.cypress.com/products/ez-usb-fx2lp)
- nanoDLA 仓库：[https://github.com/wuxx/nanoDLA](https://github.com/wuxx/nanoDLA)
- fx2lafw 仓库：[https://github.com/sigrokproject/sigrok-firmware-fx2lafw](https://github.com/sigrokproject/sigrok-firmware-fx2lafw)
- PulseView 仓库：[https://github.com/sigrokproject/pulseview](https://github.com/sigrokproject/pulseview)
- sigrok Wiki：[https://sigrok.org/wiki/Main_Page](https://sigrok.org/wiki/Main_Page)
- miniLA 仓库：[https://gitee.com/SAST-E/miniLA](https://gitee.com/SAST-E/miniLA)
- MUSE LAB：[https://www.muselab-tech.com](https://www.muselab-tech.com)

