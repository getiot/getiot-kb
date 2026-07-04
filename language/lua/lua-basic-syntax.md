---
sidebar_position: 3
---

# Lua 基础语法



## 程序块

Lua 执行的每段代码都被称为一个程序块（chunk），一个程序块是一连串的语句或命令。一个程序块可以只包含一条语句，也可以由多条不同语句定义构成。也就是说，程序块可以是任意大小。例如：

```lua showLineNumbers
-- hello world lua program
function SayHello()
    print ("Hello, World!")
end

SayHello()
```

说明：

- Lua 中的每一个源代码文件或在交互模式（Cmd）中输入的一行代码都称之为程序块；
- 一个程序块就是一连串语句或者命令；
- Lua 中连续的语句不需要分隔符，但为了可读性可以加换行，或者分隔符分号 `;` 来分割语句；
- 换行在代码中没有任何作用，仅仅是为了提高可读性。

虽然 Lua 解释器很小，但 Lua 通常被作为一种数据描述语言来使用，几兆字节的程序块是很常见的，Lua 解释器对于大型程序块处理不会有任何问题。



## 词法规范

### 注释

- **单行注释**

  在 Lua 中，单行注释以两个减号（`--`）开始，后面的所有字符都会被视为注释。例如：

  ```lua showLineNumbers
  -- This is a single-line comment
  ```

- **多行注释**

  多行注释则以 `--[[` 开始，以 `--]]` 结束，可以跨多行。例如：

  ```lua showLineNumbers
  --[[
   multi-line comments 1
   multi-line comments 2
   multi-line comments 3
  --]]
  ```



### 标识符

Lua 标识符用于定义一个变量、函数或其他用户定义的项。命名规则如下：

- Lua 中的标识符可由任意字母、数字、下划线构成；
- Lua 标识符不能以数字开头，只能以字母或下划线开头；
- Lua 标识符对字母大小写敏感；
- 避免使用下划线开头后跟一个或多个大写字母的标识符，因为 Lua 将此类标识符保留用作特殊用途（例如 `_VERSION`）。

值得注意的是，Lua 中对于“什么是字母”的概念依赖于区域设置（Locale）。举例来说，如果你设置的区域是希腊，那就可以使用希腊字母作为变量名，但这样的变量名可能无法在其他区域的系统上运行。



### 关键字

目前，Lua 共有 22 个关键字。关键字是 Lua 解释器保留下来有特殊用途的标识符，用户不能使用这些保留关键字作为变量名和函数名等自定义项。下表列出了 Lua 的保留关键字。

<table align="center">
    <tr>
        <td>and</td>
        <td>break</td>
        <td>do</td>
        <td>else</td>
        <td>elseif</td>
        <td>end</td>
    </tr>
    <tr>
        <td>false</td>
        <td>for</td>
        <td>function</td>
        <td>goto</td>
        <td>if</td>
        <td>in</td>
    </tr>
    <tr>
        <td>local</td>
        <td>nil</td>
        <td>not</td>
        <td>or</td>
        <td>repeat</td>
        <td>return</td>
    </tr>
    <tr>
        <td>then</td>
        <td>true</td>
        <td>until</td>
        <td>while</td>
        <td> </td>
        <td> </td>
    </tr>
</table>



## 变量


### 全局变量

和其他语言不一样，在默认情况下，Lua 的变量总是认为是全局的。

全局变量（Global Variables）无需声明，仅需将一个值赋给一个全局变量即可创建。访问一个没有初始化的全局变量也不会出错，只不过得到的结果是 nil。

例如全局变量 x，赋值后才存在

```lua showLineNumbers
> x
nil
> x=233
> x
233
```

如果想删除 x 全局变量，只需要将其赋值为 nil（当且仅当一个变量不等于 nil 时，这个变量才存在）

```lua showLineNumbers
> x=nil
> x
nil
```

同时，Lua 是动态类型语言，如果想要更改变量类型，重新赋值即可

```lua showLineNumbers
> x="getiot.tech"
> x
getiot.tech
```

一般约定，以下划线开头连接一串大写字母的名字（比如 `_VERSION`）被保留用于 Lua 内部全局变量。

```lua showLineNumbers
> _VERSION
Lua 5.4
```



### 局部变量

在一个块（block）中的变量，如果之前没有定义过，那么 Lua 会认为它是一个全局变量，而不是这个块的局部变量。这样容易造成不小心覆盖了全局同名变量的错误，因此有时候需要使用局部变量（Local Variables）。

Lua 中的局部变量要用 local 关键字来显式定义，例如：

```lua showLineNumbers
g_var = 1         -- global var
local l_var = 2   -- local var
```

局部变量的生命周期是有限的，它的作用域仅限于声明它的块（block）。一个块是一个控制结构的执行体、或者是一个函数的执行体再或者是一个程序块（chunk）。通过下面例子可以帮助理解局部变量的作用域：

```lua showLineNumbers
x = 10
local i = 1         -- 程序块中的局部变量 i

while i <= x do
  local x = i * 2   -- while 循环体中的局部变量 x
  print(x)          -- output： 2, 4, 6, 8, ...
  i = i + 1
end

print(x)            -- 打印 10
```

使用局部变量有如下好处：

- 局部变量可以避免因为命名问题污染了全局环境；
- local 变量的访问比全局变量更快；
- 由于局部变量出了作用域之后生命周期结束，这样可以被垃圾回收器及时释放。

