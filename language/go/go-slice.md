---
sidebar_position: 19
slug: /go-slice
---

# Go 语言切片（Slice）

在 Go 语言中，切片（Slice）是对数组的一种抽象，它提供了一种方便、灵活且高效的方式来操作序列化的数据集合。在实现上，切片本质上是对底层数组的一个引用。

我们知道，Go 数组定义好之后，其长度就不可改变。这种特性在某些场景就不太适用，因此 Go 提供了一种灵活，功能强悍的内置类型 —— 切片。与数组相比，切片的长度是不固定的，它可以动态增长或缩减，并且支持自动扩容。当追加元素时，切片的容量就会增大。因此，切片也被称为“动态数组”。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/slice) 下载。

:::

## 定义切片

由于切片不需要说明长度，因此一个简单的方法是通过声明一个未指定大小的数组来定义切片：

```go
var identifier []type
```

或使用 `make()` 函数来创建切片：

```go
var slice1 []type = make([]type, len)
```

也可以简写为：

```go
slice1 := make([]type, len)
```

在 Go 语言中，`make()` 函数用于创建动态的数据结构，如切片、映射和通道。其定义如下：

```go
make([]T, length, capacity)
```

其中，`len` 是切片的长度，表示当前切片中元素的个数；而 `capacity` 是切片的容量，是一个可选参数，表示切片底层数组的大小。如果不指定容量，则默认与长度相同。

:::tip

切片的长度（length）和容量（capacity）的区别是，切片的长度会随着元素的增加或删除而动态变化，但切片的容量不会，除非进行了重新分配或扩容操作。

:::



## 切片初始化

你可以在定义切片的时候直接对其进行初始化，例如：

```go
s :=[] int {1,2,3 }
```

这里，`[]` 表示是切片类型，`{1,2,3}` 初始化值依次是 1、2、3，此时 cap = len = 3。

初始化切片 `s`，是数组 `arr` 的引用：

```go
s := arr[:]
```

将 `arr` 中从下标 `startIndex` 到 `endIndex-1` 下的元素创建为一个新的切片：

```go
s := arr[startIndex:endIndex]
```

缺省 `endIndex` 时将表示一直到 `arr` 的最后一个元素：

```go
s := arr[startIndex:]
```

缺省 `startIndex` 时将表示从 `arr` 的第一个元素开始：

```go
s := arr[:endIndex]
```

通过切片 `s` 初始化切片 `s1`：

```go
s1 := s[startIndex:endIndex]
```

通过内置函数 `make()` 初始化切片 `s`，`[]int` 表示其元素类型为 `int` 的切片：

```go
s :=make([]int, len, cap)
```



## len() 和 cap() 函数

切片是可索引的，并且可以由 `len()` 方法获取长度。

切片提供了计算容量的方法 `cap()` 可以测量切片最长可以达到多少。

以下为具体实例：

```go showLineNumbers title="slice_example_01.go"
package main

import "fmt"

func main() {
    var numbers = make([]int, 3, 5)

    printSlice(numbers)
}

func printSlice(x []int){
    fmt.Printf("len=%d cap=%d slice=%v\n", len(x), cap(x), x)
}
```

以上实例运行输出结果为:

```bash
len=3 cap=5 slice=[0 0 0]
```



## 空（nil）切片

一个切片在未初始化之前默认为 `nil`，长度为 0，实例如下：

```go showLineNumbers title="slice_example_02.go"
package main

import "fmt"

func main() {
    var numbers []int

    printSlice(numbers)

    if(numbers == nil){
        fmt.Println("切片是空的")
    }
}

func printSlice(x []int){
    fmt.Printf("len=%d cap=%d slice=%v\n", len(x), cap(x), x)
}
```

以上实例运行输出结果为:

```bash
len=0 cap=0 slice=[]
切片是空的
```



## 切片截取

可以通过设置下限及上限来设置截取切片 `[lower-bound:upper-bound]`，实例如下：

```go showLineNumbers title="slice_example_03.go"
package main

import "fmt"

func main() {
    /* 创建切片 */
    numbers := []int{0,1,2,3,4,5,6,7,8}   
    printSlice(numbers)

    /* 打印原始切片 */
    fmt.Println("numbers ==", numbers)

    /* 打印子切片从索引1(包含) 到索引4(不包含)*/
    fmt.Println("numbers[1:4] ==", numbers[1:4])

    /* 默认下限为 0*/
    fmt.Println("numbers[:3] ==", numbers[:3])

    /* 默认上限为 len(s)*/
    fmt.Println("numbers[4:] ==", numbers[4:])

    numbers1 := make([]int,0,5)
    printSlice(numbers1)

    /* 打印子切片从索引  0(包含) 到索引 2(不包含) */
    number2 := numbers[:2]
    printSlice(number2)

    /* 打印子切片从索引 2(包含) 到索引 5(不包含) */
    number3 := numbers[2:5]
    printSlice(number3)
}

func printSlice(x []int) {
    fmt.Printf("len=%d cap=%d slice=%v\n",len(x),cap(x),x)
}
```

执行以上代码输出结果为：

```bash
len=9 cap=9 slice=[0 1 2 3 4 5 6 7 8]
numbers == [0 1 2 3 4 5 6 7 8]
numbers[1:4] == [1 2 3]
numbers[:3] == [0 1 2]
numbers[4:] == [4 5 6 7 8]
len=0 cap=5 slice=[]
len=2 cap=9 slice=[0 1]
len=3 cap=7 slice=[2 3 4]
```



## append() 和 copy() 函数

如果想增加切片的容量，我们必须创建一个新的更大的切片并把原分片的内容都拷贝过来。

下面实例演示了如何使用 `copy` 方法拷贝切片，以及使用 `append` 方法向切片追加新元素。

```go showLineNumbers title="slice_example_04.go"
package main

import "fmt"

func main() {
    var numbers []int
    printSlice(numbers)

    /* 允许追加空切片 */
    numbers = append(numbers, 0)
    printSlice(numbers)

    /* 向切片添加一个元素 */
    numbers = append(numbers, 1)
    printSlice(numbers)

    /* 同时添加多个元素 */
    numbers = append(numbers, 2, 3, 4)
    printSlice(numbers)

    /* 创建切片 numbers1 是之前切片的两倍容量*/
    numbers1 := make([]int, len(numbers), (cap(numbers))*2)

    /* 拷贝 numbers 的内容到 numbers1 */
    copy(numbers1, numbers)
    printSlice(numbers1)   
}

func printSlice(x []int) {
    fmt.Printf("len=%d cap=%d slice=%v\n", len(x), cap(x), x)
}
```

以上代码执行输出结果为：

```bash
len=0 cap=0 slice=[]
len=1 cap=1 slice=[0]
len=2 cap=2 slice=[0 1]
len=5 cap=6 slice=[0 1 2 3 4]
len=5 cap=12 slice=[0 1 2 3 4]
```
