---
sidebar_position: 0
slug: /rust-embedded-intro
---

# 嵌入式 Rust 简介

嵌入式 Rust 是把 Rust 用在 MCU、开发板、传感器和低资源设备上的实践。它的目标不是替代所有 C 代码，而是在合适的场景里提供更强的类型检查和内存安全。

## 和桌面 Rust 有什么不同

在桌面程序里，你通常可以使用完整标准库 `std`。在很多 MCU 上，没有操作系统、文件系统、堆分配或线程支持，这时会使用 `no_std`。

嵌入式程序还会面对：

- 交叉编译
- 烧录和调试
- 中断
- 寄存器
- GPIO、UART、I2C、SPI 等外设
- 电压、电流和硬件连接问题

## 嵌入式 Rust 生态

常见组成包括：

- PAC：Peripheral Access Crate，寄存器级访问
- HAL：Hardware Abstraction Layer，硬件抽象层
- embedded-hal：跨芯片的外设 trait
- probe-rs：烧录和调试工具链之一

## 适合初学者的路线

你可以按这个顺序学习：

1. 先掌握普通 Rust 的所有权、借用、错误处理
2. 理解 `no_std` 为什么存在
3. 学会为目标芯片交叉编译
4. 使用开发板现成 HAL 点亮 LED
5. 再学习 UART、I2C、SPI 和中断

## 小结

嵌入式 Rust 的难点一半来自 Rust，一半来自硬件。你要同时保持软件思维和硬件安全意识，尤其注意电压、接线和芯片型号。

