---
sidebar_position: 1
slug: /lua-tables
---

# Lua 表（Table）

table 是 Lua 最重要的数据结构。你可以用它表示数组、字典、集合、对象、模块、配置项，甚至模拟类和命名空间。

如果你只记住一句话，那就是：Lua 的 table 是关联数组，key 可以是除 `nil` 和 NaN 之外的大多数值，value 可以是任意 Lua 值；当 value 被赋为 `nil` 时，这个 key 会被删除。

## 创建 table

使用 `{}` 创建空 table：

```lua showLineNumbers title="main.lua"
local user = {}

user.name = "Alice"
user.age = 18

print(user.name)
print(user["age"])
```

输出：

```text
Alice
18
```

`user.name` 是 `user["name"]` 的简写。字段名是合法标识符时，可以使用点号写法。

## table 构造器

你可以在创建 table 时直接写入内容：

```lua showLineNumbers title="main.lua"
local user = {
   name = "Alice",
   age = 18,
   online = true,
}

print(user.name)
print(user.age)
```

输出：

```text
Alice
18
```

也可以混合数组部分和键值部分：

```lua showLineNumbers title="main.lua"
local config = {
   "temperature",
   "humidity",
   interval = 5,
   enabled = true,
}

print(config[1])
print(config[2])
print(config.interval)
```

输出：

```text
temperature
humidity
5
```

## key 和 value

table 的 key 可以是数字、字符串、布尔值、table、函数等，但不能是 `nil`。

```lua showLineNumbers title="main.lua"
local t = {}

t[1] = "number key"
t["name"] = "string key"
t[true] = "boolean key"

print(t[1])
print(t["name"])
print(t[true])
```

输出：

```text
number key
string key
boolean key
```

实际项目中最常见的是数字 key 和字符串 key。

## 赋值 nil 会删除字段

```lua showLineNumbers title="main.lua"
local user = {
   name = "Alice",
   age = 18,
}

user.age = nil

print(user.name)
print(user.age)
```

输出：

```text
Alice
nil
```

这就是为什么 table 不能可靠保存“值就是 nil 的字段”。如果你需要区分“字段不存在”和“字段存在但值为空”，通常要使用一个特殊标记值。

## 引用语义

table 是引用类型。把一个 table 赋值给另一个变量，不会复制 table，而是让两个变量指向同一个 table：

```lua showLineNumbers title="main.lua"
local a = {name = "Lua"}
local b = a

b.name = "GetIoT"

print(a.name)
print(b.name)
```

输出：

```text
GetIoT
GetIoT
```

这在传参时也一样：

```lua showLineNumbers title="main.lua"
local function rename(user)
   user.name = "Bob"
end

local user = {name = "Alice"}
rename(user)

print(user.name)
```

输出：

```text
Bob
```

函数修改的是传入 table 本身。

## 遍历 table

使用 `pairs()` 遍历键值对：

```lua showLineNumbers title="main.lua"
local user = {
   name = "Alice",
   age = 18,
   online = true,
}

for key, value in pairs(user) do
   print(key, value)
end
```

输出顺序不固定，可能类似：

```text
name	Alice
age	18
online	true
```

`pairs()` 不保证顺序。如果你需要固定顺序，请单独维护 key 列表。

## 常用 table 函数

常见函数如下：

| 函数 | 说明 |
| :--- | :--- |
| `table.insert(list, value)` | 向数组末尾插入元素 |
| `table.insert(list, pos, value)` | 向指定位置插入元素 |
| `table.remove(list)` | 删除并返回最后一个元素 |
| `table.remove(list, pos)` | 删除并返回指定位置元素 |
| `table.concat(list, sep)` | 拼接数组中的字符串 |
| `table.sort(list, comp)` | 原地排序数组 |
| `table.unpack(list)` | 把数组展开为多个返回值 |

示例：

```lua showLineNumbers title="main.lua"
local fruits = {"banana", "orange"}

table.insert(fruits, "apple")
table.insert(fruits, 1, "mango")

for i, fruit in ipairs(fruits) do
   print(i, fruit)
end
```

输出：

```text
1	mango
2	banana
3	orange
4	apple
```

排序：

```lua showLineNumbers title="main.lua"
local values = {3, 1, 2}

table.sort(values)

print(table.concat(values, ", "))
```

输出：

```text
1, 2, 3
```

## 判断 table 是否为空

你可以使用 `next()`：

```lua showLineNumbers title="main.lua"
local t = {}

if next(t) == nil then
   print("empty")
end
```

输出：

```text
empty
```

## 浅拷贝

如果你需要复制一个 table 的第一层字段，可以这样写：

```lua showLineNumbers title="main.lua"
local function shallow_copy(source)
   local result = {}

   for key, value in pairs(source) do
      result[key] = value
   end

   return result
end

local a = {name = "Lua", year = 1993}
local b = shallow_copy(a)

b.name = "GetIoT"

print(a.name)
print(b.name)
```

输出：

```text
Lua
GetIoT
```

这只是浅拷贝。如果字段值本身还是 table，内部 table 仍然会共享引用。

## 小结

这一节你需要重点掌握：

- table 是 Lua 的核心数据结构。
- `t.name` 等价于 `t["name"]`。
- 给字段赋值 `nil` 会删除字段。
- table 是引用类型，赋值和传参不会自动复制。
- `pairs()` 遍历键值对但不保证顺序。
- `table.insert`、`table.remove`、`table.concat`、`table.sort` 很常用。
