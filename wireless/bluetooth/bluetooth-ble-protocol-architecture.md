---
sidebar_position: 4
---

# 蓝牙 BLE 协议架构



想要开发蓝牙应用，了解蓝牙协议架构是必不可少的。本文以低功耗蓝牙 BLE 为例，简要介绍 BLE 蓝牙协议架构，帮助开发者快速了解蓝牙协议概况。



## BLE 协议分层

![蓝牙协议层次划分](https://static.getiot.tech/bluetooth-stack-framework.png)



BLE 协议栈主要由如下几部分组成：

- **PHY 层（Physical layer 物理层）**

  PHY层用来指定 BLE 所用的无线频段，调制解调方式和方法等。PHY层做得好不好，直接决定整个 BLE 芯片的功耗，灵敏度以及 selectivity 等射频指标。

- **LL 层（Link Layer 链路层）**

  LL层是整个 BLE 协议栈的核心，也是 BLE 协议栈的难点和重点。像 Nordic 的 BLE 协议栈能同时支持 20 个 link（连接），就是 LL 层的功劳。LL 层要做的事情非常多，比如具体选择哪个射频通道进行通信，怎么识别空中数据包，具体在哪个时间点把数据包发送出去，怎么保证数据的完整性，ACK 如何接收，如何进行重传，以及如何对链路进行管理和控制等等。LL 层只负责把数据发出去或者收回来，对数据进行怎样的解析则交给上面的 GAP 或者 GATT。

- **HCI（Host controller interface）**

  HCI 是可选的（具体请参考文章： [蓝牙技术 Q&A](https://luhuadong.blog.csdn.net/article/details/112306398) 蓝牙协议栈的三种工作方式），HCI 主要用于2颗芯片实现 BLE 协议栈的场合，用来规范两者之间的通信协议和通信命令等。

- **GAP 层（Generic access profile）**

  GAP 是对 LL 层 payload（有效数据包）如何进行解析的两种方式中的一种，而且是最简单的那一种。GAP 简单的对 LL payload 进行一些规范和定义，因此 GAP 能实现的功能极其有限。GAP 目前主要用来进行广播，扫描和发起连接等。

- **L2CAP 层（Logic link control and adaptation protocol）**

  L2CAP 对 LL 进行了一次简单封装，LL 只关心传输的数据本身，L2CAP 就要区分是加密通道还是普通通道，同时还要对连接间隔进行管理。

- **SMP（Secure manager protocol）**

  SMP 用来管理 BLE 连接的加密和安全的，如何保证连接的安全性，同时不影响用户的体验，这些都是 SMP 要考虑的工作。

- **ATT（Attribute protocol）**

  简单来说，ATT 层用来定义用户命令及命令操作的数据，比如读取某个数据或者写某个数据。BLE 协议栈中，开发者接触最多的就是 ATT。BLE 引入了 attribute 概念，用来描述一条一条的数据。Attribute 除了定义数据，同时定义该数据可以使用的 ATT 命令，因此这一层被称为 ATT 层。

- **GATT（Generic attribute profile ）**

  GATT 用来规范 attribute 中的数据内容，并运用 group（分组）的概念对 attribute 进行分类管理。没有 GATT，BLE 协议栈也能跑，但互联互通就会出问题，也正是因为有了 GATT 和各种各样的应用 profile，BLE 摆脱了 ZigBee 等无线协议的兼容性困境，成了出货量最大的 2.4G 无线通信产品。




## GATT profile

Generic attribute profile 规定了一个 profile 并用 att protocol 来进行处理两边设备的交互。对于蓝牙应用开发者来说，通常只需要关心各种 profile 即可上手开发。

![](https://static.getiot.tech/bluetooth-stack-profile.png)

- 通常一个 Service 代表一个 Profile，比如电池服务，配网服务。（也有可能一个 Profile 包含多个 Service）
- 一个 Include 代表这个 service 需要包含其他服务才能工作。（这个用的不多）
- Characteristic 表示属性的真实值，profile 表中的每个属性被称为 characteristic，每个 characteristic 都会有一个 properites（就是属性的属性值，用于指示读写等属性）；value 则是用于存储该属性所定义的值；desriptor 也是可有可无的，用来描述该属性的，可理解为标签。（比如你自定义某个 uuid 的时候，蓝牙 SIG 没有规定这个 uuid 是哪个 profile。但是你又想要告诉对端这个 uuid 显示成哪个字符串，就可以加 一个 descriptor 来修饰一下上面的 characteristic。）


![](https://static.getiot.tech/bluetooth-stack-attribute.png)
> 表：characteristic 的定义

对于蓝牙属性的读写操作，实际上只需要找到对应的 characteristic，然后根据数据定义读写 value 即可。