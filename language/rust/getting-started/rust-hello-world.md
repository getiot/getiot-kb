---
sidebar_position: 4
slug: /rust-hello-world
---

# 第一个 Rust 程序

这一节我们先写一个最小 Rust 程序，让你看到 Rust 源码如何编译和运行。

## 编写程序

创建 `main.rs`：

```rust showLineNumbers title="main.rs"
fn main() {
    println!("Hello, world!");
}
```

## 编译与运行

使用 `rustc` 编译：

```bash
rustc main.rs
```

运行：

```bash
./main
```

输出：

```text
Hello, world!
```

Windows 上生成的可执行文件通常是 `main.exe`。

## 程序剖析

`fn main()` 定义了程序入口函数：

```rust
fn main() {
}
```

`println!` 用来输出一行文本：

```rust
println!("Hello, world!");
```

注意 `println!` 后面有 `!`，这表示它是一个 macro，而不是普通函数。你现在不用深入宏，只要先记住这个写法。

语句通常以分号结尾：

```rust
println!("Hello, world!");
```

Rust 官方风格使用 4 个空格缩进。

## 用 cargo 创建项目

真实项目中更常用 `cargo`：

```bash
cargo new hello-rust
cd hello-rust
cargo run
```

输出：

```text
Hello, world!
```

## 小结

你已经完成：

- 编写 `main.rs`。
- 使用 `rustc` 编译单文件。
- 使用 `cargo new` 和 `cargo run` 运行项目。

后续教程会主要使用 `cargo`。
