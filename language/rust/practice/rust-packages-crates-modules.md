---
sidebar_position: 0
slug: /rust-packages-crates-modules
---

# Package、Crate 与 Module

当你的 Rust 程序从一个文件长成多个文件时，就需要理解 `package`、`crate` 和 `module`。这三个词看起来抽象，其实是在回答一个很实际的问题：代码应该怎样组织，别人又该怎样使用它？

## 三个概念

`package` 是一个 Cargo 项目，里面有 `Cargo.toml`。

`crate` 是 Rust 的编译单元。一个 package 可以包含一个 library crate，也可以包含一个或多个 binary crate。

`module` 是 crate 内部组织代码的方式，用 `mod`、`pub`、`use` 管理作用域和可见性。

一个常见项目结构如下：

```text
hello-rust/
├── Cargo.toml
└── src/
    ├── main.rs
    └── network.rs
```

`src/main.rs` 是 binary crate 的入口，`src/network.rs` 可以作为一个 module 被引入。

## 创建 module

```rust title="src/main.rs" showLineNumbers
mod network;

fn main() {
    network::connect();
}
```

```rust title="src/network.rs" showLineNumbers
pub fn connect() {
    println!("connect to server");
}
```

如果函数没有写 `pub`，它默认只能在当前 module 内使用。

## 使用 use 简化路径

```rust title="src/main.rs" showLineNumbers
mod network;

use network::connect;

fn main() {
    connect();
}
```

`use` 不会复制代码，它只是把路径引入当前作用域。

## 目录形式的 module

当一个 module 继续变大，可以把它拆成目录：

```text
src/
├── main.rs
└── network/
    ├── mod.rs
    └── tcp.rs
```

```rust title="src/network/mod.rs"
pub mod tcp;
```

```rust title="src/network/tcp.rs"
pub fn listen() {
    println!("listening");
}
```

```rust title="src/main.rs"
mod network;

fn main() {
    network::tcp::listen();
}
```

## 小结

你可以这样记：Cargo 管 `package`，Rust 编译器编译 `crate`，你用 `module` 把 crate 内部整理清楚。初学时先别急着设计复杂目录，等一个文件真的太长了，再把相关代码拆出去。

