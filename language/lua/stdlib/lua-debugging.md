---
sidebar_position: 6
slug: /lua-debugging
---

# Lua 调试

调试不是“代码写错之后才做的事”，而是你理解程序运行过程的一部分。Lua 程序常见调试方法包括打印日志、阅读报错、使用 `pcall()` 捕获错误、查看 traceback，以及在需要时使用 `debug` 库。

## 从错误信息开始

先看一个错误示例：

```lua showLineNumbers title="main.lua"
local user = nil
print(user.name)
```

运行后会看到类似信息：

```text
main.lua:2: attempt to index a nil value (local 'user')
```

你应该先读三部分：

- `main.lua:2`：错误发生在第 2 行。
- `attempt to index a nil value`：你在访问一个 `nil` 的字段。
- `(local 'user')`：这个 `nil` 值来自局部变量 `user`。

很多问题不需要复杂工具，先认真读报错就能定位。

## 使用 print 调试

最简单的调试方式是打印关键变量：

```lua showLineNumbers title="main.lua"
local value = "42"

print("value:", value)
print("type:", type(value))

local number = tonumber(value)
print("number:", number)
```

输出：

```text
value:	42
type:	string
number:	42
```

`type()` 很适合排查参数类型错误。

## 使用 assert 检查条件

在函数入口处检查参数，可以更早发现问题：

```lua showLineNumbers title="main.lua"
local function read_sensor(sensor)
   assert(type(sensor) == "table", "sensor must be a table")
   assert(sensor.id, "sensor.id is required")

   print("read:", sensor.id)
end

read_sensor({id = "sensor-001"})
```

如果调用方传错参数，错误会更明确。

## 使用 traceback

`debug.traceback()` 可以生成调用栈：

```lua showLineNumbers title="main.lua"
local function c()
   print(debug.traceback("here"))
end

local function b()
   c()
end

local function a()
   b()
end

a()
```

输出会显示 `a -> b -> c` 的调用路径。具体行号取决于文件内容。

## 使用 pcall 包住风险代码

当你调用插件、用户脚本或不可靠代码时，可以用 `pcall()` 捕获错误：

```lua showLineNumbers title="main.lua"
local function plugin_run()
   error("plugin failed")
end

local ok, err = pcall(plugin_run)

if not ok then
   print("plugin error:", err)
end
```

输出：

```text
plugin error:	main.lua:2: plugin failed
```

## debug.getinfo

`debug.getinfo()` 可以查看函数或调用栈信息：

```lua showLineNumbers title="main.lua"
local function hello()
   local info = debug.getinfo(1, "nSl")

   print(info.what)
   print(info.currentline)
end

hello()
```

`debug` 库对框架、测试工具和调试器很有用，但普通业务代码不应过度依赖它。

:::warning

`debug` 库可以突破很多封装边界，也可能在沙箱环境中被禁用。生产环境中应谨慎开放给用户脚本。

:::

## 常见调试思路

遇到问题时，可以按这个顺序排查：

1. 先读错误信息中的文件名和行号。
2. 打印关键变量和 `type()`。
3. 检查变量是否意外为 `nil`。
4. 检查 table 字段名是否拼写正确。
5. 检查函数返回的是不是多返回值。
6. 用 `pcall()` 或 `xpcall()` 捕获错误并打印 traceback。

## 示例：定位 nil 字段

```lua showLineNumbers title="main.lua"
local function show_device(device)
   assert(type(device) == "table", "device must be a table")
   assert(device.id, "device.id is required")

   print("device:", device.id)
end

local ok, err = pcall(show_device, {name = "sensor"})

if not ok then
   print("failed:", err)
end
```

输出：

```text
failed:	main.lua:3: device.id is required
```

这个错误比“attempt to concatenate a nil value”更容易理解。

## 小结

你需要掌握：

- 先读错误行号和错误类型。
- `print()` 和 `type()` 是最实用的调试工具。
- `assert()` 可以让错误更早、更清楚地暴露。
- `debug.traceback()` 可以查看调用栈。
- `debug` 库很强，但要谨慎使用。
