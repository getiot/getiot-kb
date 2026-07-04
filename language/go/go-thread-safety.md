---
sidebar_position: 30
slug: /go-thread-safety
---

# Go 语言并发安全和锁

在 Go 程序中除了使用通道（channel），还可以使用传统的共享内存等方式在多个 goroutine 间进行数据交换。但是，多个 goroutine 同时操作一个资源（临界区）时容易发生竞态问题。为了保证数据交换的正确性，很多并发模型中必须使用互斥锁对内存进行加锁，本节我们就来学习如何使用 Go 语言的锁机制。不过，这种做法可能会造成性能问题，使用时要多加注意。

:::tip

本文所有示例代码可在 [GitHub](https://github.com/getiot/go-courses/tree/main/basic/goroutine) 下载。

:::



## 并发安全

有时候我们的代码中可能会存在多个 goroutine 同时操作一个资源的情况，这种情况下就会发生数据读写错乱的问题。

请看下面实例：

```go showLineNumbers title="sync_example_01.go"
package main

import (
	"fmt"
	"sync"
)

var (
	x int64
	wg sync.WaitGroup // 等待组
)

// add 对全局变量x执行50000次加1操作
func add() {
	for i := 0; i < 50000; i++ {
		x = x + 1
	}
	wg.Done()
}

func main() {
	wg.Add(2)
	go add()
	go add()
	wg.Wait()
	fmt.Println(x)
}
```

我们将上述代码执行多次，不出意外会输出许多不同的结果，这是为什么呢？

因为在上述代码中，我们开启了两个 goroutine 去执行 `add` 函数，某个 goroutine 对全局变量 `x` 的修改可能会覆盖掉另外一个 goroutine 中的操作，所以导致结果与预期不符。



## 互斥锁

互斥锁是一种常用的控制共享资源访问的方法，它能够保证同一时间只有一个 goroutine 可以访问共享资源。Go 语言中使用 `sync` 包中提供的 `Mutex` 类型来实现互斥锁。

下面实例使用互斥锁限制每次只有一个 goroutine 能修改全局变量 `x`，从而解决上述问题。

```go showLineNumbers title="sync_example_02.go"
package main

import (
	"fmt"
	"sync"
)

var (
	x  int64
	wg sync.WaitGroup
	m  sync.Mutex // 互斥锁
)

func add() {
	for i := 0; i < 50000; i++ {
		m.Lock()    // 修改前加锁
		x = x + 1
		m.Unlock()  // 修改后解锁
	}
	wg.Done()
}

func main() {
	wg.Add(2)
	go add()
	go add()
	wg.Wait()
	fmt.Println(x)
}
```

将上述代码编译后多次执行，最终结果都会是 10000。

使用互斥锁能够保证同一时间有且只有一个 goroutine 进入临界区，其他的 goroutine 则在等待锁；当互斥锁释放后，等待的 goroutine 才可以获取锁进入临界区，多个 goroutine 同时等待一个锁时，唤醒的策略是随机的。



## 读写互斥锁

互斥锁是完全互斥的，但是实际上有很多场景是读多写少的，当我们并发的去读取一个资源而不涉及资源修改的时候是没有必要加互斥锁的，这种场景下使用读写锁是更好的一种选择。在 Go 语言中使用 `sync` 包中的 `RWMutex` 类型来实现读写互斥锁。

读写锁分为两种，即读锁和写锁。当一个 goroutine 获取到读锁之后，其他的 goroutine 如果是获取读锁会继续获得锁，如果是获取写锁就会等待；而当一个 goroutine 获取写锁之后，其他的 goroutine 无论是获取读锁还是写锁都会等待。

请看下面实例：

```go showLineNumbers title="sync_example_03.go"
package main

import (
	"fmt"
	"sync"
	"time"
)

var (
	x  = 0
	wg sync.WaitGroup
	// lock sync.Mutex
	rwlock sync.RWMutex
)

func read() {
	defer wg.Done()
	// lock.Lock()
	rwlock.RLock()
	fmt.Println(x)
	time.Sleep(time.Millisecond)
	rwlock.RUnlock()
	// lock.Unlock()
}

func write() {
	defer wg.Done()
	rwlock.Lock()
	// lock.Lock()
	x += 1
	time.Sleep(time.Millisecond * 5)
	rwlock.Unlock()
	// lock.Unlock()
}

func main() {
	start := time.Now()
	for i := 0; i < 10; i++ {
		go write()
		wg.Add(1)
	}
	time.Sleep(time.Second)
	for i := 0; i < 1000; i++ {
		go read()
		wg.Add(1)
	}
	wg.Wait()
	fmt.Println(time.Since(start))
}
```

这是一个读多写少的场景，可以体现出 `sync.RWMutex` 相较于 `sync.Mutex` 的优势。读写锁非常适合读多写少的场景，但如果读和写的操作差别不大，读写锁的优势就发挥不出来了。

在开发过程中，你可以根据具体的业务场景来选择应该使用互斥锁还是读写锁。
