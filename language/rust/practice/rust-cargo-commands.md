---
sidebar_position: 5
slug: /rust-cargo-commands
---

# 常用 Cargo 命令

Cargo 是 Rust 的项目管理工具。你写 Rust 时，大部分日常操作都会通过 Cargo 完成。

## 创建项目

```bash
cargo new hello-rust
```

创建 library crate：

```bash
cargo new my-lib --lib
```

## 构建和运行

```bash
cargo build
cargo run
```

`cargo build` 只构建，`cargo run` 会先构建再运行。

发布模式构建：

```bash
cargo build --release
```

生成的程序通常会放在 `target/release/`。

## 检查代码

```bash
cargo check
```

`cargo check` 会做类型检查，但通常不生成最终可执行文件，所以速度比完整构建快。你在开发过程中可以频繁使用它。

## 测试、格式化和 lint

```bash
cargo test
cargo fmt
cargo clippy
```

## 管理依赖

添加依赖时编辑 `Cargo.toml`：

```toml title="Cargo.toml"
[dependencies]
serde = "1"
```

然后正常运行 `cargo build` 或 `cargo run`，Cargo 会解析并下载依赖。

## 查看文档

```bash
cargo doc --open
```

它会为当前项目和依赖生成本地文档。

## 小结

初学阶段你最常用的是 `cargo new`、`cargo run`、`cargo check`、`cargo test`。把它们练熟，你就掌握了 Rust 项目的基本节奏。

