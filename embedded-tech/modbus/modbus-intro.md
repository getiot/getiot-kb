---
sidebar_position: 1
authors: [luhuadong]
---

# Modbus 简介

![](https://static.getiot.tech/modbus-logo-with-icons.png#center)

Modbus 协议是一个开放标准的通信协议，最初设计用于连接可编程逻辑控制器（PLC）和其他自动化设备。它的简单性和可靠性使得 Modbus 成为工业领域中最受欢迎的通信协议之一，被广泛用于监控、控制和数据采集。

## 什么是 Modbus

Modbus 是工业界常用的一种通讯协议，可以理解为是一种通讯的约定。

Modbus 协议包括 RTU、ASCII、TCP，其中 Modbus-RTU 最常用，比较简单，在单片机上很容易实现。Modbus RTU 协议定义了一个与下层通信层无关的简单协议数据单元（PDU），串行链路上的 Modbus RTU 帧格式如下图所示。

![](https://static.getiot.tech/modbus-rtu-pdu.png#center)

其中，地址字段只含有从机地址；功能码指示指令要执行何种操作；功能码的后续数据是请求或响应数据字段；差错检验字段是“报文内容”数据进行“循环冗余校验”计算所得结果，采用 CRC16 循环冗余校验算法。

Modbus 和 OPC UA、MQTT 等通讯协议本质上是一样的，都是为了实现多个设备相互通信的应用层协议。



## Modbus 的起源与发展

Modbus 协议于 1979 年由 Modicon 公司（现被 Schneider 公司收购）设计开发，一经面世因其简单开放的通信方式逐渐成为工业系统中流行的标准，是全球第一个真正用于工业现场的总线协议。

后来，为了更好地普及和推动 Modbus 基于以太网（TCP/IP）的分布式应用，施耐德公司将 Modbus 协议的所有权移交给 IDA（Interface for Distributed Automation，分布式自动化接口）组织，并成立了 Modbu-IDA 国际组织，负责推广 Modbus 标准以及对 Modbus 产品进行认证。

现在，我们可以从 Modbus 官网 [www.modbus.org](https://www.modbus.org/) 找到相关协议文档、Modbus 产品和厂商等信息。



## Modbus 通信协议特点

Modbus 协议定义了一个控制器能够认识使用的消息结构，而不管它们是经过何种网络进行通信的。因此，底层通信方式可以使用 RS232，RS485 等串行链路，也可以使用 TCP/IP 以太网链路。当在 Modbus 网络上通信时，控制器必须要知道该网络中其他从设备的地址，才能识别按地址发来的消息，并作出相应行为。

简单来说，Modbus 通信协议具有以下几个特点：

- Modbus 协议标准开放、公开发布且无版税要求，用户可以免费获取并使用 Modbus 协议，不需要缴纳许可证费；
- Modbus 最开始使用 RS232，RS485 等串行链路作为底层通信方式，串行总线的接口芯片成本低，而且布线也简单方便；
- Modbus 协议支持多种电气接口，如 RS232、RS485、TCP/IP 等，还可以在各种介质上传输，如双绞线、光纤、红外、无线等；
- Modbus 是简单地应用层协议，其协议消息帧格式简单、紧凑、通俗易懂，便于用户理解和使用、厂商开发和集成，方便形成工业控制网络。



## 为什么要学习 Modbus

虽然 Modbus 已经发展到了极为成熟的阶段，但由于其协议的简单性以及便于在多种通信媒介上实施的应用特点，Modbus 仍然是当前工业电子设备之间常用的连接方式之一。在某种程度上来说，Modbus 通信协议就是工业领域通信协议的业界标准。在物联网蓬勃发展的当下，了解并掌握广泛应用的 Modbus 通信协议意义重大。

下图展示了 Modbus RTU 网络的设备连接。

![](https://static.getiot.tech/VirtualSCADA-VS1-Modbus-RTU-Network.jpg#center)



## 专业术语

在 Modbus 开发中的常见专业术语如下：

- Master ：主（站）设备
- Slave ：从（站）设备
- Client ：客户端，对应 Master 设备
- Server ：服务器端，对应 Slave 设备
- ADU ：应用数据单元（Application Data Unit）
- PDU ：协议数据单元（Protocol Data Unit）
- MSB ：最高有效位（Most Significant Bit）
- LSB ：最低有效位（Least Significant Bit）
- MBAP ：Modbus 应用协议（Modbus Application Protocol）
- PLC ：可编程逻辑控制器（Programmable Logic Controller）
- RTU ：远程终端单元（Remote Terminal Unit）
- SCADA ：监督控制和数据采集（Supervisory Control And Data Acquisition）



