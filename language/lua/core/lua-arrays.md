---
sidebar_position: 2
slug: /lua-arrays
---

# Lua 数组

Lua 没有单独的数组类型，数组通常用 table 表示。只要你用连续整数作为 key，就可以把 table 当成数组使用。

Lua 习惯从下标 `1` 开始：

```lua showLineNumbers title="main.lua"
local colors = {"red", "green", "blue"}

print(colors[1])
print(colors[2])
print(colors[3])
```

输出：

```text
red
green
blue
```

## 创建数组

最常见写法是：

```lua showLineNumbers title="main.lua"
local values = {10, 20, 30}

print(values[1])
print(values[2])
print(values[3])
```

数组元素也可以逐个赋值：

```lua showLineNumbers title="main.lua"
local values = {}

values[1] = 10
values[2] = 20
values[3] = 30

print(values[1], values[2], values[3])
```

## 获取数组长度

对连续数组，可以使用 `#`：

```lua showLineNumbers title="main.lua"
local values = {10, 20, 30}
print(#values)
```

输出：

```text
3
```

## 遍历数组

使用数值 `for`：

```lua showLineNumbers title="main.lua"
local values = {10, 20, 30}

for i = 1, #values do
   print(i, values[i])
end
```

输出：

```text
1	10
2	20
3	30
```

使用 `ipairs()`：

```lua showLineNumbers title="main.lua"
local values = {10, 20, 30}

for index, value in ipairs(values) do
   print(index, value)
end
```

输出同样是：

```text
1	10
2	20
3	30
```

## 添加和删除元素

可以使用 `table.insert()` 和 `table.remove()`：

```lua showLineNumbers title="main.lua"
local values = {10, 20}

table.insert(values, 30)
table.insert(values, 1, 5)

print(table.concat(values, ", "))

local removed = table.remove(values)
print("removed:", removed)
print(table.concat(values, ", "))
```

输出：

```text
5, 10, 20, 30
removed:	30
5, 10, 20
```

## nil 会造成空洞

如果数组中间出现 `nil`，它就不再是一个简单的连续数组：

```lua showLineNumbers title="main.lua"
local values = {10, 20, 30}

values[2] = nil

print(#values)

for index, value in ipairs(values) do
   print(index, value)
end
```

输出可能让你意外：

```text
3
1	10
```

`ipairs()` 会在第一个 `nil` 处停止。`#values` 对有空洞数组的结果也不适合作为稳定逻辑依赖。

:::warning

如果你希望把 table 当数组使用，尽量保持从 `1` 开始、没有空洞的连续整数下标。

:::

## 使用 0 或负数下标

Lua 允许你使用 `0`、负数或其他数字作为 table key：

```lua showLineNumbers title="main.lua"
local values = {}

values[0] = "zero"
values[-1] = "minus one"
values[1] = "one"

print(values[0])
print(values[-1])
print(values[1])
```

输出：

```text
zero
minus one
one
```

但这只是 table 的普通 key，不是 Lua 推荐的数组习惯。普通数组还是建议从 `1` 开始。

## 小结

你需要掌握：

- Lua 数组由 table 表示。
- 普通数组建议从 `1` 开始。
- `#` 和 `ipairs()` 适合连续数组。
- 数组中间出现 `nil` 会造成空洞，应谨慎处理。
- `table.insert()` 和 `table.remove()` 可用于添加和删除元素。
