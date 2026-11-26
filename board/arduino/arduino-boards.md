---
sidebar_position: 2
authors: [luhuadong]
---

# Arduino 开源硬件



## Arduino 开发板

官方的所有 Arduino 开发板可以在[这里](https://www.arduino.cc/en/Main/Products)找到，下面介绍几款比较常见的 Arduino 开发板。

### Arduino UNO

UNO 是入门电子技术和编程最佳的 Arduino 开发板。如果您是第一次尝试使用 Arduino 开发平台，那么强烈建议从 Arduino UNO 开始，因为它是使用量最多、学习资料最全的 Arduino 开发板。

Arduino Uno 基于 ATmega328P 微控制器，有14个数字输入/输出引脚（其中6个可用作 PWM 输出）、6个模拟输入、16MHz 晶振时钟、USB连接、电源插孔、ICSP 接头和复位按钮。只需要通过 USB 数据线连接电脑就能供电、程序下载和数据通讯。

![](https://static.getiot.tech/Arduino-UNO.jpg#center)

The UNO is the best board to get started with electronics and coding. If this is your first experience tinkering with the platform, the UNO is the most robust board you can start playing with. The UNO is the most used and documented board of the whole Arduino family.

### Arduino NANO

Arduino Nano 是类似于 UNO 的紧凑型开发板（可看作是 UNO 的微型版本）。

与其他版本最大的不同是，Arduino Nano 没有电源插座并且 USB 接口是 Mini-B 型插座。Arduino Nano 小到可以直接插在面包板上使用，其处理器核心是 ATmega 168（Nano 2.x）和 ATMega328（Nano 3.0）。同时具有14路数字输入/输出口（其中6路可作为 PWM 输出）、8路模拟输入、1个16MHz晶体振荡器、1个 mini-B USB 口、1个 ICSP header 以及1个复位按钮。

![](https://static.getiot.tech/Arduino-Nano.jpg#center)

The **Arduino Nano** is a compact board similar to the UNO.

### Arduino Leonardo

Arduino Leonardo 基于 ATmega32U4 微控制器，有20个数字输入/输出引脚（其中7个可用作 PWM 输出，12个可用作模拟输入）、1个16MHz 晶体振荡器、1个 micro USB 接口、1个 DC 电源插孔、1个 ICSP 接头和1个复位按钮。它包含了支持微控制器所需的一切，用户可以简单地通过把它连接到计算机的 USB 接口，或者使用 AC-DC 适配器，甚至直接用电池来驱动它。

与其他版本最大的不同是，Arduino Leonardo 直接使用了 ATmega32U4 的 USB 通信功能，这使得 Leonardo 不仅可以作为一个虚拟的（CDC）串行/COM 端口，还可以作为鼠标或键盘连接到计算机。

![](https://static.getiot.tech/Arduino-Leonardo.jpg#center)

Similar to an Arduino UNO, can be recognized by computer as a mouse or keyboard.

### Arduino Mega 2560

Arduino Mega 2560 是专门为更复杂的项目而设计的，它具有54个数字输入/输出引脚，16个模拟输入以及更大的存储容量，是 3D 打印机和机器人项目的推荐板。

Mega 2560 的核心控制器是 ATmega2560，具有 256KB 的闪存可用于存储代码（其中 8KB 被预留为启动引导项），另外还具有 8KB 的内存和 4KB 的 EEPROM。同时还具有4路 UART 接口、1个16MHz 晶体振荡器、1个 USB 接口、1个 DC 电源插孔、1个 ICSP 接头和1个复位按钮，兼容 Arduino UNO 设计的扩展板。

![](https://static.getiot.tech/Arduino-MEGA2560.jpg#center)

The MEGA 2560 is designed for more complex projects. With 54 digital I/O pins, 16 analog inputs and a larger space for your sketch it is the recommended board for 3D printers and robotics projects. This gives your projects plenty of room and opportunities.

### Arduino Micro

Micro 是 Arduino 系列产品中最小的板，可以轻松集成到日常用品中，使这些物品具有交互性。

Arduino Micro 基于 ATmega32U4 微控制器，内置 USB，因此也可以被计算机识别为鼠标或键盘。

![](https://static.getiot.tech/Arduino-Micro.jpg#center)

**Arduino Micro** is the smallest board of the family, easy to integrate it in everyday objects to make them interactive. The Micro is based on the ATmega32U4 microcontroller featuring a built-in USB which makes the Micro recognisable as a mouse or keyboard.

### Arduino Due

Arduino Due 是第一款基于32位 ARM 微控制器（Atmel SAM3X8E）的 Arduino 开发板。它具有54个数字输入/输出引脚（其中12个可用作 PWM 输出）、12个模拟输入、4路 UART 接口、84MHz 的始终频率、1个 USB OTG 接口、2路 DAC（模数转换）、2路 TWI、1个电源插座、1个 SPI 接口、1个 JTAG 接口、1个复位按键和1个擦写按键。是强大的大规模 Arduino 项目的理想之选。

![](https://static.getiot.tech/Arduino-Due.jpg#center)

The Arduino Due is the first Arduino board based on a 32-bit ARM core microcontroller. With 54 digital input/output pins, 12 analog inputs, it is the perfect board for powerful larger scale Arduino projects.

### Arduino YÚN

Arduino YÚN 是设计物联网项目理想的开发板，它结合了 Linux 的强大功能和 Arduino 的易用性。与其他 Arduino 开发板不同，Arduino YÚN 除了有一颗 ATmega32U4 微控制器，还有一颗运行 Linux（Linino，基于 OpenWrt）系统的 Atheros AR9331 微处理器（WiFi SoC）。

Arduino YÚN 可以理解为是一款具备无线功能的 Leonardo，用户可以通过 WiFi 编程实现物联网应用，同时还有一个 micro-SD 卡插槽，提供额外的存储空间。

![](https://static.getiot.tech/Arduino-YUN.jpg#center)

Arduino YÚN is the perfect board to use when designing connected devices and, more in general, Internet of Things projects. It combines the power of Linux with the ease of use of Arduino.



### Arduino Ethernet

Arduino Ethernet 是 Arduino 以太网接口版本，与其他版本最大的不同就是没有片上的 USB 转串口驱动芯片，取而代之的是 Wiznet W5100 以太网控制器（内嵌 TCP/IP 协议栈）。

Arduino Ethernet 的主控制器是 ATmega328，同时具有14路数字输入/输出引脚（其中6路可作为 PWM 输出）、6路模拟输入、1个 16MHz 晶体振荡器、1个 RJ45 接口、1个 MicroSD 卡座、1个电源插座、1个 ICSP 接头和1个复位按键。

![](https://static.getiot.tech/Arduino-Ethernet.jpg#center)

An Arduino Uno incorporating a WizNet W5100 TCP/IP Ethernet Controller.



## Arduino 产品

### Arduino Opta

Arduino Opta 是一款由 Arduino 官方和 [Finder](https://www.findernet.com) 合作设计的微型可编程 PLC，具备工业物联网能力，具备多种产业常用的网络及协议等，支持 Arduino 草图和标准 PLC 语言，包括 LD（梯形逻辑图）和 FBD（功能框图）等。Arduino Opta 使用 STM32H747XI 作为主控芯片，拥有双核 Cortex -M7 +M4 MCU 的强大计算能力，能让用户实现实时控制、监控和实施预测性维护应用。

![Arduino Opta 微型可编程 PLC](https://static.getiot.tech/arduino-opta.webp#center-600)

目前，Arduino Opta 有三种型号可供选择：

- **Arduino Opta Lite**：板载以太网和 USB-C 端口。
- **Arduino Opta RS485**：板载以太网和 USB-C 端口，加上 RS-485 连接。
- **Arduino Opta WiFi**：板载以太网和 USB-C 端口，加上 RS-485 和 WiFi 蓝牙低能耗。

Arduino Opta 设计安全耐用，支持 OTA 固件更新，并通过板载安全元件和 X.509 标准合规性确保从硬件到云端的数据安全。同时，它保持了 Arduino Pro 易于生产部署的特点，因为有大量现成的软件库和 Arduino sketch 可用。它支持各种连接选项，用户可通过实时仪表板和直观的 Arduino Cloud（或第三方服务）进行无线固件更新和远程控制，轻松掌控一切。
