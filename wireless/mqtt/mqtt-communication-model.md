---
sidebar_position: 2
authors: [luhuadong]
---

# MQTT 通信模型



MQTT 协议定义了两种网络实体：**消息代理**（**message broker**）与**客户端**（**client**）。其中，消息代理用于接收来自客户端的消息并转发至目标客户端。MQTT 客户端可以是任何运行有 MQTT 库并通过网络连接至消息代理的设备，例如微型控制器或大型服务器。

信息的传输是通过**主题**（**topic**）管理的。发布者有需要分发的数据时，其向连接的消息代理发送携带有数据的控制消息。代理会向订阅此主题的客户端分发此数据。发布者不需要知道订阅者的数据和具体位置；同样，订阅者不需要配置发布者的相关信息。

如果消息代理接受到某个主题上的消息，且这个主题没有任何订阅，那么代理就会丢弃之，除非发布者将其标记为**保留消息**（**retained message**）。



![](https://static.getiot.tech/mqtt-model-simple.png#center)







![](https://static.getiot.tech/mqtt-broker-model.png#center)
