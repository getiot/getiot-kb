---
sidebar_position: 2
slug: /rust-cross-compilation
---

# 交叉编译

交叉编译是指在一种机器上编译另一种目标平台的程序。例如，你在 x86_64 Linux 电脑上编译 ARM MCU 程序。

## 查看当前目标

```bash
rustc -vV
```

输出中会有 `host`，表示当前主机目标。

## 添加目标

例如添加 Cortex-M 常见目标：

```bash
rustup target add thumbv7em-none-eabihf
```

目标名里的 `none` 通常表示没有传统操作系统。

## 指定 target 构建

```bash
cargo build --target thumbv7em-none-eabihf
```

真实嵌入式项目还需要链接脚本、启动代码、HAL crate 和烧录配置。

## .cargo/config.toml

项目可以把默认 target 写入配置：

```toml title=".cargo/config.toml"
[build]
target = "thumbv7em-none-eabihf"
```

这样运行 `cargo build` 时会默认使用该目标。

## 小结

交叉编译要回答三个问题：目标芯片是什么架构、Rust 是否安装了对应 target、项目是否配置了链接和启动流程。

