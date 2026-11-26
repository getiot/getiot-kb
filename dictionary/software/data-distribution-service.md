---
sidebar_label: DDS 数据分发服务
sidebar_position: 17
slug: /data-distribution-service
---

# DDS 数据分发服务



## 什么是 DDS

**DDS**（英文全称：Data Distribution Service），即数据分发服务。是一种分布式实时通信中间件协议，采用发布/订阅体系架构，强调以数据为中心，提供丰富的 QoS 服务质量策略，以保障数据进行实时、高效、灵活地分发，可满足各种分布式实时通信应用需求。

DDS 最早应用在美国海军系统，用于解决军舰系统复杂网络环境中大量软件升级的兼容性问题。

- 在机器人领域，在 ROSCon 2014 上，新一代基于 DDS 的 ROS 的设计架构（Next-generation ROS: Building on DDS）正式公布，也就是后来的 [ROS2](/ros2/ros2-intro/)。
- 在汽车领域，2018年 Adaptive [AUTOSAR](/autosar/autosar-intro/) 引用了 DDS，作为可选择的通信方式之一。目前国内已有主机厂开始研究，主要针对自动驾驶相关需求，工具方面，在汽车电子领域常用的工具厂商也在开发这部分内容。



## DDS 规范

DDS 规范是由 [OMG](https://www.omg.org)（Object Management Group）对象管理组织发布的。OMG 组织是一个国际性、开放性、非盈利性技术标准联盟，由供应商、终端用户、学术机构、政府机构推动，已经有 31 年的历史；OMG 工作组针对各种技术和行业制定企业集成标准，并开发可为数千个垂直行业提供现实价值的技术标准。

DDS 的相关标准包括核心协议（DDSI-RTPS、DDS-XTypes、DDS-Security、Interface Definition Language (IDL)…）、API（DDS C++ API、DDS Java API）、拓展协议（DDS-RPC、DDS-XML…）等 13 份协议集合。



## DDS 架构

在分布式系统中，DDS 作为以数据为中心的连接中间件，位于操作系统和应用程序之间，它支持多种底层协议，并支持多种编程语言，向上提供统一的 API 标准。使得使系统的各个组件能够更容易地通信和共享数据，让软件开发人员专注于应用程序的业务功能，而不是在应用程序和系统之间传递信息的机制，从而简化了分布式系统的开发。

![](https://static.getiot.tech/dds-architecture.png#center-500)

总的来说，DDS 将系统的组件集成在一起，提供低延迟的数据连接、极高的可靠性，以及业务和关键任务物联网（IoT）应用程序所需的可伸缩架构。



## DDS 基本概念

- **Domain**：代表一个通信域空间，由 Domain ID 唯一标识，只有在同一个域内的通信实体才可以通信。你可以根据产品特性只划分1个 Domain，也可以按照交互规则或其他规则，定义多个 Domain。
- **Domain Participant**：标识域内通信的应用程序的本地成员身份。
- **Topic**：标识数据的主题，是数据的抽象概念，由 TopicName 标识。
- **DataWriter**：数据写入者，类似缓存，把需要发布的主题数据从应用层写入到 DataWriter 中。
- **DataReader**：数据读取者，同样可以理解为一种缓存，从订阅者得到主题数据，随之传给应用层。
- **Publisher**：发布者，发布主题数据，至少与1个 DataWriter 关联，通过调用 DataWriter 的相关函数将数据发出去。
- **Subscriber**：订阅者，订阅主题数据，至少与1个 DataReader 关联，支持同步访问和异步通知两种情况。



## DDS 通信模型

DDS 的核心是“发布-订阅模型”（Data-Centric Publish-Subscribe，简称 DCPS）。在 DDS 中，数据通过主题（Topic）进行标识，发布者根据主题发布数据，订阅者根据自己感兴趣的主题订阅数据。

下面是 DDS 的通信模式示例，相关名词可以对照上面的 DDS 基本概念。

![](https://static.getiot.tech/dds-components-diagram.png#center)



## 参考

- [What is DDS?](https://www.dds-foundation.org/what-is-dds-3/)
- [An Introduction to Connext DDS](https://community.rti.com/static/documentation/connext-dds/5.2.0/doc/manuals/connext_dds/html_files/RTI_ConnextDDS_CoreLibraries_GettingStarted/Content/GettingStarted/An_Introduction_to_.htm)

