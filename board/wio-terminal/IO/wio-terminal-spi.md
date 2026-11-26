---
sidebar_position: 5
slug: /wio-terminal-spi
---

# Wio Terminal SPI 接口



本文主要介绍如何使用 Wio Terminal 上的 SPI 接口，你可以使用 SPI 接口连接许多外部设备，例如 Sensor 传感器、LCD 显示器等等。



## 引脚配置

![](https://static.getiot.tech/wio-terminal-spi-sch.jpg#center)

Wio Terminal 的主控制器 ATSAMD51P19 提供了一组硬件 SPI 控制器，其引脚定义如下：

- **MOSI** -> `GPIO 19`
- **MISO** -> `GPIO 21`
- **SCK** -> `GPIO 23`
- **SS** -> `GPIO 24`





## 软件配置

在 Arduino 中，所有 SPI 引脚都是预定义的，你可以按如下方式访问这些引脚：

- **MOSI** -> `PIN_SPI_MOSI`
- **MISO** -> `PIN_SPI_MISO`
- **SCK** -> `PIN_SPI_SCK`
- **SS** -> `PIN_SPI_SS`

在 Wio Terminal 的 variant.h 文件中，SPI 引脚的具体定义如下：

```cpp showLineNumbers
/*
 * SPI Interfaces
 */
#define SPI_INTERFACES_COUNT 4

#define PIN_SPI_MISO (47ul)
#define PIN_SPI_MOSI (48ul)
#define PIN_SPI_SCK (49ul)
#define PIN_SPI_SS (50ul)
#define PERIPH_SPI sercom5
#define PAD_SPI_TX SPI_PAD_0_SCK_1
#define PAD_SPI_RX SERCOM_RX_PAD_2

  static const uint8_t SS = PIN_SPI_SS;
  static const uint8_t MOSI = PIN_SPI_MOSI;
  static const uint8_t MISO = PIN_SPI_MISO;
  static const uint8_t SCK = PIN_SPI_SCK;
```

