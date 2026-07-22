---
sidebar_position: 5
slug: /lua-loops
---

# Lua 循环语句

循环用于重复执行一段代码。比如你要读取一组传感器数据、遍历一个数组、重试网络请求，都会用到循环。

Lua 常见循环结构有四种：

- `while`
- 数值 `for`
- 泛型 `for`
- `repeat...until`

## while 循环

`while` 会先判断条件，条件为真才执行循环体：

```lua
while condition do
   -- 循环体
end
```

示例：

```lua showLineNumbers title="main.lua"
local count = 1

while count <= 5 do
   print(count)
   count = count + 1
end
```

输出：

```text
1
2
3
4
5
```

如果一开始条件就不成立，循环体一次也不会执行。

## 数值 for 循环

如果你知道循环次数，数值 `for` 通常最清楚：

```lua
for var = start, stop, step do
   -- 循环体
end
```

`step` 可以省略，默认是 `1`。

```lua showLineNumbers title="main.lua"
for i = 1, 5 do
   print(i)
end
```

输出：

```text
1
2
3
4
5
```

倒序循环可以使用负步长：

```lua showLineNumbers title="main.lua"
for i = 5, 1, -1 do
   print(i)
end
```

输出：

```text
5
4
3
2
1
```

数值 `for` 的循环变量是局部变量，只在循环体中有效。

## 遍历数组

Lua 数组通常从下标 `1` 开始。你可以用数值 `for` 遍历：

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

也可以使用 `ipairs()`：

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

`ipairs()` 适合遍历连续数组，会从下标 `1` 开始，遇到第一个 `nil` 停止。

## 泛型 for 循环

泛型 `for` 用来遍历迭代器。最常见的是 `pairs()` 和 `ipairs()`。

`pairs()` 适合遍历 table 的所有键值对：

```lua showLineNumbers title="main.lua"
local device = {
   id = "sensor-001",
   type = "temperature",
   online = true,
}

for key, value in pairs(device) do
   print(key, value)
end
```

输出顺序不固定，可能类似：

```text
id	sensor-001
type	temperature
online	true
```

:::note

`pairs()` 不保证遍历顺序。如果你需要稳定顺序，应使用数组保存顺序，或把 key 收集后排序。

:::

## repeat...until 循环

`repeat...until` 会先执行循环体，再判断条件。因此它至少执行一次。

```lua
repeat
   -- 循环体
until condition
```

注意语义：`until condition` 表示“直到条件为真时结束”。

```lua showLineNumbers title="main.lua"
local count = 1

repeat
   print(count)
   count = count + 1
until count > 5
```

输出：

```text
1
2
3
4
5
```

## break

`break` 用于提前结束当前循环：

```lua showLineNumbers title="main.lua"
for i = 1, 10 do
   if i > 3 then
      break
   end

   print(i)
end
```

输出：

```text
1
2
3
```

`break` 只跳出当前这一层循环。如果你有多层嵌套循环，它不会一次跳出所有循环。

## 避免无限循环

无限循环不是错误，但你要非常明确自己为什么这么写：

```lua
while true do
   -- 持续执行
end
```

在嵌入式或服务程序中，无限循环很常见。但初学时如果程序卡住，多半是循环条件没有正确更新：

```lua
local i = 1

while i <= 5 do
   print(i)
   -- 忘记 i = i + 1，会导致无限循环
end
```

## 示例：简单重试

下面这个例子模拟网络请求重试：

```lua showLineNumbers title="retry.lua"
local success = false

for attempt = 1, 3 do
   print("try:", attempt)

   if attempt == 2 then
      success = true
      break
   end
end

if success then
   print("request ok")
else
   print("request failed")
end
```

输出：

```text
try:	1
try:	2
request ok
```

## 小结

这一节你需要掌握：

- `while` 适合条件循环。
- 数值 `for` 适合固定次数循环。
- `ipairs()` 适合遍历连续数组。
- `pairs()` 适合遍历 table 键值对，但顺序不固定。
- `repeat...until` 至少执行一次。
- `break` 可以提前结束循环。
