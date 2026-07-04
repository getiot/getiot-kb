---
sidebar_position: 20
slug: /go-map
---

# Go 语言集合（Map）

在 Go 语言中，Map 是一种无序的键值对集合，也称为字典、映射或关联数组。它提供了一种快速查找和检索值的方式，类似于其他编程语言中的哈希表或字典。Map 中的每个键都是唯一的，且与一个值关联。

和数组不同，Map 最重要的一点是通过 key 来快速检索数据，key 类似于索引，指向数据的值。这个特性使得它适合用于存储无序的数据。Map 是一种集合，所以你可以像迭代数组和切片那样迭代它。不过由于 map 是无序的，所以我们无法决定它的返回顺序，这是因为 map 是使用 hash 表来实现的。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/map) 下载。

:::

## 定义和初始化

你可以使用 `map` 关键字来声明一个集合，格式如下：

```go
var map_variable map[key_data_type]value_data_type
```

例如声明一个名为 scores 的集合，键和值的类型分别为 `string` 和 `int`，分别代表学生名字和成绩：

```go
var scores map[string]int
```

不过，此时的 scores 是一个空的（`nil`）集合，还不能使用。你需要通过 `make()` 函数初始化该集合，或者直接对其进行初始化。

你可以在声明集合的同时进行初始化，例如：

```go
scores := map[string]int{
    "Alice": 90,
    "Bob":   85,
    "Carol": 95,
}
```

如果你还没有准备好集合的数据，也可以使用内建函数 `make()` 对集合进行初始化，格式如下：

```go
map_variable = make(map[key_data_type]value_data_type)
```

例如：

```go
var scores map[string]int
scores = make(map[string]int)
```

初始化之后就可以通过如下方式为该集合添加元素：

```go
scores["Alice"] = 90
scores["Bob"] = 85
scores["Carol"] = 95
```

注意：如果键不存在，会添加一个键值对；如果键已存在，则修改该键的值。



## 使用集合

下面通过一个实例，演示如何创建、添加、修改以及遍历集合。代码如下：

```go showLineNumbers title="map_example_01.go"
package main

import "fmt"

func main() {
    var scores map[string]int

    /* 创建集合 */
    scores = make(map[string]int)

    /* 添加初始数据 */
    scores = map[string]int{
        "Alice": 90,
        "Bob":   85,
        "Carol": 95,
    }

    /* 插入新数据 */
    scores["David"] = 80

    /* 修改数据 */
    scores["Bob"] = 70
   
    /* 遍历集合，使用 key 输出 map 值 */
    for name := range scores {
        fmt.Printf("%8s : %d\n", name, scores[name])
    }
}
```

以上实例运行结果为：

```bash
   Alice : 90
     Bob : 70
   Carol : 95
   David : 80
```



## 删除键值对

使用 `delete()` 函数可以删除集合中的元素，参数为 map 和其对应的 key。

请看下面实例：

```go showLineNumbers title="map_example_02.go"
package main

import "fmt"

func main() {
    var scores map[string]int

    /* 创建集合 */
    scores = make(map[string]int)

    /* 添加初始数据 */
    scores = map[string]int{"Alice": 90, "Bob": 85, "Carol": 95}

    /* 遍历集合，使用 key 输出 map 值 */
    for name := range scores {
        fmt.Printf("%8s : %d\n", name, scores[name])
    }

    fmt.Println("----------------")

    /* 删除数据 */
    delete(scores, "Bob")
   
    /* 再次输出 */
    for name := range scores {
        fmt.Printf("%8s : %d\n", name, scores[name])
    }
}
```

以上实例运行结果为：

```bash
   Alice : 90
     Bob : 85
   Carol : 95
----------------
   Alice : 90
   Carol : 95
```



## 检查键是否存在

在使用 map 集合时，检查键是否存在是一种常见的需求。

如果我们想获得集合中某个 key 对应的值，可以这样写：

```go
score := scores["Alice"]
```

其实，访问键值时还有第二个返回值，用于表示该键是否存在。例如：

```go
score, ok := scores["Alice"]
```

请看下面实例：

```go showLineNumbers title="map_example_03.go"
package main

import "fmt"

func main() {
    var scores map[string]int

    /* 初始化 */
    scores = map[string]int{
        "Alice": 90,
        "Bob":   85,
        "Carol": 95,
    }

    // scores["David"] = 80

    checkKey(scores, "Alice")
    checkKey(scores, "David")
}

func checkKey(scores map[string]int, name string) {

    /* 查看元素在集合中是否存在 */
    score, ok := scores[name]

    /* 如果 ok 是 true, 则存在，否则不存在 */
    if (ok) {
        fmt.Printf("%s's score is %d\n", name, score)
    } else {
        fmt.Printf("%s doesn't exist\n", name) 
    }
}
```

由于集合 scores 中不存在 "David"，因此以上实例运行结果为：

```bash
Alice's score is 90
David doesn't exist
```

如果你只关心键是否存在，可以使用 `_` 忽略掉键值对的值。例如下面代码，函数 `isKeyExisted()` 用于判断键是否存在。

```go showLineNumbers
func isKeyExisted(scores map[string]int, key string) bool {
    _, ok := scores[key]
    return ok
}
```



## 空集合

`map` 的零值是 `nil`，如果声明了一个集合但未初始化，那么它的值就是 `nil`，即空的集合。为了安全起见，你可以在使用集合之前判断它是否为空。

下面代码判断集合 scores 是否为空，如果为空，则初始化它：

```go
var scores map[string]int
if scores == nil {
    scores = make(map[string]int)
}
```



## 注意事项

- **`map` 的键类型必须是可比较的**：`map` 的键类型必须支持相等性比较操作，因为 `map` 是根据键来进行索引和查找的。常见的可比较类型包括基本类型（如整数、浮点数、字符串）、指针、数组和结构体。切片、函数和包含切片的结构体等类型是不可比较的，因此不能作为 `map` 的键。
- **避免在并发环境下修改 `map`**：`map` 不是并发安全的，即在多个 goroutine 同时对同一个集合进行读写操作可能会导致数据竞态和未定义的行为。在并发环境下使用 `sync.Map` 等并发安全的数据结构，或者通过加锁等手段来保护 `map` 的并发访问。
- **`map` 的容量不固定**：与切片不同，`map` 的容量是动态增长的，不需要事先指定容量。`map` 的容量会根据插入的键值对动态调整，因此不需要担心容量不足的问题。
