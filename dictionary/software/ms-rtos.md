---
sidebar_label: MS-RTOS
sidebar_position: 5
slug: /ms-rtos
---

# MS-RTOS



![](https://static.getiot.tech/ms-rtos-logo.png#center-300)

## 概述

**MS-RTOS**（Micro Safe RTOS）是翼辉信息设计的一款面向未来的安全实时操作系统，主要面向小型物联网设备端的应用。其最大的特点是开创性地在没有 MMU 和资源受限的 MCU上也能支持多进程与动态装载技术。使得应用与系统能分离开发、独立升级。MS-RTOS 支持内核空间内存保护（应用程序通过 syscall 访问内核），使得内核有着非常高的安全性。

MS-RTOS 在提供足够丰富功能的同时，保持了高效简洁的实现，对 ROM、RAM 消耗极低，特别适用于对硬件成本敏感、安全性要求特别高的产品。与此同时翼辉信息提供了一套功能强大的集成开发环境 IDE，给开发者在各种开发阶段提供了强而有力的支撑。

MS-RTOS 在保证小内存消耗的同时采用了目前最先进的设计方法，彻底颠覆传统物联网节点开发方式，提高物联网节点安全性。符合未来 5G 时代万物互联的需求。



## 系统架构

![](https://static.getiot.tech/ms-rtos-framework.png#center)



## 功能特性

- **多进程** —— 允许运行多个进程，进程用户代码工作在 CPU 用户态，通过系统调用（syscall）访问内核资源，利用 MPU 实现进程地址空间相互隔离。
- **动态装载** —— 驱动与应用程序分离开发，应用与系统独立升级，应用程序直接在 FLASH 中运行（无需加载到 RAM 执行，节约 RAM，运行速度更快）。
- **内核安全** —— 进程用户代码工作在 CPU 用户态，通过系统调用（syscall）进入内核, 保护内核不被进程破坏，利用 MPU 做到进程地址空间相互隔离, 进程影响范围最小化，掉电安全文件系统。
- **体积小** —— 模块化设计，高度可配置（标准配置 FLASH：50KB，RAM：32KB，最小配置 FLASH：8KB，RAM：4KB）。
- **硬实时** —— ns 级中断响应延迟，支持中断嵌套；基于优先级抢占式调度，调度时间确定；支持同优先级线程，时间片轮转 RR 和先来先服务 FIFO 调度；互斥量支持优先级继承，防止优先级翻转；进程切换零损耗。
- **高效简洁、功能丰富** —— 内核实现高效简洁；丰富的任务间通信机制：信号量、互斥量 、消息队列、条件变量、事件标志组等；支持动态装载，支持多进程；内存管理；软件定时器；IO 系统；掉电安全文件系统；丰富的驱动框架，包括 UART、SPI、I2C、GPIO、CAN、TOUCH、LCD …...
- **低功耗** —— 支持 Tick-less 技术，减少 Tick 中断；设备低功耗框架；系统空闲时 CPU 进入深度睡眠。
- **高质量** —— 符合 MISRA C 2012 编程规范；白盒测试，内核代码分支覆盖率达 100%；可通过 IEC 61508 SIL3 认证。
- **开发者友好** —— 一致的 API 设计，易于使用；丰富且详尽的开发文档；强大的集成开发环境；Shell 命令行；图形化内核行为分析；内核与应用图形化调试，多线程感知；内核与应用代码覆盖率分析；崩溃现场（寄存器、调用函数栈）分析；静态堆栈消耗量分析；完善的 C 库、C++ 运行时支持。

![](https://static.getiot.tech/ms-rtos-kernel.png#center)



## 应用领域

- 电力
- 轨交
- 汽车
- 医疗
- 航空航天
- 工业自动化



## 学习平台

### MS-RTOS IoT Pi 开发板

IoT Pi 是一块小巧的物联网开发板，开发者们通过 IoT Pi 除了可以掌握 MS-RTOS 的开发技能外，还可以学习到最前瞻的物联网开发技术。

IoT Pi 采用了主频高达 100MHz 的 Cortex-M4 处理器，拥有高达 512KB 的 FLASH 储存空间和 256KB 的 RAM 空间，保证流畅运行 MS-RTOS 和多个应用。IoT Pi 板载了 EEPROM 和 SD 卡插座，可用于储存数据和与 PC 机交互文件。而板载的 WiFi 模块，则能轻松实现 WiFi 无线联网功能。IoT Pi 板载了三个按键和三个 LED 及一个 USB 转串口，使用 USB 线供电的同时也能与 PC 机进行串口通信。此外，IoT Pi 引出了众多的 GPIO，可以方便地与外围模块（如 SSD1306 OLED）相连，大大提升了可玩性。

![](https://static.getiot.tech/ms-rtos-iot-pi.png#center)


官方除了提供 IoT Pi 的 MS-RTOS BSP（板级支持包）外，还提供了众多的开源中间件，如 FAT 文件系统、ESP8266 网络库等，详见 MS-RTOS 开源仓库 [https://github.com/MS-RTOS](https://github.com/MS-RTOS)。开发者们只需要关心应用、发挥创意，快速完成产品原型。

同时，MS-RTOS 实现了 EdgerOS（下一代面向物联网和边缘计算的智能操作系统）的 SDDC（Smart device discovery and control protocol）协议，IoT Pi 通过板载的 WiFi 模块，即能与 EdgerOS 无缝连接，轻松实现远程智能控制。

### MS-RTOS IoT Pi Pro 开发板

IoT Pi Pro 是一块功能丰富、性能强劲的物联网开发板，开发者们通过 IoT Pi Pro 除了可以掌握 MS-RTOS 的开发技能外，还可以学习到最前瞻的物联网开发技术和 GUI 图形界面技术。

IoT Pi Pro 采用了主频高达 400MHz 的 Cortex-M7 处理器，拥有高达 128KB+8MB 的 FLASH 储存空间和 1MB 的 RAM 空间，有效保证流畅运行 MS-RTOS 和多个应用。IoT Pi Pro 板载了 EEPROM 和 SD 卡插座，可用于储存数据和与 PC 机交互文件。而板载的 WiFi 模块，则能轻松实现 WiFi 无线联网功能。与 IoT Pi 相比，IoT Pi Pro 增加了一块显示效果出色、触摸灵敏的显示屏，可满足高端智能设备的人机交互需求。此外，IoT Pi Pro 兼容树莓派的扩展接口，可以方便地与各种外围模块相连，大大提升了可玩性。

![](https://static.getiot.tech/ms-rtos-iot-pi-pro.png#center)


## 资源链接

- [MS-RTOS 项目官网](https://www.edgeros.com/ms-rtos)
- [IoT Pi 快速入门](http://docs.edgeros.com/ms-rtos/IOTPI/QUICK_START.html?from=singlemessage)
- [MS-RTOS 开发手册](http://docs.edgeros.com/ms-rtos/index.html)





## 参考

- [面向未来的安全实时操作系统 —— MS-RTOS](https://blog.csdn.net/lu_embedded/article/details/108505002)
