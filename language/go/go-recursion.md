---
sidebar_position: 22
slug: /go-recursion
---

# Go 语言递归函数

递归函数是一种在函数体内调用自身的函数。Go 语言支持递归，使用递归函数对于解决数学上的问题是非常有用，特别是涉及到树结构、图结构或者其他递归定义的数据结构时。本节我们将通过计算阶乘、斐波那契数列两个简单的示例，帮助你理解和掌握递归函数的使用。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/recursion) 下载。

:::



## 概述

Go 语言支持递归，下面是递归函数的伪代码格式：

```go showLineNumbers
func recursion() {
    recursion() /* 函数调用自身 */
}

func main() {
    recursion()
}
```

需要强调的是，在使用递归时，你必须在递归函数中设置退出条件，否则递归将陷入无限循环中。



## 计算阶乘

在数学中，正整数的阶乘（Factorial）是**所有小于等于该数的正整数的积**。例如 5 的阶乘等于 5 * 4 * 3 * 2 * 1，结果为 120。

下面通过 Go 语言的递归函数实现一个计算任意正整数阶乘的程序。

```go showLineNumbers title="factorial_example.go"
package main

import "fmt"

func factorial(n int) (result int) {
    if n == 0 {
        result = 1   
    } else {
        result = n * factorial(n - 1)
    }
    return
}

func main() {  
    var i int = 5
    fmt.Printf("%d 的阶乘是 %d\n", i, factorial(i))
}
```

以上实例执行输出结果为：

```bash
5 的阶乘是 120
```



## 斐波那契数列

斐波那契数列（Fibonacci sequence）又称黄金分割数列，这个数列很特别，由 0 和1 开始，后面的每一项数字都是前面两项数字的和。

斐波那契数列可以通过如下方程式来表达：

```bash
F(0) = 0，F(1) = 1
F(n) = F(n - 1) + F(n - 2)，其中 n > 1
```

下面通过 Go 语言的递归函数实现斐波那契数列：

```go showLineNumbers title="fibonacci_example.go"
package main

import "fmt"

func fibonacci(n int) int {
    if n < 2 {
        return n
    }
    return fibonacci(n-2) + fibonacci(n-1)
}

func main() {
    var i int

    for i = 0; i < 15; i++ {
        fmt.Printf("%d ", fibonacci(i))
    }
	fmt.Println()
}
```

以上实例执行输出结果为：

```bash
0 1 1 2 3 5 8 13 21 34 55 89 144 233 377
```

