---
sidebar_position: 6
slug: /lua-functions
---

# Lua 函数

函数是一段可以重复调用的代码。你可以用函数把复杂任务拆小，让程序更清楚，也更容易测试。

Lua 中函数是一等值。也就是说，函数可以赋值给变量、保存到 table、作为参数传递，也可以作为另一个函数的返回值。

## 定义函数

最常见的写法是：

```lua
local function function_name(arg1, arg2)
   -- 函数体
   return result
end
```

示例：

```lua showLineNumbers title="main.lua"
local function add(a, b)
   return a + b
end

print(add(3, 5))
```

输出：

```text
8
```

建议你优先使用 `local function`，这样不会创建不必要的全局函数。

## 参数

函数参数在函数体内表现为局部变量：

```lua showLineNumbers title="main.lua"
local function greet(name)
   print("Hello, " .. name)
end

greet("Lua")
```

输出：

```text
Hello, Lua
```

如果实参数量少于形参数量，缺少的参数会是 `nil`：

```lua showLineNumbers title="main.lua"
local function show(a, b)
   print(a, b)
end

show(1)
```

输出：

```text
1	nil
```

如果实参数量多于形参数量，多余的参数通常会被忽略：

```lua showLineNumbers title="main.lua"
local function show(a, b)
   print(a, b)
end

show(1, 2, 3)
```

输出：

```text
1	2
```

## 返回值

函数使用 `return` 返回结果：

```lua showLineNumbers title="main.lua"
local function max(a, b)
   if a > b then
      return a
   end

   return b
end

print(max(10, 4))
```

输出：

```text
10
```

如果函数没有显式返回值，调用结果是 `nil`。

## 多返回值

Lua 函数可以返回多个值。这在 Lua 中非常常见：

```lua showLineNumbers title="main.lua"
local function divide(a, b)
   if b == 0 then
      return nil, "division by zero"
   end

   return a / b, nil
end

local result, err = divide(10, 2)
print(result, err)

result, err = divide(10, 0)
print(result, err)
```

输出：

```text
5.0	nil
nil	division by zero
```

这种“第一个值返回结果，第二个值返回错误信息”的模式，在 Lua 库中很常见。

## 函数作为值

函数可以赋值给变量：

```lua showLineNumbers title="main.lua"
local say = function(message)
   print(message)
end

say("hello")
```

输出：

```text
hello
```

也可以作为参数传递：

```lua showLineNumbers title="main.lua"
local function apply(value, fn)
   return fn(value)
end

local function square(x)
   return x * x
end

print(apply(5, square))
```

输出：

```text
25
```

这就是回调函数的基本形式。

## 匿名函数

匿名函数没有名字，通常直接传给另一个函数：

```lua showLineNumbers title="main.lua"
local values = {3, 1, 2}

table.sort(values, function(a, b)
   return a < b
end)

for _, value in ipairs(values) do
   print(value)
end
```

输出：

```text
1
2
3
```

`table.sort()` 的第二个参数就是一个匿名函数，用来告诉 Lua 如何比较两个元素。

## 可变参数

使用 `...` 可以接收任意数量的参数：

```lua showLineNumbers title="main.lua"
local function sum(...)
   local total = 0

   for _, value in ipairs({...}) do
      total = total + value
   end

   return total
end

print(sum(1, 2, 3, 4))
```

输出：

```text
10
```

如果可变参数中可能包含 `nil`，不要简单依赖 `{...}` 和 `#` 计算个数。可以使用 `select("#", ...)`：

```lua showLineNumbers title="main.lua"
local function count_args(...)
   return select("#", ...)
end

print(count_args(1, nil, 3))
```

输出：

```text
3
```

## 闭包

函数可以捕获外层局部变量，这叫闭包：

```lua showLineNumbers title="main.lua"
local function new_counter()
   local count = 0

   return function()
      count = count + 1
      return count
   end
end

local counter = new_counter()

print(counter())
print(counter())
print(counter())
```

输出：

```text
1
2
3
```

`count` 是 `new_counter()` 内部的局部变量，但返回的匿名函数仍然可以访问它。

## 冒号调用和点号调用

当函数保存在 table 中时，你会看到两种调用方式：

```lua showLineNumbers title="main.lua"
local device = {
   id = "sensor-001"
}

function device.show(self)
   print(self.id)
end

device.show(device)
device:show()
```

输出：

```text
sensor-001
sensor-001
```

`device:show()` 等价于 `device.show(device)`。冒号会自动把调用者作为第一个参数传进去，这在面向对象写法中很常见。

## 小结

这一节你需要掌握：

- 优先使用 `local function` 定义函数。
- Lua 函数可以返回多个值。
- 函数是一等值，可以赋值、传参和返回。
- `...` 表示可变参数。
- 闭包可以捕获外层局部变量。
- `obj:method()` 会把 `obj` 作为第一个参数传入。
