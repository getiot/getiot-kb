---
sidebar_position: 2
slug: /threadx
sidebar_label: ThreadX
---

# ThreadX 实时操作系统



## 简介

ThreadX 是由 Express Logic 公司开发的嵌入式实时操作系统。Express Logical 位于加州 San Diego，这里汇集了美国无线通信和医疗领域的高科技公司，著名的高通（Qualcom）公司总部就在 San Diego，德州仪器、三星、Intel、摩托罗拉、松下等全球主流的高科技企业均在此地设有专门的无线通信研发机构，这使得 ThreadX 在无线通信领域有大量的应用。

ThreadX 支持多任务，采用抢占式任务调度模式，提供独立内存管理，支持线程间通信、互斥、事件和线程同步等基本功能。ThreadX 名字是由来有两个方面，Thread（线程）是操作系统的可执行单元， X 表示上下文切换。ThreadX 的线程共享同一内存空间，资源可共享。

2019年4月，微软收购 Express Logic 公司，经过了一年多的准备，微软将 ThreadX 包装成了 Azure-rtos 并将其开源出去。2023年底，微软宣布在 MIT 许可证下将 ThreadX RTOS 开源，将其捐赠给 Eclipse 基金会，因此改名为 Eclipse ThreadX。

如今，ThreadX 已成为一个不可小觑的 RTOS 系统，在汽车、工业设备、医疗设备、航空航天等领域都得到广泛应用。截至2023年底数据显示，全球有 120 亿台设备在运行这款系统上。

:::info

ThreadX 的作者是 [Willian Lamie](https://en.wikipedia.org/wiki/William_Lamie) 博士，他也曾是 Nucleus RTOS 的作者，该系统发展到 1.3 版本后被 Mentor 公司收购。而后他成立了 Express Logic 公司，重新开发了一个 ThreadX RTOS，后来被微软收购。之后他离开了微软又创办了新的公司，开发了新的实时操作系统 PX5 RTOS。

![](https://static.getiot.tech/Willian-Lamie-1.jpg#center)

:::



## 主要特点

ThreadX 嵌入式操作系统具有如下特点：

- **技术成熟、可扩展性强。** ThreadX 已经发展 20 年有余，目前在全球超过 120 亿台设备上运行，是公认的高性能、高稳定性实时操作系统。
- **基于宽松的开源许可证。** ThreadX 将采用 MIT 开源许可证，为用户和采用者提供高度宽松的许可条款。
- **以厂商中立为基调进行开源管理。** ThreadX 将由 Eclipse 基金会管理并遵循其开发流程，保证以厂商中立的治理模式推动其发展和延续，造福于整个技术行业。
- **通过了功能安全认证。** ThreadX 已通过 SGS-TÜV Saar 认证，符合 IEC 61508、IEC 62304、ISO 26262 和 EN 50128 标准。ThreadX 还通过了 EAL4+ Common Criteria 安全认证。全面的安全认证积累开行业之先河，也让 ThreadX 成为第一款有望改变游戏规则的可靠开源 RTOS（取代 QNX）。



## 系统组件

Eclipse ThreadX 平台是一个运行时解决方案的集合，除了 ThreadX 内核，还包括 NetX Duo、FileX、GUIX 和 USBX 等核心组件。

![](https://static.getiot.tech/ThreadX-components-1.png#center)

- **ThreadX**

  ThreadX 操作系统内核，提供任务管理、消息传递、中断管理等基础服务。

- **FileX**

  FileX 是一种高性能的 FAT 兼容文件系统。它与 ThreadX 完全集成，可用于所有支持的处理器。具有占用空间小和高性能的特点，使其成为当今需要文件操作的深度嵌入式应用程序的理想选择。FileX 通过 LevelX 支持大多数物理介质，包括 RAM 磁盘、USBX、SD 卡和 NAND/NOR 闪存。

- **GUIX**

  GUIX 是一个专业品质的图形用户界面库，旨在满足嵌入式系统开发人员的需求。具有体积小、速度快的特点，并且可以轻松移植到几乎任何能够支持图形输出的硬件配置。

- **NetX Duo**

  NetX Duo 是一种先进的工业级 TCP/IP 网络协议栈，专为深度嵌入式、实时和物联网应用而设计。NetX Duo 是一个 IPv4 和 IPv6 双网络协议栈。

- **USBX**

  USBX 是高性能 USB 主机、设备和 On-The-Go（OTG）嵌入式协议栈。它与 ThreadX 完全集成，可用于所有 ThreadX 支持的处理器。具有占用空间小、性能高的特点，非常适合需要 USB 设备接口的深度嵌入式应用。

- **Windows tools**

  GUIX Studio 提供了完整的 GUI 应用程序设计环境，方便了应用程序 GUI 中所有图形元素的创建和维护。GUIX Studio 自动生成与 GUIX 库兼容的 C 代码，准备在目标上编译和运行。

  TraceX 是一种基于主机的分析工具，为开发人员提供实时系统事件的图形视图，使他们能够可视化并更好地理解实时系统的行为。



## 相关链接

- [ThreadX 官方网站](https://threadx.io)
- [ThreadX 代码仓库](https://github.com/eclipse-threadx/threadx)

