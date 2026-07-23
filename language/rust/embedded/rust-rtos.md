---
sidebar_position: 6
slug: /rust-rtos
---

# Rust 与 RTOS

RTOS 是 Real-Time Operating System 的缩写，通常翻译为“实时操作系统”。在嵌入式系统中，RTOS 用于任务调度、定时器、同步和通信。

## Rust 一定需要 RTOS 吗

不一定。很多小型 MCU 程序可以用裸机循环和中断完成。

当系统需要多个并发任务、明确的实时响应、复杂外设协调时，RTOS 会更有帮助。

## Rust 与 C RTOS

许多成熟 RTOS 是用 C 编写的。Rust 项目可以通过 FFI 调用 C API，也可以使用社区提供的绑定。

这种模式下，你通常会把 RTOS API 封装成更安全的 Rust 接口，避免在业务代码里到处写裸指针和 `unsafe`。

## Rust 原生嵌入式并发

Rust 生态也有一些面向嵌入式的异步或任务框架。它们尝试用 Rust 的类型系统表达任务、外设和资源关系。

选择时要看：

- 目标芯片是否支持
- 调试工具是否成熟
- 项目是否需要硬实时
- 团队是否熟悉 Rust

## 小结

Rust 可以和 RTOS 协作，也可以在某些场景下使用 Rust 原生嵌入式并发框架。初学者先理解任务、中断、共享资源，再比较具体方案会更稳。

