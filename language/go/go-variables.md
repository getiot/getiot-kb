---
sidebar_position: 7
slug: /go-variables
---

# Go 语言变量

在 Go 语言中，变量（Variable）是用于存储数据值的一个名称或者标识符。变量可以存储各种类型的数据，比如整数、浮点数、字符串、布尔值等。变量是计算机编程语言中对数据存储的抽象概念，你可以通过变量名访问和操作该变量对应的数据值。



## 变量声明

在 Go 语言中，声明变量可以使用关键字 `var`，语法如下：

```go
var identifier type
```

Go 语言规定变量名只能由字母、数字、下划线组成，且首个字母不能为数字。

### 变量声明示例

第一种形式：指定变量类型，声明后若不赋值，使用默认值。

```go
var v_name v_type
v_name = value
```

第二种形式：根据值自行判定变量类型。

```go
var v_name = value
```

第三种形式：省略 `var`，注意 `:=` 左侧的变量不应该是已经声明过的，否则会导致编译错误。

```go
v_name := value
```

例如下面三种声明整型变量的方式是等效的：

```go
var a int = 10
var b = 10
c := 10
```

尝试运行下面示例代码（可在 [GitHub](https://github.com/getiot/go-courses) 获取）：

```go showLineNumbers title="var_create.go"
package main
var a = "人人都懂物联网"
var b string = "getiot.tech"
var c bool = true
var d int = 10

func main() {
    println(a, b, c, d)
}
```

输出结果为：

```bash
人人都懂物联网 getiot.tech true 10
```

### 多变量声明示例

为了使代码更简洁，我们在编写程序时常常会将多个同类型的变量放在一起声明。语法格式如下：

```go
var vname1, vname2, vname3 type
vname1, vname2, vname3 = v1, v2, v3
```

类似于 Python，你不需要显式声明类型，Go 编译器会自动推断：

```go
var vname1, vname2, vname3 = v1, v2, v3
```

也可以采用短变量声明，不过这种方式仅适用于函数或方法内部：

```go
vname1, vname2, vname3 := v1, v2, v3
```

:::warning

多个变量一起声明时，左侧至少有一个未声明过的变量，否则编译错误。另外，已声明过的变量会退化为赋值。

:::

如果类型不同多个变量，或者全局变量，可以使用下面方式声明（局部变量不能使用这种方式）：

```go
var (
    vname1 v_type1
    vname2 v_type2
)
```

请看下面示例代码：

```go showLineNumbers title="var_create_multi.go"
package main

var x, y int
var (
    a int
    b bool
)

var c, d int = 1, 2
var e, f = 123, "hello"

//这种不带声明格式的只能在函数体中出现
//g, h := 123, "hello"

func main() {
    g, h := 123, "hello"
    println(x, y, a, b, c, d, e, f, g, h)
}
```

输出结果为：

```bash
0 0 0 false 1 2 123 hello 123 hello
```



## 简短形式（`:=` 赋值操作符）

前面我们讲了，在 Go 语言中可以在变量初始化时省略变量的类型而由系统自动推断。那么，声明语句写上 `var` 关键字其实是显得有些多余了，因此我们可以将它们简写为 `a := 50` 或 `b := false`。此时，`a` 和 `b` 的类型（`int` 和 `bool`）将由编译器自动推断。

这是使用变量的首选形式，但是它只能被用在函数体内，而不可以用于全局变量的声明与赋值。使用操作符 `:=` 可以高效地创建一个新的变量，称之为初始化声明。



## 注意事项

1️⃣ 如果在相同的代码块中，我们不可以再次对于相同名称的变量使用初始化声明，例如：`a := 20` 就是不被允许的（因为在前文中已经声明了 `a := 50`），编译器会提示错误 “no new variables on left side of :=”。但是 `a = 20` 是可以的，因为这是给相同的变量赋予一个新的值。

2️⃣ 如果你在定义变量 `a` 之前使用它，则会得到编译错误 “undefined: a”。

3️⃣ 如果你声明了一个局部变量却没有在相同的代码块中使用它，同样会得到编译错误。例如下面这个例子当中的变量 `a`：

```go showLineNumbers title="var_unused.go"
package main

import "fmt"

func main() {
    var a string = "abc"
    fmt.Println("Hello, World!")
}
```

尝试编译这段代码将得到错误 “a declared but not used”。

这说明在 Go 语言中，**单纯地给变量赋值也是不够的，这个变量必须被使用才行**。不过这条规则也有例外，全局变量是允许声明但不使用。

4️⃣ 同一类型的多个变量可以声明在同一行，如：

```go
var a, b, c int
```

多变量可以在同一行进行赋值，如：

```go
a, b, c = 5, 7, "abc"
```

上面这行假设了变量 `a`、`b` 和 `c` 都已经被声明，否则的话应该这样使用：

```go
a, b, c := 5, 7, "abc"
```

右边的这些值以相同的顺序赋值给左边的变量，所以 `a` 的值是 5，`b` 的值是 7，`c` 的值是 "abc"。这被称为 **并行** 或 **同时** 赋值。

5️⃣ 如果你想要交换两个变量的值，则可以简单地使用 `a, b = b, a`。

6️⃣ 空白标识符 `_` 也被用于抛弃值，如值 5 在：`_, b = 5, 7` 中被抛弃。

`_` 实际上是一个只写变量，你不能得到它的值。这样做是因为 Go 语言中你必须使用所有被声明的变量，但有时你并不需要使用从一个函数得到的所有返回值。

7️⃣ 并行赋值也被用于当一个函数返回多个返回值时，比如这里的 `val` 和错误 `err` 是通过调用 `Func1` 函数同时得到：

```go
val, err = Func1(var1)
```

