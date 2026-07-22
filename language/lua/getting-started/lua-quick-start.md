---
sidebar_position: 3
slug: /lua-quick-start
---

# Lua 快速上手

这一节我们先不追求讲完所有语法，而是用几个小程序让你对 Lua 有一个手感。你会看到变量、字符串拼接、table、循环和函数怎样配合起来。

## 第一行 Lua 代码

创建文件 `hello.lua`：

```lua showLineNumbers title="hello.lua"
print("Hello, Lua!")
```

运行：

```bash
lua hello.lua
```

输出：

```text
Hello, Lua!
```

`print()` 是 Lua 的基础函数，用来把内容输出到终端。

## 变量和字符串

接下来写一个带变量的版本：

```lua showLineNumbers title="hello-name.lua"
local name = "GetIoT"
print("Hello, " .. name .. "!")
```

输出：

```text
Hello, GetIoT!
```

你先记住两个点：

- `local` 用来声明局部变量。
- `..` 用来拼接字符串。

Lua 不会用 `+` 拼接字符串。下面这种写法是错误的：

```lua
print("Hello, " + name)
```

## 使用 table 保存数据

Lua 最重要的数据结构是 table。你可以先把它理解成“数组和字典的结合体”。

```lua showLineNumbers title="scores.lua"
local scores = {
   Alice = 95,
   Bob = 82,
   Cindy = 100,
}

print(scores["Alice"])
print(scores.Bob)
```

输出：

```text
95
82
```

`scores["Alice"]` 和 `scores.Bob` 都是在访问 table 字段。点号写法更简洁，但字段名必须是合法标识符。

## 使用循环遍历 table

继续改造上面的例子：

```lua showLineNumbers title="show-scores.lua"
local scores = {
   Alice = 95,
   Bob = 82,
   Cindy = 100,
}

for name, score in pairs(scores) do
   print(name .. ": " .. score)
end
```

输出可能是：

```text
Alice: 95
Bob: 82
Cindy: 100
```

:::note

`pairs()` 遍历 table 时不保证顺序。你现在只需要知道它能遍历键值对，后面讲 table 和迭代器时我们会展开。

:::

## 定义函数

当一段逻辑需要重复使用时，你可以把它写成函数：

```lua showLineNumbers title="function-demo.lua"
local function format_score(name, score)
   return name .. ": " .. score
end

print(format_score("Alice", 95))
print(format_score("Bob", 82))
```

输出：

```text
Alice: 95
Bob: 82
```

Lua 函数可以返回值，也可以作为值保存到变量中。后面的函数章节会专门讲这一点。

## 一个完整小程序

最后写一个稍完整的成绩统计程序：

```lua showLineNumbers title="average-score.lua"
local scores = {
   Alice = 95,
   Bob = 82,
   Cindy = 100,
}

local total = 0
local count = 0

for _, score in pairs(scores) do
   total = total + score
   count = count + 1
end

local average = total / count
print("Average score:", average)
```

输出：

```text
Average score:	92.333333333333
```

这里的 `_` 是一个常见写法，表示“这个返回值我不关心”。`pairs(scores)` 每次返回两个值：名字和分数。我们只关心分数，所以把名字位置写成 `_`。

## 常见错误

### 忘记使用 `local`

初学时建议你尽量写：

```lua
local value = 10
```

不要随手写：

```lua
value = 10
```

第二种写法会创建或修改全局变量，容易带来难查的错误。

### 把 `0` 当成假

在 Lua 中，只有 `false` 和 `nil` 是假。数字 `0`、空字符串 `""` 和空 table `{}` 都是真：

```lua
if 0 then
   print("0 is true in Lua")
end
```

## 小结

你已经写过几个真正能运行的 Lua 程序。接下来我们会放慢速度，从基础语法开始，把每个概念拆开讲清楚。
