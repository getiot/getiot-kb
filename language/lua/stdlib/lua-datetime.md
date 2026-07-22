---
sidebar_position: 2
slug: /lua-datetime
---

# Lua 日期时间

Lua 的日期时间能力主要来自 `os` 库。你会经常用到 `os.time()`、`os.date()`、`os.difftime()` 和 `os.clock()`。

## 获取当前时间戳

`os.time()` 不带参数时返回当前时间戳：

```lua showLineNumbers title="main.lua"
print(os.time())
```

输出类似：

```text
1784770000
```

具体数值会随运行时间变化。

## 格式化当前日期

`os.date()` 可以把时间格式化为字符串：

```lua showLineNumbers title="main.lua"
print(os.date("%Y-%m-%d"))
print(os.date("%H:%M:%S"))
print(os.date("%Y-%m-%d %H:%M:%S"))
```

输出类似：

```text
2026-07-23
02:30:00
2026-07-23 02:30:00
```

常见格式：

| 格式 | 说明 |
| :--- | :--- |
| `%Y` | 四位年份 |
| `%m` | 月份，01-12 |
| `%d` | 日期，01-31 |
| `%H` | 小时，00-23 |
| `%M` | 分钟，00-59 |
| `%S` | 秒，00-60 |
| `%w` | 星期，0-6，星期日为 0 |

## 获取时间表

如果你把 `os.date()` 的第一个参数写成 `"*t"`，会得到一个 table：

```lua showLineNumbers title="main.lua"
local now = os.date("*t")

print(now.year)
print(now.month)
print(now.day)
print(now.hour)
print(now.min)
print(now.sec)
```

输出取决于当前时间。

## 构造指定时间

`os.time()` 也可以接收一个 table，构造指定时间的时间戳：

```lua showLineNumbers title="main.lua"
local timestamp = os.time({
   year = 2026,
   month = 7,
   day = 23,
   hour = 12,
   min = 0,
   sec = 0,
})

print(timestamp)
print(os.date("%Y-%m-%d %H:%M:%S", timestamp))
```

输出中的时间戳会受本地时区影响。

## 计算时间差

`os.difftime(t2, t1)` 返回两个时间戳之间相差的秒数：

```lua showLineNumbers title="main.lua"
local start_time = os.time({
   year = 2026,
   month = 7,
   day = 23,
   hour = 10,
})

local end_time = os.time({
   year = 2026,
   month = 7,
   day = 23,
   hour = 12,
})

print(os.difftime(end_time, start_time))
```

输出：

```text
7200.0
```

7200 秒就是 2 小时。

## UTC 时间

`os.date("!*t")` 可以获取 UTC 时间表：

```lua showLineNumbers title="main.lua"
local utc = os.date("!*t")
print(utc.year, utc.month, utc.day, utc.hour)
```

`!` 表示按 UTC 格式化，而不是本地时区。

## 测量 CPU 时间

`os.clock()` 返回程序消耗的 CPU 时间，常用于粗略测量代码运行开销：

```lua showLineNumbers title="main.lua"
local start_clock = os.clock()

local sum = 0
for i = 1, 1000000 do
   sum = sum + i
end

local elapsed = os.clock() - start_clock
print(sum)
print(string.format("elapsed: %.4f seconds", elapsed))
```

输出会因机器不同而不同。

:::note

`os.clock()` 测的是 CPU 时间，不一定等于真实墙钟时间。需要高精度计时或异步定时器时，通常要使用宿主环境或第三方库。

:::

## 小结

你需要掌握：

- `os.time()` 获取或构造时间戳。
- `os.date()` 格式化时间。
- `os.date("*t")` 返回本地时间 table。
- `os.date("!*t")` 返回 UTC 时间 table。
- `os.difftime()` 计算时间差。
- `os.clock()` 可用于粗略性能测量。
