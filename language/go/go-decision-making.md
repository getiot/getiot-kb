---
sidebar_position: 10
slug: /go-decision-making
---

# Go 语言条件语句

在 Go 语言中，条件语句用于根据给定条件执行不同的代码块。条件语句需要指定一个或多个条件，并通过测试条件是否为 true 来决定是否执行指定代码块，并在条件为 false 的情况再执行另外的代码块。本节将介绍 Go 语言的几种条件语句，包括 `if-else` 语句、`switch` 语句、`type-switch` 语句，以及用于通信的 `select` 语句。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/decision-making) 下载。

:::

## if 语句

`if` 语句由布尔表达式后紧跟一个或多个语句组成。Go 语言中 `if` 语句的语法如下：

```go
if condition {
    // 如果条件为真，执行这里的代码
}
```

`if` 在布尔表达式为 true 时，其后紧跟的语句块执行，如果为 false 则不执行。

请看下面实例：

```go showLineNumbers title="if_example_01.go"
package main

import "fmt"

func main() {
    /* 定义局部变量 */
    var a int = 10
 
    /* 使用 if 语句判断布尔表达式 */
    if a < 20 {
        /* 如果条件为 true 则执行以下语句 */
        fmt.Printf("a 小于 20\n")
    }
    fmt.Printf("a 的值为 %d\n", a)
}
```

以上代码执行结果为：

```bash
a 小于 20
a 的值为 10
```



## if-else 语句

`if` 语句后可以使用可选的 `else` 语句，`else` 语句中的表达式在布尔表达式为 false 时执行。Go 语言中 `if...else` 语句的语法如下：

```go
if condition {
    // 如果条件为真，执行这里的代码
} else {
    // 如果条件为假，执行这里的代码
}
```

`if` 在布尔表达式为 true 时，其后紧跟的语句块执行，如果为 false 则执行 `else` 语句块。

请看下面实例：

```go showLineNumbers title="if_example_02.go"
package main

import "fmt"

func main() {
    /* 局部变量定义 */
    var a int = 100
 
    /* 判断布尔表达式 */
    if a < 20 {
        /* 如果条件为 true 则执行以下语句 */
        fmt.Printf("a 小于 20\n")
    } else {
        /* 如果条件为 false 则执行以下语句 */
        fmt.Printf("a 不小于 20\n")
    }
    fmt.Printf("a 的值为 %d\n", a)
}
```

以上代码执行结果为：

```bash
a 不小于 20
a 的值为 100
```



## if-else if 语句

`if` 语句后面除了可以带 `else` 语句，还可以一个或多个 `else if` 语句，如果 `else if` 语句中的布尔表达式为 true 则执行该语句块。Go 语言中 `if...else if` 语句的语法如下：

```go
if condition1 {
    // 如果条件1为真，执行这里的代码
}
else if condition2 {
    // 如果条件2为真，执行这里的代码
} else {
    // 如果上述条件均为假，执行这里的代码
}
```

请看下面实例：

```go showLineNumbers title="if_example_03.go"
package main

import "fmt"

func main() {
    /* 局部变量定义 */
    var a int = 50
 
    /* 判断布尔表达式 */
    if a < 20 {
        fmt.Printf("a 小于 20\n")
    } else if a < 40 {
        fmt.Printf("a 大于等于 20，小于 40\n")
    } else if a < 60 {
        fmt.Printf("a 大于等于 40，小于 60\n")
    } else {
        fmt.Printf("a 不小于 60\n")
    }
    fmt.Printf("a 的值为 %d\n", a)
}
```

以上代码执行结果为：

```bash
a 大于等于 40，小于 60
a 的值为 50
```



## if 嵌套语句

你还可以在 `if` 或 `else if` 语句中嵌入一个或多个 `if` 或 `else if` 语句。Go 语言中 `if...else` 语句的语法如下：

```go
if condition1 {
    // 如果条件1为真，执行这里的代码
    if condition2 {
        // 如果条件2为真，执行这里的代码
    }
}
```

你可以以同样的方式在 `if` 语句中嵌套 `else if...else` 语句

请看下面实例：

```go showLineNumbers title="if_example_04.go"
package main

import "fmt"

func main() {
    /* 定义局部变量 */
    var a int = 100
    var b int = 200
 
    /* 判断条件 */
    if a == 100 {
        /* if 条件语句为 true 执行 */
        if b == 200 {
           /* if 条件语句为 true 执行 */
           fmt.Printf("a 的值为 100，b 的值为 200\n")
        }
    }
    fmt.Printf("a 值为 %d\n", a )
    fmt.Printf("b 值为 %d\n", b )
}
```

以上代码执行结果为：

```bash
a 的值为 100，b 的值为 200
a 值为 100
b 值为 200
```



## switch 语句

`switch` 语句用于基于不同条件执行不同动作，每一个 `case` 分支都是唯一的，从上直下逐一测试，直到匹配为止。你可以定义任意个数的 `case` 分支。

值得注意的是，不同于 C/C++ 等编程语言，Go 语言的 `switch` 语句匹配项后面不需要添加 `break` 语句。

Go 语言中 `switch` 语句的语法如下：

```go
switch expression {
    case value1:
        // 如果expression的值等于value1，执行这里的代码
    case value2:
        // 如果expression的值等于value2，执行这里的代码
    default:
        // 如果以上条件都不满足，执行这里的代码
}
```

变量 `expression` 可以是任何类型，而 `value1` 和 `value2` 则可以是同类型的任意值。类型不被局限于常量或整数，但必须是相同的类型；或者最终结果为相同类型的表达式。

你可以同时测试多个可能符合条件的值，使用逗号分割它们，例如 `case val1, val2, val3`。

请看下面实例：

```go showLineNumbers title="switch_example.go"
package main

import "fmt"

func main() {
    /* 定义局部变量 */
    var grade string = "B"
    var score int = 90

    switch score {
        case 90: grade = "A"
        case 80: grade = "B"
        case 60, 70: grade = "C"
        default: grade = "D"
    }

    switch {
        case grade == "A" :
            fmt.Printf("优秀!\n")
        case grade == "B" :
            fmt.Printf("良好\n")
        case grade == "C" :
            fmt.Printf("及格\n")
        default:
            fmt.Printf("不及格\n")
    }
    fmt.Printf("你的等级是 %s\n", grade)
}
```

以上代码执行结果为：

```bash
优秀!
你的等级是 A
```



## type-switch 语句

`type-switch` 语句与普通的 `switch` 语句类似，但是在 `case` 后面跟着的不是具体的值，而是类型。用于根据接口值的实际类型执行不同的代码块。

Type Switch 语法格式如下：

```go
switch value.(type){
    case type1:
        // 如果value的类型是type1，执行这里的代码
    case type2:
        // 如果value的类型是type2，执行这里的代码
    default: /* 可选 */
        // 如果以上类型都不匹配，执行这里的代码
}
```

在`type-switch`语句中，`value` 是一个接口值（`interface` 变量），`(type)` 用于获取接口值的实际类型。然后，`case` 后面跟着的是具体的类型，用于匹配接口值的实际类型。

请看下面实例（这里用到了[函数](/go/go-functions/)，后面章节将详细介绍）：

```go showLineNumbers title="type-switch_example.go"
package main

import "fmt"

func checkType(i interface{}) {
    switch i.(type) {
    case int:
        fmt.Println("i 是一个整数")
    case float64:
        fmt.Println("i 是一个浮点数")
    case string:
        fmt.Println("i 是一个字符串")
    default:
        fmt.Println("i 的类型未知")
    }
}

func main() {
    checkType(10)
    checkType(3.14)
    checkType("Hello")
    checkType(true)
}
```

以上代码执行结果为：

```bash
i 是一个整数
i 是一个浮点数
i 是一个字符串
i 的类型未知
```



## select 语句

`select` 语句是 Go 语言特有的设计，语法类似于 `switch` 语句，但只能用于处理一个或多个通道的发送和接收操作。也就是说，每个 `case` 必须是一个通信操作，要么是发送要么是接收。由于涉及通信，因此 `select` 语句会阻塞，直到其中一个 `case` 可以执行，然后执行该 `case` 中的代码。

以下是 `select` 语句的基本语法：

```go
select {
    case <-channel1:
    	// 如果 channel1 可以接收数据，则执行这里的代码
    case data := <-channel2:
    	// 如果 channel2 可以接收数据，则执行这里的代码，并将接收到的数据存储在变量 data 中
    case channel3 <- value:
    	// 如果 channel3 可以发送数据，则执行这里的代码，将 value 发送到 channel3 中
    default:
    	// 如果没有任何 case 可以执行，则执行这里的代码
}
```

`select` 语句包含一个或多个 `case` 分支，每个 `case` 分支描述了一个通道操作，可以是接收操作、发送操作或者其他操作。当 `select` 语句执行时，它会尝试执行每个 `case` 分支，并选择第一个可以操作的分支执行，如果有多个分支可以操作，则会随机选择一个。如果没有任何分支可以操作，则会执行 `default` 分支（如果有的话），否则 `select` 语句会阻塞，直到有一个分支可以操作。

请看下面实例：

```go showLineNumbers title="select_example.go"
package main

import (
    "fmt"
    "time"
)

func main() {
    ch1 := make(chan int)
    ch2 := make(chan int)

    go func() {
        time.Sleep(1 * time.Second)
        ch1 <- 1
    }()

    go func() {
        time.Sleep(2 * time.Second)
        ch2 <- 2
    }()

    for {
        select {
        case <-ch1:
            fmt.Println("Received from channel 1")
        case <-ch2:
            fmt.Println("Received from channel 2")
        default:
            // fmt.Println("no communication")
        }
    }
}
```

以上代码执行结果为：

```bash
Received from channel 1
Received from channel 2
```

在上面的示例中，我们创建了两个通道 `ch1` 和 `ch2`，并在两个 goroutine 中分别向它们发送数据。然后，我们使用 `select` 语句来等待哪个通道首先接收到数据，并打印相应的消息。由于 `ch1` 通道在 1 秒后接收到数据，而`ch2`通道在 2 秒后接收到数据，因此 `select` 语句会先选择执行 `case <-ch1` 分支，并打印 "Received from channel 1"。

:::tip

更多关于 goroutine 和 channel 的更多内容，我们将在 [Go 语言并发模型](/go/go-concurrency-model/) 进行讲解。

:::
