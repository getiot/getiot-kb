---
sidebar_position: 5
authors: [luhuadong]
---

# ROS2 系统架构



本文主要介绍 ROS2 的整体架构，对比 ROS1 和 ROS2 的区别，并介绍 ROS2 中的核心组件，包括 DDS 通信和 RMW 中间件等概念。



## ROS1 和 ROS2 架构对比

和 ROS1 相比，ROS2 采用了全新的架构，底层基于 DDS（Data Distribution Service）通信机制，支持实时性、嵌入式、分布式、多操作系统。ROS2 支持的系统包括 Linux、windows、Mac、RTOS，甚至是单片机等没有操作系统的裸机。

ROS1 和 ROS2 的软件架构对比如下图所示。

![ROS1 和 ROS2 架构对比](https://static.getiot.tech/ROS1-ROS2-architecture.png#center)

ROS1 的通信系统基于 TCPROS/UDPROS，强依赖于 master 节点的处理。而 ROS2 的通信系统是基于 DDS，取消了 master 节点，避免了单点故障。同时在 ROS2 内部提供了 DDS 的抽象层实现，有了这个抽象层，用户就可以不去关注底层的 DDS 使用了哪个厂商提供的 API。

ROS1 和 ROS2 中的另一个重要区别，就是“Nodelet”和“Intra-process”独立模块。在 ROS1 的架构中，Nodelet 和 TCPROS/UDPROS 是并列的层次，当然也是负责通讯的，实际上 Nodelet 是为同一个进程中的多个节点提供一种更优化的数据传输方式。ROS2 中也保留了这种数据传输方式，只不过换了一个名字，叫“Intra-process”，同样也是独立于 DDS。



## ROS2 软件架构

ROS2 软件架构如下图所示，从上到下分别是应用层（Application Layer）、ROS2 客户端程序库层（ROS2 Client Layer）、DDS 抽象层（Abstract DDS Layer）、DDS 实现层（DDS Implementation Layer）、操作系统层（Operating System Layer）。

![ROS2 软件架构](https://static.getiot.tech/ROS2-Architecture-Overview.png#center)

其中，DDS 是一种分布式的发布/订阅通信协议，RMW（ROS 中间件接口层）用于隐藏 DDS 服务的具体实现细节。

对于应用开发者而言，只需要通过 ROS2 客户端程序库提供的 API 接口实现自己的节点即可。相对来说，rclcpp 库的效率更高、响应更快、时延更小；而 rclpy 库更容易上手，能有效缩短开发时间，适合原型开发阶段。



## DDS 通信机制

DDS 的全称是 Data Distribution Service，即数据分发服务。其实 DDS 也并不是一个很新鲜的概念，它是对象管理组织 OMG（Object Management Group）在 2004 年正式发布的一个专门为实时系统设计的数据分发/订阅标准，最早应用于美国海军， 解决舰船复杂网络环境中大量软件升级的兼容性问题，目前已经成为美国国防部的强制标准，同时广泛应用于国防、民航、工业控制等领域， 成为分布式实时系统中数据发布/订阅的标准解决方案。

DDS 的技术核心是以数据为核心的发布订阅模型（Data-Centric Publish-Subscribe ，DCPS），这种 DCPS 模型创建了一个“全局数据空间”（Global data space）的概念，所有独立的应用都可以去访问。在 DDS 中，每一个发布者或者订阅者都成为参与者（Participant），类似于 ROS 中节点的概念。每一个参与者都可以使用某种定义好的数据类型来读写全局数据空间。

