---
sidebar_position: 5
slug: /lua-error-handing
---

# Lua 异常处理

程序运行时总会遇到错误：文件不存在、网络超时、参数类型不对、除数为 0、模块加载失败。Lua 的错误处理方式比较简单，核心工具是 `error()`、`assert()`、`pcall()` 和 `xpcall()`。

## 语法错误和运行时错误

语法错误发生在 Lua 解析代码时，例如少写 `end`：

```lua
if true then
   print("hello")
```

运行时错误发生在程序执行过程中，例如调用一个不存在的函数：

```lua showLineNumbers title="main.lua"
local value = nil
value()
```

运行会报类似错误：

```text
attempt to call a nil value
```

语法错误通常要靠修改代码解决；运行时错误则需要检查输入、状态和调用结果。

## 主动抛出错误

使用 `error()` 可以主动抛出错误：

```lua showLineNumbers title="main.lua"
local function divide(a, b)
   if b == 0 then
      error("division by zero")
   end

   return a / b
end

print(divide(10, 0))
```

程序会中断并输出错误信息。

## 使用 assert

`assert(value, message)` 会检查第一个参数。如果第一个参数是假值，也就是 `false` 或 `nil`，就抛出错误。

```lua showLineNumbers title="main.lua"
local file = assert(io.open("data.txt", "r"), "cannot open data.txt")
file:close()
```

`io.open()` 失败时返回 `nil, err`，所以 `assert()` 很适合快速处理“失败就中止”的场景。

你也可以用它检查参数：

```lua showLineNumbers title="main.lua"
local function set_timeout(seconds)
   assert(type(seconds) == "number", "seconds must be a number")
   assert(seconds >= 0, "seconds must be non-negative")

   print("timeout:", seconds)
end

set_timeout(10)
```

## 返回 nil 和错误信息

并不是所有错误都应该直接中断程序。很多库函数采用这种风格：

```lua
return nil, "error message"
```

示例：

```lua showLineNumbers title="main.lua"
local function divide(a, b)
   if b == 0 then
      return nil, "division by zero"
   end

   return a / b
end

local result, err = divide(10, 0)

if not result then
   print("failed:", err)
else
   print(result)
end
```

输出：

```text
failed:	division by zero
```

如果错误是可预期的，例如文件不存在、网络失败、参数不合法，这种写法通常更友好。

## 使用 pcall 捕获错误

`pcall()` 会以保护模式调用函数。函数内部如果抛出错误，程序不会直接崩掉，而是返回 `false` 和错误信息。

```lua showLineNumbers title="main.lua"
local function risky()
   error("something wrong")
end

local ok, err = pcall(risky)

if not ok then
   print("caught:", err)
end
```

输出类似：

```text
caught:	main.lua:2: something wrong
```

如果调用成功，`pcall()` 返回 `true`，后面跟着被调用函数的返回值：

```lua showLineNumbers title="main.lua"
local function add(a, b)
   return a + b
end

local ok, result = pcall(add, 3, 5)
print(ok, result)
```

输出：

```text
true	8
```

## 使用 xpcall 添加错误处理器

`xpcall()` 和 `pcall()` 类似，但可以指定错误处理函数。常见用途是生成 traceback：

```lua showLineNumbers title="main.lua"
local function risky()
   error("boom")
end

local function handler(err)
   return debug.traceback("error: " .. tostring(err), 2)
end

local ok, result = xpcall(risky, handler)

if not ok then
   print(result)
end
```

输出会包含调用栈，适合调试复杂错误。

## 什么时候用哪种方式

建议你这样选择：

- 参数明显错误，且继续执行没有意义：使用 `assert()` 或 `error()`。
- 错误是业务上可预期的：返回 `nil, err`。
- 调用第三方代码或插件，希望捕获崩溃：使用 `pcall()`。
- 需要完整调用栈：使用 `xpcall()` 配合 `debug.traceback()`。

## 小结

你需要掌握：

- `error()` 主动抛出错误。
- `assert()` 适合快速检查条件或打开文件。
- `nil, err` 是 Lua 中常见的可恢复错误返回方式。
- `pcall()` 可以捕获错误。
- `xpcall()` 可以配合错误处理器生成 traceback。

:::note

本文件名已经修正为 `lua-error-handling.md`，但 `slug` 暂时保留旧路径 `/lua-error-handing`，用于兼容已有链接。

:::
