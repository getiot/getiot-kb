---
sidebar_position: 0
---

# Lua 教程

![Lua 语言教程](https://static.getiot.tech/cover-lua-tutorial.webp#center)

Lua 是一门轻量、灵活、容易嵌入到其他程序中的脚本语言。你可能会在游戏引擎、OpenResty、Wireshark 插件、嵌入式设备、自动化脚本、网络工具和各种可扩展软件中见到它。

这份教程面向初学者。你不需要先有 Lua 基础，但最好已经接触过一点命令行，知道如何创建文本文件、运行命令和阅读简单报错。

## 你会学到什么

学完这份教程后，你应该能够：

- 安装 Lua，并运行交互式解释器和 `.lua` 脚本。
- 理解 Lua 的变量、数据类型、运算符和控制流程。
- 熟练使用函数、字符串、table、数组、迭代器和模块。
- 使用常见标准库完成文件读写、日期时间、数学计算、错误处理和调试。
- 理解 metatable、面向对象写法、coroutine 和 garbage collection 等进阶机制。
- 了解 Lua 与 C、网络、数据库、游戏、Wireshark 等工程场景的关系。

## 学习路线

建议你按左侧目录顺序学习：

1. 先完成“Lua 入门”，装好环境并跑通第一个脚本。
2. 再学习“Lua 语言基础”，建立基本语法能力。
3. 接着重点学习“Lua 核心用法”，尤其是 table、函数和模块。
4. 然后学习“Lua 标准库与工具”，让代码能处理真实输入输出。
5. 最后进入“Lua 进阶机制”和“Lua 实战与扩展”。

:::tip

Lua 的语法不复杂，真正重要的是理解它的几个核心心智模型：变量默认是全局的、函数是一等值、table 是唯一通用数据结构、metatable 可以改变对象行为。

:::

## 本教程的版本约定

本教程以 Lua 5.4 作为稳定学习基线，并尽量说明重要版本差异。你可以使用 Lua 5.4 或 Lua 5.5 学习大部分基础内容。

如果你正在参与一个已有项目，请优先使用项目指定的 Lua 版本。例如，OpenResty 和部分 LuaJIT 生态通常与 Lua 5.1 语义关系更密切。

## 示例代码约定

教程中的代码通常保存为 `main.lua` 或具体示例文件名，然后使用下面的命令运行：

```bash
lua main.lua
```

除非特别说明，示例默认在 Linux / macOS / Windows 终端环境下都可以理解。涉及系统路径、动态库、包管理器或网络服务的章节，会单独说明平台差异。

## 下一步

如果你是第一次接触 Lua，可以从 [Lua 简介](getting-started/lua-intro.md) 开始。如果你已经知道 Lua 是什么，只想先跑起来，可以直接阅读 [Lua 安装](getting-started/lua-installation.md) 和 [Lua 快速上手](getting-started/lua-quick-start.md)。
