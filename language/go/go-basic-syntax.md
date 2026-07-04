---
sidebar_position: 5
slug: /go-basic-syntax
---

# Go 语言语法基础

上一节我们了解了 Go 语言的基本组成结构，这一节我们将更进一步，学习 Go 语言的基础语法。这些内容很基础，但也很重要，一定要掌握哦！

## 标记

Go 程序可以由多个标记组成，标记可以是关键字、标识符、常量、字符串、符号。例如以下 Go 语句：

```go showLineNumbers
fmt.Println("Hello, World!")
```

它由 6 个标记组成，这 6 个标记分别是（每行一个）：

```go showLineNumbers
fmt
.
Println
(
"Hello, World!"
)
```



## 行分隔符

在 Go 程序中，一行代表一个语句结束。每个语句不需要像 C/C++ 语言那样以分号 `;` 结尾，因为这些工作都将由 Go 编译器自动完成。

例如下面为两个语句，结尾不需要分号：

```go showLineNumbers
fmt.Println("Hello, World!")
fmt.Println("人人都懂物联网：getiot.tech")
```

但是如果你打算将多个语句写在同一行，那么它们就必须使用 `;` 人为区分，但在实际开发中我们并不鼓励这种做法。



## 注释

注释不会被编译，每一个包应该有相关注释。

单行注释是最常见的注释形式，你可以在任何地方使用以 `//` 开头的单行注释。例如：

```go showLineNumbers
// 单行注释
```

多行注释也叫块注释，均已以 `/*` 开头，并以 `*/` 结尾。例如：

```go showLineNumbers
/*
 Author by GetIoT.tech
 这是多行注释
 */
```



## 标识符

标识符用来命名变量、类型等程序实体。一个标识符实际上就是一个或是多个字母（A-Z 和 a-z）数字（0-9）、下划线 `_` 组成的序列，但是第一个字符不能是数字，只能是字母或下划线。

以下是有效的标识符：

```go
mahesh   kumar   abc   move_name   a_123
myname50   _temp   j   a23b9   retVal
```

以下是无效的标识符：

- `1ab`（以数字开头）
- `case`（Go 语言的关键字）
- `a+b`（运算符是不允许的）



## 字符串连接

Go 语言的字符串可以通过 `+` 实现连接。

## 实例

```go showLineNumbers
package main
import "fmt"
func main(){
    fmt.Println("GetIoT.tech"+" 是一个学习技术的好地方！")
}
```

运行程序，输出结果如下：

```bash
GetIoT.tech 是一个学习技术的好地方！
```



## 关键字

下面列举了 Go 代码中会使用到的 25 个关键字或保留字：

```go
break       default        func      interface    select
case        defer          go        map          struct
chan        else           goto      package      switch
const       fallthrough    if        range        type
continue    for            import    return       var
```

除了以上介绍的这些关键字，Go 语言还有 36 个预定义标识符：

```go
append  bool     byte     cap      close   complex  complex64  complex128  uint16
copy    false    float32  float64  imag    int      int8       int16       uint32
int32   int64    iota     len      make    new      nil        panic       uint64
print   println  real     recover  string  true     uint       uint8       uintptr
```

程序一般由关键字、常量、变量、运算符、类型和函数组成。

程序中可能会使用到这些分隔符：括号 `()`，中括号 `[]` 和大括号 `{}`。

程序中可能会使用到这些标点符号：`.`、`,`、`;`、`:` 和 `…`。



## 空格

在 Go 语言中，空格通常用于分隔标识符、关键字、运算符和表达式，以提高代码的可读性。

变量的声明必须使用空格隔开，这样才能明确区分出哪个是关键字，哪个是变量名，哪个是类型。例如：

```go showLineNumbers
var age int
const Pi float64 = 3.14159265358979323846
```

在 Go 程序语句中适当使用空格能让程序看易阅读。

看一个无空格的例子：

```go showLineNumbers
fruit=apples+oranges
```

再看看在变量与运算符间加入空格，代码看起来是不是变得美观了？

```go showLineNumbers
fruit = apples + oranges
```



## 缩进

Go 对于代码的缩进层级方面使用 tab 还是空格并没有强制规定，一个 tab 可以代表 4 个或 8 个空格。在实际开发中，1 个 tab 应该代表 4 个空格，而在本身的例子当中，每个 tab 代表 8 个空格。至于开发工具方面，一般都是直接使用 tab 而不替换成空格。

在命令行输入下面命令会格式化该源文件的代码，然后将格式化后的代码覆盖原始内容：

```bash
$ gofmt -w program.go
```

注意：如果不加参数 `-w` 则只会打印格式化后的结果而不重写文件。

下面命令会格式化并重写所有 Go 源文件：

```bash
$ gofmt -w *.go
```

下面命令会格式化并重写 map1 目录及其子目录下的所有 Go 源文件。

```bash
$ gofmt map1
```

`gofmt` 也可以通过在参数 `-r` 后面加入用双引号括起来的替换规则实现代码的简单重构，规则的格式：

```bash
<原始内容> -> <替换内容>
```

例如下面的代码会将源文件中没有意义的括号去掉：

```bash
$ gofmt -r '(a) -> a' -w *.go
```

