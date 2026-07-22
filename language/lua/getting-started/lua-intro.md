---
sidebar_position: 0
slug: /lua-intro
---

# Lua 简介

![Lua Logo](https://static.getiot.tech/Lua-Logo_128x128.png#center)

Lua 是一门小巧、高效、可嵌入的脚本语言。你可以把它理解为一种“给宿主程序增加脚本能力”的语言：主程序通常由 C、C++、Go 或其他语言编写，而 Lua 负责配置、扩展、热更新或编写业务脚本。

当然，Lua 也可以作为独立脚本语言使用。你可以像运行 Python 脚本一样运行 Lua 脚本，只是 Lua 的标准库更小，语言核心更克制。

## Lua 适合做什么

Lua 的典型场景包括：

- 嵌入到 C / C++ 程序中，作为配置和扩展脚本。
- 游戏开发中的逻辑脚本、关卡脚本、热更新脚本。
- OpenResty / Nginx 生态中的高性能 Web 网关逻辑。
- Wireshark 插件、协议解析器和网络调试脚本。
- 嵌入式系统、IoT 设备和资源受限环境中的轻量脚本。
- 自动化工具和小型命令行脚本。

Lua 不太适合作为“自带完整生态的大型应用开发语言”来理解。它更像一把小而锋利的工具：核心少，嵌入容易，扩展能力强。

## Lua 的几个特点

- **轻量**

  Lua 解释器体积很小，源码包也很小。你可以把它嵌入到一个现有程序中，而不必引入庞大的运行时。

- **可移植**

  Lua 使用标准 C 实现，可以在 Linux、macOS、Windows 和许多嵌入式平台上编译运行。

- **简洁**

  Lua 语法很少。变量、函数、table、控制流程和少量标准库，就能覆盖大部分日常脚本需求。

- **可扩展**

  Lua 最强的地方不是“内置很多东西”，而是很容易由宿主程序提供能力。C / C++ 程序可以把自己的函数、对象和数据暴露给 Lua。

- **table 是核心**

  Lua 只有一种通用数据结构：table。数组、字典、对象、模块、命名空间，很多东西都可以用 table 表达。学 Lua，table 是必须认真掌握的一章。

## Lua 的历史

Lua 起源于 1993 年，诞生于巴西里约热内卢天主教大学 PUC-Rio 的 Tecgraf 实验室，主要设计者是 Roberto Ierusalimschy、Waldemar Celes 和 Luiz Henrique de Figueiredo。

![Lua 作者团队](https://static.getiot.tech/lua-author-team.jpg#center)

> 图中从左到右分别是 Waldemar、Roberto、Luiz。

Lua 这个名字来自葡萄牙语，意思是“月亮”。它最初是为工程软件提供可配置、可扩展脚本能力而设计的，后来逐渐进入游戏、网络服务、嵌入式系统和工具插件等领域。

## 和其他语言的区别

如果你学过 C、Python 或 JavaScript，可以先记住下面这些差异：

- Lua 变量默认是全局变量，建议你主动使用 `local`。
- Lua 只有 `false` 和 `nil` 是假，`0` 和空字符串都是真。
- Lua 数组通常从下标 `1` 开始。
- Lua 的 table 既能当数组，也能当字典。
- Lua 函数是一等值，可以赋值给变量、作为参数传递、作为返回值返回。
- Lua 标准库比较小，很多工程能力来自宿主程序或第三方模块。

## 官方资源

- Lua 官方网站：[https://www.lua.org](https://www.lua.org)
- Lua 参考手册：[https://www.lua.org/manual/](https://www.lua.org/manual/)
- Lua 下载目录：[https://www.lua.org/ftp/](https://www.lua.org/ftp/)
- Lua 官方仓库镜像：[https://github.com/lua/lua](https://github.com/lua/lua)

## 小结

你可以这样理解 Lua：它不是一门追求“大而全”的语言，而是一门追求“小、快、易嵌入、可扩展”的语言。接下来我们先看版本选择和安装方法，然后写出第一个 Lua 脚本。
