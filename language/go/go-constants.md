---
sidebar_position: 8
slug: /go-constants
---

# Go 语言常量

除了变量外，Go 语言还有常量的概念。常量（Constant）是一种恒定不变的值，声明常量使用关键字 `const`。你可以将常量理解为只读变量，这意味着在程序运行时，常量是不会被修改的。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/const) 下载。

:::

## 常量定义

在 Go 语言中，常量中的数据类型只可以是布尔型、数字型（整数型、浮点型和复数）和字符串型。

常量的定义格式：

```go
const identifier [type] = value
```

你可以省略类型说明符 `[type]`，因为 Go 编译器可以根据变量的值来推断其类型。

### 常量定义示例

显式类型定义：

```go
const b string = "abc"
```

隐式类型定义：

```go
const b = "abc"
```

多个相同类型的声明可以简写为：

```go
const c_name1, c_name2 = value1, value2
```

以下实例演示了常量的应用：

```go showLineNumbers title="const_example_01.go"
package main

import "fmt"

func main() {
    const LENGTH int = 10
    const WIDTH int = 5   
    var area int
    const a, b, c = 123, true, "getiot" // 多重赋值

    area = LENGTH * WIDTH
    fmt.Printf("面积为 %d", area)
    println()
    println(a, b, c)
}
```

以上实例运行结果为：

```bash
面积为 50
123 true getiot
```

## 常量的应用

在 Go 程序中，常量可以用作枚举。例如下面示例，数字 0、1 和 2 分别代表未知性别、女性和男性。

```go showLineNumbers
const (
    Unknown = 0
    Female = 1
    Male = 2
)
```

对于常量，可以用 `len()`、`cap()`、`unsafe.Sizeof()` 等函数计算常量表达式的值。需要注意的是，在常量表达式中，函数必须是内置函数，否则编译不通过。

```go showLineNumbers title="const_example_02.go"
package main

import "unsafe"

const (
    a = "abc"
    b = len(a)
    c = unsafe.Sizeof(a)
)

func main(){
    println(a, b, c)
}
```

以上实例运行结果为：

```bash
abc 3 16
```



## iota 常量

`iota` 是一个特殊常量，可以认为是一个可以被编译器修改的常量。在每一个 `const` 关键字出现时，被重置为 0，然后再下一个 `const` 出现之前，每出现一次 `iota`，其所代表的数字会自动增加 1。

:::tip

“iota”一词源自希腊语，表示希腊字母表的第九个字母。在现代用法中，“iota”常用于表示极小的量或微小的变化。在 Go 语言中，`iota` 被用作一种特殊的常量生成器，它自增并生成连续的整数值序列。由于其含义与连续增量有关，因此 Go 语言的设计者选择了“iota”作为这个功能的名称。

:::

`iota` 可以被用作枚举值：

```go showLineNumbers
const (
    a = iota
    b = iota
    c = iota
)
```

第一个 `iota` 等于 0，每当 `iota` 在新的一行被使用时，它的值都会自动加 1；所以 `a=0, b=1, c=2` 可以简写为如下形式：

```go showLineNumbers
const (
    a = iota
    b
    c
)
```

### 示例 1

下面来看一个简单的 `iota` 示例：

```go showLineNumbers title="iota_example_01.go"
package main

import "fmt"

func main() {
    const (
            a = iota   // 0
            b          // 1
            c          // 2
            d = "ha"   // 独立值，iota += 1
            e          // "ha"   iota += 1
            f = 100    // iota +=1
            g          // 100  iota +=1
            h = iota   // 7，恢复计数
            i          // 8
    )
    fmt.Println(a, b, c, d, e, f, g, h, i)
}
```

以上示例程序运行结果为：

```bash
0 1 2 ha ha 100 100 7 8
```

### 示例 2

再来看一个有趣的 `iota` 示例：

```go showLineNumbers title="iota_example_02.go"
package main
import "fmt"

const (
    i = 1<<iota
    j = 3<<iota
    k
    l
)

func main() {
    fmt.Println("i = ", i)
    fmt.Println("j = ", j)
    fmt.Println("k = ", k)
    fmt.Println("l = ", l)
}
```

以上示例程序运行结果为：

```bash
i =  1
j =  6
k =  12
l =  24
```

`iota` 表示从 0 开始自动加 1，所以 `i=1<<0, j=3<<1`（`<<` 表示左移的意思），因此 `i` 等于二进制 `0b0001` 左移 0 位，还是 1；而 `j` 等于二进制 `0b0011` 左移 1 位，变成 `0b0110` 即为十进制 6。

`i` 和 `j` 的值没问题，关键在于 `k` 和 `l`，从输出结果看，`k=3<<2`，`l=3<<3`。

简单表述:

- `i` = 1 左移 0 位，不变仍为 1。
- `j` = 3 左移 1 位，变为二进制 110，即 6。
- `k` = 3 左移 2 位，变为二进制 1100，即 12。
- `l` = 3 左移 3 位，变为二进制 11000，即 24。

注：`<<n` 等效于 `*(2^n)`。


