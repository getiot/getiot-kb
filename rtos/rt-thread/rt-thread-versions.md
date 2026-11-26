---
sidebar_position: 2
authors: [luhuadong]
---

# RT-Thread 版本

RT-Thread 是一个开源的嵌入式实时操作系统，经过十余年的发展，成长为一个小而美的物联网操作系统。实际上，除了我们常用的 RT-Thread 标准版本，还有 Nano 和 Smart 两个开源分支，以及针对商业市场的多个发行版本，例如专用于智能穿戴领域的 PersimUI OS（湃心OS），以及应用于智能表计领域的 MoM（Microkernel on MCU），还有一些许可授权的衍生 OS。

本文将尽可能完整地介绍 RT-Thread 的各种版本，包括开源的、商业的，以及衍生的系统，帮助客户和开发者针对自己的使用场景更快地做出选择。

![](https://static.getiot.tech/rt-thread-version-evolution-2021.jpg#center)

## 开源版本

RT-Thread 针对不同应用场景，目前提供了三个主版本，分别是 RT-Thread 标准版、RT-Thread Nano 和 RT-Thread Smart。代码均可在 [官方网站](https://www.rt-thread.org/page/download.html) 或 [GitHub](https://github.com/RT-Thread) 页面下载。

### RT-Thread 标准版

大家最常用应该是 RT-Thread 标准版（也称为 RT-Thread 全功能版本），它由内核层、组件和服务层、IoT 框架层、文件系统、图形库、设备框架等组成。包含完整的中间件组件，具备低功耗、安全、通信协议支持和云端连接能力，是一个完整的 IoT OS。

![](https://static.getiot.tech/rt-thread-framework-2020.png#center)


可以看到，除了实时内核，RT-Thread 标准版还具备丰富的中间层组件和软件包生态，这也是 RT-Thread 与其他很多 RTOS 的主要区别之一。



### RT-Thread Nano

RT-Thread Nano 是一个极简的硬实时内核，其内存资源占用极小，功能包括任务管理、软件定时器、信号量、邮箱和实时调度等相对完整的实时操作系统特性。对于系统资源紧张或是项目功能较为简单的，则可以选择基于 RT-Thread Nano 进行开发。比如家电、消费、医疗、工控领域的 32 位入门级 MCU。

![](https://static.getiot.tech/rt-thread-nano-framework-2020.png#center)


Tips：RT-Thread Nano 已得到 ARM Keil 官方的认可和支持，在 Keil MDK 中以 pack 方式提供，方便用户使用。



### RT-Thread Smart

RT-Thread Smart 是基于 RT-Thread 操作系统上的混合微内核操作系统，简称为 rt-smart。其定位在于填补传统 RTOS 和大型操作系统 Linux 之间的空白，在实时性、成本、安全性、启动速度等方面取得最佳的平衡。自 V5.0.0 起，rt-smart 分支已合并至 master 分支上，用户下载 rt-thread 源码后，无需再切换至 rt-smart 分支，但需要为 BSP 配置 Smart 内核。

RT-Thread Smart 适用于带 MMU 的中高端应用的芯片，例如 ARM Cortex-A 系列芯片、MIPS 芯片、带 MMU 的 RISC-V 芯片等。能够把应用从内核中独立出来，形成独立的用户态应用程序，并具备独立的地址空间（32 位系统上是 4G 的独立地址空间）。可应用于安防、车载、军工、消费电子等领域。

下图是 RT-Thread Smart 的整体结构框图，在硬件平台的基础上通过 MMU、系统调用的方式把整个系统分成了内核态及用户态。

![](https://static.getiot.tech/rt-thread-smart-framework-2022.png#center)

RT-Thread Smart 在 RT-Thread 标准版的基础上启用独立、完整的进程方式，同时以混合微内核模式执行。这里“混合”的意思是指在编译时决定整体系统采用什么样的运行模式。



## 商业版本

除了以上三个开源版本以外，RT-Thread 还在积极探索商业市场，不断演进出多个商业版本。包括应用于可穿戴领域的 PersimWear OS、应用于航空领域的 RT-Thread Space 等等。

### PersimWear OS

湃心穿戴 OS 底层是 RT-Thread 的内核，使用的是 RT-Thread 开源的版本，提供从设计到开发和测试的完整的工具支持。中间层的模块包括 GUI 引擎、通讯组件、NFC、存储类工具，中间件比 RT-Thread 要高级，中上层是 JS 搭建的应用程序框架，最上层则是应用开发层。

![](https://static.getiot.tech/persimos-framework-2022.png#center)

湃心穿戴 OS 有几大特色：

- 采用 RTOS 的第四代柿饼 GUI，具备类 Android 界面交互，支持多点触摸，效果更加炫酷，同时支持矢量图形库，具备增强的图形处理能力。
- 小程序的开发模式。采用类微信小程序开发模式，上手极快，应用轻量级，支持应用商店，极速安装体验，支持多国语音。
- 提供 MWM 应用开发框架。应用的界面开发和业务逻辑是互相结耦的，贴合前端工程师习惯。
- 跨平台能力。软件一次开发，即可在任一硬件 CPU、MCU 及 MPU 平台上运行；系统高度可裁剪，最小 160KB RAM，512 KB ROM；提供模拟器环境，无需真实硬件，即可进行应用开发；RTT 自身具备中立属性。

湃心穿戴 OS 还具备一些创新性的组件，如消息管理引擎（EMQ）、数据管理组件（DCM）、KVDB 及 TSDB 数据库、DIY 开发套件。此外，官方还推出了湃心 Studio IDE 和 PX1 DIY 手表开发套件，方便用户学习和验证技术方案。在生态方面，Persim OS 已经启动在线应用商店，增加对移动支付、视频通话等功能的支持，助力实现穿戴设备「进一步取代手机功能」的目标。

更多介绍：[湃心网站](https://www.rt-thread.com/persimos/)



### RT-Thread Secure

RT-Thread Secure 是一款稳定可靠的高性能实时操作系统，主要面向航空航天、轨道交通、电力、工业控制等可靠性要求苛刻的特种行业，常用 VxWorks、QNXLinux，用来开发诸如雷达、星载计算机、火箭，导弹控制、通信终端、显控、DCS 等产品。

RT-Thread Secure 主要针对国产 MPU 和 MCU 进行适配和优化，集成了安全 Bootloader，支持可信启动、安全升级、多冗余度安全启动功能，通过 IEC 61508 SIL3 认证。

![](https://static.getiot.tech/rt-thread-secure-framework-2020.png#center)

更多介绍：[RT-Thread Secure](https://www.rt-thread.com/products/Secure-29.html)



### RT-Thread Space

RT-Thread Space 是一款面向航天领域的高安全可靠实时操作系统内核，全静态化内存管理，极致精简，核心代码小于 5000 行，遵循国军标操作系统接口规范，已被用于多个航天型号中。

![](https://static.getiot.tech/rt-thread-space-framework-2020.png#center)

RT-Thread Space 具有如下特点：

- 自主可控，拥有全部源代码和知识产权，具备优秀的维护和升级能力；
- 空间确定性：采用全静态化的内存管理机制，为系统提供了最好的可靠性与实时性；
- 时间确定性：实时响应时间达微秒级；
- 极致精简，核心系统源码规模小于 5000 行；
- MC/DC 测试覆盖率达 100%。

更多介绍：[RT-Thread Space](https://www.rt-thread.com/products/Space-28.html)



### RT-Thread Smart Pro

RT-Thread Smart Pro 是一款面向实时应用场合的高性能混合微内核操作系统，是 RT-Thread Smart 的商用版本。它能够填补传统 RTOS 和大型操作系统 Linux 之间的空白，针对 MPU 类芯片， 具备内核精简、快速启动、实时抢占调度、系统和应用安全隔离保护，完整的 POSIX 接口、方便开发和调试等特性。

它提供 RT-Thread Studio Pro（专业版）一站式集成开发环境，集设计、开发、配置、调试、测试、运行、发布于一体，可帮助用户最大限度的降低开发难度，让产品的配置裁剪、编码，调试和部署变得容易。

更多介绍：[RT-Thread Smart Pro](https://www.rt-thread.com/products/Smart-30.html)



### “程翧”车载软件平台

“程翧”是 RT-Thread 在2022年3月推出的车载融合软件平台。基于“程翧”平台，睿赛德科技可以给汽车行业提供三个方面的支持，分别是 RT-Thread 操作系统，包括安全型实时操作系统 RT-Thread Secure Auto 和微内核操作系统 RT-Thread Smart Auto，虚拟化系统 vmRT-Thread Hypervisor，以及 vmBUS 统一消息总线。

RT-Thread Secure Auto 主要适用于基于 ARM Cortex-R/M 内核研发的 MCU，目前已获得英飞凌、NXP、德州仪器、意法半导体相关平台的支持，可广泛应用于安全网关、区控制器、毫米波雷达、智能传感器/执行器、分体式仪表盘、抬头显示、三电模块等场景。

RT-Thread Smart Auto 重点针对的是基于复杂的 Arm Cortex-A 核芯片研发的 MPU，旨在填补传统 RTOS 和大型操作系统 Linux 之间的空白。除了上面主流的芯片厂商，目前 RT-Thread Smart Auto 还获得了黑芝麻智能、恩智浦、赛灵思等厂商的支持，可用于 4D 毫米波雷达、激光雷达、域控制器、5G-V2X 智能天线等场景。

vmRT-Thread Hypervisor 则是一套建立在 RT-Thread 基础上、面向多核 SMP 处理器的虚拟机。基于该虚拟平台，可以让不同安全要求的操作系统运行在同一硬件平台上，以更好地实现资源的划分和隔离。



## 衍生 OS

类似于 Linux 和 RedHat、Ubuntu 等发行版的关系，RT-Thread 也有一些衍生的 OS 版本。但这部分可能涉及商业秘密，不便透露太多，这里只介绍中国移动的 OneOS。

### 中移 OneOS

OneOS 是中国移动针对物联网领域推出的轻量级操作系统，具有可裁剪、跨平台、低功耗、高安全等特点，支持 ARM Cortex-M/R/A、MIPS、RISC-V 等主流 CPU 架构，兼容 POSIX、CMSIS 等标准接口，支持 Micropython 语言开发，提供图形化开发工具，能够有效提高开发效率并降低开发成本，帮助客户开发稳定可靠、安全易用的物联网应用。

![](https://static.getiot.tech/oneos-architecture-2023.png#center)

和 RT-Thread 一样，OneOS 也遵循 Apache 2.0 许可证，个人、企业客户可以免费在商业产品中使用，不需要公布应用程序源码，没有潜在商业风险。OneOS 源代码托管于 Gitee，点击 [这里](https://gitee.com/cmcc-oneos) 访问。

更多介绍：[OneOS - 中国移动物联网操作系统](https://os.iot.10086.cn/)

