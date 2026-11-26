---
sidebar_position: 2
---

# reTerminal 硬件概述



reTerminal 的机械尺寸是 140 x 95 x 21mm，拥有一块 5 英寸的液晶显示屏、4 个用户按键、USB、HDMI、RJ45、MIPI 以及两组扩展接口。（文末提供 reTerminal 原理图下载链接）

![](https://static.getiot.tech/reTerminal_HW_overview.png#center)



## 硬件资源

下图是 reTerminal 主板的硬件资源分布图，核心板是 Raspberry Pi Compute Module 4（CM4）。

![](https://static.getiot.tech/reTerminal_hw-overview-internal-v1.3.jpg#center)



## 硬件框图

下图是 reTerminal 的硬件框图，描述了主要模块和外设的连接关系。

![](https://static.getiot.tech/reTerminal_block_diagram-v1.3.png#center)



## 资源列表

- 硬件平台
  - 处理器：Broadcom BCM2711 quad-core Cortex-A72 (ARM v8)
  - 工作频率：64-bit SoC @ 1.5GHz
- 存储器
  - RAM：LPDDR4 with on-die ECC，4GB
  - ROM：eMMC，32GB
- 无线通信
  - Wi-Fi：2.4GHz and 5.0GHz IEEE 802.11b/g/n/ac
  - Bluetooth：Bluetooth 5.0, BLE
- 显示
  - 显示屏：5-inch 720x1280 LCD
  - 触摸屏：Capacitive touch panel（支持多点触控）
- Video
  - HDMI：1 x Micro HDMI output（高达 4Kp60 帧率）
  - CSI：1 x 2-lane MIPI CSI camera interface
  - 多媒体：
    - H.265（4Kp60 decode）
    - H.264（1080p60 decode,1080p30 encode）
    - OpenGL ES 3.0 graphics
- 内置模块
  - RTC 实时时钟
    - NXP Semiconductors PCF8563T
    - Low backup current; typical 0.25μA at VDD = 3.0 V and Temperature = 25 ℃
  - 加速度计
    - STMicroelectronics LIS3DHTR
    - 16-bit, ±2g/±4g/±8g/±16g dynamically selectable full scale
  - Encryption
    - Microchip ATECC608A
    - Secure Hardware-Based Key Storage, Asymmetric Sign, Verify, Key Agreement
  - 光传感器：Levelek LTR-303ALS-01，Digital light sensor
  - 内部 IO 扩展口：Microchip MCP23008-E
  - 蜂鸣器：≥85dB @10cm 2700±300Hz
- 外部扩展接口
  - GPIOs（侧面）
    - Up to 5 × UART
    - Up to 5 × I2C
    - Up to 5 × SPI
    - 1 × SDIO interface
    - 1 × DPI（Parallel RGB Display）
    - 1 × PCM
    - 1 × PWM channel
    - Up to 3× GPCLK outputs
  - Vertical expansion interface（背面）
    - 1 × PCIe 1-lane Host, Gen 2（5Gbps）
    - 1 × USB 2.0 port（highspeed）
    - 26 x GPIOs
    - POE
- 电源：5V DC，3A
- 工作温度：0 - 70°C（LCD 显示屏：0 - 60°C）
- 机械尺寸：140mm x 95mm x 21mm
- 产品认证：CE, FCC, TELEC(211-210815)



## 扩展接口

下面是 reTerminal 侧面（正面 LCD 屏右侧，背面的左侧）的 40 pin 扩展接口的引脚说明图。

![](https://static.getiot.tech/reTerminal_pinout-v2.jpg#center)

原理图参考：[reTerminal 40 pin 扩展接口原理图](https://files.seeedstudio.com/wiki/ReTerminal/40-pin_sch.jpg)



## 资源链接

- **[PDF]** [reTerminal Schematics v1.6](https://files.seeedstudio.com/wiki/ReTerminal/reTerminal-v1.6_SCH.pdf)
- **[ZIP]** [reTerminal Schematics v1.6](https://files.seeedstudio.com/wiki/ReTerminal/reTerminal-v1.6_SCH.zip)
- **[PDF]** [reTerminal Schematics v1.3](https://files.seeedstudio.com/wiki/ReTerminal/reTerminal-v1.3_SCH.pdf)
- **[ZIP]** [reTerminal Schematics v1.3](https://files.seeedstudio.com/wiki/ReTerminal/reTerminal-v1.3_SCH.zip)
- **[STP]** [reTerminal 3D Model](https://files.seeedstudio.com/wiki/ReTerminal/resources/reTerminal-3d-model.stp)
- **[PDF]** [Raspberry Pi Compute Module 4 数据手册](https://datasheets.raspberrypi.org/cm4/cm4-datasheet.pdf)
