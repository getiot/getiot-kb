---
sidebar_position: 18
authors: [luhuadong]
---

# Linux 守护进程

在本文中，你将学习什么是 **Linux 守护进程**（Daemon），它与普通进程的区别，以及如何用 C 语言编写一个简单的守护进程。我们还会介绍创建守护进程时需要注意的一些技术细节，包括脱离终端、关闭文件描述符、后台运行等。



## 什么是守护进程？

守护进程是一种在后台运行的特殊进程，通常不依赖终端（如 bash 或 tty）输入输出，常用于提供系统服务，比如 `sshd`（远程登录服务）、`cron`（定时任务服务）等。

守护进程的主要特性：

- 在后台运行，与用户无交互；
- 通常在系统启动时被自动启动；
- 不依赖于终端（脱离控制终端）；
- 拥有自己的日志文件（通常写入 `/var/log`）。



## 守护进程的创建步骤

在 Linux 中，你可以通过以下步骤在 C 程序中创建一个守护进程：

### 1. 创建子进程并退出父进程

这样做的目的是让子进程不是原有终端的会话组长，以便后续脱离终端。

```c
pid_t pid = fork();
if (pid < 0) exit(EXIT_FAILURE);
if (pid > 0) exit(EXIT_SUCCESS);  // 父进程退出
```

### 2. 创建新的会话

```c
setsid();  // 子进程成为新的会话组长
```

### 3. 修改工作目录

防止守护进程阻止某个挂载点被卸载。

```c
chdir("/");  // 切换到根目录
```

### 4. 设置文件权限掩码

```c
umask(0);  // 清除文件模式创建掩码
```

### 5. 关闭不必要的文件描述符

```c
close(STDIN_FILENO);
close(STDOUT_FILENO);
close(STDERR_FILENO);
```

### 6. 守护进程核心逻辑

在守护进程中，你通常会执行一些循环工作，比如日志记录、监控任务等。



## 示例：手动创建守护进程

下面是一个完整的示例程序，演示如何创建一个守护进程。（完整代码：[GitHub](https://github.com/getiot/linux-c/blob/main/system/process/daemon.c)）

```c showLineNumbers title="daemon.c"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <time.h>
#include <fcntl.h>

int main() {
    pid_t pid = fork();
    if (pid < 0) exit(EXIT_FAILURE);
    if (pid > 0) exit(EXIT_SUCCESS);  // 父进程退出

    setsid();      // 创建新会话
    chdir("/");    // 切换工作目录
    umask(0);      // 清除文件创建掩码

    close(STDIN_FILENO);
    close(STDOUT_FILENO);
    close(STDERR_FILENO);

    // 守护进程主体逻辑：每 5 秒写一次时间到文件
    while (1) {
        FILE *fp = fopen("/tmp/daemon.log", "a+");
        if (fp) {
            time_t now = time(NULL);
            fprintf(fp, "守护进程运行中：%s", ctime(&now));
            fclose(fp);
        }
        sleep(5);
    }

    return 0;
}
```

你可以将此程序保存为 `daemon.c`，然后用以下命令编译运行：

```bash
gcc -o daemon daemon.c
./daemon
```

然后用 `tail -f /tmp/daemon.log` 观察日志文件是否持续更新。



## 使用 `daemon()` 函数

在上面的示例中，你使用了 `fork()`、`setsid()`、`chdir()`、`umask()`、`close()` 等函数来手动创建守护进程。步骤虽然不复杂，但其实还是挺繁琐的。因此 Linux 系统为我们提供了一个用于创建守护进程的标准函数 `daemon()`，它定义在 `<unistd.h>` 头文件中。

函数原型：

```c
#include <unistd.h>
int daemon(int nochdir, int noclose);
```

参数说明：

- **`nochdir`**：如果为 `0`，`daemon()` 会将当前工作目录更改为根目录 `/`；
- **`noclose`**：如果为 `0`，`daemon()` 会将标准输入、输出和错误重定向到 `/dev/null`。

你可以将原来的这些步骤：

```c showLineNumbers
pid_t pid = fork();
if (pid < 0) exit(EXIT_FAILURE);
if (pid > 0) exit(EXIT_SUCCESS);
setsid();
chdir("/");
close(STDIN_FILENO);
close(STDOUT_FILENO);
close(STDERR_FILENO);
```

简化为一行：

```c showLineNumbers
daemon(0, 0);  // 切换工作目录，关闭标准描述符
```

这样代码更简洁，也更容易维护。

:::tip

`daemon()` 函数手动创建守护进程的一个封装版本，简化了守护进程的创建过程。

需要注意，`daemon()` 不是 POSIX 标准的一部分，但在大多数 Unix/Linux 系统中可用。在某些系统中需要链接 `libc`，但通常默认即可。

:::



## 小结

在本教程中，你学习了：

- 什么是守护进程及其用途；
- 如何通过 C 程序创建一个守护进程；
- 使用 `fork()`、`setsid()`、`chdir()`、`umask()` 和关闭文件描述符来实现一个完整的守护进程；
- 如何将后台任务写入日志文件进行验证。

守护进程是 Linux 系统中不可或缺的组成部分，掌握它能帮助你构建更加专业和高效的系统级服务程序。

