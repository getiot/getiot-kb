---
sidebar_position: 16
slug: /go-pointers
---

# Go 语言指针

和 C/C++ 一样，Go 语言也有指针的概念，指针就是一个存储了变量地址的变量。不过，Go 语言中的指针没有指针运算，只能获取变量的地址、访问指针指向的变量以及将指针传递给函数等基本操作。因此，Go 语言中的指针很容易学习，合理使用指针也能让程序设计变得更加简单。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/pointers) 下载。

:::

## 什么是指针

我们都知道，变量是一种使用方便的占位符，用于引用计算机内存地址。如果你想获得某个变量的地址，可以使用取地址符 `&`，将其放到一个变量前使用就会返回相应变量的内存地址。

以下实例演示了如何获取变量在内存中地址：

```go showLineNumbers title="pointer_example_01.go"
package main

import "fmt"

func main() {
    var a int = 10
    fmt.Printf("变量的地址: %x\n", &a)
}
```

执行以上代码输出结果为（你看到的地址可能不一样）：

```bash
变量的地址: c000012110
```

实际上，**指针就是一个存储了变量地址的变量**，一个指针变量可以指向任何一个值的内存地址。

类似于变量和常量，在使用指针前需要声明指针。指针声明格式如下：

```go
var var_name *var-type
```

其中，`var-type` 为指针类型，`var_name` 为指针变量名，`*` 号用于指定变量是作为一个指针。

例如，下面声明指向 int 和 float32 的指针：

```go
var ip *int        // 指向整型
var fp *float32    // 指向浮点型
```



## 如何使用指针

指针的一般使用流程为：定义指针变量 -> 为指针变量赋值 -> 访问指针变量中指向地址的值。

在指针类型前面加上 `*` 号（前缀）来获取指针所指向的内容。一个指针变量通常缩写为 `ptr`。

请看下面实例：

```go showLineNumbers title="pointer_example_02.go"
package main

import "fmt"

func main() {
    var a int= 20   /* 声明实际变量 */
    var ptr *int     /* 声明指针变量 */

    ptr = &a  /* 指针变量的存储地址 */

    fmt.Printf("  a 变量的内存地址: %x\n", &a)

    /* 指针变量的存储地址 */
    fmt.Printf("ptr 变量的存储地址: %x\n", ptr)

    /* 使用指针访问值 */
    fmt.Printf("*ptr 变量的值: %d\n", *ptr)
}
```

以上实例执行输出结果为：

```bash
  a 变量的内存地址: c000012110
ptr 变量的存储地址: c000012110
*ptr 变量的值: 20
```



## 空指针

当一个指针被定义后没有分配到任何变量时，它的值为 `nil`。`nil` 指针也称为空指针。

`nil` 在概念上和其它语言的 `null`、`None`、`nil`、`NULL` 一样，都指代零值或空值。

请看下面实例：

```go showLineNumbers title="pointer_example_03.go"
package main

import "fmt"

func main() {
    var ptr *int
    fmt.Printf("ptr 的值为 %v\n", ptr)
    fmt.Printf("ptr 的值为 %#v\n", ptr)
}
```

以上实例输出结果为：

```go
ptr 的值为 <nil>
ptr 的值为 (*int)(nil)
```

在使用指针之前，可以先判断是否为空，判断的方法是和 `nil` 作比较，例如：

```go
if(ptr != nil)     // ptr 不是空指针
if(ptr == nil)     // ptr 是空指针
```



## 数组指针

数组指针即指向数组的指针，也就是用于存储数组地址的变量。

在介绍数组指针之前，先看个实例，定义了长度为 3 的整型数组：

```go showLineNumbers title="pointer_example_04.go"
package main

import "fmt"

const MAX int = 3

func main() {
    a := []int{10,100,200}

    for i := 0; i < MAX; i++ {
        fmt.Printf("a[%d] = %d\n", i, a[i])
    }
}
```

以上代码执行输出结果为：

```go
a[0] = 10
a[1] = 100
a[2] = 200
```

有一种情况，我们可能需要保存数组，这样我们就需要使用到指针。

你可以通过下面方法声明一个整型数组指针：

```go
var ptr [MAX]*int
```

以下实例的三个整数将存储在指针数组中：

```go showLineNumbers title="pointer_example_05.go"
package main

import "fmt"

const MAX int = 3

func main() {
    a := []int{10,100,200}
    var ptr [MAX]*int

    for i := 0; i < MAX; i++ {
        ptr[i] = &a[i]  // 整数地址赋值给指针数组
    }

    for i := 0; i < MAX; i++ {
        fmt.Printf("a[%d] = %d\n", i, *ptr[i])
    }
}
```

以上代码执行输出结果为：

```go
a[0] = 10
a[1] = 100
a[2] = 200
```



## 指针的指针

如果一个指针变量存放的又是另一个指针变量的地址，则称这个指针变量为**指向指针的指针变量**。

当定义一个指向指针的指针变量时，第一个指针存放第二个指针的地址，第二个指针存放变量的地址。

例如，声明一个指向整型指针的指针变量：

```go
var ptr **int
```

注意：访问指向指针的指针变量值需要使用两个 `*` 号。

请看下面实例：

```go showLineNumbers title="pointer_example_06.go"
package main

import "fmt"

func main() {
    var a int
    var ptr *int
    var pptr **int

    a = 3000

    /* 指针 ptr 地址 */
    ptr = &a

    /* 指向指针 ptr 地址 */
    pptr = &ptr

    /* 获取 pptr 的值 */
    fmt.Printf("变量 a = %d\n", a)
    fmt.Printf("指针变量 *ptr = %d\n", *ptr)
    fmt.Printf("指向指针的指针变量 **pptr = %d\n", **pptr)
}
```

以上实例执行输出结果为：

```bash
变量 a = 3000
指针变量 *ptr = 3000
指向指针的指针变量 **pptr = 3000
```



## 向函数传递指针参数

Go 语言允许向函数传递指针，只需要在函数定义的参数上设置为指针类型即可。和值传递不同，通过引用或地址传参，在函数调用时可以改变实参的值。

下面实例演示了如何向函数传递指针，并在函数调用后修改函数内的值。

```go showLineNumbers title="pointer_example_07.go"
package main

import "fmt"

func main() {
    /* 定义局部变量 */
    var a int = 100
    var b int= 200

    fmt.Printf("交换前 a 的值 : %d\n", a)
    fmt.Printf("交换前 b 的值 : %d\n", b)

    /* 调用函数用于交换值
     * &a 指向 a 变量的地址
     * &b 指向 b 变量的地址
     */
    swap(&a, &b)

    fmt.Printf("交换后 a 的值 : %d\n", a)
    fmt.Printf("交换后 b 的值 : %d\n", b)
}

func swap(x *int, y *int) {
    var temp int
    temp = *x    // 保存 x 地址的值
    *x = *y      // 将 y 赋值给 x
    *y = temp    // 将 temp 赋值给 y
}
```

以上实例允许输出结果为：

```bash
交换前 a 的值 : 100
交换前 b 的值 : 200
交换后 a 的值 : 200
交换后 b 的值 : 100
```

