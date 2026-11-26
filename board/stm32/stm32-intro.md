---
sidebar_position: 1
---

# STM32 简介



STM32 是意法半导体（STMicroelectronics，简称 ST）设计的一系列以 ARM®  Cortex®-M 为核心的 32 位微控制器（MCU）。

2007年，ST 在北京首发了全球首款采用 ARM Cortex-M 内核的处理器 STM32 F1，为 MCU 用户提供了新的开发自由度。它集高性能、实时功能、数字信号处理、低功耗/低电压操作、连接性等特性于一身，同时还提供易于开发的工具、库和文档，使其在随后十几年里得到了广泛的应用。

2019年，在亚太区的 MCU 市场中，ST 超越 NXP 成为该地区 MCU 市场占有率第一的半导体厂商。

![](https://static.getiot.tech/mcu-market-share-2019.png#center)



## 产品生态

目前，STM32 基于 ARM Cortex M0、M0+、M3、M4、M33、M7、A7 内核，提供 16 大产线、5 类产品、超过 1000 个型号的 MCU 产品。

![](https://static.getiot.tech/stm32-32-bit-cortex-mcus-2020.png#center)



## 产品特点

STM32 微控制器具有许多优点，主要体现在以下几个方面：

- **超低的价格**。以 8 位 MCU 的价格，得到 32 位 MCU，是 STM32 最大的优势。
- **超多的外设**。STM32 拥有包括 FSMC、TIMER、SPI、IIC、USB、CAN、IIS、SDIO、ADC、DAC、RTC、DMA 等众多外设及功能，具有极高的集成度。
- **丰富的型号**。STM32 仅 Cortex-M3 内核就拥有 F100、F101、F102、F103、F105、F107、F207、F217 等 8 个系列上百种型号，具有 QFN、LQFP、BGA 等封装可供选择。同时 STM32 还推出了 STM32L 和 STM32W 等超低功耗和无线应用型的 M3 芯片。
- **优异的实时性能**。84个中断，16 级可编程优先级，并且所有的引脚都可以作为中断输入。
- **杰出的功耗控制**。STM32 各个外设都有自己的独立时钟开关，可以通过关闭相应外设的时钟来降低功耗。
- **极低的开发成本**。STM32 的开发不需要昂贵的仿真器，只需要一个串口即可下载代码，并且支持 SWD 和 JTAG 两种调试口。SWD 调试可以为你的设计带来跟多的方便，只需要两个 IO 口，即可实现仿真调试。
- **超长的供货周期**。ST 采用供货长周期计划，MCU、MEMS 等产品具有十年供货承诺，而且是十年滚动续期供货承诺。
- **成熟的生态系统**。ST 与合作伙伴共同构建了一个强大且成熟的 STM32 生态系统，提供完善的开发工具和技术支持，有助于简化产品的开发。
- **完善的开发工具**。硬件方面，ST 提供了为各个系列提供了评估开发板。软件方面，开发者不仅可以使用传统 IDE（包括 Keil 和 IAR），还可以使用一整套免费的 STM32Cube 软件工具和扩展包，轻松解决软件开发方案。



## 应用场景

STM32 作为通用 MCU，市场面对的客户不仅是消费类，更多的是工业控制，通信类客户。在数据采集、电机控制、人机交互、网络连接、USB 通信等方面具有优势。常见的应用场景有：智能制造、医疗保健、智能家居、消费电子、可穿戴设备等等。

随着 STM32 产品的不断丰富，提供更高性能、更安全、更易于连接的 MCU 产品，未来在物联网领域的应用也将不断丰富。



## 资源列表

- ST 官方网站：[https://www.st.com](https://www.st.com)
- STM32 中文官网：[https://www.stmcu.com.cn](https://www.stmcu.com.cn)
- ST 中文论坛：[https://www.stmcu.org.cn](https://www.stmcu.org.cn)
- 新 ST 中文论坛：[https://shequ.stmicroelectronics.cn](https://shequ.stmicroelectronics.cn)
- GitHub 主页：[https://github.com/STMicroelectronics](https://github.com/STMicroelectronics)
- Wiki 文档：[https://wiki.stmicroelectronics.cn/stm32mcu](https://wiki.stmicroelectronics.cn/stm32mcu)





