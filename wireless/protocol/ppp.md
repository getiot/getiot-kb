---
sidebar_position: 15
---

# PPP 点对点协议

PPP 协议是一种点到点（一根链路两端只有两个接口）链路层协议，主要用于在全双工的同异步链路上进行点到点的数据传输。

![](https://static.getiot.tech/network-point-to-point.png#center)



## 概述

PPP 协议（Point-to-Point Protocol，点对点协议）是一种网络协议中最为基础的协议，工作于数据链路层，它是为在同等单元之间传输数据包这样的简单链路而设计的，这种链路提供了全双工操作，并按照顺序传递数据包。

PPP 主要是用来通过拨号或专线方式在两个网络节点之间建立连接、发送数据。PPP 是各类型主机、网桥和路由器之间简单连接的一种解决方案。PPP 协议在 RFC1661 中有详细的描述。 PPP 协议是目前广域网上应用最广泛的协议之一，它的优点在于简单、具备用户验证能力、可以解决 IP 分配等。

PPP 协议包括以下三个部分：

- 数据帧封装方法。
- 链路控制协议 LCP（Link Control Protocol），用于对封装格式选项的自动协商、建立和终止连接，探测链路错误和配置错误。
- 针对不同网络层协议的一族网络控制协议 NCP（Network Control Protocol），PPP 协议规定了针对每一种网络层协议都有相应的网络控制协议，并用他们来管理各个协议不同的需求。



## PPP 协议特点

- PPP 既支持同步传输又支持异步传输，而 X.25、FR（Frame Relay）等数据链路层协议仅支持同步传输，SLIP 仅支持异步传输。（关于同步和异步的概念请参考 [通信协议基础](/protocol/basic-knowledge-of-communication-protocol/)）
- PPP 协议具有很好的扩展性，例如，当需要在以太网链路上承载 PPP 协议时，PPP 可以扩展为 PPPoE。
- PPP 提供了 LCP（Link Control Protocol）协议，用于各种链路层参数的协商。
- PPP 提供了各种 NCP（Network Control Protocol）协议（如 IPCP、IPXCP），用于各网络层参数的协商，更好地支持了网络层协议。
- PPP 提供了认证协议 CHAP（Challenge-Handshake Authentication Protocol）、PAP（Password Authentication Protocol），更好地保证了网络的安全性。
- 无重传机制，网络开销小，速度快。



## PPP 协议报文格式

![](https://static.getiot.tech/ppp-protocol-frame-format.png#center)

1. **Flag 域**：标识一个物理帧的起始和结束，该字节为二进制序列 01111110（0x7E）；
2. **Address 域**：字节固定为 11111111 （0xFF），是一个广播地址；
3. **Control 域**：默认为 00000011（0X03），表明为无序号帧；
4. **Protocol 字段**：用来说明 PPP 所封装的协议报文类型；典型的字段值有：0xC021 代表 LCP 报文，0xC023 代表 PAP 报文，0xC223 代表 CHAP 报文。如果协议字段被设为 0xC021，则说明通信双方正通过 LCP 报文进行 PPP 链路的协商和建立：
5. **Information 字段**：包含协议字段中指定协议的数据包。
   - **Code 字段**：主要是用来标识 LCP 数据报文的类型。典型的报文类型有：配置信息报文（Configure Packets: 0x01)，配置成功信息报文（Configure-Ack: 0x02），终止请求报文（Terminate-Request：0x05）。
   - **Identifier 域**：1个字节，用来匹配请求和响应。
   - **Data 字段**：的默认最大长度（不包括协议字段）称为最大接收单元 MRU（Maximum Receive Unit），MRU 的缺省值为 1500 字节。
6. **帧校验序列（FCS）**：是个16位的校验和，用于检查 PPP 帧的完整性。



## PPP 链路建立状态机

![](https://static.getiot.tech/ppp-protocol-link.png#center)

- **Dead 阶段**：也称为物理层不可用阶段。当通信双方的两端检测到物理线路激活时，就会从 Dead 阶段迁移至 Establish 阶段，即链路建立阶段。
- **Establish 阶段**：PPP 链路进行 LCP 参数协商。协商内容包括最大接收单元 MRU、认证方式、魔术字（Magic Number）等选项。LCP 参数协商成功后会进入 Opened 状态，表示底层链路已经建立。
- **Authenticate 阶段**：多数情况下，链路两端的设备是需要经过认证阶段（Authenticate）后才能够进入到网络层协议阶段。PPP 链路在缺省情况下是不要求进行认证的。如果要求认证，则在链路建立阶段必须指定认证协议。认证方式是在链路建立阶段双方进行协商的。如果在这个阶段再次收到了 Configure-Request 报文，则又会返回到链路建立阶段。
- **Network 阶段**：PPP 链路进行 NCP 协商。通过 NCP 协商来选择和配置一个网络层协议并进行网络层参数协商。只有相应的网络层协议协商成功后，该网络层协议才可以通过这条 PPP 链路发送报文。如果在这个阶段收到了 Configure-Request 报文，也会返回到链路建立阶段。NCP 协商成功后，PPP 链路将保持通信状态。
- PPP 运行过程中，可以随时中断连接，例如物理链路断开、认证失败、超时定时器时间、管理员通过配置关闭连接等动作都可能导致链路进入 **Terminate 阶段**。在 Terminate 阶段，如果所有的资源都被释放，通信双方将回到 **Dead 阶段**，直到通信双方重新建立 PPP 连接。





