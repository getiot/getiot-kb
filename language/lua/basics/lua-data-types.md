---
sidebar_position: 2
slug: /lua-data-types
---

# Lua 数据类型

Lua 中变量没有固定类型，值才有类型。你可以把一个变量先赋值为数字，再赋值为字符串，这在 Lua 中是合法的。

```lua showLineNumbers title="main.lua"
local value = 42
print(type(value))

value = "Lua"
print(type(value))
```

输出：

```text
number
string
```

## 基本类型

Lua 常见类型如下：

| 类型 | 说明 |
| :--- | :--- |
| `nil` | 空值，表示没有有效值 |
| `boolean` | 布尔值，只有 `true` 和 `false` |
| `number` | 数字，Lua 5.3 起内部区分整数和浮点数 |
| `string` | 字符串，表示不可变字符序列 |
| `function` | 函数，可以由 Lua 或 C 实现 |
| `table` | 表，Lua 唯一的通用数据结构 |
| `thread` | 协程对象，不是操作系统线程 |
| `userdata` | 用户数据，通常用于保存 C 侧对象 |

初学阶段你最常用的是 `nil`、`boolean`、`number`、`string`、`function` 和 `table`。

## type 函数

`type()` 可以查看一个值的类型：

```lua showLineNumbers title="main.lua"
print(type(nil))
print(type(true))
print(type(123))
print(type("hello"))
print(type(print))
print(type({}))
```

输出：

```text
nil
boolean
number
string
function
table
```

注意，`type()` 的返回值本身是字符串：

```lua showLineNumbers title="main.lua"
print(type(type(123)))
```

输出：

```text
string
```

## nil

`nil` 表示没有值。访问不存在的变量或 table 字段时，通常会得到 `nil`。

```lua showLineNumbers title="main.lua"
local user = {
   name = "Alice"
}

print(user.name)
print(user.age)
```

输出：

```text
Alice
nil
```

在 table 中，把字段赋值为 `nil` 会删除这个字段：

```lua
user.name = nil
```

## boolean

布尔类型只有两个值：`true` 和 `false`。

```lua showLineNumbers title="main.lua"
local enabled = true

if enabled then
   print("enabled")
end
```

Lua 的真假规则非常重要：只有 `false` 和 `nil` 是假，其他值都是真。

```lua showLineNumbers title="main.lua"
if 0 then
   print("0 is true")
end

if "" then
   print("empty string is true")
end
```

输出：

```text
0 is true
empty string is true
```

## number

Lua 使用 `number` 表示数字。Lua 5.3 以后，`number` 内部可以分成 integer 和 float。

```lua showLineNumbers title="main.lua"
print(type(10))
print(type(3.14))
print(math.type(10))
print(math.type(3.14))
```

输出：

```text
number
number
integer
float
```

`math.type()` 是 Lua 5.3+ 提供的函数，用于区分 integer 和 float。

## string

字符串可以使用单引号、双引号或长字符串：

```lua showLineNumbers title="main.lua"
local a = "hello"
local b = 'Lua'
local c = [[multi
line]]

print(a)
print(b)
print(c)
```

字符串是不可变的。拼接、替换和大小写转换都会产生新的字符串。

## table

table 是 Lua 的核心数据结构。它可以用来表示数组：

```lua
local colors = {"red", "green", "blue"}
print(colors[1])
```

也可以表示键值表：

```lua
local user = {
   name = "Alice",
   age = 18,
}

print(user.name)
```

后面我们会用单独章节详细讲 table。

## function

函数也是值。你可以把函数赋值给变量：

```lua showLineNumbers title="main.lua"
local say = function(message)
   print(message)
end

say("hello")
```

也可以用更常见的写法：

```lua
local function say(message)
   print(message)
end
```

## 小结

这一节你需要记住：

- Lua 变量没有固定类型，值才有类型。
- `type()` 可以查看值的类型。
- 只有 `false` 和 `nil` 是假。
- table 是 Lua 最重要的数据结构。
- 函数也是值，可以赋值和传递。
