---
sidebar_position: 2
---

# ARP 协议

## 简介

**ARP**（Address Resolution Protocol）协议是网络通信中的一个重要协议，是一种用于解决 IP 地址与 MAC 地址之间映射关系的协议，它在 TCP/IP 协议栈中起着关键作用。

在 TCP/IP 网络中，每个设备都有一个唯一的 IP 地址和 MAC（Media Access Control）地址。IP 地址用于在网络中唯一标识设备，而 MAC 地址则用于在局域网中唯一标识设备。ARP 协议负责将 IP 地址映射到相应的 MAC 地址，以便实现数据包的正确传输。

ARP 协议位于 OSI 七层协议模型中的第二层，即数据链路层。数据链路层负责在物理网络上传输数据帧，并提供设备间的直接通信。ARP 协议的作用是解决网络层（第三层）中的 IP 地址与数据链路层（第二层）中的 MAC 地址之间的映射关系，将已知的 IP 地址转换为对应的 MAC 地址。当一个设备需要与另一个设备通信时，它需要知道目标设备的 MAC 地址才能将数据包正确发送到目标设备所在的局域网上。ARP 协议通过广播询问的方式，向局域网上的所有设备询问某个特定 IP 地址对应的 MAC 地址。

## 协议格式

ARP 数据包的格式如下所示：

![](https://static.getiot.tech/arp-packet-format.jpg#center)

协议字段具体说明：

- **硬件类型（Hardware Type）**：指定硬件地址的类型，通常为以太网，对应的值为 1。
- **协议类型（Protocol Type）**：指定协议地址的类型，通常为 IPv4，对应的值为 0x0800。
- **硬件地址长度（Hardware Address Length）**：指定硬件地址的长度，对于以太网来说，长度为 6 个字节。
- **协议地址长度（Protocol Address Length）**：指定协议地址的长度，对于 IPv4 来说，长度为 4 个字节。
- **操作码（Operation Code）**：指定 ARP 数据包的类型，包括请求和应答两种类型。
- **发送方硬件地址（Sender Hardware Address）**：发送方的 MAC 地址。
- **发送方协议地址（Sender Protocol Address）**：发送方的 IP 地址。
- **目标硬件地址（Target Hardware Address）**：目标设备的 MAC 地址，在 ARP 请求中通常为 00:00:00:00:00:00。
- **目标协议地址（Target Protocol Address）**：目标设备的 IP 地址。

## 工作流程

- **ARP 请求**：当设备 A 需要与设备 B 通信时，但不知道设备 B 的 MAC 地址时，设备 A 将发送一个 ARP 请求广播到局域网上，询问对应目标 IP 地址的设备的 MAC 地址。
- **ARP 应答**：设备 B 收到 ARP 请求后，如果发现目标 IP 地址与自己相符，则会发送一个 ARP 应答包给设备 A，包含自己的 MAC 地址。

## 小结

ARP 协议是 TCP/IP 网络中非常重要的一个协议，它解决了 IP 地址与 MAC 地址之间的映射关系，保证了数据包在局域网中的正确传输。通过 ARP 协议，设备可以动态地获取到其他设备的 MAC 地址，从而实现网络通信。
