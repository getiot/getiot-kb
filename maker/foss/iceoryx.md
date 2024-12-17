---
sidebar_position: 19
slug: /iceoryx
---

# iceoryx 进程间通信中间件



## 概述

**iceoryx**（中文名：冰羚）是一个适用于各种操作系统的进程间通信（IPC）中间件，由 Eclipse 基金会发布和维护。目前已支持 Linux、macOS 和 QNX。

Eclipse iceoryx 项目起源于汽车行业，最早是由罗伯特·博世公司 (Robert Bosch GmbH) 自动驾驶部门的架构大牛 [Michael  Pöhnl](https://github.com/budrus) 先生创建。我们知道，当涉及到驾驶辅助或自动驾驶系统时，会有大量的数据需要在不同的进程之间传输，成为影响实时性和效率的瓶颈。因此，iceoryx 运用“零拷贝”技术实现进程间通信，实现了快速、灵活和可靠的发布/订阅架构。

![](https://static.getiot.tech/iceoryx-intro-01.webp#center)

iceoryx 使用了真正的零拷贝，共享内存的方法，允许从发布者到订阅者的数据传输，而没有创建单一的副本。这确保了无论有效载荷的大小，数据传输都具有恒定的延迟。

下图是 iceoryx 和 message queue、unix domain socket 在通信延迟维度的横向对比。

![](https://static.getiot.tech/iceoryx-intro-02.webp#center)



## 实现原理

在操作系统中，两个不同进程进行数据交换，因为进程的物理资源是独立的，因此同样一份数据在两个进程之间交互就需要拷贝副本，这会产生对应的 CPU 及内存 IO 耗时，如果通信频繁数据量大，通信的时延就会越来越大。

零拷贝技术，顾名思义就是通过减少数据的多次拷贝，实现数据交换的提速。常见的方式是使用共享内存，当我们需要在两个进程间传递一份数据时，不用完整地拷贝，只需要传递它的指针即可。

iceoryx 利用共享内存技术，它会预先开辟一些内存块，称之为 chunk。publisher 将数据写入 subscriber 通过指针到 chunk 获取信息，当 chunk 中被写入数据时，订阅相应 topic 的 subscriber 就会收到一个指针，不同的 subscriber 可以订阅同一个 topic 信息，它们彼此不知道对方。

iceoryx 知道每个 chunk 对应的 subscriber 引用记录，每增加一个 subscriber 读取信息，对应的 reference 就+1。如果一个 subscriber 不消费了，reference 就 -1。如果 reference 没有人消息了就被置为 0，它就被后台重置回收，避免造成资源浪费。



## 应用场景

Eclipse iceoryx 高效的通信机制使其可以应用于更广泛的领域，例如在机器人或游戏开发领域。实际上，ROS 2、eCAL、RTA-VRTE、Cyclone DDS、Apex.OS 等许多框架都已经集成了 iceoryx 中间件。

- Eclipse Cyclone DDS
- eCAL（来自 Continental）
- RTA-VRTE（来自 ETAS）
- Apex.OS（来自 Apex.AI）

由于 iceoryx 是一种与数据无关的基于共享内存的传输机制，因此它仅仅提供了相当底层的 API。因此，官方不建议开发者直接使用该 API，而是将其集成到一个更大的能够提供高级 API 和工具的框架中去，比如 [AUTOSAR](/autosar/autosar-intro) Adaptive Platform 和 [ROS](/ros/ros-intro)（Robotic Operating System）。



## 相关链接

- GitHub 仓库：[https://github.com/eclipse-iceoryx/iceoryx](https://github.com/eclipse-iceoryx/iceoryx)
- 文档中心：[https://iceoryx.io](https://iceoryx.io)



## 参考

- http://www.chezhubidu.com/detail/details/1/588064
- https://zhuanlan.zhihu.com/p/500113506
