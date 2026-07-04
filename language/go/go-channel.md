---
sidebar_position: 29
slug: /go-channel
---

# Go 语言通道（channel）

上一节我们介绍了协程（goroutine）的概念和用法，但是单纯地将函数并发执行是没有意义的，函数与函数间需要交换数据才能体现并发执行函数的意义。Go 语言为 goroutine 间的数据交换提供了一种简单的方法 —— 通道（channel）。

Go 语言中的通道（channel）是一种特殊的类型。通道像一个传送带或者队列，总是遵循先入先出的规则，保证收发数据的顺序。Go 的每一个通道都是一个具体类型的导管，因此声明 channel 的时候需要为其指定元素类型。同时，通道还提供了同步机制，确保数据在发送和接收之间的安全传递，可以有效地避免竞态条件和死锁等并发问题。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/goroutine) 下载。

:::



## 通道的创建

声明通道类型变量需要使用 `chan` 关键字，语法格式如下：

```go
var 变量名 chan 元素类型
```

注意：声明通道时需要指定元素类型，即通道中传递的元素的类型。

例如：

```go
var a chan int     // 声明一个传递 int 类型数据的通道
var b chan string  // 声明一个传递 string 类型数据的通道
var c chan bool    // 声明一个传递 bool 类型数据的通道
```



## 初始化通道

未经初始化的通道默认值为 `nil`，需要使用 `make()` 函数初始化之后才能使用，语法格式如下：

```go
make(chan 数据类型, [缓冲大小])
```

其中 channel 的缓冲大小是可选的。

例如：

```go
ch := make(chan int)  // 创建一个传递 int 类型数据的通道
ch := make(chan int)  // 创建一个传递 int 类型数据、缓冲大小为10的通道
```



## 通道的操作

通道共有发送、接收、关闭三种操作，而发送和接收操作均用 `<-` 符号，请看下面几个例子。

- 声明通道并初始化

  ```go
  ch := make(chan int)  // 声明一个通道并初始化
  ```

- 给一个通道发送值

  ```go
  ch <- 10  // 把10发送给ch通道
  ```

- 从一个通道中取值

  ```go
  x := <-ch  // x从ch通道中取值
  <-ch       // 从ch通道中取值，忽略结果
  ```

- 关闭通道

  ```go
  close(ch)  // 关闭通道
  ```

注意：一个通道值是可以被垃圾回收掉的。

通道通常由发送方执行关闭操作，并且只有在接收方明确等待通道关闭的信号时才需要执行关闭操作。它和关闭文件不一样，通常在结束操作之后关闭文件是必须要做的，但关闭通道不是必须的。

关闭后的通道有以下特点：

- 对一个关闭的通道再发送值就会导致 panic。
- 对一个关闭的通道进行接收会一直获取值直到通道为空。
- 对一个关闭的并且没有值的通道执行接收操作会得到对应类型的零值。
- 关闭一个已经关闭的通道会导致 panic。



## 无缓冲的通道

无缓冲的通道又称为阻塞的通道，我们来看一下如下代码片段：

```go showLineNumbers title="channel_example_01.go"
package main

import "fmt"

func main() {
    ch := make(chan int)
    ch <- 100
    fmt.Println("发送成功")
}
```

上面这段代码能够通过编译，但是执行时会报错：

```bash
fatal error: all goroutines are asleep - deadlock!

goroutine 1 [chan send]:
main.main()
	/home/rudy/workspace/go-courses/basic/goroutine/channel_example_01.go:7 +0x28
exit status 2
```

`deadlock` 表示我们程序中所有的 goroutine 都被挂起导致程序死锁了，为什么会出现这种情况呢？

这是因为我们创建的是一个无缓冲区的通道，无缓冲的通道只有在有接收方能够接收值的时候才能发送成功，否则会一直处于等待发送的阶段。同理，如果对一个无缓冲通道执行接收操作时，没有任何向通道中发送值的操作那么也会导致接收操作阻塞。

我们可以创建一个 goroutine 去接收值，例如：

```go showLineNumbers title="channel_example_02.go"
package main

import "fmt"

func receive(ch chan int) {
    ret := <-ch
    fmt.Println("接收成功", ret)
}

func main() {
    ch := make(chan int)
    go receive(ch)
    ch <- 100
    fmt.Println("发送成功")
}
```

以上代码执行结果如下：

```bash
接收成功 100
发送成功
```



## 有缓冲区的通道

另外还有一种方法解决上述死锁的问题，那就是使用有缓冲区的通道。我们可以在使用 `make` 函数初始化通道时，为其指定缓冲区大小，例如：

```go {6} showLineNumbers title="channel_example_01.go"
package main

import "fmt"

func main() {
    ch := make(chan int, 1)
    ch <- 100
    fmt.Println("发送成功")
}
```

以上代码执行结果如下：

```
发送成功
```

只要通道的容量大于零，那么该通道就属于有缓冲的通道，通道的容量表示通道中最大能存放的元素数量。当通道内已有元素数达到最大容量后，再向通道执行发送操作就会阻塞，除非有从通道执行接收操作。

:::tip

你可以使用内置的 `len()` 函数获取通道的长度，使用 `cap()` 函数获取通道的容量。

:::



## 判断通道关闭

当向通道中发送完数据时，我们可以通过 `close()` 函数来关闭通道。当一个通道被关闭后，再往该通道发送值会引发panic。从该通道取值的操作会先取完通道中的值。通道内的值被接收完后再对通道执行接收操作得到的值会一直都是对应元素类型的零值。那我们如何判断一个通道是否被关闭了呢？

```go
value, ok := <-ch
```

其中，`value` 是从通道中所取得的值；`ok` 是状态，若通道已关闭，返回 `false`，否则返回 `true`。

以下代码会不断从通道中取值，直到通道被关闭后退出。

```go showLineNumbers title="channel_example_03.go"
package main

import "fmt"

func receive(ch chan int) {
	for {
		v, ok := <-ch
		if !ok {
			fmt.Println("通道已关闭")
			break
		}
		fmt.Printf("v:%#v ok:%#v\n", v, ok)
	}
}

func main() {
	ch := make(chan int, 1)
	ch <- 1
	close(ch)
	receive(ch)
}
```

以上代码执行结果如下：

```bash
v:1 ok:true
通道已关闭
```



## for range 接收值

通常我们会使用 for range 循环来从通道中接收值，当通道关闭后，会在通道内所有值被取完之后退出循环。

前面的示例我们使用 for range 改写，会更加简洁。代码如下：

```go showLineNumbers title="channel_example_04.go"
package main

import "fmt"

func receive(ch chan int) {
	for i := range ch {
		fmt.Printf("v:%v", i)
	}
}

func main() {
	ch := make(chan int, 1)
	ch <- 1
	close(ch)
	receive(ch)
}
```

以上代码执行结果如下：

```go
v:1
```



## 单向通道

在某些场景下我们可能会将通道作为参数在多个任务函数间进行传递，通常我们会选择在不同的任务函数中对通道的使用进行限制，比如限制通道在某个函数中只能执行发送或只能执行接收操作。

```go
<- chan int  // 只接收通道，只能接收不能发送
chan <- int  // 只发送通道，只能发送不能接收
```

例如将示例1的通道修改成只接收通道：

```go {6} showLineNumbers title="channel_example_05.go"
package main

import "fmt"

func main() {
    ch := make(<-chan int, 1)
    ch <- 100
    fmt.Println("发送成功")
}
```

上面这段代码编译时会报错：

```bash
# command-line-arguments
basic/goroutine/channel_example_05.go:7:5: invalid operation: cannot send to receive-only channel ch (variable of type <-chan int)
```



## select 多路复用

在某些场景下，你可能需要同时从多个通道接收数据。通道在接收数据时，如果没有数据可以被接收，那么当前的 goroutine 将会发生阻塞。Go 语言内置了 `select` 关键字，使用它可以同时响应多个通道的操作。

`select` 语句的语法如下：

```go
select {
    case communication clause :
        statement(s)      
    case communication clause :
        statement(s)
    /* 你可以定义任意数量的 case */
    default : /* 可选 */
        statement(s)
}
```

例如：

```go
select {
    case <-ch1:
	    //...
    case data := <-ch2:
	    //...
    case ch3 <- 10:
	    //...
    default:
	    //默认操作
}
```

`select` 语句具有以下特点及注意事项：

- select 语句只能用于通道的读写操作，可以处理一个或多个 channel 的发送/接收操作。
- 执行 select 语句时，所有 channel 表达式都会被求值，所有被发送的表达式也都会被求值。
- 每个 case 都必须是一个通信，如果任意某个通信可以进行，它就执行，其他 case 将被忽略。
- 如果多个 case 同时满足，select 会随机公平地选择一个执行，其他不会执行。
- 如果 case 中有通道值为 `nil` 的读写操作，则该分支将被忽略。
- 如果没有满足条件的 case，同时有 default 子句，则执行 default 语句；如果没有 default 子句，那么 select 将阻塞，直到某个通信可以运行。
- 如果有超时条件语句，判断逻辑为如果在这个时间段内一直没有满足条件的 case，则执行这个超时 case。如果此段时间内出现了可操作的 case，则直接执行这个 case。（一般用超时语句代替了 default 语句）
- 对于空的 select 语句，会引起死锁；对于 for 循环中的 select，也有可能会引起 CPU 占用过高的问题。

请看下面实例，使用 select 语句在终端中打印 1-10 之间的奇数。

```go showLineNumbers title="select_example_01.go"
package main

import "fmt"

func main() {
	ch := make(chan int, 1)  // 创建一个类型为int，缓冲区大小为1的通道

	for i := 1; i <= 10; i++ {
		select {
		case x := <-ch:  // 第一次循环由于没有值，所以该分支不满足
			fmt.Println(x)
		case ch <- i:    // 将i发送给通道(由于缓冲区大小为1，缓冲区已满，第二次不会走该分支)
		}
	}
}
```

以上代码执行结果如下：

```bash
1
3
5
7
9
```

再看一个稍微复杂一点的实例：

```go showLineNumbers title="select_example_02.go"
package main

import (
	"fmt"
	"time"
)

func main() {
	ch1 := make(chan int)
	ch2 := make(chan int)

	go func() {
		time.Sleep(1 * time.Second)
		ch1 <- 1
	}()

	go func() {
		time.Sleep(2 * time.Second)
		ch2 <- 2
	}()

	for {
		select {
		case <-ch1:
			fmt.Println("Received from channel 1")
		case <-ch2:
			fmt.Println("Received from channel 2")
		default:
			// fmt.Println("no communication")
		}
	}
}
```

以上代码执行结果为：

```bash
Received from channel 1
Received from channel 2
```

