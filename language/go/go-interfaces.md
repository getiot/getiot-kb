---
sidebar_position: 24
slug: /go-interfaces
---

# Go 语言接口

在 Go 语言中，接口（Interface）是一种抽象类型，用于定义对象的行为。接口定义了一组方法的集合，但不包含具体的实现。通过接口，可以实现对象的多态性，使得不同类型的对象可以被统一地处理。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/interface) 下载。

:::



## 接口的定义

接口由一组方法签名组成，方法签名定义了方法的名称、参数列表和返回值列表。接口的定义通常以 `type` 关键字和 `interface` 关键字为前缀，语法格式如下：

```go
type interface_name interface {
    method_name1 [return_type]
    method_name2 [return_type]
    method_name3 [return_type]
    ...
    method_namen [return_type]
}
```

你可以在接口中定义任意数量的方法。

举个例子，下面我们定义一个名为 `Shape` 的接口，它包含了两个方法 `Area()` 和 `Perimeter()`，分别用于计算形状的面积和周长。

```go showLineNumbers
type Shape interface {
    Area() float64
    Perimeter() float64
}
```

现在，你有了一个 `Shape` 接口。任何实现了 `Area()` 和 `Perimeter()` 方法的类型都可以被视为 `Shape` 接口的实现类型。



## 接口的实现

在 Go 语言中，不需要显式地声明实现了某个接口，只需要实现了接口中的所有方法即可被认为是该接口的实现。

接口实现的语法格式大致如下：

```go
/* 定义接口 */
type interface_name interface {
    method_name1 [return_type]
    method_name2 [return_type]
    method_name3 [return_type]
    ...
    method_namen [return_type]
}

/* 定义结构体，实现该接口 */
type struct_name struct {
    /* variables */
}

/* 实现接口方法 */
func (struct_name_variable struct_name) method_name1() [return_type] {
    /* 方法实现 */
}

func (struct_name_variable struct_name) method_name2() [return_type] {
    /* 方法实现*/
}

...
```

例如，如果有一个 `Circle` 类型，实现了 `Shape` 接口中定义的 `Area()` 和 `Perimeter()` 方法，那么 `Circle` 类型就是 `Shape` 接口的实现类型。

接口实现代码如下：

```go showLineNumbers
type Circle struct {
    Radius float64
}

func (c Circle) Area() float64 {
    return math.Pi * c.Radius * c.Radius
}

func (c Circle) Perimeter() float64 {
    return 2 * math.Pi * c.Radius
}
```



## 接口的使用

接口可以用作函数的参数类型、返回值类型或变量类型，从而实现多态性。任何实现了接口的类型都可以作为接口类型的值传递给函数，实现了接口的方法将被调用。

下面实例演示了接口的定义、实现和调用过程：

```go showLineNumbers title="circle_shape_example.go"
package main

import (
    "fmt"
    "math"
)

type Shape interface {
    Area() float64
    Perimeter() float64
}

type Circle struct {
    Radius float64
}

func (c Circle) Area() float64 {
    return math.Pi * c.Radius * c.Radius
}

func (c Circle) Perimeter() float64 {
    return 2 * math.Pi * c.Radius
}

func PrintShapeInfo(s Shape) {
    fmt.Println("Area:", s.Area())
    fmt.Println("Perimeter:", s.Perimeter())
}

func main() {
    var c = new(Circle)
    c.Radius = 5.0
    
    PrintShapeInfo(c)
}
```

以上实例运行结果为：

```bash
Area: 78.53981633974483
Perimeter: 31.41592653589793
```



## 空接口

空接口（Empty Interface）是一个不包含任何方法的接口，即接口中没有定义任何方法签名。空接口可以表示任意类型的值，因此被称为最宽泛的接口。

空接口的定义如下：

```go
var any interface{}
```

空接口有以下用途：

- **接收任意类型的值**：空接口可以接收任意类型的值作为参数或赋值给空接口类型的变量。这样，可以在不知道具体类型的情况下，使用空接口来处理各种类型的值，从而实现通用性和灵活性。
- **作为函数参数或返回值**：空接口类型可以作为函数的参数或返回值，从而实现函数接受任意类型的参数或返回任意类型的值。这种特性常用于需要处理多种类型的函数，例如 `fmt` 包中的 `Printf` 函数就接受空接口类型的参数，可以接受任意类型的值。
- **与类型断言结合使用**：空接口与类型断言（Type Assertion）结合使用，可以将接口类型的值断言为特定类型的值，从而获取原始类型的值。这种特性在需要处理接口类型的值时非常有用，例如从 `map` 中取出的值需要判断其原始类型并进行相应的处理。



## 小结

接口是 Go 语言中实现多态性的关键机制，它提供了一种简单而灵活的方式来定义对象的行为。通过接口，可以实现代码的解耦和灵活性的提高。需要注意的是，接口设计应该遵循接口隔离原则，即将接口设计得小而精简，而不应该包含过多的方法。
