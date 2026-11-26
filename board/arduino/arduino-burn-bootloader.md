---
sidebar_position: 19
authors: [luhuadong]
---

# Arduino 烧写 Bootloader



如果没有 Bootloader，那么 Arduino 就只是一块普通的 AVR 开发板而已。我们购买的 Arduino 板子其实已经烧写好了 Bootloader 程序，所以我们感受不到它的存在。

但有几种情况，你可能需要为 Arduino 烧写 Bootloader 程序：

- 板子原来的 Bootloader 太旧了，需要更新一下 Bootloader 版本；
- 你自己做了一块 Arduino 板子，但是新买的 MCU 没有 Bootloader 程序；
- 单纯的想研究 Arduino 的技术内幕，看看它是怎么工作的。



## ICSP 接口

在介绍具体的 Bootloader 烧写方法之前，需要先了解一下 ICSP 接口。

ICSP 是 In-Circuit Serial Programming 的缩写，即在线程序烧录接口。在 Arduino 系列电路板上为一个 2*3 的排针端子，有 6 根排针与 Arduino 电路板上的单片机相连接，分别对应 5V、MISO、MOSI、SCK、GND 和 RESET，具体引脚分布如下图所示。

![](https://static.getiot.tech/arduino-icsp-pins.png#center)

其中 MISO、MOSI、SCK 为 Arduino SPI 接口，与 Arduino 扩展接口上的 SPI 接口相连，但没有使用 SS 引脚，同时增加了 RESET 复位引脚。

![](https://static.getiot.tech/arduino-uno-icsp-bootloader-connect-01.jpg#center-small)



## 使用下载器烧写

最简单的方法是使用专门的 ISP 下载器，比如 AVR USB tiny ISP，然后在电脑上安装相应的驱动程序。

使用配套的线缆连接 ISP 下载器和 Arduino 板子，下载器的另一端通过 USB 连接到你的电脑。

![](https://static.getiot.tech/arduino-uno-icsp-bootloader-connect-02.jpg#center)

打开 Arduino IDE，在工具栏中选择 “工具” -> 开发板，选择对应要烧写的开发板型号；在 “工具” -> 处理器，选择对应处理器型号；“工具” -> 编程器选择 USBtinyISP。

![](https://static.getiot.tech/arduino-uno-icsp-bootloader-connect-02-1.jpg#center)

设置完成后点击 “工具” -> 烧录引导程序，进行 Bootloader 程序的烧写。

![](https://static.getiot.tech/arduino-uno-icsp-bootloader-connect-02-2.png#center)

烧写完成后，在 Arduino IDE 下方会提示烧写成功。



## 使用 Arduino 烧写

除此之外，我们还可以借助其他的 Arduino 板子来为目标 Arduino 板烧写 Bootloader，这种方式也被称为 Arduino as ISP。

例如，使用 Arduino Uno 为另一块  Arduino Uno 烧写 Bootloader，硬件接线如下。

![](https://static.getiot.tech/arduino-uno-icsp-bootloader-connect-03.png#center)

为了完成工作，需要先为左侧的 Arduino 下载一段专用程序 ArduinoISP。打开 Arduino IDE，依次点击 `Files -> Examples -> ArduinoISP -> ArduinoISP`，将该程序编译并上传到 Arduino 板中。

接着就可以开始为目标 Arduino 烧写 Bootloader 啦！步骤与前面使用专用下载器烧写类似，不同的是在 “工具” -> 编程器中需要选择 Arduino as ISP。设置完成后点击 “工具” -> 烧录引导程序即可。



