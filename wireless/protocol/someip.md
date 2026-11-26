---
sidebar_position: 21
---

# SOME/IP 协议



**SOME/IP**（英文全称 Scalable service-Oriented MiddlewarE over IP）是一种用于汽车行业的通信协议。它的设计目的是为了在现代车辆中实现高效的、可扩展的服务和应用程序之间的通信。如今，SOME/IP 已成为目前车内运用最广泛的 SOA 架构通信协议。

注意，SOME/IP 不能写作 Some/IP 或 SOMEIP 等。



## SOME/IP 协议的起源

在过去的几十年中，汽车电子系统经历了巨大的变革。从最初的机械化控制系统到电子控制单元（ECU）的广泛应用，汽车电子控制系统已经变得更加复杂和多样化。各种 ECU 需要相互通信以实现各种功能，例如引擎控制、刹车系统、安全系统等。同时，随着车辆对外部服务的需求增加，如导航、音视频娱乐系统和远程配置等，车辆内部通信体系的复杂性也进一步提高。

过去，汽车通信主要采用专有的总线协议，如 CAN（Controller Area Network），但这些传统的通信协议在可扩展性、带宽和灵活性方面存在一定的限制。随着汽车智能化和网联化发展，业界迫切需要一种高效、可靠且灵活的通信方式来支持车内各个组件和外部服务之间的互联互通。基于 IP 网络的通信方案因为能够满足不断增长的通信需求，因此受到广泛关注。

基于此背景，SOME/IP 协议在 2008 年由 Automotive Open Systems Architecture（AUTOSAR）联盟引入，并在之后的版本中逐渐完善和推广。AUTOSAR 联盟是一个由汽车制造商、供应商和软件公司组成的国际性组织，旨在推动汽车电子系统的标准化和互操作性。SOME/IP 作为 AUTOSAR 的通信协议标准之一，成为了现代汽车电子系统中通信和服务交互的重要组成部分。

SOME/IP 协议的引入为汽车行业带来了许多好处。它提供了一种灵活和可扩展的通信架构，使得不同的 ECU 和服务可以轻松地集成在一起。同时，SOME/IP 建立在 IP 网络上，为车辆互联和外部服务提供了更广阔的连接能力。这使得车辆可以更容易地与云平台、移动设备和其他车辆进行交互，为车主和乘客提供更多的功能和服务。



## SOME/IP 协议模型

SOME/IP 是一种专用于汽车嵌入式的客户端/服务器通信机制。位于OSI七层模型中的5-7层。与CAN总线相比，实现了从小平台到大平台的扩展，兼容更多的用户案例和通信伙伴节点，并且既能够应用到嵌入式AUTOSAR系统中，又可以应用于Linux、QNX或Android等高级操作系统中。

![](https://static.getiot.tech/SOME-IP-OSI-Model.png)





## SOME/IP 协议的特点

A. 基于IP网络的通信
B. 灵活的服务和应用程序架构
C. 支持多种传输层协议
D. 实时性和可靠性要求



## SOME/IP 协议的核心组件



A. Service Discovery（服务发现）
B. Method Invocation（方法调用）
C. Event Notification（事件通知）
D. Parameter Serialization（参数序列化）
E. Diagnostic Services（诊断服务）



## SOME/IP 的应用场景

A. 车辆诊断和维修
B. 远程配置和软件更新
C. 音视频娱乐系统
D. 导航和地图服务
E. 传感器和智能系统集成



既然SOME/IP是一种提供服务的通信协议，我们就可以把请求服务的ECU看成是client，而提供服务的ECU就是server

SOME/IP作为一种通信协议，它也有自己的数据结构，根据官方文档
