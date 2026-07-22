---
sidebar_position: 0
slug: /lua-basic-syntax
---

# Lua 基础语法

这一节我们先建立 Lua 程序的基本外观。你会看到注释、标识符、关键字、代码块和语句分隔方式。先把这些规则掌握住，后面读代码就不会陌生。

## 程序块

Lua 执行的一段代码称为 chunk。一个 `.lua` 文件是 chunk，在交互式解释器中输入的一行或多行代码也可以看作 chunk。

下面是一个最小的 Lua 程序：

```lua showLineNumbers title="main.lua"
print("Hello, Lua!")
```

运行：

```bash
lua main.lua
```

输出：

```text
Hello, Lua!
```

Lua 语句末尾通常不需要分号：

```lua
local name = "Lua"
print(name)
```

如果你愿意，也可以写分号，但一般没有必要：

```lua
local name = "Lua";
print(name);
```

## 注释

单行注释以 `--` 开始：

```lua
-- 这一行不会被执行
print("hello")
```

多行注释可以使用 `--[[ ... ]]`：

```lua
--[[
这里是多行注释。
你可以临时注释一段代码。
]]
print("hello")
```

如果多行字符串或注释中本身包含 `]]`，可以使用更长的分隔符，例如 `--[=[ ... ]=]`。初学阶段你先记住普通形式即可。

## 标识符

标识符用于给变量、函数、table 字段等命名。

常见写法：

```lua
local user_name = "Alice"
local score1 = 95
local _private_value = 10
```

需要注意：

- 标识符不能以数字开头。
- 标识符区分大小写，`name` 和 `Name` 是两个不同名字。
- 不建议使用以下划线加大写字母开头的名字，例如 `_VERSION`，这类名字通常留给 Lua 自身或底层库。

## 关键字

Lua 关键字不能作为变量名或函数名。常见关键字如下：

| 关键字 | 关键字 | 关键字 | 关键字 |
| :--- | :--- | :--- | :--- |
| `and` | `break` | `do` | `else` |
| `elseif` | `end` | `false` | `for` |
| `function` | `goto` | `if` | `in` |
| `local` | `nil` | `not` | `or` |
| `repeat` | `return` | `then` | `true` |
| `until` | `while` |  |  |

例如，下面这段代码是错误的：

```lua
local function = 10
```

因为 `function` 是关键字。

## 代码块和缩进

Lua 使用关键字表示代码块，例如 `if ... then ... end`、`while ... do ... end`、`function ... end`。

```lua showLineNumbers title="main.lua"
local score = 90

if score >= 60 then
   print("pass")
else
   print("fail")
end
```

Lua 不强制缩进，但你应该保持缩进一致。教程中的示例通常使用三个空格缩进。

## 变量默认是全局的

这是 Lua 初学者最需要先记住的规则之一：如果你没有写 `local`，赋值时会创建或修改全局变量。

```lua showLineNumbers title="main.lua"
name = "global"
local age = 18

print(name)
print(age)
```

一般建议你优先使用 `local`：

```lua
local name = "Lua"
```

这样能减少意外修改全局变量的风险，也通常更高效。

## 大小写敏感

Lua 区分大小写：

```lua showLineNumbers title="main.lua"
local name = "Lua"
local Name = "GetIoT"

print(name)
print(Name)
```

输出：

```text
Lua
GetIoT
```

## 小结

这一节你需要记住：

- Lua 文件或交互式输入都可以看作 chunk。
- 单行注释使用 `--`，多行注释使用 `--[[ ... ]]`。
- Lua 不要求语句末尾写分号。
- Lua 通过 `end` 结束代码块。
- 变量默认是全局的，初学时应优先使用 `local`。
