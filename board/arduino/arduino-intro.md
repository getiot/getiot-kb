---
sidebar_position: 1
authors: [luhuadong]
---

# Arduino 简介

![](https://static.getiot.tech/arduino_logo.gif#center)

Arduino 是一个开源嵌入式硬件平台，用户可以使用它快速制作可交互式的嵌入式项目。本文简单介绍 Arduino 的起源及其特点。



## Arduino 起源

Arduino 最初是针对不会写程序，也不懂电子学，没有任何技术背景的学生而设计的一种易用的可编程设备，设计初衷是用于交互艺术设计项目。

2005年，在意大利北部艾芙瑞亚交互设计学院（Interactive Design Institute Ivrea），MassimoBanzi 与 David Cuartielles 基于 Hernando Barragán（Wiring 发明者）的工作创造了 Arduino。随后，David Mellis 基于 Wiring 开发了 Arduino 软件。不久之后，Gianluca Martino 与 Tomlgoe 加入该项目。他们五人也被公认为 Arduino 的创始人。

![](https://static.getiot.tech/arduino-team.jpg#center)

Arduino 的诞生源于他们想开发这样一种简单的设备：这种设备应当能够很容易地连接到其他各种设备上，比如继电器、发动机、传感器，也应当很容易进行编程；并且价格也要便宜，毕竟学生和艺术家没多少闲钱。最后，他们选择了 Atmel 公司生产的 8 位微控制器（又称 MCU 或 μC）中的 AVR 系列，设计了一种易于连接使用的独立电路板，并为微控制器编写了 BootLoader 固件，然后将其全部打包放入一个简单的集成开发环境，其中使用的程序称为 sketch。就这样，Arduino 诞生了。

此后，Arduino 朝着几个不同的方向发展，其中一些版本变得更加小巧，而另一些版本则变得更大。每个版本的 Arduino 都有特定的市场定位，以满足不同用户的需求。这些不同版本的 Arduino 的共同之处是，它们都提供 Arduino runtime AVR-GCC 库，并配备了 Arduino 开发环境，且都有板载 BootLoader 固件，该固件会被预先加载到每个 Arduino 开发板的微控制器。

Arduino 官方网站 arduino.cc 上有篇文章（[Hardware Index](http://www.arduino.cc/en/Main/Boards)）列出了 Arduino 早期和现有的一些控制板，感兴趣的小伙伴可以上去看看。

扩展阅读：[https://arduinohistory.github.io](https://arduinohistory.github.io)



## Arduino 的特点

Arduino 开源硬件平台不仅是一个易学易用的 I/O 电路板，还包括一套集成开发环境和众多软件库。Arduino IDE 支持 Windows、macOS、Linux 三大主流操作系统平台。

Arduino 具有如下特点，这也是其迅速流行起来的原因。

1. Arduino 采用 Creative Commons（CC）许可，任何人都被允许生产电路板的复制品，还能重新设计出符合自己需求的电路；
2. 除了电路设计是完全开源的，开发环境也是开源的且可以在官网免费下载；
3. 使用性价比高的微控制器（AVR 系列控制器）；
4. Arduino 支持 ISP 在线系统编程，可以为 AVR 单片机烧入引导程序（Bootloader），单片机也可以通过引导程序使用串行通信协议在线更新固件；
5. Arduino 对底层单片机操作进行了二次封装，为应用程序提供简单、统一的 API。

经过十几年的发展，Arduino 已经在全球售出超过 100 万件，成为了创客运动、开源硬件的标志。在全球的创客们共同完善与努力下，Arduino 形成了硬件、软件完整丰富的开发生态。



## 相关链接

- 官方网站：[https://www.arduino.cc](https://www.arduino.cc)
- 中文社区：[https://www.arduino.cn](https://www.arduino.cn)
- 项目分享：[https://create.arduino.cc/projecthub](https://create.arduino.cc/projecthub)


