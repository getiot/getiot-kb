---
sidebar_position: 15
slug: /go-arrays
---

# Go 语言数组

Go 语言提供了数组类型的数据结构。数组是具有相同唯一类型的一组已编号且长度固定的数据项序列，这种类型可以是任意的原始类型例如整型、字符串或者自定义类型。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/array) 下载。

:::

## 声明数组

Go 语言数组声明需要指定元素类型及元素个数，声明一维数组的语法格式如下：

```go
var variable_name [SIZE] variable_type
```

注意：数组长度必须是整数且大于 0。

例如，定义一个数组 array，其长度为 10，类型为 int：

```go
var array [10] int
```

请看下面实例：

```go showLineNumbers title="array_example_01.go"
package main

import "fmt"

func main() {
    var array [10] int
    
    for i, x := range array {
        fmt.Printf("[%d] %d\n", i, x)
    }
}
```

以上实例运行输出结果为：

```bash
[0] 0
[1] 0
[2] 0
[3] 0
[4] 0
[5] 0
[6] 0
[7] 0
[8] 0
[9] 0
```



## 初始化数组

你可以在声明数组的同时进行初始化，例如：

```go
var array = [5]float32{1000.0, 2.0, 3.4, 7.0, 50.0}
```

注意：初始化数组中 `{}` 中的元素个数不能大于 `[]` 中的数字。

如果忽略 `[]` 中的数字不设置数组大小，Go 语言会根据元素的个数来设置数组的大小。例如：

```go
var array = []float32{1000.0, 2.0, 3.4, 7.0, 50.0}
```

请看下面实例：

```go showLineNumbers title="array_example_02.go"
package main

import "fmt"

func main() {
    var array = []float32{1000.0, 2.0, 3.4, 7.0, 50.0}
    
    for i, x := range array {
        fmt.Printf("[%d] %f\n", i, x)
    }
}
```

以上实例运行输出结果为：

```bash
[0] 1000.000000
[1] 2.000000
[2] 3.400000
[3] 7.000000
[4] 50.000000
```



## 访问数组元素

数组元素可以通过索引（位置）来读取（或者修改），索引从 0 开始，第一个元素索引为 0，第二个索引为 1，以此类推。

格式为数组名后加中括号，中括号中为索引的值。例如，读取数组 array 第 10 个元素的值：

```go
var a float32 = array[9]
a := array[9]
```

下面实例演示了数组完整操作（声明、赋值、访问）：

```go showLineNumbers title="array_example_03.go"
package main

import "fmt"

func main() {
    var n [10]int /* n 是一个长度为 10 的数组 */
    var i,j int

    /* 为数组 n 初始化元素 */         
    for i = 0; i < 10; i++ {
        n[i] = i + 100 /* 设置元素为 i + 100 */
    }

    /* 输出每个数组元素的值 */
    for j = 0; j < 10; j++ {
        fmt.Printf("Element[%d] = %d\n", j, n[j])
    }
}
```

以上实例执行结果如下：

```bash
Element[0] = 100
Element[1] = 101
Element[2] = 102
Element[3] = 103
Element[4] = 104
Element[5] = 105
Element[6] = 106
Element[7] = 107
Element[8] = 108
Element[9] = 109
```



## 多维数组

Go 语言支持多维数组，例如二维数组、三维数组等。多维数组本质上是由一维数组组成的，最简单的多维数组是二维数组。

声明多维数组的语法格式如下：

```go
var variable_name [SIZE1][SIZE2]...[SIZEN] variable_type
```

例如，二维数组定义方式如下：

```go
var arrayName [ x ][ y ] variable_type
```

其中，`variable_type` 为 Go 语言的数据类型，`arrayName` 为数组名。你可以将二维数组想象成一个表格，`x` 为行，`y` 为列。例如，下面声明一个三行四列的二维整型数组：

```go
var array2d [3][4]int
```

该二维数组使用表格形式表示如下：

```bash
         Column 0    Column 1    Column 2    Column 3
      +-----------+-----------+-----------+-----------+
Row 0 |  a[0][0]  |  a[0][1]  |  a[0][2]  |  a[0][3]  |
      +-----------+-----------+-----------+-----------+
Row 1 |  a[1][0]  |  a[1][1]  |  a[1][2]  |  a[1][3]  |
      +-----------+-----------+-----------+-----------+
Row 2 |  a[2][0]  |  a[2][1]  |  a[2][2]  |  a[2][3]  |
      +-----------------------------------------------+
```

多维数组可通过大括号来初始值。例如，定义 3 行 4 列的二维数组并赋初值：

```go
var array2d = [3][4]int {
    {0, 1, 2, 3} ,   //  第一行索引为 0
    {4, 5, 6, 7} ,   //  第二行索引为 1
    {8, 9, 10, 11}   //  第三行索引为 2
}
```

二维数组中的元素可通过 `a[i][j]` 的形式指定坐标来访问，其中 `i` 为行索引，`j` 为列索引。例如，访问第三行的第四个元素（索引从 0 开始）：

```go
int val = a[2][3]
```

二维数组可以使用循环嵌套来输出元素：

```go showLineNumbers title="array_example_04.go"
package main

import "fmt"

func main() {
    /* 数组 - 3 行 4 列 */
    var array2d = [3][4]int {{0, 1, 2, 3}, {4, 5, 6, 7}, {8, 9, 10, 11}}
    var i, j int

    /* 输出数组元素 */
    for  i = 0; i < 3; i++ {
        for j = 0; j < 4; j++ {
            fmt.Printf("a[%d][%d] = %d\n", i, j, array2d[i][j])
        }
    }
}
```

以上实例运行输出结果为：

```bash
a[0][0] = 0
a[0][1] = 1
a[0][2] = 2
a[0][3] = 3
a[1][0] = 4
a[1][1] = 5
a[1][2] = 6
a[1][3] = 7
a[2][0] = 8
a[2][1] = 9
a[2][2] = 10
a[2][3] = 11
```



## 向函数传递数组

如果你想将数组作为参数传递给函数，你需要在函数定义时，声明形参为数组。我们可以通过以下两种方式来声明：

方式一：形参设定数组大小

```go
void myFunction(param [10]int) {
...
}
```

方式二：形参未设定数组大小

```go
void myFunction(param []int) {
...
}
```

请看下面实例，在该实例中函数接收整型数组参数，另一个参数则指定了数组元素的个数，并返回平均值。

```go showLineNumbers
func getAverage(arr []int, size int) float32 {
    var i int
    var avg, sum float32

    for i = 0; i < size; ++i {
        sum += arr[i]
    }

    avg = sum / size
    return avg
}
```

接下来我们来调用这个函数：

```go showLineNumbers title="array_example_05.go"
package main

import "fmt"

func main() {
    /* 数组长度为 5 */
    var array = [5]int {1000, 2, 3, 17, 50}
    var avg float32

    /* 数组作为参数传递给函数 */
    avg = getAverage(array, 5);

    /* 输出返回的平均值 */
    fmt.Printf("平均值为 %f\n", avg);
}

func getAverage(arr [5]int, size int) float32 {
    var i,sum int
    var avg float32

    for i = 0; i < size;i++ {
        sum += arr[i]
    }

    avg = float32(sum) / float32(size)
    return avg;
}
```

以上实例执行输出结果为：

```go
平均值为 214.399994
```

