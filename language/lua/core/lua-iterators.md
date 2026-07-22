---
sidebar_position: 4
slug: /lua-iterators
---

# Lua 迭代器

迭代器用于“一个一个取出数据”。你在 `for ... in ... do` 中使用的 `pairs()`、`ipairs()`，本质上都和迭代器有关。

初学时，你不需要马上写复杂迭代器，但需要理解它能解决什么问题。

## 泛型 for 的形式

泛型 `for` 的基本形式是：

```lua
for var1, var2 in iterator do
   -- 循环体
end
```

最常见例子是 `ipairs()`：

```lua showLineNumbers title="main.lua"
local values = {"a", "b", "c"}

for index, value in ipairs(values) do
   print(index, value)
end
```

输出：

```text
1	a
2	b
3	c
```

## ipairs 和 pairs

`ipairs()` 适合遍历连续数组：

```lua showLineNumbers title="main.lua"
local values = {10, 20, 30}

for index, value in ipairs(values) do
   print(index, value)
end
```

`pairs()` 适合遍历 table 键值对：

```lua showLineNumbers title="main.lua"
local device = {
   id = "sensor-001",
   online = true,
   value = 23.5,
}

for key, value in pairs(device) do
   print(key, value)
end
```

`pairs()` 的遍历顺序不固定。不要把它的输出顺序用于业务逻辑。

## 自定义简单迭代器

最简单的迭代器是一个函数。每次调用它时，返回下一个值；没有值时返回 `nil`。

```lua showLineNumbers title="counter.lua"
local function counter(max)
   local current = 0

   return function()
      current = current + 1

      if current <= max then
         return current
      end
   end
end

for value in counter(3) do
   print(value)
end
```

输出：

```text
1
2
3
```

这里返回的匿名函数捕获了 `current` 和 `max`，这就是闭包。

## 迭代多个返回值

迭代器每次可以返回多个值：

```lua showLineNumbers title="main.lua"
local function range_with_square(max)
   local current = 0

   return function()
      current = current + 1

      if current <= max then
         return current, current * current
      end
   end
end

for value, square in range_with_square(4) do
   print(value, square)
end
```

输出：

```text
1	1
2	4
3	9
4	16
```

这和 `pairs()` 返回 key、value 的思路类似。

## 遍历文件行

Lua 标准库已经提供了很多迭代器。例如 `io.lines()` 可以逐行读取文件：

```lua showLineNumbers title="read-lines.lua"
for line in io.lines("data.txt") do
   print(line)
end
```

当文件很大时，逐行读取比一次性读入整个文件更节省内存。

:::warning

上面的代码假设当前目录存在 `data.txt`。如果文件不存在，程序会报错。文件 I/O 章节会讲更稳妥的打开方式。

:::

## 什么时候需要自定义迭代器

你可能在这些场景中写自己的迭代器：

- 分批读取传感器数据。
- 遍历自定义数据结构。
- 从网络流、日志文件或数据库游标中逐个取出记录。
- 隐藏复杂遍历逻辑，让调用方只写 `for ... in ... do`。

如果只是遍历普通数组或 table，优先使用 `ipairs()` 和 `pairs()`。

## 小结

这一节你需要掌握：

- 泛型 `for` 可以配合迭代器使用。
- `ipairs()` 遍历连续数组。
- `pairs()` 遍历 table 键值对，但顺序不固定。
- 简单迭代器可以用闭包实现。
- 迭代器适合把“取下一个值”的逻辑封装起来。
