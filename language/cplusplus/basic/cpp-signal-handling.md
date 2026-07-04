---
sidebar_position: 49
slug: /cpp-signal-handling
---

# C++ 信号处理



信号（signal）是一种进程间通信机制，它给应用程序提供一种异步的软件中断，使应用程序有机会接受其他程序或终端发送的命令（即信号）。



## 信号

应用程序收到信号后，有三种处理方式：忽略，默认，或捕捉。

进程收到一个信号后，会检查对该信号的处理机制。

- 如果是 `SIG_IGN`，就忽略该信号；
- 如果是 `SIG_DFT`，则会采用系统默认的处理动作，通常是终止进程或忽略该信号；
- 如果给该信号指定了一个处理函数（捕捉），则会中断当前进程正在执行的任务，转而去执行该信号的处理函数，返回后再继续执行被中断的任务。

在 UNIX、Linux、Mac OS X 或 Windows 系统上，可以通过按 `Ctrl+C` 产生中断。



## 信号列表

有些信号不能被程序捕获，但是下表所列信号可以在程序中捕获，并可以基于信号采取适当的动作。这些信号是定义在 C++ 头文件 `<csignal>` 中。

| 信号      | 描述                                         |
| --------- | -------------------------------------------- |
| `SIGABRT` | 程序的异常终止，如调用 abort。               |
| `SIGFPE`  | 错误的算术运算，比如除以零或导致溢出的操作。 |
| `SIGILL`  | 检测非法指令。                               |
| `SIGINT`  | 接收到交互注意信号。                         |
| `SIGSEGV` | 非法访问内存。                               |
| `SIGTERM` | 发送到程序的终止请求。                       |



## signal 函数

C++ 信号处理库 `<csignal>` 提供了 `signal()` 函数，用来捕获突发事件。函数原型如下：

```cpp showLineNumbers
void (*signal (int sig, void (*func)(int)))(int);
```

这个函数接收两个参数：

- 第一个参数 `sig` 是一个整数，代表了信号的编号；
- 第二个参数 `func` 是一个指向信号处理函数的指针。

不管在程序中捕获什么信号，都必须使用 `signal()` 函数来注册信号，并将其与信号处理程序相关联。

示例 ： 使用 `signal()` 函数捕获 `SIGINT` 信号

```cpp showLineNumbers
#include <iostream>
#include <csignal>

#include <unistd.h>

using namespace std;

void signalHandler(int signum)
{
    cout << "Interrupt signal (" << signum << ") received.\n";
    exit(signum);
}

int main(void)
{
    signal(SIGINT, signalHandler);  // 注册信号 SIGINT 和信号处理程序 
    
    while (1) {
        cout << "Going to sleep...." << endl;
        sleep(1);
    }
    
    return 0;
}
```

编译运行以上示例，输出结果如下：

```cpp showLineNumbers
Going to sleep....
Going to sleep....
Going to sleep....
```

此时按下组合键 `Ctrl+C` 中断程序，会看到程序捕获信号，程序打印如下内容并退出：

```bash
Going to sleep....
Going to sleep....
Going to sleep....
^CInterrupt signal (2) received.
```



## raise 函数

`raise()` 函数用于生成信号，函数原型如下：

```cpp showLineNumbers
int raise (signal sig);
```

参数 `sig` 是要发送的信号的编号，这些信号包括 `SIGINT`、`SIGABRT`、`SIGFPE`、`SIGILL`、`SIGSEGV`、`SIGTERM`、`SIGHUP` 等。

示例：使用 `raise()` 函数内部生成信号

```cpp showLineNumbers
#include <iostream>
#include <csignal>
#include <unistd.h>

using namespace std;

void signalHandler(int signum)
{
    cout << "Interrupt signal (" << signum << ") received.\n";
    exit(signum);
}

int main(void)
{
    int i = 0;

    signal(SIGINT, signalHandler);  // 注册信号 SIGINT 和信号处理程序 

    while (++i) {
        cout << "wait for 1s...." << endl;
        if (i == 3) {
            raise(SIGINT);
        }
        sleep(1);
    }
    
    return 0;
}
```

编译运行以上程序，输出结果如下：

```bash
wait for 1s....
wait for 1s....
wait for 1s....
Interrupt signal (2) received.
```