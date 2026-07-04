---
sidebar_position: 5
draft: true
---

# Lua 数据类型

Lua 是动态类型语言，变量本身没有类型，只有值才有类型。值可以存入变量、作为参数传递，也可以作为结果返回。

Lua 没有变量类型，但值有明确的类型。Lua 中值的类型如下表所示。

| 序号 | 值类型及说明 |
| :---: | :----------------------------------------------------------- |
| 1 | **nil** 表示空值，用于区分「有数据」和「无数据（nil）」 |
| 2 | **boolean** 布尔值，包括 `true` 和 `false`，常用于条件判断 |
| 3 | **number** 数字，Lua 5.3 起区分整数和浮点数，均属于 number 类型 |
| 4 | **string** 字符串，表示字符序列 |
| 5 | **function** 函数，可以是 Lua 函数，也可以是用 C 编写的函数 |
| 6 | **userdata** 用户数据，用于表示任意 C 数据 |
| 7 | **thread** 线程，表示独立的执行线程，用于实现协程 |
| 8 | **table** 表，可表示数组、字典、集合、记录、图、树等，实现关联数组；值可以是任意类型（包括 nil） |

## type 函数

Lua 提供了 **`type`** 函数，用于获取值的类型。注意：Lua 变量本身没有类型，但存入变量的值有类型。

下面的代码给出了一些示例：

```lua showLineNumbers title="main.lua"
-- 字符串类型
print(type("What is my type"))   --> string
t = 10

-- 数字类型
print(type(5.8*t))               --> number
-- 布尔类型
print(type(true))                --> boolean
-- 函数类型
print(type(print))               --> function
-- nil 类型
print(type(nil))                 --> nil
-- type 的返回值本身是字符串
print(type(type(nil)))           --> string
```

运行上述程序，输出如下：

```bash
string
number
boolean
function
nil
string
```

## 获取函数的类型

`type` 也可以用来获取函数的类型，如下所示：

```lua showLineNumbers title="main.lua"
-- 定义求两个数最大值的函数
function max(num1, num2)

   if (num1 > num2) then
      result = num1;
   else
      result = num2;
   end

   return result;
end

-- 获取函数本身的类型
print("The type of the function ", type(max))

-- 获取函数返回值的类型
print("The type of the function ", type(max(3,4)))

-- 获取函数的返回值
print("The Max Value: ", max(3,4))
```

运行上述程序，输出如下：

```bash
The type of the function 	function
The type of the function 	number
The Max Value: 	4
```

默认情况下，变量在赋值或初始化之前值为 `nil`。在条件判断中，只有 **`false`** 和 **`nil`** 被视为假（falsy），数字 `0` 和空字符串 `""` 都被视为真（truthy）。进行布尔运算时需要特别注意这一点。后续章节将进一步介绍各类型的用法。
