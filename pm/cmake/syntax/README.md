---
sidebar_position: 0
---

# 第二部分：核心语法

这一部分把“能跑”提升到“写得对、写得稳”。重点是 CMakeLists.txt 的基本结构、变量/缓存、常用命令与调试输出。

## 学习目标

- 能读懂一个中小型项目的 `CMakeLists.txt`
- 理解变量、缓存变量与作用域（避免“改了但不生效”）
- 熟悉常见命令的用法边界（何时用 `set()`、`option()`、`list()` 等）

## 推荐阅读顺序

1. `CMake 基础语法（CMakeLists.txt 基础结构）`
2. `CMake 常用变量`
3. `CMake 常用命令`
4. `CMake 消息打印`

## 练习建议

- 给你的项目加一个 `option()` 开关，并在命令行用 `-D` 切换
- 用 `message(STATUS ...)` 打印关键变量（如 `CMAKE_BUILD_TYPE`、`CMAKE_GENERATOR`）

