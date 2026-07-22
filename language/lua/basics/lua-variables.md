---
sidebar_position: 1
slug: /lua-variables
---

# Lua 变量

变量是给值起的名字。你可以把数字、字符串、布尔值、函数和 table 保存到变量中，然后在后续代码里使用它。

Lua 是动态类型语言，变量本身没有固定类型，值才有类型。同一个变量可以先保存数字，后保存字符串。

## 声明局部变量

局部变量使用 `local` 声明：

```lua showLineNumbers title="main.lua"
local name = "Lua"
local year = 1993

print(name)
print(year)
```

输出：

```text
Lua
1993
```

如果声明变量时没有赋值，变量默认是 `nil`：

```lua showLineNumbers title="main.lua"
local value
print(value)
```

输出：

```text
nil
```

## 全局变量

如果你直接给一个名字赋值，而没有写 `local`，Lua 会把它当作全局变量：

```lua showLineNumbers title="main.lua"
site = "getiot.tech"
print(site)
```

这种写法短，但在稍大的程序中容易出错。例如你本来想创建局部变量，却因为拼写错误改到了全局环境。

```lua
local count = 10
coutn = count + 1  -- 拼错了，创建了一个新的全局变量
```

所以初学阶段请养成习惯：能写 `local` 就写 `local`。

## 作用域

局部变量只在声明它的代码块中可见。代码块可以是函数体、循环体、`if` 分支或显式的 `do ... end`。

```lua showLineNumbers title="main.lua"
local x = 10

do
   local x = 20
   print("inside:", x)
end

print("outside:", x)
```

输出：

```text
inside:	20
outside:	10
```

内部的 `x` 不会修改外部的 `x`。这种能力可以帮助你把变量影响范围控制得更小。

## 多变量赋值

Lua 支持一次给多个变量赋值：

```lua showLineNumbers title="main.lua"
local a, b = 10, 20
print(a, b)
```

输出：

```text
10	20
```

你还可以用它交换两个变量：

```lua showLineNumbers title="main.lua"
local a, b = 10, 20
a, b = b, a
print(a, b)
```

输出：

```text
20	10
```

如果值的数量少于变量数量，多出来的变量会得到 `nil`：

```lua showLineNumbers title="main.lua"
local a, b, c = 1, 2
print(a, b, c)
```

输出：

```text
1	2	nil
```

如果值的数量多于变量数量，多余的值会被忽略：

```lua showLineNumbers title="main.lua"
local a, b = 1, 2, 3
print(a, b)
```

输出：

```text
1	2
```

## nil 和删除变量

`nil` 表示“没有值”。对于全局变量，把它赋值为 `nil` 可以理解为删除这个名字：

```lua showLineNumbers title="main.lua"
message = "hello"
print(message)

message = nil
print(message)
```

输出：

```text
hello
nil
```

对于 table 字段，赋值为 `nil` 会删除这个字段。后面讲 table 时你会经常见到这个规则。

## 命名建议

建议你使用清晰的变量名：

```lua
local sensor_value = 23.5
local retry_count = 3
local device_id = "esp32-001"
```

避免使用太短且没有含义的名字，除非是在很短的循环里：

```lua
for i = 1, 10 do
   print(i)
end
```

## 小结

你需要掌握这些规则：

- 变量本身没有固定类型，值才有类型。
- 局部变量用 `local` 声明。
- 不写 `local` 时，赋值通常会落到全局变量。
- Lua 支持多变量赋值和变量交换。
- `nil` 表示没有值，也常用于删除 table 字段或全局变量。
