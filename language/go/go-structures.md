---
sidebar_position: 17
slug: /go-structures
---

# Go 语言结构体

在 Go 语言中，结构体（struct）是一种用户自定义的数据类型，具有相同类型或不同类型的数据构成的数据集合，常用于表示一组相关的字段。结构体可以包含零个或多个字段，每个字段可以是任意类型的数据，包括基本类型、数组、切片、结构体等。结构体允许将多个字段组合在一起，形成一个更大的数据结构，用于表示复杂的数据。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/struct) 下载。

:::

## 定义结构体

结构体定义需要使用 `type` 和 `struct` 语句。其中，`type` 语句用于设定结构体的名称，`struct` 语句用于定义一个新的数据类型，即结构体中的具体成员和类型。

定义结构体的格式如下：

```go
type struct_variable_type struct {
    member definition
    member definition
    ...
    member definition
}
```

一旦定义了结构体类型，它就能用于变量的声明，语法格式如下：

```go
variable_name := structure_variable_type {value1, value2 ... valuen}
```

假设我们想要定义一个结构体，用于记录图书馆中每本图书的信息，图书具有 Title（标题）、Author（作者）、Subject（学科）、ID（书籍 ID）四个属性。那么，我们可以定义一个 `Books` 结构体，如下：

```go showLineNumbers title="Books 结构体"
type Books struct {
    title string
    author string
    subject string
    book_id int
}
```



## 访问结构体成员

如果要访问结构体成员，需要使用点号（`.`）操作符，格式为："结构体.成员名"。

结构体类型变量使用 `struct` 关键字定义，实例如下：

```go showLineNumbers title="struct_example_01.go"
package main

import "fmt"

type Books struct {
    title string
    author string
    subject string
    book_id int
}

func main() {
    var book1 Books  /* 声明 book1 为 Books 类型 */
    var book2 Books  /* 声明 book2 为 Books 类型 */

    /* book 1 描述 */
    book1.title = "Go 语言"
    book1.author = "getiot.tech"
    book1.subject = "Go 基础教程"
    book1.book_id = 978495407

    /* book 2 描述 */
    book2.title = "Python 语言"
    book2.author = "getiot.tech"
    book2.subject = "Python 基础教程"
    book2.book_id = 978495700

    /* 打印图书信息 */
    fmt.Printf("       |     title    |    author   |      subject     |   book_id\n")
    fmt.Printf("-------+-------------------------------------------------------------\n")
    fmt.Printf("Book 1 | %10s | %10s | %12s | %10d\n", book1.title, book1.author, book1.subject, book1.book_id)
    fmt.Printf("Book 2 | %10s | %10s | %12s | %10d\n", book2.title, book2.author, book2.subject, book2.book_id)
    fmt.Printf("-------+-------------------------------------------------------------\n")
}
```

以上实例执行运行结果为：

```bash
       |    title    |    author   |     subject     |   book_id
-------+-------------------------------------------------------------
Book 1 |      Go 语言 | getiot.tech |      Go 基础教程 |  978495407
Book 2 |  Python 语言 | getiot.tech |  Python 基础教程 |  978495700
-------+-------------------------------------------------------------
```



## 结构体作为函数参数

你可以像其他数据类型一样，将结构体类型作为参数传递给函数。下面实例，我们增加了 `printBook` 函数，该函数接收一个 Books 结构体类型的参数。

```go showLineNumbers title="struct_example_02.go"
package main

import "fmt"

type Books struct {
    title string
    author string
    subject string
    book_id int
}

var index int = 1

func main() {
    var book1 Books  /* 声明 book1 为 Books 类型 */
    var book2 Books  /* 声明 book2 为 Books 类型 */

    /* book 1 描述 */
    book1.title = "Go 语言"
    book1.author = "getiot.tech"
    book1.subject = "Go 基础教程"
    book1.book_id = 978495407

    /* book 2 描述 */
    book2.title = "Python 语言"
    book2.author = "getiot.tech"
    book2.subject = "Python 基础教程"
    book2.book_id = 978495700

    /* 打印图书信息 */
    fmt.Printf("       |     title    |    author   |      subject     |   book_id\n")
    fmt.Printf("-------+-------------------------------------------------------------\n")
    printBook(book1)
    printBook(book2)
    fmt.Printf("-------+-------------------------------------------------------------\n")
}

func printBook(book Books) {
    fmt.Printf("Book %d | %10s | %10s | %12s | %10d\n", index, book.title, book.author, book.subject, book.book_id)
    index++
}
```

以上实例执行运行结果为：

```bash
       |    title    |    author   |     subject     |   book_id
-------+-------------------------------------------------------------
Book 1 |      Go 语言 | getiot.tech |      Go 基础教程 |  978495407
Book 2 |  Python 语言 | getiot.tech |  Python 基础教程 |  978495700
-------+-------------------------------------------------------------
```



## 结构体指针

在前面的实例中，结构体传递给函数是值传递方式，相当于将实参的结构体拷贝一份给形参。因此，函数内部对该结构体变量进行的修改无法同步到实参当中，解决办法是使用结构体指针进行参数传递。

你可以定义指向结构体的指针类似于其他指针变量，格式如下：

```go
var book_ptr *Books
```

以上定义的指针变量可以存储结构体变量的地址。查看结构体变量地址，可以将 `&` 符号放置于结构体变量前：

```go
book_ptr = &Book1
```

使用结构体指针访问结构体成员，使用 `.` 操作符：

```go
book_ptr.title
```

接下来让我们使用结构体指针重写以上实例，代码如下：

```go showLineNumbers title="struct_example_03.go"
package main

import "fmt"

type Books struct {
    title string
    author string
    subject string
    book_id int
}

var index int = 1

func main() {
    var book1 Books  /* 声明 book1 为 Books 类型 */
    var book2 Books  /* 声明 book2 为 Books 类型 */

    /* book 1 描述 */
    book1.title = "Go 语言"
    book1.author = "getiot.tech"
    book1.subject = "Go 基础教程"
    book1.book_id = 978495407

    /* book 2 描述 */
    book2.title = "Python 语言"
    book2.author = "getiot.tech"
    book2.subject = "Python 基础教程"
    book2.book_id = 978495700

    /* 打印图书信息 */
    fmt.Printf("       |     title    |    author   |      subject     |   book_id\n")
    fmt.Printf("-------+-------------------------------------------------------------\n")
    printBook(&book1)
    printBook(&book2)
    fmt.Printf("-------+-------------------------------------------------------------\n")
}

func printBook(book *Books) {
    fmt.Printf("Book %d | %10s | %10s | %12s | %10d\n", index, book.title, book.author, book.subject, book.book_id)
    index++
}
```

以上实例执行运行结果为：

```bash
       |     title    |    author   |      subject     |   book_id
-------+-------------------------------------------------------------
Book 1 |      Go 语言 | getiot.tech |      Go 基础教程 |  978495407
Book 2 |  Python 语言 | getiot.tech |  Python 基础教程 |  978495700
-------+-------------------------------------------------------------
```

