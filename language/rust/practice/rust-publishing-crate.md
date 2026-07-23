---
sidebar_position: 6
slug: /rust-publishing-crate
---

# 发布 crate

当你写了一个可复用的 library crate，可以把它发布到 crates.io，供其他 Rust 项目使用。

## 准备 Cargo.toml

发布前，`Cargo.toml` 需要包含基本元数据：

```toml title="Cargo.toml"
[package]
name = "my-awesome-crate"
version = "0.1.0"
edition = "2024"
description = "A short description"
license = "MIT OR Apache-2.0"
repository = "https://github.com/your-name/my-awesome-crate"
```

`name` 在 crates.io 上必须唯一。`description`、`license` 这些信息会影响别人是否敢使用你的 crate。

## 本地检查

发布前至少运行：

```bash
cargo fmt
cargo clippy
cargo test
cargo package
```

`cargo package` 会模拟打包，帮助你发现缺少文件、元数据不完整等问题。

## 登录并发布

你需要在 crates.io 获取 API token，然后执行：

```bash
cargo login
cargo publish
```

发布后，同一个版本号不能再次发布。如果要修复问题，需要提升版本号，例如从 `0.1.0` 改成 `0.1.1`。

## 版本号习惯

Rust crate 通常遵循语义化版本：

- `MAJOR`：不兼容的 API 变更
- `MINOR`：向后兼容的新功能
- `PATCH`：向后兼容的问题修复

## 小结

发布 crate 前，你要确认它有清楚的文档、测试和版本信息。对初学者来说，先学会写 library crate，再考虑发布，会更稳。

