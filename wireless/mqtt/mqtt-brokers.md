---
sidebar_position: 7
authors: [luhuadong]
---

# MQTT 中介服务器



如果你想搭建一个完整的 MQTT 开发环境，除了要有 MQTT Client 端的实现，还需要一个 MQTT Broker，即中介服务器。Broker 负责接收 MQTT 发布者的消息，并将消息发送给相应的 MQTT 订阅者。当然，在实际应用中，MQTT Broker 还应该提供 MQTT Client 鉴权、集群、监控等功能。

下面介绍常见的一些 MQTT Broker 实现。



## Mosquitto

Mosquitto 是用 C 语言编写的一款开源 MQTT Broker，单机配置和运行 Mosquitto 比较简单，官方也没有提供集群的解决方案。

因此，如果需要扩展 Mosquitto 的功能，比如自定义的验证方式，实现过程比较复杂，对接现有的业务系统等也较为复杂，需要对 Mosquitto 代码比较熟悉。



## EMQ X

EMQ X 是由中国人开发并提供商业支持的 MQTT Broker，同时提供开源社区版和企业付费版。

EMQ X 采用 Erlang 语言编写，官方提供集群解决方案，并且可以通过编写插件的方式对 Broker 的功能进行扩展。不过，由于 Erlang 这门语言比较小众，而且学习曲线陡峭，所以编写插件时需要重新学习一门语言。



## VerneMQ

VerneMQ 也是一款使用 Erlang 编写的开源 MQTT Broker，并且支持集群和插件，目前由一家位于瑞士的公司提供商业服务。



## HiveMQ

HiveMQ 是用 Java 编写的 MQTT Broker，支持集群，同时也可以通过插件的方式对功能进行扩展。由于采用 Java 语言，因此功能扩展相对简单。不过，HiveMQ 是闭源的，只提供付费企业版。



## ActiveMQ



## NanoMQ



