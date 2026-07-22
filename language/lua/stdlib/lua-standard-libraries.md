---
sidebar_position: 0
slug: /lua-standard-libraries
---

# Lua 标准库

Lua 标准库很小，但足够支撑基础脚本开发。你可以把它理解成 Lua 自带的一组工具箱：输入输出、字符串、table、数学、时间、模块加载、协程、调试等。

本章先做总览，后续章节会展开讲常用部分。

## 标准库有哪些

Lua 5.4 / 5.5 常见标准库包括：

| 库 | 说明 |
| :--- | :--- |
| basic | 基础函数，例如 `print`、`type`、`assert`、`pcall` |
| coroutine | coroutine 创建、挂起和恢复 |
| package | 模块加载机制，例如 `require`、`package.path` |
| string | 字符串处理 |
| utf8 | UTF-8 字符处理 |
| table | table 数组部分操作 |
| math | 数学函数 |
| io | 文件和标准输入输出 |
| os | 日期时间、环境变量、系统命令等 |
| debug | 调试接口 |

不是每个宿主环境都会开放全部标准库。比如某些嵌入式系统或沙箱环境可能禁用 `io`、`os.execute`、`debug` 等能力。

## basic 基础函数

基础函数不需要模块名前缀，可以直接使用。

```lua showLineNumbers title="main.lua"
print(type("Lua"))
print(tostring(123))
print(tonumber("42"))
```

输出：

```text
string
123
42
```

常见基础函数：

| 函数 | 说明 |
| :--- | :--- |
| `print(...)` | 输出到标准输出 |
| `type(v)` | 返回值类型 |
| `tostring(v)` | 转换为字符串 |
| `tonumber(v)` | 转换为数字 |
| `assert(v, msg)` | 断言，失败时抛出错误 |
| `error(msg)` | 主动抛出错误 |
| `pcall(f, ...)` | 保护调用，捕获错误 |
| `pairs(t)` | 遍历 table 键值对 |
| `ipairs(t)` | 遍历连续数组 |
| `next(t, k)` | 获取 table 下一个键值 |
| `select(index, ...)` | 处理可变参数 |

## string 库

`string` 库用于处理字符串：

```lua showLineNumbers title="main.lua"
local text = "Lua Tutorial"

print(string.upper(text))
print(string.sub(text, 1, 3))
print(string.find(text, "Tutorial"))
```

输出：

```text
LUA TUTORIAL
Lua
5	12
```

字符串章节已经详细介绍过常见用法。

## table 库

`table` 库主要处理数组风格的 table：

```lua showLineNumbers title="main.lua"
local values = {"b", "c"}

table.insert(values, 1, "a")
table.sort(values)

print(table.concat(values, ", "))
```

输出：

```text
a, b, c
```

常见函数包括 `table.insert`、`table.remove`、`table.concat`、`table.sort`、`table.unpack`。

## math 库

`math` 库提供数学函数：

```lua showLineNumbers title="main.lua"
print(math.floor(3.8))
print(math.ceil(3.2))
print(math.max(10, 20, 5))
print(math.sqrt(16))
```

输出：

```text
3
4
20
4.0
```

## io 库

`io` 库用于文件和标准输入输出：

```lua showLineNumbers title="main.lua"
local file = assert(io.open("hello.txt", "w"))
file:write("Hello, Lua!\n")
file:close()
```

文件 I/O 章节会详细讲打开、读取、写入和关闭文件。

## os 库

`os` 库提供日期时间、环境变量、文件删除、重命名等系统相关能力：

```lua showLineNumbers title="main.lua"
print(os.date("%Y-%m-%d"))
print(os.getenv("HOME"))
```

输出和你的系统有关。

## debug 库

`debug` 库可以查看调用栈、局部变量、upvalue 等调试信息。它很强大，也很容易破坏封装。

:::warning

不要在普通业务逻辑中过度依赖 `debug` 库。生产环境或沙箱环境中，它可能被禁用。

:::

## 标准库和第三方库

Lua 标准库有意保持小巧。JSON、HTTP、数据库、加密、Web 框架等能力通常来自第三方库或宿主程序。

安装第三方库时，常用工具是 LuaRocks：

```bash
luarocks install luasocket
```

包管理器章节会继续介绍 LuaRocks。

## 小结

你需要记住：

- Lua 标准库小而实用。
- 字符串、table、math、io、os 是最常用的标准库。
- `require()` 和 `package` 负责模块加载。
- `debug` 很强，但要谨慎使用。
- 工程项目通常需要 LuaRocks 或宿主程序提供更多能力。
