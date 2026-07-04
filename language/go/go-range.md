---
sidebar_position: 21
slug: /go-range
---

# Go 语言范围（Range）

在 Go 语言中，`range` 关键字用于迭代数组（array）、切片（slice）、集合（map）、通道（channel）或字符串等数据结构。它提供了一种简洁、安全、直观的方式来遍历集合中的元素。使用 `range` 表达式，可以有效减少代码的冗余和错误。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/range) 下载。

:::

## Range 返回值

`range` 表达式返回一个值或两个值，其中第二个值是可选的。

- 在数组、切片、字符串中，会返回索引和元素值；
- 在集合（映射）中，会返回键值对的键，也就是 key-value 对的 key 值；
- 在通道中，则返回通道中的发送值。

如果在 `range` 表达式的左侧只使用了一个值，那么这个值是下表中的第一个值。

|           | range 表达式                | 第一个值     | 第二个值（可选的） |
| --------- | --------------------------- | ------------ | ------------------ |
| 数组/切片 | `Array` 或者 `slice a [n]E` | 索引 `i int` | `a[i] E`           |
| 字符串    | `String s string type`      | 索引 `i int` | `rune int`         |
| 集合/映射 | `map m map[K]V`             | 键 `k K`     | 值 `m[k] V`        |
| 通道      | `channel c chan E`          | 元素 `e E`   | `none`             |

提示：在迭代过程中，可以选择性地使用 `_` 来忽略不需要的变量。



## 遍历数组和切片

请看下面实例，`range numbers` 将迭代数组 `numbers` 中的每个元素，`index` 表示元素的索引，`value` 表示元素的值。

```go showLineNumbers title="range_example_01.go"
package main

import "fmt"

func main() {
    numbers := []int{10, 20, 30, 40, 50}
    
    for index, value := range numbers {
        fmt.Printf("index: %d, value: %d\n", index, value)
    }
}
```

以上实例运行结果为：

```bash
index: 0, value: 10
index: 1, value: 20
index: 2, value: 30
index: 3, value: 40
index: 4, value: 50
```



## 遍历集合（map）

请看下面实例，`range ages` 将迭代集合 `ages` 中的每个键值对，`name` 表示键，`age` 表示值。

```go showLineNumbers title="range_example_02.go"
package main

import "fmt"

func main() {
    ages := map[string]int{"Alice": 30, "Bob": 25, "Carol": 35}
    
    for name, age := range ages {
        fmt.Printf("%s is %d years old\n", name, age)
    }
}
```

以上实例运行结果为：

```bash
Alice is 30 years old
Bob is 25 years old
Carol is 35 years old
```



## 遍历字符串

请看下面实例，`range str` 将迭代字符串 `str` 中的每个字符，`index` 表示字符的索引，`char` 表示字符的 Unicode 码值。

```go showLineNumbers title="range_example_03.go"
package main

import "fmt"

func main() {
    str := "GetIoT"
    
    for index, char := range str {
        fmt.Printf("index: %d, char: %c\n", index, char)
    }
}
```

以上实例运行结果为：

```bash
index: 0, char: G
index: 1, char: e
index: 2, char: t
index: 3, char: I
index: 4, char: o
index: 5, char: T
```



## 遍历通道（channel）

请看下面实例，`range ch` 迭代通道 `ch` 中的每个发送值，直到通道关闭。

```go showLineNumbers title="range_example_04.go"
package main

import "fmt"

func main() {
    ch := make(chan int)
    
    go func() {
        for i := 0; i < 5; i++ {
            ch <- i
        }
        close(ch)
    }()
    
    for value := range ch {
        fmt.Println(value)
    }
}
```

以上实例运行结果为：

```bash
0
1
2
3
4
```

关于通道的更多内容，我们将在 [Go 语言通道](/go/go-channel/) 详细介绍。
