---
sidebar_position: 13
---

# AUTOSAR DoIP 协议



UDS诊断作为汽车ECU里的一个服务功能，位于应用层，它的实现需要有网络的支撑，我们把基于[CAN总线](https://so.csdn.net/so/search?q=CAN总线&spm=1001.2101.3001.7020)实现的UDS诊断称为**DoCAN**，基于Ethernet实现的UDS诊断称为**DoIP**



Diagnostic communication over Internet Protocol，我们把通过以太网协议，承载UDS数据，实现诊断通信的这种方式称为DoIP

相比DoCAN中CAN网络的封闭性，DoIP由于Ethernet的互联互通，可以实现车与车、车与人的远距离诊断通信

DoIP在传输层以下的规范遵循ISO 13400，而应用层还是遵循ISO 14229不变，这样可以保证UDS诊断在不同车载网络上的可移植性

ISO 13400-2规定了外部测试设备与车辆ECU之间的诊断通信要求，包括：

- **网络层协议IP**
- **传输层协议TCP/UDP**
- **对网关的要求（网关如何集成到现有网络总）**
- **对测试设备的要求（如何发现车辆并建立通信）**

支持DoIP的车辆网络架构图如下
