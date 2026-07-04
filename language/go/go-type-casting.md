---
sidebar_position: 23
slug: /go-type-casting
---

# Go 语言类型转换

在 Go 语言中，类型转换（Type Casting 或 Type Conversion）是一种将一个类型的值转换为另一种类型的操作，比如将 `float32` 数据类型的变量转换为 `int32` 类型的变量。类型转换可以在不同数据类型之间进行，但必须是相互兼容的类型。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/type) 下载。

:::



## 类型转换概述

类型转换用于在不同类型之间转换数据，以便进行适当的操作。在转换之前，需要确保目标类型可以容纳源类型的值，否则可能会导致精度丢失或溢出。

Go 语言类型转换的语法格式如下：

```go
Type(expression)
```

其中，`Type` 表示目标类型，`expression` 表示要转换的值。

请看下面实例：

```go showLineNumbers title="type_casting_example_01.go"
package main

import "fmt"

func main() {
    var sum int = 17
    var count int = 5
    var mean float32
   
    mean = float32(sum) / float32(count)
    fmt.Printf("mean 的值为 %f\n", mean)
}
```

在这个实例中，我们先将 `sum` 和 `count` 由整型转化为浮点型，再计算结果，将结果赋值给浮点型变量 `mean`。

以上实例执行输出结果为：

```bash
mean 的值为 3.400000
```



## 隐式转换类型

Go 语言不支持隐式转换类型！也就是说，不同类型的变量参与运算时，需要显式进行类型转换。

例如上面的实例中，如果直接使用 `mean = sum / count` 计算，那么在编译时会出现如下错误：

```bash
cannot use sum / count (value of type int) as float32 value in assignment
```

再来看一个实例：

```go showLineNumbers title="type_casting_example_02.go"
package main
import "fmt"

func main() {  
    var a int64 = 3
    var b int32
    b = a
    fmt.Printf("b = %d\n", b)
}
```

编译时出现如下错误：

```bash
7:9: cannot use a (variable of type int64) as int32 value in assignment
```

这个错误出现在第 7 行代码，`b = a` 赋值语句，虽然 `a` 和 `b` 都是整型，但依然无法编译通过。

解决办法是在赋值时进行类型转换，代码如下：

```go {7} showLineNumbers title="type_casting_example_02.go"
package main
import "fmt"

func main() {  
    var a int64 = 3
    var b int32
    b = int32(a)
    fmt.Printf("b = %d\n", b)
}
```

以上实例执行输出结果为：

```bash
b = 3
```

