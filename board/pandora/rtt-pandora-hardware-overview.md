---
sidebar_position: 2
sidebar_label: 硬件概述
---

# 潘多拉 IoT Board 硬件概述



![](https://static.getiot.tech/pandora-iot-board-layout.png#center)

本文将详细介绍潘多拉 IoT 开发板的详细硬件资源。



## STM32L475VET6

潘多拉 IoT Board 主控制器 STM32L475VET6，芯片主频为 80MHz。具有 128KB SRAM 、512KB FLASH、9 个 16 位定时器、2 个 32 定时器、2 个 DMA 控制器（共 14 个通道）、3 个 SPI、2 个 SAI、3 个 IIC、5 个串口、一个低功耗串口、一个全速 USB OTG、一个 CAN 接口、3 个 12 位 ADC、2 个 12 位 DAC、一个 RTC（带日历功能）、一个 SDIO 接口、一个 FSMC 接口、一个硬件随机数生成器、以及 82 个通用 IO 口。

这是 ST 公司专为低功耗应用场景打造的芯片，非常适合物联网低功耗场景的应用。



## TFTLCD 显示屏

潘多拉 IoT Board 板载一个 TFT LCD 显示屏（LCD_TFT），它是一个 1.3 寸 240x240 超高分辨率的显示屏，支持 16 位真彩色显示。

![](https://static.getiot.tech/pandora-board-schematic-lcd.png#center)

注意：LCD 电路默认使用 4 线 SPI（3-SPI：IM0=1，IM1=0；4-SPI：IM0=0，IM1=1）



## AP6181 WiFi 模块

潘多拉 IoT Board 板载的一个 WiFi 模块，它是一款低功耗、高速的 WiFi 模块，支持标准的 SDIO 接口。通过这个板载的 WiFi 模块，可以很轻松的实现开发板的联网功能，非常适合物联网开发学习者的使用。

![](https://static.getiot.tech/pandora-board-schematic-ap6181.png#center)



## ES8388 音频解码芯片

潘多拉 IoT Board 板载的一个低功耗、高性能音频解码芯片。该芯片内部集成了 24 位高性能 DAC 和 ADC，可以播放最高 96K@24bit 的音频信号。我们可以使用这个芯片实现音乐播放、录音和语音识别等功能。

![](https://static.getiot.tech/pandora-board-schematic-audio.png#center)



## MIC（麦克风）

潘多拉 IoT Board 板载录音输入口（MIC），这个麦克风直接连接到 ES8388 音频解码芯片的输入上，可以用来实现录音功能。



## 存储

### SPI 闪存

潘多拉 IoT Board 板载了一片 SPI Flash 芯片，型号 W25Q128，容量为 128Mbit，即 16M 字节，可用于存储字库和其他用户数据，满足大容量数据存储要求。

![](https://static.getiot.tech/pandora-board-schematic-spi-flash.png#center)

### TF 卡接口

潘多拉 IoT Board 板载的一个标准 TF 卡接口（TF_CARD），采用 SPI 方式驱动，有了这个 TF 卡接口，就可以满足大量数据存储的需求。

![](https://static.getiot.tech/pandora-board-schematic-sdcard.png#center)



## 传感器

### ICM20608 六轴传感器

潘多拉 IoT Board 板载一个六轴传感器，ICM20608 是 Inven Sense 新推出的一款六轴传感器，内部集成 1 个三轴加速度传感器和 1 个三轴陀螺仪，它具有更低的功耗、更低的噪音和更薄的封装，并且支持 MPL 库，该传感器可用于四轴飞控。所以喜欢玩四轴的朋友，也可通过本开发板进行学习。

![](https://static.getiot.tech/pandora-board-schematic-icm20608.png#center)



### AP3216C 光环境传感器

潘多拉 IoT Board 板载的一个光环境三合一传感器，它可以作为环境光传感器、近距离（接近）传感器和红外传感器。

通过该传感器，开发板可以感知周围环境光线的变化，接近距离等，从而可以实现类似手机的自动背光控制。

![](https://static.getiot.tech/pandora-board-schematic-ap3216c.png#center)



### AHT10 温湿度传感器

潘多拉 IoT Board 板载一个温湿度传感器，它集成了温度传感器和湿度传感器的功能，可以用于环境监测等场景，该芯片使用 IIC 通讯。

![](https://static.getiot.tech/pandora-board-schematic-aht10.png#center)





## 三色 LED 灯

潘多拉 IoT Board 板载一个 RGB 三色 LED 灯，通过 R（红）、G（绿）和 B（蓝）三种颜色的组合，可以实现各种不同的颜色。

![](https://static.getiot.tech/pandora-board-schematic-led.png#center)



## 有源蜂鸣器

潘多拉 IoT Board 板载蜂鸣器（BEEP），可以实现简单的报警/闹铃，让开发板可以发声。

![](https://static.getiot.tech/pandora-board-schematic-beep.png#center)



## 红外收发器

潘多拉 IoT Board 板载一个红外发射头（IR1），可以实现红外发射功能，使用这个发射头，我们可以模拟红外遥控器的功能。同时，潘多拉 IoT Board 还提供了一个红外接收头（IR2），可以实现红外接收功能，通过这个接收头，可以接收市面常见的各种遥控器的红外信号。另外，潘多拉开发板还配备了一个小巧的红外遥控器，可以满足绝大多数红外收发实验，甚至可以自己实现万能红外解码。当然，如果应用得当，也可以用来传输数据。

![](https://static.getiot.tech/pandora-board-schematic-ir.png#center)



## 电机

潘多拉 IoT Board 板载一个贴片电机（MOTOR），我们可以用过 TC214B 驱动芯片来控制电机的转速和方向。TC214B 电机驱动芯片支持 1.2A 的持续电流输出，峰值电流高达 2.0A，可以通过两路 PWM 来同时控制电机的速度与方向。

![](https://static.getiot.tech/pandora-board-schematic-motor.png#center)



## 按键

### 用户按键

潘多拉 IoT Board 板载 4 个轻触按键（KEY0、KEY1、KEY2 和 WK_UP），其中 WK_UP 具有唤醒功能，该按键连接到 STM32 的 WKUP2（PC13）引脚，可用于待机模式下的唤醒，在不使用唤醒功能的时候，也可以做为普通按键输入使用。

其他 3 个是普通按键，可以用于人机交互的输入，这 3 个按键是直接连接在 STM32 的 IO 口上的。值得注意的是，WK_UP 是高电平有效，而 KEY0、KEY1 和 KEY2 是低电平有效。

![](https://static.getiot.tech/pandora-board-schematic-key.png#center)

### 复位按钮

潘多拉 IoT Board 板载的复位按键（RESET），用于复位开发板上的主芯片 STM32L475VET6。



## 接口

### 启动模式配置接口

潘多拉 IoT Board 板载的启动模式选择端口（BOOT），STM32 有 BOOT0（B0）（BOOT1 通过软件配置）选择引脚，用于选择复位后 STM32 的启动模式，作为开发板，这两个是必须的。在开发板上，可以通过跳线帽选择 STM32 的启动模式。

### ST LINK 接口

潘多拉 IoT Board 板载的 ST LINK V2.1 的 Micro USB 接口，用来连接电脑 USB 口，当然通过这个接口也可以给开发板供电。使用 Micro USB 线将这个接口与电脑 USB 连接后，电脑可以识别到 ST LINK 和一个 COM 口。注意：这里需要提前安装 ST LINK 和 STM32 USB 虚拟串口驱动。

STM32F103C8T6 芯片实现 ST LINK V2.1 功能，可以实现程序下载、软件仿真和串口通讯功能，用户仅需要
使用一根 Micro USB 线就可以使用这些功能。

### USB 串口/串口 1

ST LINK V2.1 的串口同 STM32 的串口 1 进行连接的接口（USART1），标号 RXD 和 TXD 是 ST LINK 转串口的 2 个数据口（对 ST LINK 来说），而 PA9(TXD) 和 PA10(RXD) 则是 STM32 的串口 1 的两个数据口（复用功能下）。他们通过跳线帽对接，就可以和连接在一起了，从而实现 STM32 的串口通信。

有了板载的 ST LINK V2.1 功能，我们就能省去 USB 转 TTL 的工具，只需要一根 Micro USB 线就可以实现串口输出功能。

### USB OTG 接口

潘多拉 IoT Board 板载一个 Micro USB 座（USB_OTG），这个接口是直接与 STM32L475VET6 的 USB OTG 引脚连接的。我们可以用过这个接口来实现 STM32L4 的从机和主机功能。如果要使用 USB 主机供能需要另外准备 USB OTG 转接线。

### WIRELESS 模块接口

潘多拉 IoT Board 左上角的 WIRELESS 模块接口可以插入 NRF24L01 模块或 WiFi 模块等无线模块，从而实现更灵活的无线通信功能。

### 扩展 I/O

潘多拉 IoT Board 右上角有两排 IO 引出端口（J3），总共引出 18 个 IO 口和一组 3.3V 电源输出口，供大家外接使用。

### 耳机接口

潘多拉 IoT Board 板载的音频输出接口（PHONE），该接口可以插 3.5mm 的耳机，当 ES8388 放音乐的时候，就可以通过在该接口插入耳机欣赏音乐。



## 电源

### 电源开关

潘多拉 IoT Board 板载电源开关（K1）。该开关用于控制整个开发板的供电，如果切断，则整个开发板都将断电，电源指示灯（PWR）会随着此开关的状态而亮灭。

### 电源指示灯

潘多拉 IoT Board 板载的一颗蓝色的 LED 灯（PWR），用于指示电源状态。在电源开启的时候（通过板上的电源开关控制），该灯会亮，否则不亮。通过这个 LED，可以判断开发板的上电情况。

### 3.3V 电源输入/输出

潘多拉 IoT Board 板载的一组 3.3V 电源输入输出排针（2x3）（VOUT2），用于给外部提供 3.3V 的电源，也可以用于从外部接 3.3V 的电源给板子供电（最大电流不能超过 500mA）。

### 5V 电源输入/输出

潘多拉 IoT Board 板载的一组 5V 电源输入输出排针（2x3）（VOUT1），该排针用于给外部提供 5V 的电源，也可以用于从外部接 5V 的电源给板子供电。
