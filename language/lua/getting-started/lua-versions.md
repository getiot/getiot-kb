---
sidebar_position: 1
slug: /lua-versions
---

# Lua 版本选择

学习 Lua 之前，建议先了解版本选择。Lua 的不同大版本之间并不完全兼容，尤其是嵌入式项目、游戏引擎、网络工具和 LuaJIT 生态，可能长期停留在某个特定版本。

## 当前版本

截至 2026 年 7 月，Lua 官方当前版本是 Lua 5.5。Lua 5.4 分支的最新补丁版本是 Lua 5.4.8。

官方版本信息可以查看：

- [Lua 版本历史](https://www.lua.org/versions.html)
- [Lua 下载目录](https://www.lua.org/ftp/)
- [Lua 参考手册](https://www.lua.org/manual/)

## 本教程使用哪个版本

本教程建议以 Lua 5.4 为主要学习版本，示例尽量使用 Lua 5.4 和 Lua 5.5 都能理解的基础语法。

这样安排有三个原因：

- Lua 5.4 仍然非常常见，适合作为稳定学习基线。
- 许多 Linux 发行版、嵌入式系统和第三方库还不会马上切换到 Lua 5.5。
- 初学阶段最重要的是掌握变量、函数、table、模块、错误处理等核心概念，这些知识在 Lua 5.x 中大体稳定。

如果你正在参与某个已有项目，应优先使用项目指定的 Lua 版本，而不是盲目追求最新版本。

## 常见版本差异

初学时不需要记住所有差异，但要知道下面几个方向：

- Lua 5.1 仍然常见，LuaJIT 主要兼容 Lua 5.1 语义。
- Lua 5.2 调整了环境模型，旧式 `setfenv`、`getfenv` 不再属于常规写法。
- Lua 5.3 引入整数、位运算和基础 `utf8` 库。
- Lua 5.4 引入 generational garbage collection、`const` 变量和 to-be-closed 变量。
- Lua 5.5 引入全局变量声明、named vararg tables 等新特性。

:::note

如果你阅读旧教程时看到 `module(..., package.seeall)`、`setfenv`、`getfenv` 等写法，需要注意它们通常来自 Lua 5.1 时代，不适合作为现代 Lua 教程的主线写法。

:::

## 选择建议

如果只是学习 Lua，建议从 Lua 5.4 或 Lua 5.5 开始。

如果你面向 OpenResty、部分游戏引擎或 LuaJIT 项目，应确认项目实际使用的是 Lua 5.1 / LuaJIT 语义。

如果你要在嵌入式设备中集成 Lua，应优先考虑宿主项目、交叉编译工具链、可用内存、第三方模块和 C API 兼容性。

## 小结

- 学习主线建议选择 Lua 5.4 或 Lua 5.5。
- 本教程以 Lua 5.4 作为稳定基线，并尽量说明重要版本差异。
- 旧版本教程中的写法不一定适合现代 Lua，需要结合官方手册验证。
