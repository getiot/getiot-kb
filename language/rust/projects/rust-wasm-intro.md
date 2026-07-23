---
sidebar_position: 5
slug: /rust-wasm-intro
---

# WebAssembly 简介

WebAssembly，简称 WASM，是一种可在浏览器和其他运行时中执行的二进制指令格式。Rust 可以编译到 WASM，因此能把部分 Rust 逻辑运行在 Web 环境中。

## Rust + WASM 适合什么

常见场景包括：

- 计算密集型逻辑
- 图像、音频、几何处理
- 游戏核心逻辑
- 需要在浏览器中复用 Rust library 的场景

它不适合为了简单页面交互而强行引入。普通表单、按钮、页面状态，用 JavaScript 或 TypeScript 通常更直接。

## 基本工具

Rust 到 WebAssembly 常见工具包括：

- `wasm32-unknown-unknown` target
- `wasm-bindgen`
- `wasm-pack`

安装 target：

```bash
rustup target add wasm32-unknown-unknown
```

## 一个适合导出的函数

```rust
pub fn add(left: i32, right: i32) -> i32 {
    left + right
}
```

真实 Web 项目通常需要 `wasm-bindgen` 生成 JavaScript 绑定，让浏览器更容易调用 Rust 函数。

## 小结

WASM 让 Rust 不只运行在服务器、命令行和嵌入式设备中，也能进入浏览器。学习时先理解“把 Rust 编译成另一个目标平台”这件事，再引入绑定工具和前端工程流程。

