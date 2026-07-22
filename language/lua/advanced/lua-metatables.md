---
sidebar_position: 0
slug: /lua-metatables
---

# Lua 元表（Metatable）

metatable 是 Lua 中最强也最容易让初学者迷糊的机制之一。你可以把它理解成“给 table 设置一组特殊规则”：当你访问不存在的字段、执行加法、调用 table、打印 table 时，Lua 可以根据 metatable 中的 metamethod 改变默认行为。

metatable 是理解 Lua 面向对象、运算符重载、代理 table、只读 table 的基础。

## 设置和获取 metatable

使用 `setmetatable()` 设置 metatable，使用 `getmetatable()` 获取：

```lua showLineNumbers title="main.lua"
local t = {}
local mt = {}

setmetatable(t, mt)

print(getmetatable(t) == mt)
```

输出：

```text
true
```

metatable 本身也是 table。

## __index：访问不存在字段

`__index` 是最常用的 metamethod。当你访问 table 中不存在的字段时，Lua 会去 `__index` 指定的地方继续查找。

```lua showLineNumbers title="main.lua"
local defaults = {
   timeout = 5,
   retry = 3,
}

local config = {
   timeout = 10,
}

setmetatable(config, {
   __index = defaults,
})

print(config.timeout)
print(config.retry)
```

输出：

```text
10
3
```

`config.timeout` 自己有值，所以返回 `10`。`config.retry` 不存在，于是 Lua 去 `defaults.retry` 查找。

## __index 也可以是函数

```lua showLineNumbers title="main.lua"
local t = {}

setmetatable(t, {
   __index = function(_, key)
      return "missing key: " .. key
   end,
})

print(t.name)
print(t.value)
```

输出：

```text
missing key: name
missing key: value
```

函数形式的 `__index` 适合做懒加载、默认值、访问日志等逻辑。

## __newindex：写入不存在字段

`__newindex` 会在你给不存在的字段赋值时触发：

```lua showLineNumbers title="main.lua"
local data = {}

setmetatable(data, {
   __newindex = function(_, key, value)
      print("set", key, value)
   end,
})

data.name = "Lua"
print(data.name)
```

输出：

```text
set	name	Lua
nil
```

注意，示例中的 `__newindex` 只打印，没有真正保存值，所以 `data.name` 仍然是 `nil`。

如果你要绕过 metamethod 直接写入，可以使用 `rawset()`：

```lua
rawset(data, key, value)
```

## 只读 table

结合 `__index` 和 `__newindex` 可以做一个简单只读 table：

```lua showLineNumbers title="main.lua"
local function readonly(source)
   return setmetatable({}, {
      __index = source,
      __newindex = function()
         error("attempt to modify readonly table")
      end,
   })
end

local config = readonly({
   host = "localhost",
   port = 8080,
})

print(config.host)
config.port = 9000
```

输出前会打印：

```text
localhost
```

随后程序会报错。

## 运算符重载

metatable 可以定义 table 的运算行为。例如让两个向量相加：

```lua showLineNumbers title="main.lua"
local Vector = {}

Vector.__index = Vector

function Vector.new(x, y)
   return setmetatable({x = x, y = y}, Vector)
end

function Vector.__add(a, b)
   return Vector.new(a.x + b.x, a.y + b.y)
end

function Vector.__tostring(v)
   return "(" .. v.x .. ", " .. v.y .. ")"
end

local a = Vector.new(1, 2)
local b = Vector.new(3, 4)
local c = a + b

print(c)
```

输出：

```text
(4, 6)
```

这里的 `__add` 定义了 `a + b` 的行为，`__tostring` 定义了 `print(c)` 时如何转换为字符串。

## 常见 metamethod

| metamethod | 触发场景 |
| :--- | :--- |
| `__index` | 访问不存在字段 |
| `__newindex` | 给不存在字段赋值 |
| `__add` | `+` |
| `__sub` | `-` |
| `__mul` | `*` |
| `__div` | `/` |
| `__eq` | `==` |
| `__lt` | `<` |
| `__le` | `<=` |
| `__len` | `#` |
| `__call` | 把 table 当函数调用 |
| `__tostring` | `tostring()` |

## __call：让 table 像函数一样调用

```lua showLineNumbers title="main.lua"
local counter = {
   value = 0,
}

setmetatable(counter, {
   __call = function(self)
      self.value = self.value + 1
      return self.value
   end,
})

print(counter())
print(counter())
```

输出：

```text
1
2
```

## rawget 和 rawset

`rawget()` 和 `rawset()` 可以绕过 metatable：

```lua showLineNumbers title="main.lua"
local t = {}

setmetatable(t, {
   __index = function()
      return "default"
   end,
})

print(t.name)
print(rawget(t, "name"))
```

输出：

```text
default
nil
```

调试 metatable 行为时，`rawget()` 很有用。

## 小结

你需要掌握：

- metatable 用于改变 table 的默认行为。
- `__index` 处理读取不存在字段。
- `__newindex` 处理写入不存在字段。
- metamethod 可以实现运算符重载、只读 table、对象方法查找等机制。
- `rawget()` 和 `rawset()` 可以绕过 metamethod。
