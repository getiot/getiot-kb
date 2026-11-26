---
sidebar_position: 18
---

# PTP 精确时间协议



**PTP**（Precision Time Protocol，精确时间协议）是一种时间同步的协议，对应 IEEE 1588 标准，采用硬件时间戳，一般应用在工业以太网上。



## PTP 的优势

PTP 协议本身主要用于通过网络通讯的形式实现设备之间的高精度时间同步，也可被借用于设备之间的频率同步。相比现有的各种时间同步机制，PTP 具备以下优势：

- 相比 NTP（Network Time Protocol，网络时间协议），PTP 能够满足更高精度的时间同步要求，NTP 一般只能达到亚秒级的时间同步精度，而 PTP 则可达到亚微秒级。
- 相比 GPS（Global Positioning System，全球定位系统），PTP 具备更低的建设和维护成本，并且由于可以摆脱对 GPS 的依赖，在国家安全方面也具备特殊的意义。



## PTP 同步原理

在系统的同步过程中，主时钟周期性发布 PTP 时间同步协议及时间信息，从时钟端口接收主时钟端口发来的时间戳信息，系统据此计算出主从线路时间延迟及主从时间差，并利用该时间差调整本地时间，使从设备时间保持与主设备时间一致的频率与相位。IEEE1588 可以同时实现频率同步和时间同步。

PTP 采用请求应答机制测量端到端的延时时间，时间同步的原理如下图所示：

![PTP 精确时间协议报文收发流程](https://static.getiot.tech/ptp-working-principle.jpg#center)

如上图所示，存在 4 种 PTP 报文，Sync 同步报文、Follow_up 跟随报文、Delay_req 延迟请求报文，以及 Delay_resp 延迟请求响应报文。

报文收发流程说明：

- 主时钟向从时钟发送 Sync 报文，并记录时间 T1；
- 从时钟收到 Sync 后，记录接收时间 T2；
- 主时钟发送完 Sync，紧接着发送一个带有 T1 值的 Follow_Up 报文给从时钟；
- 从时钟向主时钟发送 Delay_Req 报文，记录发送时间 T3；
- 主时钟收到 Delay_Req 报文后，记录接收时间 T4；
- 主时钟向从时钟发送携带 T4 的报文 Delay_Resp。



## PTP 工作模式

PTP 同步可以通过不同的通信协议承载（CAN、以太网等）。同步模式上，PTP 同步可以使用两种机制 —— E2E（端到端）和 P2P（对等网络）。

- **E2E**（End to End）模式：采用请求应答机制（Request Response Mechanism）；
- **P2P**（Peer to Peer）模式：采用对等延迟机制（Peer Delay Mechanism）。

我们将设备上运行了 PTP 的设备的端口称为 PTP 端口，PTP 端口分为三种：

- 主端口（Master Port）：发布同步时间的端口；
- 从端口（Slave Port）：接收同步时间的端口；
- 被动端口（Passive Port）：既不发布也不接收，只作为转发所用。

PTP 协议采用主从模式，但主从关系是相对而言的。发布同步时间的节点称为主节点，而接收同步时间的节点则称为从节点。

- 主节点上的时钟称为**主时钟**，而从节点上的时钟则称为**从时钟**；
- 发布同步时间的端口称为**主端口**，而接收同步时间的端口则称为**从端口**。



## 时钟类型

- **普通时钟**（Ordinary Clock）：只有一个端口连接到网络的时钟，可以作为 master 或 slave 之一。如果作为 master 时候，可以是 grandmaster；而作为 slave 时，一般作为时钟分发网络的端点设备（end，最后一级）。 
- **边界时钟**（Boundary Clock）：有多个端口连接到网络的时钟，一个 slave 端口连接到上游设备的 PTP 端口，其他的端口作为 master 连接到下游设备的 slave 端口。下游 slave 端口同构 PTP 协议直接同步于边界时钟，而不是直接和 grandmaster 通信。
- **透明时钟**（Transparent Clock）：一个网络设备，比如交换机，不通过 PTP 协议进行时间同步，但是能够转发或修改某些经过的PTP报文，比如把 PTP 报文经过自己时候花费的时间增加到 PTP 报文的 correctonField。



## gPTP 协议

gPTP（general precise time protocol）是 PTP 在时效性网络（Time-Sensitive Networking）的派生协议。同步机制采用和 PTP 协议一致的 P2P 端延迟机制（Peer Delay Mechanism），同时采用以太网 L2 层通信。与 PTP 不同，gPTP 要求使用硬件方式打时间戳，也就是常说的硬件时间戳，所以对于交换机和 Master 时钟会有较严苛的要求。



## ptp4l



## FAQs

PTP 时间精度评估指标？

PTP 时间同步消耗时间？

如何确认 PTP 同步已经稳定，或者出现失步怎么办？



