---
sidebar_position: 2
---

# NuMaker-HMI-N9H30 硬件概览



## 整体外观

NuMaker-HMI-N9H30 开发板采用新唐科技的 N9H 系列微处理器，是一套完整的人机显示界面解决平台。N9H30 开发板共包括两块板卡，分别是主控制板和显示屏及驱动板，外观如下图所示。

![](https://static.getiot.tech/NuMaker-HMI-N9H30-Board-overview.png#center)

主控制板和 LCD 驱动板直接通过一个 64 pin 的接口，其中包括 24 位 RGB 的并行端口。



## 资源分布

NuMaker-HMI-N9H30 开发板的硬件资源分布如下图所示。

【正面】

![](https://static.getiot.tech/NuMaker-HMI-N9H30-Board-Layout-Front-View.png#center)

【背面】

![](https://static.getiot.tech/NuMaker-HMI-N9H30-Board-Layout-Rear-View.png#center)

**NuMaker-HMI-N9H30 开发板硬件资源如下：**

- N9H30F61IEC 主控芯片：LQFP 封装，216 引脚，内置 64MB DDR 存储器；
- W25Q256JVEQ：SPI Flash 存储芯片，容量 32 MB；
- W29N01HVSINA：NAND Flash 存储芯片，容量 128 MB；
- 提供 Micro-SD/TF 插槽，用于扩展外部存储容量；
- 两路 RS-232 串口（DB9 端口，75C3232E 转换芯片）
  - UART_0 用作系统开发和调试串口；
  - UART_2 可用作用户应用通信串口；
- 22 引脚的 GPIO 扩展接口，包含 7 组 UART 串口功能； 
- JTAG 调试接口；
- NAU88C22 音频编码芯片（codec）：支持麦克风输入和耳机/扬声器输出 24 位双通道立体声；
- 6 个用户可配置的按键；
- 3 个 LED 状态指示灯；
- 1 路 CAN 总线接口（SN65HVD230 转换芯片）；
- 1 路 RS-485 总线接口（ MAX3485 转换芯片）；
- 1 个可编程蜂鸣器；
- 2 组 RJ45 以太网接口（使用 IP101GR PHY 芯片，支持 10/100Mbps）；
- 2 组 USB 2.0 接口
  - USB_0（micro USB）用作 Device/HOST 高速设备接口；
  - USB_1（type-A USB）用作 HOST 高速主机接口，可连接鼠标、键盘等外设；
- 7 寸 LCD（800x480）RGB 24-bit 含 4 线式电阻式触控
- RTC 纽扣电池插槽；
- 5V 直流电源接口。

