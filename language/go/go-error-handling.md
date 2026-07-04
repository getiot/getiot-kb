---
sidebar_position: 25
slug: /go-error-handling
---

# Go 语言错误处理



在 Go 语言中，错误处理是一种常见的编程模式，用于处理可能发生的错误和异常情况。Go 语言通过内置的 `error` 错误接口提供了非常简单的错误处理机制，通过返回错误值来表示函数执行过程中是否出现了错误，并通过标准库中的 `error` 接口来表示错误类型。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/error) 下载。

:::



## 错误接口

Go 语言的错误类型是一个接口类型，即 `error` 接口，它只包含了一个 `Error() string` 方法，用于返回错误的描述信息。`error` 接口的定义如下：

```go
type error interface {
    Error() string
}
```

任何实现了 `Error() string` 方法的类型都可以被视为 `error` 类型的值，用于表示错误。我们可以在编码中通过实现 `error` 接口类型来生成错误信息。



## 错误值

错误值（Error Value）是实现了 `error` 接口的具体类型的值，用于表示函数执行过程中的错误。通常，函数在遇到错误情况时会返回一个 `error` 类型的值，表示函数执行失败。

使用 `errors.New` 可返回一个错误信息，伪代码如下：

```go
func DoSomething() error {
    // 这里是函数执行过程中可能发生的错误
    if /* 发生了错误 */ {
        return errors.New("发生了错误") // 返回一个错误值
    }
    return nil // 函数执行成功，返回 nil 表示没有错误
}
```

下面示例定义了一个 `Sqrt()` 函数，它会返回一个计算结果和一个错误值，如果我们在调用 `Sqrt()` 函数的时候传递的一个负数，然后就得到了 `non-nil` 的 `error` 对象。

```go showLineNumbers
func Sqrt(f float64) (float64, error) {
    if f < 0 {
        return 0, errors.New("math: square root of negative number")
    }
    // 实现
}
```

在调用的时候，可以将接收到的 `error` 对象与 `nil` 比较，如果结果为 `true`，则进入错误处理，比如输出错误。

```go showLineNumbers
result, err := Sqrt(-1)

if err != nil {
    fmt.Println(err)
}
```



## 自定义错误

在实际开发中，通常会根据具体的业务需求定义自定义的错误类型，并通过实现 `Error() string` 方法来表示错误信息。自定义错误可以提供更丰富的错误信息和更精确的错误类型。

自定义错误的语法格式如下：

```go
type MyError struct {
    Msg string
}

func (e *MyError) Error() string {
    return e.Msg
}
```





## 完整示例

下面我们自定义一个 `DivideError` 错误类型，用于抛出除零错误。代码如下：

```go showLineNumbers title="error_example_01.go"
package main

import "fmt"

// 定义一个 DivideError 结构
type DivideError struct {
    dividee int
    divider int
}

// 实现 error 接口
func (de *DivideError) Error() string {
    strFormat := `
    Cannot proceed, the divider is zero.
    dividee: %d
    divider: 0
`
    return fmt.Sprintf(strFormat, de.dividee)
}

// 定义 int 类型除法运算的函数
func Divide(varDividee int, varDivider int) (result int, errorMsg string) {
    if varDivider == 0 {
        dData := DivideError{
            dividee: varDividee,
            divider: varDivider,
        }
        errorMsg = dData.Error()
        return
    } else {
        return varDividee / varDivider, ""
    }
}

func main() {

    // 正常情况
    if result, errorMsg := Divide(100, 10); errorMsg == "" {
        fmt.Println("100/10 = ", result)
    }

    // 当被除数为零的时候会返回错误信息
    if _, errorMsg := Divide(100, 0); errorMsg != "" {
        fmt.Println("errorMsg is: ", errorMsg)
    }
}
```

执行以上程序，输出结果为：

```bash
100/10 =  10
errorMsg is:  
   Cannot proceed, the divider is zero.
  dividee: 100
  divider: 0
```

