---
sidebar_position: 12
---

# AUTOSAR SOME/IP 协议



SOME/IP全称Scalableservice-Oriented Middleware over IP，基于IP的可扩展面向服务的中间件。

SOME/IP协议于2011年由BMW集团的Lars Völker设计，并于2013年纳入AUTOSAR 4.1规范，其在规范里定义如图1所示。在车载以太网的协议架构中，SOME/IP位于应用层(如图2所示)，提供面向服务的通信接口。其通信方式为AUTOSAR中提到的CS接口的概念，就是客户端(client)和服务端(Server)，当有请求发出时，SOME/IP才会发出数据，否则不发送数据，类似于COM模块的Direct模式，这样总线上就没有不必要的数据，降低总线负载。同时在整车电子电气架构中可以将Classical AUTOSAR和Adaptive AUTOSAR桥接起来，如图3所示。

SOME/IP主要为应用层提供API接口，创建CS接口，通过TCP/IP协议进行通信。而SOME/IP的访问方式分为三种，分别是事件通知、远程过程调用和访问进程数据。

- 事件通知与传统的CAN通信类似，服务端端周期性或者事件变化时向客户端发送特定的数据，如图4所示。
- 远程过程调用是当客户端有请求的时候，向服务端发送请求命令，服务端解析命令，并作出相应的响应，如图4所示。
- 访问进程数据可以使客户面向服务器写入(Setter)或者读取(Getter)数据，其方式如图6所示。



## SOME/IP 数据格式

- Message ID(Server ID) ：16bit，服务的ID，标识出一个服务；
- Message ID(Method ID) ：16bit，方法的ID，表示出一个方法；
- Length：报文长度，32bit，标识从request ID到报文结束的总长度；
- Request ID(Client ID) ：客户端ID，16bit。区分不同的客户端；
- Request ID(Session ID) ：会话ID，区分同一个客户端的多次调用；
- Protocol Version ：协议的版本号，固定值为x01；
- Interface Version：服务接口版本；
- Message Type ：报文类型，在AUTOSAR中，总共包含五种，包括REQUEST，REQUEST_NO_RETURN，NOTIFICATION，RESPONSE，ERROR；
- Return Code ：返回码，包括四种，REQUEST，REQUEST_NO_RETURN，NOTIFICATION，RESPONSE；
- Payload ：数据段，用于放置需要传输的数据。



SOME/IP开源库 [vsomeip](https://github.com/COVESA/vsomeip)



