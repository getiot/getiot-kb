---
sidebar_position: 2
---

# NanoPi R6S 硬件概览



## 硬件资源

NanoPi R6S 的硬件资源分布如下图所示。

![](https://static.getiot.tech/NanoPi_R6S_Layout.jpg#center)

硬件资源具体说明如下：

- SoC：Rockchip（瑞芯微）RK3588S
  - CPU：四核 ARM Cortex-A76（高达 2.4GHz）和四核 Cortex-A55 CPU（高达 1.8GHz）
  - GPU：Mali-G610 MP4，兼容 OpenGLES 1.1、2.0 和 3.2，OpenCL（最高 2.2）和 Vulkan1.2
  - VPU：支持 8K@60fps H.265 和 VP9 解码器、8K@30fps H.264 解码器、4K@60fps AV1 解码器、8K@30fps H.264 和 H.265 编码器
  - NPU：6TOPs，支持 INT4/INT8/INT16/FP16
- RAM：64-bit 8GB LPDDR4X（工作频率 2133MHz）
- Flash：32GB eMMC（HS400 模式）
- Ethernet：一个原生千兆以太网，两个 PCIe 扩展以太网（2.5G）
- USB：一个 USB 3.0 Type-A，一个 USB 2.0 Type-A
- HDMI：兼容 HDMI2.1、HDMI2.0 和 HDMI1.4，最高支持 7680x4320@60Hz，支持 RGB/YUV（最高 10bit）格式
- microSD：支持 SDR104 模式
- GPIO：12-pin 0.5mm FPC 连接器，可扩展出最多 1 路 SPI、3 路 UART、1 路 I2C、2 路 SPDIF、8 个 GPIO
- Debug：调试串口（3 Pin 2.54mm header, 3.3V level, 1500000bps）
- LEDs：4 个 GPIO 控制的 LED（SYS, WAN, LAN1, LAN2）
- 其他：
  - 2 Pin 1.27/1.25mm RTC 电池输入连接器（低功耗 RTC IC HYM8563TS）
  - 1 个 IR 红外接收器（载波频率为 38Khz）
  - 1 个 MASK 按钮（用于 eMMC update）
  - 1 个用户按钮
  - 1 个 5V Fan 连接器
- Power supply：USB-C，支持 PD、5V/9V/12V/20V 输入
- PCB：8 层板，尺寸 62x90x1.6mm
- 环境工作温度：0℃ 到 70℃



## 扩展接口

NanoPi R6S 主板上提供了一个 12-pin 0.5mm FPC 连接器，可扩展出最多 1 路 SPI、3 路 UART、1 路 I2C、2 路 SPDIF、8 个 GPIO，具体引脚定义如下表所示。

| Pin  | GPIO          | SPI / I2C    | UART        | SPDIF        | 说明          |
| ---- | ------------- | ------------ | ----------- | ------------ | ------------- |
| 1    | VCC3V3_SYS_S3 |              |             |              | 3.3V 电源输出 |
| 2    | VCC3V3_SYS_S3 |              |             |              | 3.3V 电源输出 |
| 3    | GPIO1_B3      | SPI0_CLK_M2  | UART4_TX_M2 |              | 3.3V          |
| 4    | GND           |              |             |              | 地            |
| 5    | GPIO1_B1      | SPI0_MISO_M2 |             |              | 3.3V          |
| 6    | GPIO1_B4      | SPI0_CS0_M2  |             |              | 3.3V          |
| 7    | GPIO1_B2      | SPI0_MOSI_M2 | UART4_RX_M2 |              | 3.3V          |
| 8    | GND           |              |             |              | 地            |
| 9    | GPIO1_B7      | I2C5_SDA_M3  | UART1_RX_M1 | SPDIF1_TX_M0 | 3.3V          |
| 10   | GPIO1_B6      | I2C5_SCL_M3  | UART1_TX_M1 | SPDIF0_TX_M0 | 3.3V          |
| 11   | GPIO3_C4      |              | UART5_TX_M1 |              | 3.3V          |
| 12   | GPIO3_C5      |              | UART5_RX_M1 |              | 3.3V          |



## 调试串口

| Pin  | 信号              | 说明 |
| ---- | ----------------- | ---- |
| 1    | GND               | 地   |
| 2    | UART2_TX_M0_DEBUG | 发送 |
| 3    | UART2_RX_M0_DEBUG | 接收 |



## 相关资料

- 电路原理图：[NanoPi_R6S_2208_SCH.PDF](https://wiki.friendlyelec.com/wiki/images/2/2f/NanoPi_R6S_2208_SCH.PDF)
- PCB 文件：[NanoPi_R6S_2208_2D_DXF.zip](https://wiki.friendlyelec.com/wiki/images/9/96/NanoPi_R6S_2208_2D_DXF.zip)
- 数据手册：[Rockchip_RK3588S_Datasheet_V1.0-20211221.pdf](https://wiki.friendlyelec.com/wiki/images/1/17/Rockchip_RK3588S_Datasheet_V1.0-20211221.pdf)

