---
sidebar_position: 5
slug: /rust-embedded-interfaces
---

# UART / I2C / SPI 简介

嵌入式设备经常通过 UART、I2C、SPI 连接传感器、屏幕、模组和其他芯片。

## UART

UART 是串口通信，常用于日志输出、调试、GNSS 模组、蓝牙模组等。

你需要关注：

- 波特率
- 数据位
- 校验位
- 停止位
- TX/RX 是否交叉连接

## I2C

I2C 是两线总线，通常使用 `SCL` 和 `SDA`。多个设备可以挂在同一条总线上，每个设备有自己的地址。

你需要关注：

- 设备地址
- 上拉电阻
- 总线速度
- 电压等级

## SPI

SPI 通常使用 `SCLK`、`MOSI`、`MISO`、`CS`。它速度较快，常用于显示屏、Flash、ADC 等设备。

你需要关注：

- SPI mode
- 时钟频率
- 片选信号
- 数据位序

## Rust 中的抽象

在 Rust 中，驱动通常会依赖 `embedded-hal` 中的 trait。这样同一个传感器驱动可以适配不同芯片 HAL。

## 小结

UART 简单直接，I2C 适合多个低速设备共享总线，SPI 适合更高速度的外设。写代码前先把接线、电压和时序参数确认清楚。

