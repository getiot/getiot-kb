---
sidebar_position: 12
slug: /go-functions
---

# Go 语言函数

在 Go 语言中，函数（Function）是一段代码块，用于执行特定的任务或操作。你可以通过函数来划分不同功能，逻辑上每个函数执行的是指定的任务。在前面的章节中，我们已经见过函数 —— `main()` 函数（Go 程序中最少有一个 `main()` 函数）。

实际上，Go 语言[标准库](/go/go-standard-libraries/)提供了许多内置函数，例如 `len()` 函数可以接受不同类型参数并返回该类型的长度。本节我们将详细介绍 Go 语言中函数相关的概念。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/function) 下载。

:::

## 函数定义

在 Go 语言中，函数的声明由关键字 `func` 开头，后面跟着函数的名称、参数列表和返回值列表。

Go 语言函数定义格式如下：

```go
func function_name( [parameter list] ) [return_types] {
    // 函数体
}
```

函数定义解析：

- **`func`**：函数由 `func` 关键字开始声明。
- **`function_name`**：函数名称，函数名和参数列表一起构成了函数签名。
- **`parameter list`**：函数参数列表。参数就像一个占位符，当函数被调用时，你可以将值传递给参数，这个值被称为实际参数。参数列表指定的是参数类型、顺序及参数个数。参数是可选的，也就是说函数也可以不包含参数。
- **`return_types`**：函数返回类型。return_types 是该列值的数据类型。有些功能不需要返回值，这种情况下 return_types 不是必须的。
- **函数体**：函数定义的代码集合。

以下实例为 `max()` 函数的代码，该函数传入两个整型参数 `num1` 和 `num2`，并返回这两个参数的最大值：

```go showLineNumbers
/* 函数返回两个数的最大值 */
func max(num1, num2 int) int {
    /* 声明局部变量 */
    var result int

    if (num1 > num2) {
        result = num1
    } else {
        result = num2
    }
    return result
}
```



## 函数调用

当我们创建函数后，就可以通过函数调用来执行该调用该函数提供的功能。调用函数时，需要向函数传递参数，并接收返回值。

下面实例演示了如何在 `main` 函数中调用 `max` 函数：

```go showLineNumbers title="func_example_01.go"
package main

import "fmt"

func main() {
    /* 定义局部变量 */
    var a int = 100
    var b int = 200
    var ret int

    /* 调用函数并返回最大值 */
    ret = max(a, b)
    fmt.Printf("The max is %d\n", ret)
}

/* 函数返回两个数的最大值 */
func max(num1, num2 int) int {
    /* 定义局部变量 */
    var result int

    if (num1 > num2) {
        result = num1
    } else {
        result = num2
    }
    return result
}
```

以上实例在 `main()` 函数中调用 `max()` 函数，执行结果为：

```bash
The max is 200
```



## 函数返回多个值

类似于 Python，Go 函数也可以返回多个值，例如：

```go showLineNumbers title="func_example_02.go"
package main

import "fmt"

func swap(x, y string) (string, string) {
    return y, x
}

func main() {
    a, b := swap("Tesla", "Nikola")
    fmt.Println(a, b)
}
```

以上实例执行结果为：

```bash
Nikola Tesla
```



## 函数参数传递

如果函数有一个或多个参数，那么这些参数变量就可称为函数的**形参**，即形式参数（Formal parameters）。相对应的，调用函数时传递的参数则被称为**实参**，即实际参数（Actual parameters）。

形参就像定义在函数体内的局部变量。在函数调用中，可以通过两种方式来传递参数，分别是**值传递**和**引用传递**。

- 值传递（Pass-by-value）是指在调用函数时将实际参数复制一份传递到函数中，这样在函数中如果对参数进行修改，将不会影响到实际参数。
- 引用传递（Pass-by-reference）是指在调用函数时将实际参数的地址传递到函数中，那么在函数中对参数所进行的修改，将影响到实际参数。

默认情况下，Go 语言使用的是值传递，即在调用过程中不会影响到实际参数。

### 值传递

传递是指在调用函数时将实际参数复制一份传递到函数中，这样在函数中如果对参数进行修改，将不会影响到实际参数。

以下定义了 `swap()` 函数：

```go showLineNumbers
/* 定义相互交换值的函数 */
func swap(x, y int) {
    var temp int
    temp = x  // 保存 x 的值
    x = y     // 将 y 值赋给 x
    y = temp  // 将 temp 值赋给 y
}
```

接下来，让我们使用值传递来调用 `swap()` 函数：

```go showLineNumbers title="func_example_03.go"
package main

import "fmt"

func main() {
    /* 定义局部变量 */
    var a int = 100
    var b int = 200

    fmt.Printf("交换前 a 的值为 %d\n", a)
    fmt.Printf("交换前 b 的值为 %d\n", b)

    /* 通过调用函数来交换值 */
    swap(a, b)

    fmt.Printf("交换后 a 的值为 %d\n", a)
    fmt.Printf("交换后 b 的值为 %d\n", b)
}

/* 定义相互交换值的函数 */
func swap(x, y int) {
    var temp int
    temp = x  // 保存 x 的值
    x = y     // 将 y 值赋给 x
    y = temp  // 将 temp 值赋给 y
}
```

以下代码执行结果为：

```bash
交换前 a 的值为 100
交换前 b 的值为 200
交换后 a 的值为 100
交换后 b 的值为 200
```

可以看到，a 和 b 的值并没有真正交换成功。



### 引用传递

引用传递是指在调用函数时将实际参数的地址传递到函数中，那么在函数中对参数所进行的修改，将影响到实际参数。

引用传递将指针参数传递到函数内，关于指针的详细内容，将在后续章节 [Go 语言指针](/go/go-pointers/) 进行介绍。

以下是交换函数 `swap()` 使用了引用传递：

```go showLineNumbers
/* 定义交换值函数 */
func swap(x *int, y *int) {
    var temp int
    temp = *x    // 保持 x 地址上的值
    *x = *y      // 将 y 值赋给 x
    *y = temp    // 将 temp 值赋给 y
}
```

以下我们通过使用引用传递来调用 `swap()` 函数：

```go showLineNumbers title="func_example_04.go"
package main

import "fmt"

func main() {
    /* 定义局部变量 */
    var a int = 100
    var b int= 200

    fmt.Printf("交换前 a 的值为 %d\n", a)
    fmt.Printf("交换前 b 的值为 %d\n", b)

    /* 调用 swap() 函数
     * &a 指向 a 指针，a 变量的地址
     * &b 指向 b 指针，b 变量的地址
     */
    swap(&a, &b)

    fmt.Printf("交换后 a 的值为 %d\n", a)
    fmt.Printf("交换后 b 的值为 %d\n", b)
}

/* 定义交换值函数 */
func swap(x *int, y *int) {
    var temp int
    temp = *x    // 保持 x 地址上的值
    *x = *y      // 将 y 值赋给 x
    *y = temp    // 将 temp 值赋给 y
}
```

以上代码执行结果为：

```bash
交换前 a 的值为 100
交换前 b 的值为 200
交换后 a 的值为 200
交换后 b 的值为 100
```

可以看到，这次 a 和 b 的值交换成功了！

