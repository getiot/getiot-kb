---
sidebar_position: 6
authors: [luhuadong]
---

# Linux 进程管理

在 Linux 系统编程中，“进程” 是非常核心的概念。一个正在运行的程序就是一个进程，进程是系统资源分配和调度的基本单位。本篇教程将带你了解 Linux 中进程的基本概念、创建与终止方法、进程 ID、父子进程、进程状态以及常用的系统调用，如 `fork()`、`exec()`、`wait()`、`getpid()` 等。通过这些知识，你将能够编写简单的多进程程序，并掌握操作系统是如何管理这些进程的。



## 什么是进程？

在 Linux 中，**进程**（Process）是操作系统中运行中的程序实例。每一个进程都拥有独立的地址空间、寄存器状态和系统资源（如文件描述符、堆栈等）。Linux 使用进程调度器来管理所有进程的运行。

你可以通过 [`ps`](/linux-command/ps/)、[`top`](/linux-command/top/)、[`htop`](/linux-command/htop/) 等命令查看系统中运行的进程。

Linux 系统中进程的状态包括：

- **R（Running）**：正在运行或可运行
- **S（Sleeping）**：休眠状态，等待事件
- **Z（Zombie）**：僵尸进程，已结束但父进程未回收资源
- **T（Stopped）**：被暂停或跟踪

你可以通过 `ps -aux` 查看进程的状态。



## 进程的标识符：PID 与 PPID

每个进程都有唯一的进程 ID（PID），你可以通过 `getpid()` 获取当前进程的 PID，通过 `getppid()` 获取父进程的 PID（PPID）。

```c showLineNumbers
#include <stdio.h>
#include <unistd.h>

int main() {
    printf("当前进程 PID：%d\n", getpid());
    printf("父进程 PID：%d\n", getppid());
    return 0;
}
```



## 创建进程：fork()

Linux 中可以使用 `fork()` 创建新进程，它会复制当前进程，并生成一个**子进程**。子进程与父进程几乎完全一样，只是 PID 不同。

```c showLineNumbers
#include <stdio.h>
#include <unistd.h>

int main() {
    pid_t pid = fork();
    if (pid < 0) {
        perror("fork 失败");
        return 1;
    } else if (pid == 0) {
        printf("这是子进程，PID=%d\n", getpid());
    } else {
        printf("这是父进程，PID=%d，子进程 PID=%d\n", getpid(), pid);
    }
    return 0;
}
```

**说明：**

- `fork()` 返回值区分父子进程：父进程中返回子进程的 PID，子进程中返回 0。
- 父子进程是**并发执行**的，它们各自独立运行。



## 替换进程：exec()

`exec()` 系列函数用于在当前进程中加载并运行一个新的程序。它不会创建新进程，而是**替换当前进程的内容**。

```c showLineNumbers
#include <unistd.h>

int main() {
    execl("/bin/ls", "ls", "-l", NULL);
    return 0;
}
```

**说明：**

- 如果 `execl()` 成功，它不会返回，当前进程内容会被 `ls -l` 替代。
- 如果失败，才会返回一个负数。



## 等待子进程：wait() 与 waitpid()

父进程通常要等待子进程结束，否则子进程可能成为“僵尸进程”。

```c showLineNumbers
#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork();
    if (pid == 0) {
        printf("子进程 PID=%d 开始运行\n", getpid());
        sleep(2);
        printf("子进程结束\n");
    } else {
        wait(NULL);  // 等待子进程结束
        printf("父进程继续运行\n");
    }
    return 0;
}
```



## 系统调用一览表

|   函数名    | 作用                           |
| :---------: | :----------------------------- |
|  `fork()`   | 创建新进程                     |
|  `exec()`   | 替换当前进程映像               |
|  `wait()`   | 阻塞等待子进程退出             |
| `getpid()`  | 获取当前进程的 PID             |
| `getppid()` | 获取当前进程的父进程 PID       |
|  `exit()`   | 正常退出一个进程               |
|  `kill()`   | 发送信号给某个进程，常用于终止 |



## 小结

在本节中，你学习了 Linux 进程的基本概念和管理方法。我们介绍了进程的标识、`fork()` 创建子进程、`exec()` 替换进程映像、`wait()` 等待子进程结束等基本系统调用。你也了解了进程的生命周期和常见状态。掌握这些内容后，你已经具备编写基本多进程程序的能力了。在接下来的章节中，我们将进一步探讨进程间通信（IPC）、线程管理等更高级的主题。
