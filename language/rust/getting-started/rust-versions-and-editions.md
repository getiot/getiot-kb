---
sidebar_position: 2
slug: /rust-versions-and-editions
---

# Rust 版本与 Edition

Rust 有两个容易混淆的概念：toolchain 版本和 Edition。你可以把 toolchain 理解成编译器和工具版本，把 Edition 理解成源码使用的语言风格版本。

## Toolchain 版本

Rust 通过 `rustup` 管理 toolchain。常见 channel 有：

- `stable`：稳定版，适合大多数项目。
- `beta`：下一个稳定版的候选版本。
- `nightly`：每日构建，包含实验特性。

初学者建议使用 stable：

```bash
rustup default stable
rustup update
```

查看版本：

```bash
rustc --version
```

输出类似：

```text
rustc 1.97.1 (...)
```

具体版本会随时间更新。

## Edition 是什么

Edition 用来让 Rust 在保持生态兼容的前提下改进语言体验。常见 Edition 包括：

- Rust 2015
- Rust 2018
- Rust 2021
- Rust 2024

你会在 `Cargo.toml` 中看到：

```toml title="Cargo.toml"
[package]
edition = "2024"
```

不同 Edition 的 crate 可以互相依赖。Edition 不是“互不兼容的新语言”，而是 Rust 演进机制的一部分。

## 本教程使用哪个版本

本教程以 stable Rust 和 Rust 2024 Edition 为主线。官方 Rust Book 当前也以 Rust 2024 Edition 讲解。

如果你维护旧项目，可能看到 `edition = "2021"` 或更早版本。初学阶段不用担心，核心概念相同。

## 小结

你需要掌握：

- 使用 stable toolchain 学习 Rust。
- 使用 `rustup update` 更新工具链。
- Edition 写在 `Cargo.toml` 中。
- 本教程以 Rust 2024 Edition 为主线。
