---
sidebar_position: 1
slug: /rust-how-it-works
---

# Rust 工作原理

在写第一行 Rust 代码之前，先理解 Rust 程序大致怎样工作，会让你后面遇到编译器错误时更有耐心。

简单说：Rust 源码会先经过 `rustc` 编译器检查，再通过 LLVM 生成机器码，最后链接成可执行文件。它和 C/C++ 一样属于 ahead-of-time 编译语言，不需要传统虚拟机，也不依赖垃圾回收器。

## 从源码到可执行文件

一个 Rust 程序通常经历这些阶段：

```text
.rs 源码
  -> rustc 解析与类型检查
  -> ownership / borrowing / lifetime 检查
  -> MIR 中间表示
  -> LLVM 优化与代码生成
  -> linker 链接
  -> 可执行文件
```

初学时你不需要深入 MIR 或 LLVM。你只需要知道，Rust 的很多安全检查发生在生成机器码之前。

## rustc 和 cargo 的关系

`rustc` 是 Rust 编译器。你可以直接编译单个文件：

```bash
rustc main.rs
```

`cargo` 是 Rust 的构建工具和包管理器。真实项目中你通常使用：

```bash
cargo build
cargo run
cargo test
```

你可以把 `cargo` 理解成项目经理：它会读取 `Cargo.toml`，下载依赖，调用 `rustc`，运行测试，生成文档。

## Rust 和 C/C++ 的相同点

Rust、C、C++ 都可以编译成本地机器码：

- 运行时不需要解释器。
- 适合性能敏感程序。
- 可以调用系统 API。
- 可以和 C ABI 交互。
- 可以用于系统编程和嵌入式开发。

这也是 Rust 经常被放在 C/C++ 旁边讨论的原因。

## Rust 和 C/C++ 的关键差异

C/C++ 给你很高自由度，但很多内存问题要靠程序员自己避免。Rust 则把一部分规则写进类型系统和 borrow checker。

例如 C/C++ 中常见的问题：

- 释放后继续使用内存。
- 返回指向局部变量的指针。
- 多个线程同时修改同一份数据。
- 忘记释放资源。

Rust 会尽量在编译期拦下这些问题。你会更早看到错误，但也更早知道哪里不安全。

## Rust 为什么不需要 GC

很多语言依赖 garbage collector 自动回收对象。Rust 采用 ownership 和 RAII：

- 每个值都有 owner。
- owner 离开作用域时，值会被自动释放。
- 编译器保证不会在释放后继续使用。

示例：

```rust
fn main() {
    let name = String::from("Rust");
    println!("{name}");
} // name 在这里离开作用域，内存被释放
```

这个释放位置是确定的，不需要 GC 在运行时扫描。

## 为什么 Rust 编译慢一些

Rust 编译器做的事情比较多：

- 类型推导和类型检查。
- ownership 和 borrowing 检查。
- 泛型单态化。
- LLVM 优化。
- 增量编译和依赖分析。

它把许多运行时风险提前到编译期处理，所以你会感觉“编译器管得很多”。这不是缺点或优点的单面问题，而是一种工程取舍。

## 小结

你需要掌握：

- `rustc` 是编译器，`cargo` 是构建工具和包管理器。
- Rust 和 C/C++ 一样可以编译成本地机器码。
- Rust 通过 ownership、borrowing 和 lifetime 在编译期检查内存安全。
- Rust 不依赖 GC，而是通过确定的作用域释放资源。
- 编译器错误是学习 Rust 的重要材料，不只是障碍。
