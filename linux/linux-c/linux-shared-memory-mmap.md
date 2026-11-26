---
sidebar_position: 13
authors: [luhuadong]
---

# Linux 共享内存（mmap）



mmap 函数是 Linux系统中的一个系统调用，用于将一个文件或设备映射到进程的虚拟地址空间，从而使得进程可以通过访问内存来读写文件或设备数据，这种技术称为内存映射（memory mapping）。



## mmap 函数原型

mmap 函数的原型如下：

```c showLineNumbers
void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset);
```

各参数的含义如下：

- addr：指定映射区域的首地址，通常设置为 0 表示由系统自动选择。
- length：指定映射区域的长度。
- prot：指定映射区域的保护方式，可以是以下值的按位或：
  - `PROT_READ`：允许读取映射区域。
  - `PROT_WRITE`：允许写入映射区域。
  - `PROT_EXEC`：允许执行映射区域。
- flags：指定映射区域的标志，可以是以下值的按位或：
  - `MAP_SHARED`：共享映射，多个进程可以同时访问同一映射区域。
  - `MAP_PRIVATE`：私有映射，只有当前进程可以访问映射区域。
  - `MAP_ANONYMOUS`：创建匿名映射，不需要指定文件描述符。
  - `MAP_FIXED`：指定映射区域的地址，如果该地址已被占用则会失败。
- fd：指定要映射的文件描述符，如果是创建匿名映射则设置为 -1。
- offset：指定文件中的偏移量，对于匿名映射应该设置为 0。

返回值：成功返回映射区域的起始地址，失败则返回 `MAP_FAILED`（-1）。



## mmap 共享内存示例程序

下面是一个使用 mmap 函数创建共享内存的示例程序。

GitHub：[shared_memory_mmap.c](https://github.com/getiot/linux-c/blob/main/system/ipc/shared-memory/mmap/shared_memory_mmap.c)

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

#define MEM_SIZE  64
#define TEST_MSG  "Hello, GetIoT.tech!"

int main()
{
    int fd;
    char *data;
    const char *filename = "/tmp/shared_memory";

    /* 创建一个文件，用于共享内存 */
    fd = open(filename, O_RDWR | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
    if (fd < 0) {
        perror("open");
        exit(1);
    }
    /* 设置文件大小 */
    if (ftruncate(fd, MEM_SIZE) < 0) {
        perror("ftruncate");
        exit(1);
    }
    /* 映射到内存中 */
    data = (char *) mmap(NULL, MEM_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (data == MAP_FAILED) {
        perror("mmap");
        exit(1);
    }
    /* 关闭文件描述符，不再需要 */
    close(fd);

    /* 使用共享内存 */
    memcpy(data, TEST_MSG, sizeof(TEST_MSG));
    printf("%s\n", (char *)data);

    /* 解除映射 */
    if (munmap(data, MEM_SIZE) < 0) {
        perror("munmap");
        exit(1);
    }

    /* 删除文件 */
    if (unlink(filename) < 0) {
        perror("unlink");
        exit(1);
    }

    return 0;
}
```

编译代码：

```bash
gcc shared_memory_mmap.c -o shared_memory_mmap
```

执行结果：

```bash
$ ./shared_memory_mmap 
Hello, GetIoT.tech!
```



## mmap 和 shmget 的区别

Linux 系统中，shmget 和 mmap 接口都可以用来创建共享内存。

shmget 函数创建的共享内存是由操作系统内核进行管理，它是一块共享的物理内存，不会占用进程的虚拟地址空间。在使用 shmget 创建的共享内存时，需要调用 shmat 函数将共享内存映射到进程的虚拟地址空间中。shmget 适用于进程间需要共享数据，但数据量较大的情况。

mmap 函数创建的共享内存则是通过文件系统实现的，它将文件映射到进程的虚拟地址空间中，可以被所有映射它的进程共享。mmap 适用于进程间需要共享小量数据或者一些状态信息的情况。

总体来说，两种方式都可以用于实现进程间的共享内存，不同的是它们的使用场景略有不同。shmget 适用于大数据量的共享，mmap 适用于小数据量的共享。此外，由于 mmap 的实现方式，mmap 所创建的共享内存可以被多个进程在不同的机器上共享，而 shmget 只能在同一台机器上的进程之间共享。

