---
sidebar_position: 1
authors: [luhuadong]
---

# μC/OS-II 简介

**uC/OS-II**（Micro-Controller Operating System Version 2）是一款小型、开源、可移植、可裁剪、具有实时特性的嵌入式操作系统。它由 [**Jean J. Labrosse**](https://www.linkedin.com/in/jean-labrosse-b8b425/) 编写，是 RTOS 教学领域的经典之作，在嵌入式开发界有着广泛的影响力。

:::tip 关于 uC/OS 这个名字 🤔

uC/OS 正确的名称是 µC/OS 或 MicroC/OS，μ 即微（micro-），是一个国际单位制词头，指 10<sup>-6</sup>，一百万分之一。因此 μC/OS 的意思就是运行在微控制器上的实时操作系统。但由于 μ 不是 [ASCII](/computerbasics/ascii/) 中的字符，因此常常用字母 u 来替代。

:::



## uC/OS 系列概览

uC/OS 系列包括两个主要版本：

|     版本      | 说明                                                         |
| :-----------: | ------------------------------------------------------------ |
| **uC/OS-II**  | 第二代，功能稳定，结构清晰，广泛用于教学与中小型项目。       |
| **uC/OS-III** | 第三代，支持更多高级特性（如多个任务同优先级、时间片轮转等），但相对复杂。 |

本教程将以 **uC/OS-II 为主线**，因为它结构简单，非常适合作为学习实时操作系统的入门教材。



## 主要特性

- ✅ 源码开放（但非完全自由许可）
- 🔄 抢占式多任务调度
- 🧵 支持 64 个任务（除保留优先级）
- 🕒 精确的时间管理与任务延时
- 🔧 可裁剪、可配置
- 📦 支持信号量、互斥量、邮箱、消息队列
- ⚙️ 高度可移植，适配多种 MCU



## 应用领域

尽管 uC/OS 系列近年来被 FreeRTOS、RT-Thread、Zephyr 等更现代的 RTOS 逐渐取代，但它依然在如下领域有一定影响：

- 嵌入式教学、实验项目
- 工控自动化设备
- 老旧嵌入式系统维护
- 安全/航空/军工类项目（部分版本曾通过 DO-178B Level A 安全认证）



## 支持的硬件平台

μC/OS-II/III 支持 8 位、16 位、32 位微控制器（MCU），例如 STM32、LPC17xx（NXP）、Kinetis K60、SAM3X8E 等都是常见的硬件平台，在工业控制领域有广泛使用。

|    架构类别    | 代表芯片/平台                       | 是否有官方移植                   |
| :------------: | ----------------------------------- | -------------------------------- |
|  **8 位 MCU**  | 8051（如 AT89C52）、AVR             | ✅（8051 有完整移植）             |
| **16 位 MCU**  | TI MSP430、Renesas M16C             | ✅（少量）                        |
| **32 位 MCU**  | **ARM Cortex-M0/M3/M4/M7**（STM32） | ✅（重点支持）                    |
|                | NXP LPC 系列、Freescale Kinetis     | ✅                                |
|                | Atmel SAM 系列、Silicon Labs        | ✅                                |
| **ARM9/ARM11** | S3C2440、i.MX 系列                  | ✅（可运行 Linux 之前的裸机开发） |
|   **RISC-V**   | SiFive Core、K210                   | 部分移植                         |
|  **DSP 平台**  | TI C6000、Analog Devices SHARC      | ✅                                |
|   **x86/PC**   | PC（DOS 下 or 模拟运行）            | ✅（教学/模拟用途）               |



## 还值得学习 uC/OS-II 吗？

虽然如今 uC/OS-II/III 的市场热度有所下降，但学习它仍然有很多好处：

1. **源码极其简洁清晰**，非常适合理解调度器、任务切换、同步通信等核心概念。
2. **大量资料可查**，有《μC/OS-II源代码剖析》、Labrosse 原著等经典书籍。
3. **移植门槛低**，适用于 8051、ARM Cortex-M、STM32 等多种平台。
4. **为理解 FreeRTOS 等现代 RTOS 打下基础**。



## 与 FreeRTOS 对比简述

|    特性    |        uC/OS-II        |     FreeRTOS     |
| :--------: | :--------------------: | :--------------: |
|  开发语言  |           C            |        C         |
|  源码许可  |   Apache 2.0（开源）   |   MIT（开源）    |
| 最大任务数 |           64           |    理论无限制    |
| 时间片调度 |        ❌ 不支持        |    ✅ 可选支持    |
| 优先级机制 | 固定优先级，不允许重复 | 可配置相同优先级 |

uC/OS-II 更注重简洁与实时性，而 FreeRTOS 则更具扩展性和开源社区支持。

:::info 重要信息 📣

uC/OS-II 以前采用的是“仅读者授权/商业授权”，即学生、开发者可以获取源码进行学习，但是用作产品开发需要获得商业授权。之后在2020年3月决定开源，并采用 Apache 2.0 开源许可协议进行发布，目前除了uC/CAN、uC/MPU、uC/timespace 和 uC/GUI 之外，µC/OS-II 和 µC/OS-III 及其组件部都已经开源，并且允许商用了。

:::



## 教程预告

本系列教程将从零开始，带你逐步掌握 uC/OS-II 的使用与原理，包括：

- 如何移植 uC/OS-II 到 STM32 等平台
- 如何创建任务、使用信号量、消息队列等
- 实战多任务协同控制
- 分析系统运行与调试技巧



## 资源链接

- [µC/OS 官方网站](https://weston-embedded.com/micrium-software)
- [µC/OS-II 源码仓库（GitHub）](https://github.com/weston-embedded/uC-OS2)
- [µC/OS-III 源码仓库（GitHub）](https://github.com/weston-embedded/uC-OS3)
