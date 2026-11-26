---
sidebar_position: 10
authors: [luhuadong]
---

# Linux 信号



Linux 系统提供了一种进程间异步通信的方式 —— 信号（signal）。信号可认为是一种软中断机制，许多重要的程序都需要处理信号。例如，在终端输入 Ctrl + C 快捷键可以中断程序，实际上就是给该进程发送了一个 SIGINT 信号。



## 信号类型

Linux 系统一共定义了 64 种信号，分为两大类：可靠信号与不可靠信号，前 32 种信号为不可靠信号，后 32 种为可靠信号。

- **不可靠信号**：也称为非实时信号，不支持排队，信号可能会丢失，发送多次相同的信号，进程只能收到一次，信号值取值区间为 1~31；
- **可靠信号**：也称为实时信号，支持排队，信号不会丢失，发多少次，就可以收到多少次。信号值取值区间为 32~64。

在 Linux 系统中，可以通过 [`kill -l`](/linux-command/kill/) 命令查看所有 signal 信号，如下：

```bash
$ kill -l
1) SIGHUP 2) SIGINT 3) SIGQUIT 4) SIGILL
2) SIGTRAP 6) SIGABRT 7) SIGBUS 8) SIGFPE
3) SIGKILL 10) SIGUSR1 11) SIGSEGV 12) SIGUSR2
4)  SIGPIPE 14) SIGALRM 15) SIGTERM 16) SIGSTKFLT
5)  SIGCHLD 18) SIGCONT 19) SIGSTOP 20) SIGTSTP
6)  SIGTTIN 22) SIGTTOU 23) SIGURG 24) SIGXCPU
7)  SIGXFSZ 26) SIGVTALRM 27) SIGPROF 28) SIGWINCH
8)  SIGIO 30) SIGPWR 31) SIGSYS 34) SIGRTMIN
9)  SIGRTMIN+1 36) SIGRTMIN+2 37) SIGRTMIN+3 38) SIGRTMIN+4
10) SIGRTMIN+5 40) SIGRTMIN+6 41) SIGRTMIN+7 42) SIGRTMIN+8
11) SIGRTMIN+9 44) SIGRTMIN+10 45) SIGRTMIN+11 46) SIGRTMIN+12
12) SIGRTMIN+13 48) SIGRTMIN+14 49) SIGRTMIN+15 50) SIGRTMAX-14
13) SIGRTMAX-13 52) SIGRTMAX-12 53) SIGRTMAX-11 54) SIGRTMAX-10
14) SIGRTMAX-9 56) SIGRTMAX-8 57) SIGRTMAX-7 58) SIGRTMAX-6
15) SIGRTMAX-5 60) SIGRTMAX-4 61) SIGRTMAX-3 62) SIGRTMAX-2
16) SIGRTMAX-1 64) SIGRTMAX
```



## 信号列表

下表列出了 1~31 的信号及其描述。

| 信号值 | 信号名      | 描述                                   |
| :----- | :---------- | :------------------------------------- |
| 1      | `SIGHUP`    | 挂起                                   |
| 2      | `SIGINT`    | 中断                                   |
| 3      | `SIGQUIT`   | 退出                                   |
| 4      | `SIGILL`    | 非法指令                               |
| 5      | `SIGTRAP`   | 断点或陷阱指令                         |
| 6      | `SIGABRT`   | abort 发出的信号                       |
| 7      | `SIGBUS`    | 非法内存访问                           |
| 8      | `SIGFPE`    | 浮点异常                               |
| 9      | `SIGKILL`   | kill 信号（不能被忽略、处理和阻塞）    |
| 10     | `SIGUSR1`   | 用户信号1                              |
| 11     | `SIGSEGV`   | 无效内存访问                           |
| 12     | `SIGUSR2`   | 用户信号2                              |
| 13     | `SIGPIPE`   | 管道破损，没有读端的管道写数据         |
| 14     | `SIGALRM`   | alarm 发出的信号                       |
| 15     | `SIGTERM`   | 终止信号                               |
| 16     | `SIGSTKFLT` | 栈溢出                                 |
| 17     | `SIGCHLD`   | 子进程退出（默认忽略）                 |
| 18     | `SIGCONT`   | 进程继续                               |
| 19     | `SIGSTOP`   | 进程停止（不能被忽略、处理和阻塞）     |
| 20     | `SIGTSTP`   | 进程停止                               |
| 21     | `SIGTTIN`   | 进程停止，后台进程从终端读数据时       |
| 22     | `SIGTTOU`   | 进程停止，后台进程想终端写数据时       |
| 23     | `SIGURG`    | I/O 有紧急数据到达当前进程（默认忽略） |
| 24     | `SIGXCPU`   | 进程的 CPU 时间片到期                  |
| 25     | `SIGXFSZ`   | 文件大小的超出上限                     |
| 26     | `SIGVTALRM` | 虚拟时钟超时                           |
| 27     | `SIGPROF`   | profile 时钟超时                       |
| 28     | `SIGWINCH`  | 窗口大小改变（默认忽略）               |
| 29     | `SIGIO`     | I/O 相关                               |
| 30     | `SIGPWR`    | 关机（默认忽略）                       |
| 31     | `SIGSYS`    | 系统调用异常                           |



## 信号处理

Linux 信号的处理有三种方法，分别是：忽略、捕捉和默认动作

- **忽略信号**：大多数信号可以使用这个方式来处理，但是有两种信号不能被忽略（分别是 `SIGKILL` 和 `SIGSTOP`）。因为这两中信号向内核和超级用户提供了进程终止和停止的可靠方法，如果忽略了，那么这个进程就变成了没人能管理的进程，显然是内核设计者不希望看到的场景。
- **捕捉信号**：需要告诉内核，用户希望如何处理某一种信号。也就是说用户需要写一个信号处理回调函数，然后将这个函数告诉内核。当该信号产生时，由内核来调用用户自定义的函数，以此来实现某种信号的处理。
- **系统默认动作**，对于每个信号来说，系统都对应由默认的处理动作，当发生了该信号，系统会自动执行。不过，对系统来说，大部分的处理方式都比较粗暴，就是直接杀死该进程。

具体的信号默认动作可以使用 `man 7 signal` 来查看系统的具体定义。



| Signal Name | Signal Number |                         Description                          |
| :---------: | :-----------: | :----------------------------------------------------------: |
|   SIGHUP    |       1       | Hang up detected on controlling terminal or death of controlling process |
|   SIGINT    |       2       |   Issued if the user sends an interrupt signal (Ctrl + C)    |
|   SIGQUIT   |       3       |      Issued if the user sends a quit signal (Ctrl + D)       |
|   SIGFPE    |       8       |   Issued if an illegal mathematical operation is attempted   |
|   SIGKILL   |       9       | If a process gets this signal it must quit immediately and will not perform any clean-up operations |
|   SIGALRM   |      14       |             Alarm clock signal (used for timers)             |
|   SIGTERM   |      15       |    Software termination signal (sent by kill by default)     |



## 示例代码

完整示例代码可从 [GitHub](https://github.com/getiot/linux-c/tree/main/ipc/signal) 仓库获取。

```c showLineNumbers
#include <signal.h>
#include <unistd.h>
#include <stdio.h>

void sigroutine(int signo)
{
    /* 信号处理例程，其中 signo 将会得到信号的值 */
    switch(signo)
    {
    case SIGHUP:
        printf("Get a signal -- SIGHUP\n");  // 1
        break;
    case SIGINT:
        printf("Get a signal -- SIGINT\n");  // 2
        break;
    case SIGQUIT:
        printf("Get a signal -- SIGQUIT\n");  // 3
        break;
    }
    return;
}

int main()
{
    printf("process id is %d\n", getpid());

    signal(SIGHUP, sigroutine); //* 下面设置三个信号的处理方法
    signal(SIGINT, sigroutine);
    signal(SIGQUIT, sigroutine);

    for (;;)
        ;
}
```

使用 `kill` 命令可以发送信号，命令格式如下：

```bash
$ kill -signal pid
```

运行示例程序：

```bash
$ ./simple_example 
process id is 168125
```

打开另一个终端，给该进程发送不同的信号，如下：

```bash
$ kill -3 168125
$ kill -2 168125
$ kill -1 168125
```

可以看到示例程序的窗口打印如下信息：

```bash
Get a signal -- SIGQUIT
Get a signal -- SIGINT
Get a signal -- SIGHUP
```
