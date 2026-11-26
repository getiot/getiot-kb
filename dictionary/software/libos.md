---
sidebar_label: LibOS
sidebar_position: 7
slug: /libos
---

# 库操作系统 LibOS



**库操作系统**（Library Operating System，简称 LibOS）是根据某类应用的特殊需求，由某一高级编程语言将原本属于操作系统内核的某些资源管理功能，如文件磁盘 I/O、网络通信等，按照模块化的要求，以库的形式提供给应用程序的特殊操作系统。

它能代替操作系统内核合理地管理和控制所涉及的计算机资源，并将所涉及的计算机资源直接暴露给应用程序，让应用程序直接访问底层（虚拟）硬件，以便应用程序能够高效地运行。特别地，它与应用程序在编译时被链接到一起，形成一个只有单地址空间的二进制文件并工作在应用层，是构建 Unikernel 的一个必不可少的系统组件。

相对于 Container/VM 等共享内核技术，LibOS 更加轻量、运行资源消耗更少，并提供了内核定制能力。LibOS 有更好的隔离性，能够给每个应用都提供独立的 OS，从而让应用可以在不同的平台上运行。

库操作系统 LibOS 具有如下基本特点：

- **模块化（modularization）**

  将操作系统的功能结构化，按模块划分，以类库（library）来实现和封装系统的基本功能。模块化可以抽象出软件内部的实现细节，限制单个源代码更改的范围，并方便对各个部分做出修改和重用，满足其专业定制的需求，灵活组装出精简、优化的库操作系统。

- **专用化（customization）**

  开发人员可以根据自己对应用服务的特殊需求改写库，实现自定义抽象，省略不必要的抽象，跨设备驱动程序和应用逻辑执行全系统优化，剔除不需要的系统组件，从而构建出高度专业化的操作系统，满足其安全性和高效性。

- **单地址空间（single address space）**

  应用程序与特定的驱动、核心库运行在一起，共享同一内存页表，不存在运行时状态上下文切换的额外开销，因此可以提高程序的运行速率，实现更高效的应用服务。

库操作系统 LibOS 的通用系统架构：

![](https://static.getiot.tech/libos-generic-framework.png#center)

相关项目：

- [Graphene-SGX](https://github.com/oscarlab/graphene)
- [X-Containers](https://www.x-containers.org)





## 参考

- 《计算机科学》第45卷 第11期：库操作系统的研究及其进展，2018年11月
- [LibOS 安全操作系统，可信计算](https://www.zhihu.com/topic/21670885/hot)
- [Graphene 文档 | Read the Docs](https://graphene.readthedocs.io/en/latest/index.html)
- [X-Containers：打开Linux as LibOS的潘多拉魔盒](https://kernel.taobao.org/2019/05/x-containers/)

