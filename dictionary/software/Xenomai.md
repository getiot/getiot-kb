---
sidebar_label: Xenomai
sidebar_position: 15
slug: /xenomai
---

# Xenomai


**Xenomai** 是一个 Linux 内核的实时开发框架。它希望通过无缝地集成到 Linux 环境中来给用户空间应用程序提供全面的，与接口无关的硬实时性能。

Xenomai 项目始于2001年8月。2003年它和 [RTAI](/dictionary/rtai/) 项目合并推出了 RTAI/fusion。

网址：[https://xenomai.org](https://xenomai.org)

## Xenomai 架构

Xenomai 是众多 Linux 实时性解决方案中的一种，通过在 Linux 的基础上添加一个 RTOS 内核 Cobalt 来提高 Linux 的实时性。实时内核 Cobalt 与非实时内核 Linux 相结合，既能提供工业级 RTOS 的硬实时性能，又能利用 Linux 操作系统非常出色的网络和图形界面服务，在产品的开发周期和成本控制方面都有巨大优势。

Xenomai 方案的架构如下图所示：

![](https://static.getiot.tech/xenomai-architecture.png)

主要包括三部分，Xenomai 的移植构建也是围绕这三部分来进行：

- 用户空间中的实时应用程序库 libcobalt；
- 内核空间中的实时内核 Cobalt；
- 硬件架构与 Linux 内核版本相关层 ipipe-core 或 dovetail。

libcobalt 和 Cobalt 的源码随 Xenomai 更新，位于同一源码包内，ipipe-core 和 dovetail 则与硬件架构和具体 Linux 版本相关，以补丁的方式提供，需要单独下载。

## 参考

- [xenomai3+linux构建linux实时操作系统](https://www.cfnotes.com/archives/293)
