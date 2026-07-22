---
sidebar_position: 1
slug: /lua-math-library
---

# Lua 数学库

`math` 库提供常见数学函数。你可以用它做取整、随机数、三角函数、最大最小值、平方根等计算。

## 常用函数

| 函数 | 说明 |
| :--- | :--- |
| `math.abs(x)` | 绝对值 |
| `math.floor(x)` | 向下取整 |
| `math.ceil(x)` | 向上取整 |
| `math.max(...)` | 最大值 |
| `math.min(...)` | 最小值 |
| `math.sqrt(x)` | 平方根 |
| `math.sin(x)` | 正弦，参数为弧度 |
| `math.cos(x)` | 余弦，参数为弧度 |
| `math.rad(x)` | 角度转弧度 |
| `math.deg(x)` | 弧度转角度 |
| `math.random()` | 生成伪随机数 |
| `math.randomseed(x)` | 设置随机种子 |
| `math.type(x)` | Lua 5.3+ 中区分 integer / float |

## 取整和绝对值

```lua showLineNumbers title="main.lua"
print(math.abs(-10))
print(math.floor(3.8))
print(math.ceil(3.2))
print(math.max(10, 20, 5))
print(math.min(10, 20, 5))
```

输出：

```text
10
3
4
20
5
```

## 平方根和乘方

```lua showLineNumbers title="main.lua"
print(math.sqrt(16))
print(2 ^ 10)
```

输出：

```text
4.0
1024.0
```

Lua 使用 `^` 表示乘方。

## 三角函数

Lua 的三角函数使用弧度，不是角度。你可以用 `math.rad()` 把角度转为弧度：

```lua showLineNumbers title="main.lua"
local angle = 90
local radians = math.rad(angle)

print(math.sin(radians))
print(math.cos(radians))
```

输出可能类似：

```text
1.0
6.1232339957368e-17
```

`cos(90°)` 理论上是 `0`，但浮点计算可能得到一个非常接近 0 的小数，这是正常现象。

## 随机数

`math.random()` 的用法有三种：

```lua showLineNumbers title="main.lua"
math.randomseed(os.time())

print(math.random())        -- 0 到 1 之间的小数
print(math.random(10))      -- 1 到 10 的整数
print(math.random(5, 10))   -- 5 到 10 的整数
```

输出每次可能不同。

:::note

`math.random()` 生成的是伪随机数，不适合密码学安全场景。涉及 token、密钥、验证码等安全需求时，应使用操作系统或专门库提供的安全随机数。

:::

## integer 和 float

Lua 5.3+ 可以用 `math.type()` 判断数字内部表示：

```lua showLineNumbers title="main.lua"
print(math.type(10))
print(math.type(10.0))
print(math.type(3.14))
```

输出：

```text
integer
float
float
```

普通的 `type()` 仍然只会返回 `number`：

```lua
print(type(10)) -- number
```

## 示例：限制传感器值范围

有时你需要把一个数限制在某个范围内：

```lua showLineNumbers title="main.lua"
local function clamp(value, min_value, max_value)
   return math.max(min_value, math.min(value, max_value))
end

print(clamp(120, 0, 100))
print(clamp(-5, 0, 100))
print(clamp(60, 0, 100))
```

输出：

```text
100
0
60
```

这种函数在传感器值归一化、UI 滑块、占空比限制等场景中很常见。

## 小结

你需要掌握：

- `math.floor()` 和 `math.ceil()` 用于取整。
- 三角函数使用弧度。
- `math.random()` 是伪随机数。
- `math.type()` 可以区分 integer 和 float。
- 工程中常用 `math.min()` / `math.max()` 做范围限制。
