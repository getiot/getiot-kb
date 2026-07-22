---
sidebar_position: 3
slug: /lua-garbage-collection
---

# Lua 垃圾回收

Lua 会自动管理内存。你创建 table、函数、字符串等对象后，通常不需要手动释放；当它们不再被引用时，garbage collector 会在合适的时候回收内存。

你不需要一开始就调优 garbage collection，但应该理解“对象什么时候可能被回收”和“怎样避免不必要的内存增长”。

## 什么对象会被回收

Lua 中 table、function、thread、userdata、字符串等对象由垃圾回收器管理。

示例：

```lua
local t = {1, 2, 3}
t = nil
```

当没有任何地方再引用原来的 table 时，它就变成可回收对象。注意，“可回收”不代表马上回收，具体时间由垃圾回收器决定。

## 引用会阻止回收

```lua showLineNumbers title="main.lua"
local a = {name = "Lua"}
local b = a

a = nil

print(b.name)
```

输出：

```text
Lua
```

虽然 `a` 被设为 `nil`，但 `b` 仍然引用同一个 table，所以这个 table 不会被回收。

## collectgarbage

Lua 提供 `collectgarbage()` 控制和查看垃圾回收器。

查看当前 Lua 使用的内存，单位是 KB：

```lua showLineNumbers title="main.lua"
print(collectgarbage("count"))
```

手动触发一次完整回收：

```lua showLineNumbers title="main.lua"
local data = {}

for i = 1, 100000 do
   data[i] = {value = i}
end

print("before:", collectgarbage("count"))

data = nil
collectgarbage("collect")

print("after:", collectgarbage("count"))
```

输出数值会因平台和 Lua 版本不同而不同。

:::note

你不应该在普通代码里频繁手动 `collectgarbage("collect")`。这可能带来明显暂停。通常让 Lua 自动管理即可。

:::

## 常用 collectgarbage 参数

| 参数 | 说明 |
| :--- | :--- |
| `"count"` | 返回当前内存使用量，单位 KB |
| `"collect"` | 执行一次完整垃圾回收 |
| `"stop"` | 停止自动垃圾回收 |
| `"restart"` | 重新启动自动垃圾回收 |
| `"step"` | 执行一步垃圾回收 |
| `"isrunning"` | 判断垃圾回收器是否运行 |
| `"incremental"` | 切换到 incremental 模式 |
| `"generational"` | 切换到 generational 模式 |

不同 Lua 版本支持的参数可能略有差异。写跨版本代码时应查对应版本手册。

## 弱表

普通 table 会强引用 key 和 value。弱表可以让 key 或 value 不阻止对象被回收。

下面是弱 value table：

```lua showLineNumbers title="main.lua"
local cache = setmetatable({}, {
   __mode = "v",
})

local obj = {name = "data"}
cache.item = obj

print(cache.item.name)

obj = nil
collectgarbage("collect")

print(cache.item)
```

第二次输出可能是：

```text
nil
```

弱表常用于缓存：如果外部已经不再使用对象，缓存不应该强行留住它。

## 常见内存问题

### 全局变量意外持有对象

```lua
data = {}
```

如果你忘记写 `local`，`data` 会变成全局变量，可能长期存在，导致对象不能被回收。

### table 缓存没有清理

```lua
local cache = {}
```

如果缓存一直增长，而你从不删除旧数据，内存自然会越来越高。缓存需要淘汰策略，或使用弱表。

### 闭包持有外部变量

闭包会捕获外层局部变量。如果闭包长期存在，它捕获的对象也会继续存在。

```lua
local function make_reader(data)
   return function(index)
      return data[index]
   end
end
```

只要返回的函数还活着，`data` 就不会被回收。

## 小结

你需要掌握：

- Lua 自动管理内存。
- 对象不再被任何地方引用后，才可能被回收。
- `collectgarbage("count")` 可以查看内存使用。
- 不要频繁手动完整回收。
- 弱表适合做缓存。
- 意外全局变量和长期缓存是常见内存问题。
