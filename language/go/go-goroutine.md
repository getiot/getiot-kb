---
sidebar_position: 28
slug: /go-goroutine
---

# Go 语言协程（goroutine）

协程（goroutine）是 Go 语言中一种轻量级的并发执行单元，由 Go 运行时环境（runtime）管理。协程可以理解为一种比线程更轻量级的并发模型，它可以并发执行函数或方法，但消耗的资源更少，并且可以更高效地使用系统资源。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/goroutine) 下载。

:::



## 创建 goroutine

Go 语言中使用 goroutine 非常简单，只需要在函数或者方法前面加上 `go` 关键字就可以创建一个 goroutine，从而让该函数或者方法在新的 goroutine 中执行。

例如：

```go
go hello()
```

匿名函数同样也支持使用 `go` 关键字来创建 `goroutine` 去执行。语法格式如下：

```go
go func() {
    // 协程的执行逻辑
}()
```

注意：一个 goroutine 必定对应一个函数或者方法，你可以创建多个 goroutine 去执行相同的函数或者方法。



## 启动单个 goroutine

启动方式非常简单，我们先来看一个实例：

```go showLineNumbers title="goroutine_example_01.go"
package main

import (
    "fmt"
)

func hello() {
    fmt.Println("Hello")
}

func main() {
    go hello()
    fmt.Println("欢迎来到 GetIoT.tech！")
}
```

以上代码输出结果如下：

```bash
欢迎来到 GetIoT.tech！
```

上述代码执行结果只在终端控制台输出了“欢迎来到 GetIoT.tech！”，并没有打印“Hello”，这是为什么呢 ？

其实在 Go 程序中，会默认为 main 函数创建一个 goroutine，而在上述代码中我们使用 go 关键字创建了一个新的 goroutine 去调用 hello 函数。而此时 main 的 goroutine 还在往下执行中，我们的程序中存在两个并发执行的 goroutine。当 main 函数结束时，整个程序也结束了，所有由 main 函数创建的子 goroutine 也会跟着退出，也就是说我们的 main 函数执行过快退出导致另一个 goroutine 内容还未执行就退出了，导致未能打印出“Hello”。

所以我们这边要想办法让 main 函数等一等，让另一个 goroutine 的内容执行完。其中最简单的方法就是在 main 函数中使用 `time.Sleep` 睡眠一秒钟。

按如下方式修改

```go {15} showLineNumbers title="goroutine_example_01.go"
package main

import (
    "fmt"
    "time"
)

func hello() {
    fmt.Println("Hello")
}

func main() {
    go hello()
    fmt.Println("欢迎来到 GetIoT.tech！")
    time.Sleep(time.Second)
}
```

此时的输出结果为：

```bash
欢迎来到 GetIoT.tech！
Hello
```

那为什么会先打印“欢迎来到 GetIoT.tech！”，再打印“Hello”呢？

这是因为在程序中创建 goroutine 执行函数需要一定的开销，而与此同时 main 函数所在的 goroutine 是继续执行的。



## 使用 sync.WaitGroup

前面的实例虽然使用 `time.sleep` 可以让 Hello 打印出来，但这个方法是不准确的，因为你无法准确计算 goroutine 的运行时间。因此我们需要使用 Go 语言中的 `sync` 包，它为我们提供了一些常用的并发原语。

首先，我们介绍一下 `sync` 包中的 `WaitGroup`。当你并不关心并发操作的结果或者有其他方式收集并发操作的结果时，`WaitGroup` 是实现等待一组并发操作完成的好方法。

我们修改一下前面的示例，如下：

```go showLineNumbers title="goroutine_example_02.go"
package main

import (
    "fmt"
    "sync"
)

var wg sync.WaitGroup

func hello() {
    fmt.Println("Hello")
    defer wg.Done()  // 把计算器-1
}

func main() {
    wg.Add(1)  // 把计数器+1
    go hello()
    fmt.Println("欢迎来到 GetIoT.tech！")
    wg.Wait()  // 阻塞代码的运行，直到计算器为0
}
```

`defer` 语句用于延迟函数或方法的执行，使其在函数执行结束时执行。参见《[Go 语言函数进阶](/go/go-functions-advance/)》。

以上代码输出结果如下：

```bash
欢迎来到 GetIoT.tech！
Hello
```



## 启动多个 goroutine

接下来我们看看如何启动多个 goroutine。请看下面实例：

```go showLineNumbers title="goroutine_example_03.go"
package main

import (
    "fmt"
    "sync"
)

var wg sync.WaitGroup

func hello(i int) {
    fmt.Printf("[%v] Hello, welcome to GetIoT.tech!\n", i)
    defer wg.Done()  // goroutine 结束计数器-1
}

func main() {
    for i := 0; i < 5; i++ {
        go hello(i)
        wg.Add(1)  // 启动一个goroutine计数器+1
    }
    wg.Wait()  // 等待所有的goroutine执行结束
}
```

以上代码执行结果如下：

```bash
[4] Hello, welcome to GetIoT.tech!
[0] Hello, welcome to GetIoT.tech!
[1] Hello, welcome to GetIoT.tech!
[2] Hello, welcome to GetIoT.tech!
[3] Hello, welcome to GetIoT.tech!
```

执行多次上述代码你会发现输出顺序并不一致，这是因为多个 goroutine 都是并发执行的，而 goroutine 的调度是随机的。



## 协程的重要概念

### 动态栈

操作系统的线程一般都有固定的栈内存（通常为2MB），而 Go 语言中的 goroutine 非常轻量级，一个 goroutine 的初始栈空间很小（一般为2KB），所以在 Go 语言中一次创建数万个 goroutine 也是可能的。并且 goroutine 的栈不是固定的，可以根据需要动态地增大或缩小，Go 的 runtime 会自动为 goroutine 分配合适的栈空间。



### goroutine 调度

在经过数个版本迭代之后，目前 Go 语言的调度器采用的是 GPM 调度模型。

- **G** 表示 goroutine，存储了 goroutine 的执行 stack 信息、goroutine 状态以及 goroutine 的任务函数等；另外 G 对象是可以重用的。
- **P** 表示逻辑 processor，P 的数量决定了系统内最大可并行的 G 的数量（前提是系统的物理 CPU 核数 >= P 的数量）；P 的最大作用还是其拥有的各种 G 对象队列、链表、一些 cache 和状态。
- **M** 代表着真正的执行计算资源。在绑定有效的 P 后，进入 schedule 循环；而 schedule 循环的机制大致是从各种队列、P 的本地队列中获取 G，切换到 G 的执行栈上并执行 G 的函数，调用 goexit 做清理工作并回到 M，如此反复。M 并不保留 G 状态，这是 G 可以跨 M 调度的基础。



### GOMAXPROCS

Go 运行时，调度器使用 `GOMAXPROCS` 的参数来决定需要使用多少个 OS 线程来同时执行 Go 代码。默认值是当前计算机的 CPU 核心数。

例如：在一个 8 核处理器的电脑上，`GOMAXPROCS` 默认值为 8。

Go 语言中可以使用 `runtime.GOMAXPROCS()` 函数设置当前程序并发时占用的 CPU 核心数。

