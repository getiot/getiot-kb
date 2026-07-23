---
sidebar_position: 3
slug: /rust-embedded-hal
---

# 嵌入式 HAL

HAL 是 Hardware Abstraction Layer 的缩写，通常翻译为“硬件抽象层”。它把芯片寄存器细节包装成更容易使用的 API。

## 为什么需要 HAL

不同芯片的寄存器地址和位定义不同。如果你直接写寄存器，代码很难跨芯片复用。

HAL 会提供更接近外设概念的接口，例如：

- 配置 GPIO 为输出
- 设置 UART 波特率
- 发起 I2C 读写
- 配置 SPI 模式

## embedded-hal

`embedded-hal` 定义了一组通用 trait，让驱动可以不绑定具体芯片。

例如，一个温湿度传感器驱动可以依赖 I2C trait，而不是依赖某个 STM32 或 ESP32 的具体 HAL。

## 分层理解

你可以这样看嵌入式 Rust 代码：

```text
应用逻辑
  ↓
传感器/设备驱动
  ↓
embedded-hal trait
  ↓
芯片 HAL
  ↓
PAC / 寄存器
  ↓
硬件
```

## 小结

HAL 让你少碰寄存器，`embedded-hal` 让驱动更容易复用。初学者应该优先从开发板官方或社区推荐 HAL 入手。

