---
sidebar_position: 50
authors: [luhuadong]
---

# Linux 内存映射

在日常的 Linux C 编程中，如果你想高效地读写文件内容，除了 `read` / `write` 这样的系统调用，还有一种非常强大的方式叫做**内存映射**（Memory Mapping），也就是通过 Linux 提供的系统调用接口 `mmap()` 函数直接把文件内容映射到内存。这种方式不仅简单高效，还能让你像操作内存数组一样访问文件内容。

本教程将带你了解：

- 什么是内存映射？
- `mmap` 和 `munmap` 函数怎么用？
- 使用内存映射读写文件的完整示例；
- 常见参数说明和使用技巧。



## 什么是内存映射？

内存映射（Memory Mapping）就是将一个文件或设备映射到进程的地址空间中，这样你就可以像访问普通数组一样来访问文件内容，而无需显式调用 `read()` 或 `write()`。映射后可以大大加快文件的访问速度，从而提高程序的运行性能。

这种方式适用于以下场景：

- **读写大型文件**，避免频繁的系统调用；
- **多个进程共享内存区域**；
- **内存和磁盘之间的高效同步**。



## 函数原型

要使用内存映射相关接口函数，需要引入以下头文件。

```c showLineNumbers
#include <sys/mman.h>
```

### mmap 函数

```c showLineNumbers
void *mmap(void *addr, size_t length, int prot, int flags, 
           int fd, off_t offset);
```

**参数说明：**

- `addr`：指定文件应被映射到进程空间的起始地址，一般被指定一个空指针（`NULL`），将选择起始地址的任务留给内核来完成。
- `length`：映射到调用进程地址空间的字节数，它从被映射文件开头 offset 个字节开始算起。
- `prot`：指定共享内存的访问权限。可选值有 `PROT_READ`（可读）、`PROT_WRITE`（可写）、`PROT_EXEC`（可执行）、`PROT_NONE`（不可访问）。
- `flags`：用于设定映射的更新是否对映射同一区域的其他进程可见，以及是否将更新传递到底层文件。常用值有 `MAP_SHARED`、`MAP_PRIVATE`、`MAP_FIXED`，其中 `MAP_SHARED` 和 `MAP_PRIVATE` 必选其一，而 `MAP_FIXED` 则不推荐使用。
- `fd`：即将映射到进程空间的文件描述字，一般由 `open()` 返回。也可以指定为 -1，但此时必须指定 flags 参数中的`MAP_ANON`，表明进行的是匿名映射（不涉及具体的文件名，避免了文件的创建及打开，这种方式只能用于具有亲缘关系的进程间进行通信）。
- `offset`：一般设为0，表示从文件头开始映射。

**常见的 `prot` 取值：**

- `PROT_READ`：映射区域可读；
- `PROT_WRITE`：映射区域可写；
- `PROT_EXEC`：可执行；
- `PROT_NONE`：不可访问。

**常见的 `flags` 取值：**

- `MAP_SHARED`：对映射区域的修改会同步回原文件；
- `MAP_PRIVATE`：私有映射，修改不会影响原文件（写时复制）。

### munmap 函数

用完 `mmap` 后，你需要使用 `munmap()` 释放映射区域。它的函数原型如下：

```c showLineNumbers
int munmap(void *addr, size_t length);
```

参数中的 `addr` 和 `length` 要和 `mmap()` 返回的地址和映射大小一致。



## 使用 mmap 映射文件示例（只读）

下面是一个使用 `mmap` 读取文件内容的简单例子：

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>

int main() {
    const char *filename = "example.txt";
    int fd = open(filename, O_RDONLY);
    if (fd < 0) {
        perror("打开文件失败");
        return 1;
    }

    struct stat st;
    if (fstat(fd, &st) < 0) {
        perror("获取文件大小失败");
        close(fd);
        return 1;
    }

    size_t filesize = st.st_size;
    char *data = mmap(NULL, filesize, PROT_READ, MAP_PRIVATE, fd, 0);
    if (data == MAP_FAILED) {
        perror("mmap 失败");
        close(fd);
        return 1;
    }

    // 打印文件内容
    write(STDOUT_FILENO, data, filesize);

    // 释放映射
    munmap(data, filesize);
    close(fd);
    return 0;
}
```

**注意事项：**

- 文件大小为 0 时，`mmap()` 会失败；
- 映射长度必须正确；
- `mmap()` 返回失败时返回 `MAP_FAILED`，不是 `NULL`。



## 使用 mmap 修改文件内容

如果你想用 mmap 修改文件内容，可以这样写：

```c showLineNumbers
int fd = open("example.txt", O_RDWR);
char *data = mmap(NULL, filesize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
data[0] = 'H';  // 修改第一个字节
msync(data, filesize, MS_SYNC); // 显式刷新到磁盘（可选）
munmap(data, filesize);
```

💡 用 `MAP_SHARED` + `PROT_WRITE` 可以让你的更改写回文件；否则只是内存中“写时复制”。



## 映射匿名内存（共享内存）

除了文件，你还可以映射匿名内存用于多线程或多进程通信：

```c showLineNumbers
char *buf = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
```

这段代码创建了一块大小为 4KB 的匿名内存，没有文件对应，非常适合用作临时缓存或 IPC 共享内存。



## 小结

通过本教程，你学习了：

- 内存映射的基本原理；
- 如何使用 `mmap()` 将文件映射到内存；
- 如何通过 `munmap()` 释放映射；
- 映射区域的权限、类型和常见用法；
- 文件映射和匿名内存映射的实际应用；

内存映射是 Linux 系统编程中高效处理文件和内存资源的重要工具。如果你正在处理大型数据文件或需要多个进程共享数据，建议优先考虑 `mmap`。



