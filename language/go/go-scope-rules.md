---
sidebar_position: 14
slug: /go-scope-rules
---

# Go 语言变量作用域

在计算机编程中，变量的作用域指的是变量在程序中可以被访问的范围。变量的作用域由变量的声明位置决定，可分为全局作用域和局部作用域，对应的变量即为全局变量和局部变量。本节我们将详细介绍 Go 语言变量作用域的相关概念。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/variables) 下载。

:::



## 概述

在 Go 语言中，作用域（Scope）就是指已声明标识符所表示的常量、类型、变量、函数或包在源代码中的作用范围。

Go 语言中变量可以在三个地方声明：

- 函数内定义的变量称为**局部变量**（Local Scope）
- 函数外定义的变量称为**全局变量**（Global Scope）
- 函数定义中的变量称为**形式参数**（Formal parameters）

接下来让我们具体了解局部变量、全局变量和形式参数。



## 局部变量

在函数体内声明的变量称之为局部变量，它们的作用域只在函数体内，参数和返回值变量也是局部变量。

以下实例中 main 函数使用了局部变量 a、b、c：

```go showLineNumbers
package main

import "fmt"

func main() {
    /* 声明局部变量 */
    var a, b, c int

    /* 初始化参数 */
    a = 10
    b = 20
    c = a + b

    fmt.Printf ("结果：a = %d, b = %d, c = %d\n", a, b, c)
}
```

以上实例执行输出结果为：

```bash
结果：a = 10, b = 20, c = 30
```



## 全局变量

在函数体外声明的变量称之为全局变量，全局变量可以在整个包甚至外部包（被导出后）使用。

全局变量可以在任何函数中使用，以下实例演示了如何使用全局变量：

```go showLineNumbers
package main

import "fmt"

/* 声明全局变量 */
var g int

func main() {
    /* 声明局部变量 */
    var a, b int

    /* 初始化参数 */
    a = 10
    b = 20
    g = a + b

    fmt.Printf("结果：a = %d, b = %d, g = %d\n", a, b, g)
}
```

以上实例执行输出结果为：

```bash
结果：a = 10, b = 20, g = 30
```

Go 语言程序中全局变量与局部变量名称可以相同，但是函数内的局部变量会被优先考虑。

请看下面实例：

```go showLineNumbers
package main

import "fmt"

/* 声明全局变量 */
var g int = 20

func main() {
    /* 声明局部变量 */
    var g int = 10

    fmt.Printf ("结果：g = %d\n", g)
}
```

以上实例执行输出结果为：

```bash
结果：g = 10
```



## 形式参数

形式参数会作为函数的局部变量来使用，也就是说，对于该函数体来说，形式参数就相当于预先声明的局部变量。

请看下面实例：

```go showLineNumbers
package main

import "fmt"

/* 声明全局变量 */
var a int = 20

func main() {
    /* main 函数中声明局部变量 */
    var a int = 10
    var b int = 20
    var c int = 0

    fmt.Printf("main()函数中 a = %d\n", a)
    c = sum(a, b);
    fmt.Printf("main()函数中 c = %d\n", c)
}

/* 函数定义-两数相加 */
func sum(a, b int) int {
    fmt.Printf("sum() 函数中 a = %d\n", a)
    fmt.Printf("sum() 函数中 b = %d\n", b)

    return a + b
}
```

以上实例执行输出结果为：

```bash
main()函数中 a = 10
sum() 函数中 a = 10
sum() 函数中 b = 20
main()函数中 c = 30
```



## 变量默认值

在 Go 语言中，任何类型的变量在声明后没有赋值的情况下，都对应一个零值。例如，整型和浮点型变量的默认值为 `0`，布尔变量的默认值为 `false`，字符串类型变量的默认值为空字符串 `""`。对于一些复合类型，如指针、切片、字典、通道、接口，默认值为 `nil`。

无论是全局变量还是局部变量都一样，这一点和 C/C++ 不同。这些默认值是 Go 语言中对未初始化变量的一种安全初始化策略，可以有效地避免未经意的错误。

请看下面实例：

```go showLineNumbers title="init_value_example.go"
package main

import "fmt"

func main() {
    var num int
    var flag bool
    var str string
    var ptr *int

    fmt.Println("num:", num)   // 输出 0
    fmt.Println("flag:", flag) // 输出 false
    fmt.Println("str:", str)   // 输出 空字符串
    fmt.Println("ptr:", ptr)   // 输出 nil
}
```

以上实例执行输出结果为：

```bash
num: 0
flag: false
str: 
ptr: <nil>
```

