---
sidebar_position: 1
---

# NodeMCU 简介



## 概述

NodeMCU 是一款开源快速硬件原型平台，包括固件和开发板，用户通过几行简单的 Lua 脚本就能开发物联网应用。

![](https://static.getiot.tech/nodemcu-module_2.jpg#center)

NodeMCU 基于乐鑫 [ESP8266](https://www.espressif.com)，除了支持 WiFi 功能，还具有 GPIO、PWM、I2C、1-Wire、ADC 等功能。同时 NodeMCU 固件提供了类似于 Arduino 的开发方式（虽然 NodeMCU 并不是 Arduino 团队开发的，但是我们可以使用 Arduino IDE 对它进行开发），所以获得全球创客开发者的青睐，成为快速原型开发的选择之一。

由于 NodeMCU 采用来自中国的 ESP8266 模块，因此具有极高的性价比，非常适合开发者们学习和使用，开发物联网节点设备。



## 引脚布局

ESP8266 芯片有17个 GPIO 引脚（GPIO0～GPIO16）。这些引脚中的 GPIO6～GPIO11 被用于连接开发板的闪存（Flash Memory）。如果在实验电路中使用 GPIO6～GPIO11，NodeMCU 开发板将无法正常工作。因此建议您不要使用 GPIO6～GPIO11。

NodeMCU 的引脚布局和定义如下图所示。

![](https://static.getiot.tech/nodemcu-pin-layout.jpg#center)

NodeMCU 引脚说明如下表所示（GPIO 编号指 ESP8266 芯片的引脚编号，丝印编号指 NodeMCU 上印制的引脚名称）。

|  GPIO 编号  |        丝印编号        |     功能     |
| :---------: | :--------------------: | :----------: |
|   GPIO 0    |           D3           | 引导模式选择 |
|   GPIO 1    |        TX (D10)        |     TX0      |
|   GPIO 2    |           D4           | 引导模式选择 |
|   GPIO 3    |        RX (D9)         |     RX0      |
|   GPIO 4    |           D2           |  SDA (I2C)   |
|   GPIO 5    |           D1           |  SCL (I2C)   |
| GPIO 6 - 11 | 不可用，但需要一直供电 |   连接闪存   |
|   GPIO 12   |           D6           |  MISO (SPI)  |
|   GPIO 13   |           D7           |  MOSI (SPI)  |
|   GPIO 14   |           D5           |  SCK (SPI)   |
|   GPIO 15   |           D8           |   SS (SPI)   |
|   GPIO 16   |           D0           |   睡眠唤醒   |

注意事项：

1. ESP8266 芯片与 Arduino Uno/Mega/Nano 等开发板的引脚电平电压有所区别。Arduino 开发板的低电平是 0V，高电平是 +5V。而 NodeMCU 低电平是 0V，高电平是 +3.3V。
2. ESP8266 有2个硬件串行端口（UART）。
   - 串行端口0（UART0）使用 GPIO1（TX0）和 GPIO3（RX0）引脚；
   - 串行端口1（UART1）使用 GPIO2（TX1）和 GPIO8（RX1）引脚，但由于 GPIO8 被用于连接闪存芯片，因此 UART1 只能使用 GPIO2（TX1）来向外发送串行数据。
3. ESP8266 没有硬件 I2C 端口，只有软件模拟的 I2C 端口，也就是说我们可以使用任意的两个 GPIO 引脚通过软件模拟来实现 I2C 通信。
4. 除了连接闪存的端口，ESP8266 还提供了一组用户可用的 SPI 端口 —— GPIO12-15。