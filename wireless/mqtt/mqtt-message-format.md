---
sidebar_position: 5
authors: [luhuadong]
---

# MQTT 报文结构



## 概述

MQTT 报文由三部分组成，分别为：固定报头（Fixed header）、可变报头（Variable header）以及有效载荷（Payload）。

- 固定报头包含报文类型等字段，是所有 MQTT 报文中必须的；
- 可变报头的内容根据报文类型的不同而不同，一些报文中甚至不存在可变报头；
- 有效载荷通常是与业务/场景相关的数据，例如对 PUBLISH 报文来说有效载荷就是应用消息，对 SUBSCRIBE 报文来说有效载荷就是订阅列表。

![](https://static.getiot.tech/MQTT-message-format.png#center)



MQTT 报文格式



- 固定报头，2~5字节，所有报文都包含
- 可变报头，长度不固定，部分报文才包含
- 有效负载，长度不固定，部分报文才包含



剩余长度（Remaining Length）表示当前报文剩余部分的字节数，包括可变报头和负载的数据。剩余长度不包括用于编码剩余长度字段本身的字节数。

剩余长度字段使用一个变长度编码方案，对小于128的值它使用单字节编码。更大的值按下面的方式处理。低7位有效位用于编码数据，最高有效位用于指示是否有更多的字节。因此每个字节可以编码128个数值和一个延续位（continuation bit）。剩余长度字段最大4个字节。







## 具体报文

### 连接报文

![](https://static.getiot.tech/MQTT-Connect-message.png#center)



### 订阅报文

![](https://static.getiot.tech/MQTT-Subscribe-message.png#center)



### 发布报文

对于 PUBLISH 报文来说载荷就是业务消息，它可以是任意格式（二进制、十六进制、普通字符串、JSON 字符串、Base64）的数据。

- DUP：控制报文的重复分发标志
- QoS：PUBLISH 报文的服务质量等级
- Retain：PUBLISH 报文的保留标志

![](https://static.getiot.tech/MQTT-Publish-message.png#center)



## 所有报文



![](https://static.getiot.tech/MQTT-All-Messages.png#center)



---



表：十四种报文类型

![](https://static.getiot.tech/mqtt-packet-types.png)



MQTT 报文格式

![](https://static.getiot.tech/mqtt-packet-format.png)

- 固定报头，2~5字节，所有报文都包含
- 可变报头，长度不固定，部分报文才包含
- 有效负载，长度不固定，部分报文才包含



剩余长度（Remaining Length）表示当前报文剩余部分的字节数，包括可变报头和负载的数据。剩余长度不包括用于编码剩余长度字段本身的字节数。

剩余长度字段使用一个变长度编码方案，对小于128的值它使用单字节编码。更大的值按下面的方式处理。低7位有效位用于编码数据，最高有效位用于指示是否有更多的字节。因此每个字节可以编码128个数值和一个延续位（continuation bit）。剩余长度字段最大4个字节。





连接报文

![](https://static.getiot.tech/mqtt-connect-packet.png)



发布报文

![](https://static.getiot.tech/mqtt-publish-packet.png)



- DUP：控制报文的重复分发标志
- QoS：PUBLISH 报文的服务质量等级
- Retain：PUBLISH 报文的保留标志



订阅报文

![](https://static.getiot.tech/mqtt-subscribe-packet.png)

