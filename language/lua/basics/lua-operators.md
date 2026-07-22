---
sidebar_position: 3
slug: /lua-operators
---

# Lua 运算符

运算符用于把值组合成表达式。你已经见过 `+`、`..`、`==` 这类符号，这一节我们把常用运算符集中梳理一遍。

## 算术运算符

Lua 常见算术运算符如下：

| 运算符 | 说明 | 示例 |
| :--- | :--- | :--- |
| `+` | 加法 | `a + b` |
| `-` | 减法或取负 | `a - b`、`-a` |
| `*` | 乘法 | `a * b` |
| `/` | 浮点除法 | `a / b` |
| `//` | 向下取整除法 | `a // b` |
| `%` | 取模 | `a % b` |
| `^` | 乘方 | `a ^ b` |

示例：

```lua showLineNumbers title="main.lua"
local a = 10
local b = 3

print(a + b)
print(a - b)
print(a * b)
print(a / b)
print(a // b)
print(a % b)
print(a ^ b)
```

输出：

```text
13
7
30
3.3333333333333
3
1
1000.0
```

## 字符串拼接

Lua 使用 `..` 拼接字符串：

```lua showLineNumbers title="main.lua"
local name = "Lua"
print("Hello, " .. name)
```

输出：

```text
Hello, Lua
```

不要使用 `+` 拼接字符串：

```lua
-- 错误写法
print("Hello, " + "Lua")
```

## 长度运算符

`#` 用来获取字符串长度或序列长度：

```lua showLineNumbers title="main.lua"
local text = "Lua"
local values = {10, 20, 30}

print(#text)
print(#values)
```

输出：

```text
3
3
```

:::warning

`#` 作用在 table 上时，适合连续数组。如果数组中间有 `nil`，结果可能不符合你的直觉。

:::

## 关系运算符

关系运算符返回布尔值：

| 运算符 | 说明 |
| :--- | :--- |
| `==` | 等于 |
| `~=` | 不等于 |
| `<` | 小于 |
| `>` | 大于 |
| `<=` | 小于等于 |
| `>=` | 大于等于 |

示例：

```lua showLineNumbers title="main.lua"
print(10 == 10)
print(10 ~= 20)
print(3 < 5)
print("abc" < "bcd")
```

输出：

```text
true
true
true
true
```

字符串可以比较大小，通常按字典序比较。实际业务中如果涉及中文排序、locale 或大小写规则，建议使用专门库处理。

## 逻辑运算符

Lua 有三个逻辑运算符：

| 运算符 | 说明 |
| :--- | :--- |
| `and` | 与 |
| `or` | 或 |
| `not` | 非 |

示例：

```lua showLineNumbers title="main.lua"
local age = 20
local has_ticket = true

if age >= 18 and has_ticket then
   print("welcome")
end
```

输出：

```text
welcome
```

`and` 和 `or` 不一定返回布尔值，它们会返回参与运算的原始值：

```lua showLineNumbers title="main.lua"
print("Lua" and 123)
print(nil or "default")
print(false or 0)
```

输出：

```text
123
default
0
```

这个特性常用于设置默认值：

```lua
local name = input_name or "anonymous"
```

## 位运算符

Lua 5.3+ 支持位运算：

| 运算符 | 说明 |
| :--- | :--- |
| `&` | 按位与 |
| `|` | 按位或 |
| `~` | 按位异或或按位取反 |
| `<<` | 左移 |
| `>>` | 右移 |

示例：

```lua showLineNumbers title="main.lua"
print(0x0f & 0xf0)
print(0x0f | 0xf0)
print(1 << 4)
```

输出：

```text
0
255
16
```

位运算在嵌入式、协议解析、寄存器配置和二进制数据处理中很常见。

## 运算符优先级

常见优先级从高到低大致如下：

| 优先级 | 运算符 |
| :--- | :--- |
| 高 | `^` |
|  | 一元运算符：`not`、`#`、`-`、`~` |
|  | `*`、`/`、`//`、`%` |
|  | `+`、`-` |
|  | `..` |
|  | `<<`、`>>` |
|  | `&` |
|  | `~` |
|  | `|` |
|  | `<`、`>`、`<=`、`>=`、`~=`、`==` |
|  | `and` |
| 低 | `or` |

不确定时，直接加括号：

```lua
local result = (a + b) * c
```

括号能让代码更清楚，也能减少优先级错误。

## 小结

你需要重点掌握：

- 数值计算使用 `+ - * / // % ^`。
- 字符串拼接使用 `..`。
- 长度运算符是 `#`。
- 不等于写作 `~=`, 不是 `!=`。
- `and` 和 `or` 会返回原始值，可用于默认值表达式。
