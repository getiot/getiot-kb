---
sidebar_position: 13
slug: /go-functions-advance
---

# Go 语言函数进阶

本节介绍 Go 语言函数的高级用法，包括将函数作为值来使用、defer 语句的使用，以及介绍闭包（匿名函数）、方法等概念。本节内容涉及 Go 标准库、结构体等知识，你可以在学习完这些内容后再回头学习本节内容。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/function) 下载。

:::



## 函数作为值

Go 语言可以很灵活的创建函数，并将函数作为值使用。下面实例中，我们在 `main` 函数中声明了一个函数变量，该函数仅仅是为了使用内置的数学函数 `math.sqrt()` 求平方根。

实例代码如下：

```go showLineNumbers title="func_example_05.go"
package main

import (
    "fmt"
    "math"
)

func main() {
    /* 声明函数变量 */
    getSquareRoot := func(x float64) float64 {
        return math.Sqrt(x)
    }

    /* 使用函数 */
    fmt.Println(getSquareRoot(9))
}
```

以上代码执行结果为：

```bash
3
```



## 闭包

Go 语言支持匿名函数，可作为闭包（closure）。匿名函数是一个“内联”语句或表达式。匿名函数的优越性在于可以直接使用函数内的变量，不必声明。

以下实例中，我们创建了函数 `getSequence()`，返回另外一个函数。该函数的目的是在闭包中递增 `i` 变量，代码如下。

```go showLineNumbers title="func_example_06.go"
package main

import "fmt"

func getSequence() func() int {
    i := 0
    return func() int {
        i++
        return i
    }
}

func main(){
    /* nextNumber 为一个函数，函数 i 为 0 */
    nextNumber := getSequence()

    /* 调用 nextNumber 函数，i 变量自增 1 并返回 */
    fmt.Println(nextNumber())
    fmt.Println(nextNumber())
    fmt.Println(nextNumber())
   
    /* 创建新的函数 nextNumber1，并查看结果 */
    nextNumber1 := getSequence()
    fmt.Println(nextNumber1())
    fmt.Println(nextNumber1())
}
```

以上代码执行结果为：

```bash
1
2
3
1
2
```



## 方法

Go 语言中同时有函数和方法。一个方法就是一个包含了接受者的函数，接受者可以是命名类型或者结构体类型的一个值或者是一个指针。所有给定类型的方法属于该类型的方法集。

语法格式如下：

```go
func (variable_name variable_data_type) function_name() [return_type]{
    // 函数体
}
```

下面定义一个结构体类型和该类型的一个方法：

```go showLineNumbers title="func_example_07.go"
package main

import (
    "fmt"
)

/* 定义函数 */
type Circle struct {
    radius float64
}

func main() {
    var c1 Circle
    c1.radius = 10.00
    fmt.Println("Area of Circle(c1) = ", c1.getArea())
}

// 该 method 属于 Circle 类型对象中的方法
func (c Circle) getArea() float64 {
    //c.radius 即为 Circle 类型对象中的属性
    return 3.14 * c.radius * c.radius
}
```

以上代码执行结果为：

```bash
Area of Circle(c1) =  314
```



## defer 语句

`defer` 是 Go 语言中的一个关键字，用于延迟（defer）函数或方法的执行，使其在函数执行结束时执行。`defer` 语句通常用于释放资源、解锁互斥量、关闭文件等需要在函数退出时执行的操作，以确保在函数执行过程中发生错误或提前返回时，这些操作也能够被正确执行。

`defer` 语句的一般语法格式如下：

```go
defer functionCall(arguments)
```

其中，`functionCall` 是要延迟执行的函数或方法调用，可以带有参数；`arguments` 是函数调用的参数列表。

`defer` 语句的执行顺序是倒序的，即最后一个 `defer` 语句会最先执行，倒数第二个 `defer` 语句会第二个执行，依此类推。这种倒序执行的特性使得 `defer` 语句特别适合用于资源的释放，可以保证资源的释放顺序与申请顺序相反，从而避免资源泄漏等问题。

以下是一个简单的示例，演示了 `defer` 语句的基本用法：

```go showLineNumbers title="func_example_08.go"
package main

import "fmt"

func main() {
	fmt.Println("开始")
	defer fmt.Println(1)
	defer fmt.Println(2)
	defer fmt.Println(3)
	fmt.Println("结束")
}
```

以上代码执行结果如下：

```bash
开始
结束
3
2
1
```

