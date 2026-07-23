---
sidebar_position: 0
---

# Rust 教程

![Rust 语言教程](https://static.getiot.tech/cover-rust-tutorial.webp#center)

Rust 是一门强调可靠性、性能和工程可维护性的系统编程语言。你可以把它理解成一门试图同时接近 C/C++ 性能、现代工程体验和编译期安全检查的语言。

这份教程面向初学者。你不需要先懂 Rust，但最好已经接触过一种编程语言，并愿意耐心阅读编译器错误。Rust 的学习曲线比较陡，不过它的很多难点都有清晰原因：编译器希望在程序运行前帮你拦下内存安全、数据竞争和资源管理问题。

## 你会学到什么

学完这份教程后，你应该能够：

- 安装 Rust toolchain，并使用 `cargo` 创建、构建和运行项目。
- 理解变量、类型、函数、控制流程等基础语法。
- 掌握 ownership、borrowing、lifetime、`Option`、`Result` 等 Rust 核心概念。
- 使用 `String`、`Vec`、`HashMap`、trait、iterator 和 closure 编写惯用 Rust 代码。
- 了解测试、格式化、Clippy、日志、配置和 crate 发布等工程实践。
- 编写简单的系统程序、网络程序、嵌入式示例和命令行工具。

## 学习建议

Rust 不是靠背语法学会的语言。你需要不断回答三个问题：

1. 这个值由谁拥有？
2. 现在谁可以读取或修改它？
3. 出错时应该返回 `Result`，还是让程序直接终止？

如果你刚开始觉得 borrow checker 很严格，这是正常的。先别急着绕过它，试着理解它为什么不放心你的代码。

## 版本约定

本教程以 stable Rust 和 Rust 2024 Edition 作为主线。官方 Rust Book 当前说明使用 Rust 1.90.0 或更高版本，并在 `Cargo.toml` 中使用 `edition = "2024"`。实际学习时，你可以通过 `rustup update` 使用最新 stable toolchain。

## 下一步

建议按目录顺序学习。先完成“Rust 入门”，再进入语言基础和核心概念。系统编程、网络编程、嵌入式和项目专题可以在掌握核心概念后再学习。
