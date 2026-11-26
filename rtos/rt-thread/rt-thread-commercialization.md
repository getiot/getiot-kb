---
sidebar_position: 16
draft: true
authors: [luhuadong]
---

# RT-Thread 商业化



2022年3月，RT-Thread 发布了「程翧」车载融合软件平台，这是集 OS、虚拟化系统及相关扩展组件等于一体的平台。

基于「程翧」平台，可以向汽车行业提供三方面的支持，分别是：

- RT-Thread 操作系统，包括安全型实时操作系统 RT-Thread Secure Auto 和微内核操作系统 RT-Thread Smart Auto；
- 虚拟化系统 vmRT-Thread Hypervisor；
- vmBUS 统一消息总线。

整体上，程翧平台的适用性很广，目前除信息娱乐系统以外，其它场景都是这一平台的目标场景。

比如，**RT-Thread Secure Auto** 主要适用于基于 ARM Cortex-R/M 内核研发的 MCU，目前已获得英飞凌、NXP、德州仪器、意法半导体相关平台的支持，可广泛应用于安全网关、区控制器、毫米波雷达、智能传感器/执行器、分体式仪表盘、抬头显示、三电模块等场景。

**RT-Thread Smart Auto** 重点针对的是基于复杂的 Arm Cortex-A 核芯片研发的 MPU，旨在填补传统 RTOS 和大型操作系统 Linux 之间的空白。除了主流的芯片厂商，目前 RT-Thread Smart Auto 还获得了黑芝麻智能、恩智浦、赛灵思等厂商的支持，可用于 4D 毫米波雷达、激光雷达、域控制器、5G-V2X 智能天线等场景。

vmRT-Thread Hypervisor 则是一套建立在 RT-Thread 基础上、面向多核 SMP 处理器的虚拟机。基于该虚拟平台，可以让不同安全要求的操作系统运行在同一硬件平台上，以更好地实现资源的划分和隔离。

例如在 64 位多核 Cortex-A 处理器上运行 Linux、Android、RT-Thread Secure Auto 及 RT-Thread Smart Auto 等多个不同的系统，从而实现功能、实时性及安全性并重，该技术在区控制器、高性能域控制器等的研发过程中具有广泛应用。

安全方面，在「程翧」软件平台开发过程中，睿赛德科技也是严格按照车规要求推进的，并已获得相应认证。今年 2 月，RT-Thread Smart for Safety 已经通过了 SGS 的 ISO 26262 ASIL D、IEC 61508 SIL 3、EN 50128 SIL 4 功能安全认证，接下来睿赛德科技将推进的是针对虚拟化扩展的认证。

除此之外，睿赛德科技也会针对「程翧」平台提供相关的工具链支持，包括为 RT-Thread 量身定制的一站式开发工具 RT-Thread Studio，支持应用程序源码级调试的 VS Code + Smart 扩展插件，适用于多核、多芯片、多控制器条件下的车载应用层建模工具 System Designer，适用于多核、异构场景下的通用时序数据分析工具 System Tools Suite 等。

总的来说，睿赛德科技提供的是一套全栈式的车载 OS 解决方案，而且可以提供「白盒「」模式和定制化开发。



