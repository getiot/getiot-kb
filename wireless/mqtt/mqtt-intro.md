---
sidebar_position: 1
authors: [luhuadong]
---

# MQTT 简介




## 概述

MQTT 是一种轻量级的物联网消息传输协议。它工作在 TCP/IP 协议簇之上，是专门为硬件性能受限的远程设备以及网络状况不佳的情况下而设计的发布（Publish）/ 订阅（Subscribe）型消息协议，符合 ISO 标准（ISO/IEC PRF 20922）下基于发布/订阅范式。

MQTT 最初代表的意思是 Message Queueing Telemetry Transport（消息队列遥测传输），现在已经不用这种说法了，MQTT 就是 MQTT，不再是其他单词的缩写。

由于 MQTT 协议的内容十分精简，因此非常适合用于处理器资源及网络带宽有限的物联网设备，再加上已经由许多 MQTT 程序库被陆续开发出来，包括 C/C++、JavaScript、Python 等多种编程语言，可用于 Arduino、Espruino 等控制板上，还有开源的 MQTT 服务器，使得开发 MQTT 物联网、机器之间（Machine-to-Machine, M2M）的通讯变得非常简单。事实上，Facebook Messenger 的即时通讯也是用 MQTT 协议实现的。



## MQTT 起源

MQTT 是由 IBM 的 Andy Stanford-Clark 博士和 Arcom（已更名为 Eurotech）的 Arlen Nipper 博士于1999年发明的通讯协议。他們当时是为了在狭窄的网络带宽和微小电力损耗的需求前提之下，提供石油管道传感器和人造卫星之间一个轻量、可靠的二进制通讯协议。

因此，MQTT 协议天生就需要解决下面三个物联网场景的经典问题：

- 网络带宽敏感、网络环境复杂不可靠；
- 设备内存容量小、处理器能力有限；
- 设备对低功耗有要求。

2011年11月，IBM 和 Eurotech 决定将 MQTT 协议捐赠给负责管理开放源代码项目的 Eclipse 基金会，并且加入了 Eclipse M2M Industry 工作组织。2014年10月，MQTT 正式成为一个开放的 OASIS 国际标准（Organization Advancement Structured Information Standards，信息标准架构促进会，一个制定电子商务、网络服务和电子出版的非营利机构）。

![](https://static.getiot.tech/Andy-Stanford-Clark-and-Arlen-Nipper.jpg#center)

> MQTT 的发明人是 IBM 的 Andy Stanford-Clark 和 Arcom 的 Arlen Nipper（现为 Eurotech 的 CTO）。



## MQTT 特点

MQTT 是基于发布/订阅模式的轻量级物联网消息传输协议，具有如下特点：

- **轻量可靠**：MQTT 报文格式精简、紧凑，可在严重受限的硬件设备和低带宽、高延迟的网络上实现稳定传输。
- **发布/订阅模式**（Pub/Sub）：发布/订阅模式的优点在于发布者与订阅者的解耦，实现异步协议，即订阅者与发布者不需要建立直接连接、也不需要同时在线。
- **为物联网而生**：提供心跳机制、遗嘱消息、QoS 质量等级 + 离线消息、主题和安全管理等全面的物联网应用特性。
- **生态更完善**：实现覆盖全语言平台的客户端和 SDK，已成为 AWS IoT Core、Azure IoT Hub 等众多云厂商物联网平台的标准通信协议。



## MQTT 应用场景

MQTT 作为一种低开销，低带宽占用的即时通讯协议，可以用极少的代码和带宽为联网设备提供实时可靠的消息服务，它适用于硬件资源有限的设备及带宽有限的网络环境。因此，MQTT 协议广泛应用于物联网、移动互联网、智能硬件、车联网、电力能源等行业。

![](https://static.getiot.tech/mqtt-in-action.png#center)

常见的应用常见：

- 物联网 M2M 通信，物联网大数据采集。
- 移动即时消息，及消息推送。
- 智能硬件、智能家居、智能电器。
- 车联网通信，电动车站桩采集。
- 智慧城市、远程医疗、远程教育。
- 电力、石油与能源等行业市场。



## 相关链接

- 官方网站：[https://mqtt.org](https://mqtt.org)

