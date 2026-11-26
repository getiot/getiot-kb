---
sidebar_position: 1
authors: [luhuadong]
---

# RT-Thread 简介

![](https://static.getiot.tech/rt-thread-banner.jpg#center)

## RT-Thread 是什么

据不完全统计，世界有成千上万个 RTOS（Real-time operating system，实时操作系统），RT-Thread 就是其中一个优秀的作品。

RT-Thread 内核的第一个版本是熊谱翔先生在 2006 年年初发布的 0.1 版本。因为 RTOS 中的任务更类似于通用操作系统中的线程，并且这个系统支持基于优先级的抢占式任务调度算法，调度器的时间复杂度是 O(1)，所以把它命名为 RT-Thread，即实时线程。名字起得真妙 (。・∀・)ノ

经过14年的发展，RT-Thread 被广泛应用于智能家居、智慧城市、安防、工控、穿戴等众多行业领域，累计装机量超过6亿台，GitHub 的 Star 数量超过 6.1k，嵌入式开源社区活跃度行业第一。



## RT-Thread 的作用

随着 MCU 硬件性能的提升、外设的增加以及软件功能需求的增加，越来越多项目采用 RTOS 的开发方式。一方面裸机开发方式的软件框架不清晰，对后续扩展功能极其不利；另一方面，由于软件复杂性的增加，裸机开发对工程师的要求越来越严苛，过多使用中断等因素，都会增加系统的不可靠性。

![](https://static.getiot.tech/rtos-vs-no-rtos.png#center)


和其他优秀的 RTOS 一样，RT-Thread 的首要目标也是解决这些问题。RT-Thread 内核的主要功能是向下管理所有硬件资源，向上为应用程序提供 API 接口和软件服务，所有任务在内核的管理、同步和调度下有序运行。

简单来说，使用 RT-Thread 能够带来如下好处：

- 支持任务并发处理
- 容易扩展新的功能
- 破解应用的复杂性
- 增强代码可移植性
- 节省软件开发时间
- ......

您可能会说，其他 RTOS 也能提供这些好处呀，为什么你要推荐 RT-Thread？

因为 RT-Thread 还有许多优点，包括它支持非常多的硬件平台，还拥有及其丰富的组件和软件包（包括文件系统、网络、IoT、AI、传感器等等），提供了便捷的开发环境和 IDE 工具，以及有众多技术文档、参考设计和活跃的开发者社区，这些都能帮助您快速入门和掌握 RT-Thread，开发出优秀的产品。

当然啦，最重要的是，RT-Thread 是一群扎实做事的中国人写的开源操作系统，帮助您做出好产品的同时还能提高民族自信和国家竞争力。



## RT-Thread 的特点

相比其他操作系统，RT-Thread 的主打特性是 “**小而美的物联网操作系统**”。

“**小**” 体现在 RT-Thread 的体积小，最小资源占用 1.2KB RAM 和 2.5KB flash。RT-Thread 可伸缩、易裁剪的特性，帮助用户在需要一个适用的操作系统的时候，轻松地进行裁减，适应到需要的场景，不占用过多的资源。

“**美**” 不单止代码质量和代码风格，还有 RT-Thread 的使用和开发体验，以及增加了小程序、SMP 多核调度、PSA 安全支持等多项实用的新功能，使得 RT-Thread 系统能实现灵活极简的应用开发，能扩展至众多高性能、高安全的应用领域。

“**物联网**” 则体现在 RT-Thread 针对物联网场景提供的众多组件和软件包，比如 AT组件、WiFi、蓝牙、LoRa、Sensor、AI 等等。以及针对安全和低功耗的优化，还有以 JS 为开发方式的柿饼 UI，都使其非常适用于 IoT 领域。



## 开源的 RT-Thread

RT-Thread 是一个“开源、社区化、中立”的系统，遵循 Apache 2.0 开源许可协议。意味着您可以放心地在商业产品中免费使用 RT-Thread 内核和组件，不需要公开私有代码，只需要在产品说明书上提及 “基于 RT-Thread 系统” 或 “Powered by RT-Thread” 即可。

> **Tips**：因为 RT-Thread 软件包平台是开放的，许多软件包都是来自社区开发者，不同软件包的许可协议可能会不一样，所以在商业产品中使用时需要稍加注意。

同时，RT-Thread 非常注重在嵌入式开源社区的生态建设。经过多年的积累，除了有官方技术支持团队，还有活跃的开源社区和数十万开发者，开发过程中的遇到难题都能寻找官方团队和社区开发者的支持。



## RT-Thread 应用场景

经过十多年的深耕，如今 RT-Thread 已被广泛应用于安防、车载、航天、工业控制、消费电子、轨道交通等领域。

![](https://static.getiot.tech/rtt-application-cases.jpg#center)



## 学习资料

- [RT-Thread 文档中心](https://www.rt-thread.org/document/site/)
- [RT-Thread 视频中心](https://www.rt-thread.org/page/video.html)
- [RT-Thread 参考设计中心](https://www.rt-thread.org/page/projects.html)
- [RT-Thread 应用项目汇总](https://club.rt-thread.org/ask/article/2292.html)
- [RT-Thread 编程手册](https://www.bookstack.cn/books/rtthread-manual-doc)



## 网站链接

- [RT-Thread 开源网站](https://www.rt-thread.org)
- [RT-Thread 开源社区](https://club.rt-thread.org)
- [RT-Thread 商业网站](https://www.rt-thread.com)
- [RT-Thread 源码仓库](https://github.com/RT-Thread/rt-thread)



