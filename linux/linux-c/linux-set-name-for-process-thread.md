---
sidebar_position: 17
sidebar_label: Linux 设置线程名称
authors: [luhuadong]
---

# Linux 设置进程/线程名称

在 Linux 开发中，设置进程或线程名称是一种实用技巧，尤其在多线程程序开发中，为线程设置名称可以大大提升调试效率。当你在调试工具（如 [`gdb`](/linux-debug/gdb-usage/)）或查看系统线程状态（如 [`htop`](/linux-command/htop/)、[`ps`](/linux-command/ps/) 或 `/proc` 目录）时，清晰的线程名称能帮助你快速定位问题。

本文将带你学习在 Linux 中如何设置和查看进程名与线程名，使用的接口包括系统函数 `prctl()`、`pthread_setname_np()` 和 `pthread_getname_np()`，并结合实例进行讲解。



## 为什么要设置线程名称？

默认情况下，线程名称在系统中是模糊的，很难区分各个线程的职责。试想一下，当你多线程程序时，使用 [`ps`](/linux-command/ps/)、[`top`](/linux-command/top/)、[`htop`](/linux-command/htop/)、[`gdb`](/linux-debug/gdb-usage/) 或分析日志，却发现所有线程名称都是默认的名称（进程名称），无法直观地辨认出哪个是你所关心的线程。

这时候，设置线程名称的好处就彰显出来了，包括：

- **提升调试效率**：通过 IDE 或 `gdb`、`htop` 等系统工具可以更直观地看到线程执行情况。
- **便于识别线程职责**：可以直接通过线程名称大概知道该线程的功能是什么。
- **增强日志可读性**：在日志打印或错误报告中标明线程名，可以方便排查问题，有助于分析多线程程序行为。



## 设置线程名称

### 接口函数 `pthread_setname_np()`

Linux 提供了两个非标准的 POSIX 接口来设置和获取线程名称：

```c
int pthread_setname_np(pthread_t thread, const char *name);
int pthread_getname_np(pthread_t thread, char *name, size_t len);
```

**参数说明：**

- `thread`：线程句柄，使用 `pthread_self()` 可获取当前线程句柄。
- `name`：线程名称字符串，最多 16 字节（包括字符串结束符 `\0`）。
- `len`：获取名称时指定的缓冲区长度。

**注意事项：**

- 设置线程名只对当前 Linux 进程有效，不影响系统其他进程。
- 名称最多 15 个字符（+1 个 `\0`），超出部分将被截断。
- 这些函数是 Linux 特有的扩展，带 `_np` 后缀（non-portable）。



### 示例：设置和获取线程名称

下面是一个完整的示例程序，演示如何设置和获取线程名称。（完整代码：[GitHub](https://github.com/getiot/linux-c/blob/main/system/pthreads/thread_name_demo.c)）

```c showLineNumbers title="thread_name_demo.c"
#include <pthread.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

void *worker(void *arg) {
    char thread_name[16];

    // 设置线程名称
    pthread_setname_np(pthread_self(), "worker-thread");

    // 获取线程名称
    pthread_getname_np(pthread_self(), thread_name, sizeof(thread_name));

    printf("Thread [%ld] running with name: %s\n", pthread_self(), thread_name);

    sleep(2); // 模拟任务处理
    return NULL;
}

int main() {
    pthread_t tid;
    pthread_create(&tid, NULL, worker, NULL);

    // 主线程也设置名字
    pthread_setname_np(pthread_self(), "main-thread");

    char name[16];
    pthread_getname_np(pthread_self(), name, sizeof(name));
    printf("Main thread name: %s\n", name);

    pthread_join(tid, NULL);
    return 0;
}
```

编译运行：

```bash
gcc thread_name_demo.c -o thread_name_demo -pthread
./thread_name_demo
```

输出结果：

```bash
Main thread name: main-thread
Thread [140404333971200] running with name: worker-thread
```

你还可以使用 `ps -L -p <pid>` 命令查看线程名称，或者在 `/proc/<pid>/task/<tid>/comm` 文件中查看。



## 设置进程名称

### 接口函数 `prctl()`

`prctl()` 是一个强大的 Linux 系统调用，可用于控制进程行为，其中 `PR_SET_NAME` 用于设置进程名称。

```c
#include <sys/prctl.h>

int prctl(int option, unsigned long arg2, unsigned long arg3,
          unsigned long arg4, unsigned long arg5);
```

参数说明：

|    参数     | 说明                                                         |
| :---------: | ------------------------------------------------------------ |
|  `option`   | 要执行的操作类型，例如 `PR_SET_NAME`（设置进程名）或 `PR_GET_NAME`（获取进程名）。 |
|   `arg2`    | 操作的主要参数，比如设置名称时是指向名称字符串的指针。       |
| `arg3~arg5` | 备用参数，有些 `option` 可能会使用它们，大多数情况为 0。     |

注意：Linux 系统默认进程名长度最大为 16 字节。

### 示例：设置和获取进程名称

下面是一个完整的示例程序，演示如何设置和获取进程名称。（完整代码：[GitHub](https://github.com/getiot/linux-c/blob/main/system/process/process_name_demo.c)）

```c showLineNumbers title="process_name_demo.c"
#include <stdio.h>
#include <string.h>
#include <sys/prctl.h>
#include <unistd.h>

int main() {
    prctl(PR_SET_NAME, "my-process");
    
    char name[16];
    prctl(PR_GET_NAME, name);
    printf("Process name is: %s\n", name);

    sleep(10); // 保持进程运行，方便使用 ps/htop 观察
    return 0;
}
```

编译运行：

```bash
gcc process_name_demo.c -o process_name_demo
./process_name_demo
```

输出结果：

```bash
Process name is: my-process
（等待 10 秒）
```

你可以通过以下命令验证进程名是否生效：

```bash
ps -e -o pid,comm | grep my-process
```

或者查看 `/proc/<pid>/comm` 内容：

```bash
cat /proc/$(pidof your_program)/comm
```



:::tip

虽然 `prctl()` 函数定义接受 5 个参数，但在 C 语言中，如果后面的参数是未使用的，你是**允许省略不传的**。这些省略参数默认值通常会在寄存器或栈上置为 0。对于 `PR_SET_NAME` 操作，它只需要使用前两个参数：

- `option = PR_SET_NAME`
- `arg2 = 指向字符串的指针`

这在 C 语言中是合法的，前提是函数的实现兼容省略参数的调用方式。Linux 的 `prctl()` 是通过可变参数或明确文档规范支持这样使用的。

当然，为了代码可读性，也可以写成完整形式：

```c
prctl(PR_SET_NAME, "my-process", 0, 0, 0);
```

:::



## 线程与进程名称的区别

|  名称类别  | 设置方法                            | 查看方式                              |
| :--------: | ----------------------------------- | ------------------------------------- |
| **进程名** | `prctl(PR_SET_NAME)` 或进程二进制名 | `ps`, `/proc/<pid>/comm`              |
| **线程名** | `pthread_setname_np()`              | `htop`, `/proc/<pid>/task/<tid>/comm` |

注意：Linux 的主线程既是一个进程，也是一个线程，可以同时设置其线程名和进程名，但显示位置不同。



## 小结

本文带你学习了如何在 Linux 中设置进程和线程的名称。你学会了：

- 使用 `prctl(PR_SET_NAME)` 设置进程名；
- 使用 `pthread_setname_np()` 和 `pthread_getname_np()` 设置与获取线程名；
- 如何在系统工具中查看这些名称。

设置进程和线程名称虽然简单，却是多线程开发中的一项实用技巧，尤其在调试和日志分析阶段非常关键。建议你在实际项目中养成设置名称的好习惯，提升程序可维护性和调试效率。
