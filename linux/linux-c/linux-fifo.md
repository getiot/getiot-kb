---
sidebar_position: 9
authors: [luhuadong]
---

# Linux 有名管道

在前一节中你已经了解了无名管道，这种管道适用于有亲缘关系的进程之间的数据传输。但如果两个进程没有父子关系，该如何通信呢？答案就是使用**有名管道**（Named Pipe 或 FIFO）。本教程将详细介绍有名管道的创建与使用方法，带你一步步掌握这一重要的进程间通信方式。



## 什么是有名管道？

有名管道（FIFO）和无名管道类似，都是基于内核缓冲区的数据传输机制。但不同之处在于：

- 有名管道**有文件名**，存在于文件系统中（可见于 [`ls`](/linux-command/ls/) 列表中）
- 它可以用于**无亲缘关系的进程之间通信**
- 同样是**单向通信**（如果需要双向通信，需要建立两个 FIFO）



## 创建有名管道

你可以使用以下两种方法创建有名管道：

### 使用 `mkfifo` 命令

Linux 系统提供了一个 `mkfifo` 命令，可以直接创建有名管道。例如：

```bash
mkfifo myfifo
```

这会在当前目录下创建一个名为 `myfifo` 的管道文件。

### 使用 `mkfifo()` 函数

`mkfifo()` 函数原型如下：

```c
#include <sys/types.h>
#include <sys/stat.h>
int mkfifo(const char *pathname, mode_t mode);
```

调用示例：

```c
mkfifo("myfifo", 0666);
```



## 有名管道通信示例

以下是一个完整示例：一个进程向管道写数据，另一个读取数据。

### writer.c（写进程）

```c showLineNumbers title="writer.c"
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>

int main() {
    int fd;
    char *fifo = "myfifo";
    mkfifo(fifo, 0666); // 创建 FIFO
    
    fd = open(fifo, O_WRONLY);
    write(fd, "Hello from writer!", 19);
    close(fd);

    return 0;
}
```

### reader.c（读进程）

```c showLineNumbers title="reader.c"
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int main() {
    int fd;
    char buffer[100];

    fd = open("myfifo", O_RDONLY);
    read(fd, buffer, sizeof(buffer));
    printf("Reader received: %s\n", buffer);
    close(fd);

    return 0;
}
```

编译与运行：

```bash
gcc writer.c -o writer
gcc reader.c -o reader
```

先运行 `reader`，再运行 `writer`，观察输出。



## 注意事项

- FIFO 文件是一种特殊类型的文件，使用 `ls -l` 命令可以看到它的类型为 `p`（pipe）。
- 有名管道也会阻塞：读取端在没有数据前会阻塞，写入端在没有读取端打开前也会阻塞。
- 通信时最好先启动读取进程，避免写入时阻塞卡住。
- 有名管道是单向的，如果你需要双向通信，需创建两个不同的 FIFO 文件。



## 小结

通过本节学习，你了解了有名管道的基本概念、创建方式以及在两个无亲缘关系的进程之间如何进行通信。相比无名管道，有名管道的使用范围更广泛，适合在不相关的进程间建立数据通道。在后续的学习中，你还会遇到更加复杂的 IPC 方式，例如消息队列、共享内存和信号量，它们为 Linux 系统编程提供了更强大的能力。
