---
sidebar_position: 4
slug: /lua-decision
---

# Lua 条件语句

条件语句让程序根据不同情况执行不同代码。你可以把它理解成程序里的“分岔路口”：条件成立走一条路，不成立走另一条路。

## 真假值规则

在学习 `if` 之前，你必须先记住 Lua 的真假规则：

- `false` 是假。
- `nil` 是假。
- 其他所有值都是真，包括 `0`、空字符串 `""` 和空 table `{}`。

示例：

```lua showLineNumbers title="main.lua"
if 0 then
   print("0 is true")
end

if "" then
   print("empty string is true")
end

if nil then
   print("this will not print")
end
```

输出：

```text
0 is true
empty string is true
```

如果你有 C 语言经验，这一点尤其要注意：Lua 中的 `0` 不是假。

## if 语句

最简单的条件语句格式如下：

```lua
if condition then
   -- condition 为真时执行
end
```

示例：

```lua showLineNumbers title="main.lua"
local temperature = 32

if temperature > 30 then
   print("天气有点热")
end
```

输出：

```text
天气有点热
```

## if...else 语句

如果你希望条件不成立时也执行另一段代码，可以使用 `else`：

```lua showLineNumbers title="main.lua"
local score = 58

if score >= 60 then
   print("通过")
else
   print("需要继续练习")
end
```

输出：

```text
需要继续练习
```

## if...elseif...else 语句

多分支判断使用 `elseif`：

```lua showLineNumbers title="main.lua"
local score = 86

if score >= 90 then
   print("优秀")
elseif score >= 80 then
   print("良好")
elseif score >= 60 then
   print("及格")
else
   print("不及格")
end
```

输出：

```text
良好
```

Lua 使用 `elseif`，不是 `else if`。这是一个常见拼写错误。

## 使用逻辑运算符组合条件

你可以使用 `and`、`or`、`not` 组合条件：

```lua showLineNumbers title="main.lua"
local age = 20
local has_ticket = true

if age >= 18 and has_ticket then
   print("可以入场")
end
```

输出：

```text
可以入场
```

再看 `not`：

```lua showLineNumbers title="main.lua"
local connected = false

if not connected then
   print("请先连接设备")
end
```

输出：

```text
请先连接设备
```

## 嵌套 if

你可以在 `if` 里面再写 `if`：

```lua showLineNumbers title="main.lua"
local user = "admin"
local password_ok = true

if user == "admin" then
   if password_ok then
      print("登录成功")
   else
      print("密码错误")
   end
else
   print("未知用户")
end
```

输出：

```text
登录成功
```

嵌套层级太深时，代码会变难读。实际项目中可以考虑提前返回、拆分函数或使用 table 映射来简化。

## Lua 没有三目运算符

Lua 没有 C 语言里的 `condition ? a : b`。你可能会看到有人使用 `and` / `or` 模拟：

```lua
local label = score >= 60 and "pass" or "fail"
```

这在很多情况下可用，但如果中间值可能是 `false` 或 `nil`，就会出问题。初学阶段建议你先写清楚：

```lua
local label

if score >= 60 then
   label = "pass"
else
   label = "fail"
end
```

清楚比炫技更重要。

## 示例：检查传感器值

下面是一个更贴近 IoT 场景的小例子：

```lua showLineNumbers title="sensor-check.lua"
local temperature = 38.5
local humidity = 72

if temperature > 40 then
   print("温度过高")
elseif temperature < 0 then
   print("温度过低")
else
   print("温度正常")
end

if humidity > 80 then
   print("湿度偏高")
else
   print("湿度可接受")
end
```

输出：

```text
温度正常
湿度可接受
```

## 小结

这一节你需要掌握：

- `if condition then ... end` 是最基本的条件结构。
- 多分支使用 `elseif`。
- `false` 和 `nil` 是假，其他值都是真。
- Lua 没有三目运算符，初学时建议把条件判断写清楚。
