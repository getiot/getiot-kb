---
sidebar_position: 3
---

# NuMaker-HMI-N9H30 固件下载（Windows）



本文介绍如何使用 NuWriter 软件工具将固件程序下载到 NuMaker-HMI-N9H30 开发板，我们将以 rt-thread 固件为例，演示 SDRAM 和 SPI Flash 两种程序下载方法。



## NuWriter 工具

在开始之前，你需要在 [GitHub](https://github.com/OpenNuvoton/NUC970_NuWriter) 下载 NUC970_NuWriter 仓库，其中包含了可直接在 Windows 系统运行的 NuWriter 程序下载工具。



## 硬件连接

在正式操作之前，你需要将 5V 电源适配器、micro USB 数据线、USB 转 RS-232 DB9 串口线按下图所示连接 NuMaker-HMI-N9H30 开发板的对应端口，并将两个 USB 接口连接到 PC 电脑上。

![](https://static.getiot.tech/NuMaker-HMI-N9H30-Board-connection.png#center)

将 NuMaker-HMI-N9H30 开发板背面的拨码开关拨到 USB Boot 位置，如下图所示。

<img src="https://static.getiot.tech/NuMaker-HMI-N9H30-show-04.jpeg" width="600" />



## 程序下载

### SDRAM 下载方式 

打开 NuWriter 工具，连接开发板虚拟串口。在 Choose type 中选择“DDR/SRAM”类型，在 Choose file 中选择准备下载的程序（例如 rtthread.bin）。点击“Download”即可将程序下载到 NuMaker-HMI-N9H30 开发板的 SDRAM 中，建议勾选 Download and run 选项，这样当程序下载完成后就会直接运行程序。

![SDRAM Downloading using NuWriter](https://static.getiot.tech/NuWriter-SDRAM-download.gif#center)


具体步骤：

```bash
Choose type: DDR/SRAM
<< Press Re-Connect >>
Choose file: Specify your rtthread.bin file.
Execute Address: 0x0
Option: Download and run
<< Press Download >>
Enjoy!! 
```



### SPI Flash 下载方式

打开 NuWriter 工具，连接开发板虚拟串口。在 Choose type 中选择“SPI”类型，在 Image Name 中选择准备下载的程序（例如 rtthread.bin）。点击“Burn”即可将程序烧写到 NuMaker-HMI-N9H30 开发板的 SPI Flash 中。下载完成后，需要先断电，并将拨码开关拨到 SPI Boot 模式，然后再次上电启动。

![SPI NOR flash Downloading using NuWriter](https://static.getiot.tech/NuWriter-SPI-Flash-burn.gif#center)

具体步骤：

```bash
Choose type: SPI
<< Press Re-Connect >>
Choose file: Specify your rtthread.bin file.
Image Type: Loader
Execute Address: 0x0
<< Press Program >>
<< Press OK & Wait it down >>
<< Set Power-on setting to SPI NOR booting >>
<< Press Reset button on board >>
Enjoy!! 
```



## 测试

使用任意一款[串口终端工具](/tools/all-of-serial-tools/)，例如 Tera Term，连接到 NuMaker-HMI-N9H30 开发板的调试串口（UART_0）。串口波特率为 115200、8 位数据位，1 位停止位、无奇偶校验、无硬件流控，串口参数如下图所示。

![Serial settings](https://static.getiot.tech/NuMaker-HMI-N9H30-Serial-Port.png#center)

