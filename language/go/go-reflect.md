---
sidebar_position: 26
slug: /go-reflect
---

# Go 语言反射（Reflect）

在 Go 语言中，反射（Reflect）是一种在运行时检查变量类型和值的机制，它允许程序在运行时动态地操作对象的属性、调用对象的方法以及获取对象的类型信息等。反射是一种强大而灵活的工具，常用于实现通用算法、处理未知类型的数据和实现元编程等场景。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/reflect) 下载。

:::



## 基本概念

- 反射是 Go 语言提供的一种机制，通过反射机制，你可以在不知道具体类型的情况下查看变量类型。
- 反射是指在运行时检查变量类型和值的能力，通常包括获取类型信息、获取字段值、调用方法等操作。
- 在 Go 语言中，反射由 `reflect` 包提供支持，该包提供了一组函数和类型来实现反射操作。



## 通过反射获取类型

使用 `reflect.TypeOf()` 函数可以获取接口中保存的值的类型信息，它将返回一个 `reflect.Type` 类型的值。

请看下面实例：

```go showLineNumbers title="reflect_example_01.go"
package main

import (
    "fmt"
    "reflect"
)

func main() {
    var a float32 = 6
    var b bool = true
    var c *int
    d := "getiot.tech"
    e := make(map[string]string)

    fmt.Println(reflect.TypeOf(a))
    fmt.Println(reflect.TypeOf(b))
    fmt.Println(reflect.TypeOf(c))
    fmt.Println(reflect.TypeOf(d))
    fmt.Println(reflect.TypeOf(e))
    fmt.Println(reflect.TypeOf(nil))
}
```

以上代码执行结果如下：

```bash
float32
bool
*int
string
map[string]string
<nil>
```

注意：`reflect.Typeof(nil)` 会返回 `nil`。



## 通过反射获取值

使用 `reflect.ValueOf()` 函数可以获取接口中保存的值的反射值，它将返回一个 `reflect.Value` 类型的值。通过 `reflect.Value` 可以获取字段值、设置字段值、调用方法等操作。

请看下面实例：

```go showLineNumbers title="reflect_example_02.go"
package main

import (
    "fmt"
    "reflect"
)

func main() {
    var a float32 = 6
    var b bool = true
    var c *int
    d := "getiot.tech"
    e := make(map[string]string)

    fmt.Println(reflect.ValueOf(a))
    fmt.Println(reflect.ValueOf(b))
    fmt.Println(reflect.ValueOf(c))
    fmt.Println(reflect.ValueOf(d))
    fmt.Println(reflect.ValueOf(e))
    fmt.Println(reflect.ValueOf(nil))
}
```

以上代码执行结果如下：

```bash
6
true
<nil>
getiot.tech
map[]
<invalid reflect.Value>
```

注意：`reflect.ValueOf(nil)` 返回 `Value` 的零值。

再看下面实例，演示了如何获取结构体变量的反射值：

```go showLineNumbers title="reflect_example_03.go"
package main

import (
    "fmt"
    "reflect"
)

type Person struct {
    Name string
    Age int
}

func main() {
    person := Person{"Rudy", 30}

    v := reflect.ValueOf(person) // 获取变量 person 的反射值
    fmt.Println(v.FieldByName("Name").String()) // 输出名字
    fmt.Println(v.FieldByName("Age").Int())     // 输出年龄
}
```

以上代码执行结果如下：

```bash
Rudy
30
```



## 通过反射设置值

使用 `reflect.Value` 的 `Set()` 方法可以设置结构体字段的值。需要注意的是，只有可导出的字段才能被设置，否则会导致运行时错误。

请看下面实例：

```go showLineNumbers title="reflect_example_04.go"
package main

import (
    "fmt"
    "reflect"
)

type Person struct {
    Name string
    Age int
}

func main() {
    person := Person{"Rudy", 30}
    
    // 获取变量 person 的可设置的反射值，反射中使用 Elem() 方法获取指针所指向的值
    v := reflect.ValueOf(&person).Elem()

    v.FieldByName("Name").SetString("Tina") // 设置 Name 字段的值
    v.FieldByName("Age").SetInt(18)         // 设置 Age 字段的值

    fmt.Println(v.FieldByName("Name").String()) // 输出名字
    fmt.Println(v.FieldByName("Age").Int())     // 输出年龄
}
```

以上代码执行结果如下：

```bash
Tina
18
```



## 通过反射调用方法

使用`reflect.Value`的`MethodByName()`方法可以调用结构体的方法。方法的名称必须是可导出的，否则会导致运行时错误。

请看下面实例：

```go showLineNumbers title="reflect_example_05.go"
package main

import (
    "fmt"
    "reflect"
)

type Person struct {
    Name string
    Age int
}

func (p Person) SayHello() {
    fmt.Printf("Hello, my name is %s and I'm %d years old.\n", p.Name, p.Age)
}

func main() {
    person := Person{"Rudy", 30}

    v := reflect.ValueOf(person) // 获取变量 x 的反射值
    m := v.MethodByName("SayHello") // 获取名称为 MethodName 的方法

    if m.IsValid() { // 判断方法是否有效
        m.Call(nil) // 调用 SayHello 方法
    } else {
        fmt.Println("Method not found.")
    }
}
```

以上代码执行结果如下：

```bash
Hello, my name is Rudy and I'm 30 years old.
```



## 注意事项

1. 反射是一种强大而灵活的机制，但也有一定的性能开销和复杂度，基于反射的代码会比正常的代码运行速度慢一到两个数量级。
2. 在使用反射时，需要注意性能和安全性，并尽量避免滥用反射，以免导致代码难以维护和理解。通常情况下，应该优先考虑使用静态类型，只有在必要的情况下才使用反射。

