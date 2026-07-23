---
sidebar_position: 5
slug: /rust-cargo-quick-start
---

# Cargo 快速上手

Cargo 是 Rust 的项目工具。你会用它创建项目、编译代码、运行程序、执行测试、生成文档和管理依赖。

## 创建项目

```bash
cargo new hello-rust
cd hello-rust
```

目录结构：

```text
hello-rust/
├── Cargo.toml
└── src/
    └── main.rs
```

`Cargo.toml` 是项目配置文件，`src/main.rs` 是默认程序入口。

## 运行项目

```bash
cargo run
```

Cargo 会先编译，再运行可执行文件。

## 只编译不运行

```bash
cargo build
```

debug 构建结果在：

```text
target/debug/
```

release 构建：

```bash
cargo build --release
```

release 构建会开启优化，编译更慢，但运行性能更好。

## 检查代码

如果你只想快速检查代码能否通过编译，不生成最终二进制，可以使用：

```bash
cargo check
```

写 Rust 时，`cargo check` 很常用，因为它比完整构建更快。

## 添加依赖

依赖写在 `Cargo.toml`：

```toml title="Cargo.toml"
[dependencies]
serde = "1"
```

也可以使用：

```bash
cargo add serde
```

如果没有 `cargo add`，可以先安装较新的 Rust toolchain，或者手动编辑 `Cargo.toml`。

## 常用命令

| 命令 | 说明 |
| :--- | :--- |
| `cargo new name` | 创建新项目 |
| `cargo run` | 构建并运行 |
| `cargo build` | 构建项目 |
| `cargo build --release` | 优化构建 |
| `cargo check` | 快速检查 |
| `cargo test` | 运行测试 |
| `cargo fmt` | 格式化代码 |
| `cargo clippy` | 运行 lint |
| `cargo doc --open` | 生成并打开文档 |

## 小结

你需要掌握：

- Rust 项目通常用 Cargo 管理。
- `Cargo.toml` 保存项目元信息和依赖。
- 开发时常用 `cargo check`、`cargo run`、`cargo test`。
- 发布或性能测试时使用 `cargo build --release`。
