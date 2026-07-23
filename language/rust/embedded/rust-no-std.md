---
sidebar_position: 1
slug: /rust-no-std
---

# no_std 基础

`no_std` 表示程序不使用 Rust 标准库 `std`。很多裸机 MCU 没有操作系统能力，不能直接使用文件、线程、网络等 `std` 功能。

## 最小 no_std 示例

```rust
#![no_std]
#![no_main]

use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
```

这段代码还不能独立运行在某块板子上，但它展示了两个关键点：

- `#![no_std]`：不链接标准库
- `#[panic_handler]`：你需要定义 panic 时怎么办

## core、alloc 和 std

Rust 库可以粗略分成三层：

- `core`：最基础能力，不依赖操作系统
- `alloc`：需要堆分配器，提供 `String`、`Vec` 等
- `std`：依赖操作系统，提供文件、线程、网络等

在 `no_std` 环境下，你通常还能使用 `core`。

## no_std 不等于没有抽象

即使没有 `std`，你仍然可以使用 trait、泛型、match、Option、Result 等语言能力。限制主要来自运行环境，而不是语言本身。

## 小结

`no_std` 的本质是：目标平台没有完整操作系统支持，所以程序只能使用更底层、更可控的能力。学习时不要急着手写启动代码，优先使用开发板模板和 HAL。

