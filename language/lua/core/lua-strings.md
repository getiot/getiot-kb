---
sidebar_position: 0
slug: /lua-strings
---

# Lua 字符串

字符串用于保存文本。Lua 字符串是不可变值：你对字符串做拼接、替换、大小写转换时，得到的是一个新字符串，原来的字符串不会被修改。

## 创建字符串

Lua 支持三种常见字符串写法：

```lua showLineNumbers title="main.lua"
local a = "hello"
local b = 'Lua'
local c = [[
first line
second line
]]

print(a)
print(b)
print(c)
```

双引号和单引号都适合短字符串。长字符串 `[[ ... ]]` 适合保存多行文本，里面的普通引号不需要转义。

## 转义字符

常见转义字符如下：

| 转义序列 | 含义 |
| :--- | :--- |
| `\n` | 换行 |
| `\t` | 水平制表符 |
| `\\` | 反斜杠 |
| `\"` | 双引号 |
| `\'` | 单引号 |
| `\r` | 回车 |

示例：

```lua showLineNumbers title="main.lua"
print("Lua\nTutorial")
print("name\tvalue")
print("She said: \"Hello\"")
```

输出：

```text
Lua
Tutorial
name	value
She said: "Hello"
```

## 字符串拼接

Lua 使用 `..` 拼接字符串：

```lua showLineNumbers title="main.lua"
local name = "Lua"
local version = "5.4"

print(name .. " " .. version)
```

输出：

```text
Lua 5.4
```

如果拼接的是数字，Lua 通常会自动转换：

```lua
print("score: " .. 95)
```

但为了让代码更清楚，复杂场景建议使用 `tostring()` 或 `string.format()`。

## 字符串长度

可以使用 `#` 或 `string.len()` 获取字符串长度：

```lua showLineNumbers title="main.lua"
local text = "Lua"

print(#text)
print(string.len(text))
```

输出：

```text
3
3
```

:::warning

Lua 字符串函数默认按字节处理。对 UTF-8 中文字符串来说，一个汉字通常占多个字节，所以字节长度不等于字符数量。

:::

## 大小写转换

```lua showLineNumbers title="main.lua"
local text = "Lua"

print(string.upper(text))
print(string.lower(text))
```

输出：

```text
LUA
lua
```

## 截取字符串

`string.sub(s, i, j)` 用来截取字符串，位置从 `1` 开始：

```lua showLineNumbers title="main.lua"
local text = "Lua Tutorial"

print(string.sub(text, 1, 3))
print(string.sub(text, 5))
print(string.sub(text, -8))
```

输出：

```text
Lua
Tutorial
Tutorial
```

负数下标表示从末尾倒数。

## 查找字符串

`string.find()` 返回匹配内容的起始位置和结束位置：

```lua showLineNumbers title="main.lua"
local text = "Lua Tutorial"

local start_pos, end_pos = string.find(text, "Tutorial")
print(start_pos, end_pos)
```

输出：

```text
5	12
```

找不到时返回 `nil`：

```lua
print(string.find(text, "Python"))
```

默认情况下，`string.find()` 使用 Lua pattern，不是普通纯文本匹配。如果你想按纯文本查找，可以把第四个参数设为 `true`：

```lua
print(string.find("a.b", ".", 1, true))
```

## 替换字符串

`string.gsub()` 用于替换，返回两个值：替换后的字符串和替换次数。

```lua showLineNumbers title="main.lua"
local text = "Lua Lua Lua"
local result, count = string.gsub(text, "Lua", "Go", 2)

print(result)
print(count)
```

输出：

```text
Go Go Lua
2
```

第四个参数 `2` 表示最多替换两次。

## 格式化字符串

`string.format()` 的格式风格接近 C 语言 `printf`：

```lua showLineNumbers title="main.lua"
local name = "sensor"
local value = 23.4567

print(string.format("%s value: %.2f", name, value))
```

输出：

```text
sensor value: 23.46
```

常见格式：

| 格式 | 说明 |
| :--- | :--- |
| `%s` | 字符串 |
| `%d` | 整数 |
| `%f` | 浮点数 |
| `%.2f` | 保留两位小数 |
| `%02d` | 至少两位，不足补 0 |

## 字节和字符

`string.byte()` 获取字节值，`string.char()` 根据字节值生成字符：

```lua showLineNumbers title="main.lua"
print(string.byte("A"))
print(string.char(65))
```

输出：

```text
65
A
```

Lua 5.3+ 提供了基础 `utf8` 库，可以帮助你处理 UTF-8 字符串：

```lua showLineNumbers title="main.lua"
local text = "你好"

print(#text)
print(utf8.len(text))
```

输出通常是：

```text
6
2
```

第一个结果是字节数，第二个结果是 UTF-8 字符数量。

## 小结

你需要掌握：

- 字符串不可变。
- 字符串拼接使用 `..`。
- `#` 获取的是字节长度。
- `string.find()` 和 `string.gsub()` 默认使用 Lua pattern。
- 处理中文等 UTF-8 文本时，要区分字节数和字符数。
