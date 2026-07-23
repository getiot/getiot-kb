---
sidebar_position: 3
slug: /rust-installation
---

# Rust 安装

Rust 官方推荐使用 `rustup` 安装和管理工具链。`rustup` 会帮你安装 `rustc`、`cargo`、`rustfmt`、Clippy、本地文档等常用组件。

## Linux / macOS 安装

执行官方安装脚本：

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

安装过程中选择默认选项即可。安装完成后，根据提示重新加载 shell 环境：

```bash
source "$HOME/.cargo/env"
```

检查版本：

```bash
rustc --version
cargo --version
```

输出类似：

```text
rustc 1.97.1 (...)
cargo 1.97.1 (...)
```

## Windows 安装

Windows 用户建议从官方页面下载安装器：

```text
https://www.rust-lang.org/tools/install
```

如果你后续会学习 Linux、嵌入式或网络开发，也可以使用 Windows Subsystem for Linux，然后按 Linux 方法安装。

## 更新和卸载

更新：

```bash
rustup update
```

卸载：

```bash
rustup self uninstall
```

## 本地文档

Rust 会安装本地文档。你可以离线阅读：

```bash
rustup doc
```

只打开 Rust Book：

```bash
rustup doc --book
```

## 开发工具

推荐使用 Visual Studio Code 加 rust-analyzer 插件。常用工具：

- `rust-analyzer`：代码补全、跳转、诊断。
- `rustfmt`：格式化代码。
- `clippy`：代码 lint，提示更惯用的写法。

检查组件：

```bash
rustup component list --installed
```

## 小结

你需要掌握：

- 使用 `rustup` 安装 Rust。
- `rustc` 是编译器，`cargo` 是项目工具。
- 使用 `rustup update` 更新。
- 使用 `rustup doc` 阅读本地文档。
