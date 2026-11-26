---
sidebar_position: 4
---

# Valgrind 内存泄漏检测工具



Valgrind 是 Linux 系统中一款内存泄漏（Memory Leak）检测工具，本文主要介绍 Valgrind 的工作原理及其基本用法。



## Valgrind 简介

Valgrind 是一套 Linux 下的开源仿真调试工具集，遵循 GPLv2 许可协议，可用于内存调试、内存泄漏检测以及性能分析。

Valgrind 由内核（core）以及基于内核的其他调试工具组成，内核类似于一个框架（framework），它模拟了一个 CPU 环境，并提供服务给其他工具；而其他工具则类似于插件 (plug-in)，利用内核提供的服务完成各种特定的内存调试任务。

![Valgrind 内存泄漏检测工具](https://static.getiot.tech/valgrind.jpg#center)

## Valgrind 工具

Valgrind 包含下列一些工具：

**Memcheck**：内存错误检测器（memory error detector），这是最常用的工具，用于检测程序中的内存问题，如泄漏、越界、非法指针等。memcheck 会检测所有对内存的读写操作，一切对 `malloc()`、`free()`、`new` 和 `delete` 的调用都会被捕获，所以能检测以下问题：

  1. 对未初始化内存的使用；
  2. 读/写释放后的内存块；
  3. 读/写超出 malloc 分配的内存块；
  4. 读/写不适当的栈中内存块；
  5. 内存泄漏，指向一块内存的指针永远丢失；
  6. 不正确的 malloc/free 或 new/delete 匹配；
  7. memcpy() 相关函数中的 dst 和 src 指针重叠。

**Cachegrind**：缓存和分支预测探查器（cache and branch-prediction profiler），分析 CPU 的 cache 命中率、丢失率，用于进行代码优化。它模拟 CPU 中的一级缓存 I1，Dl 和二级缓存，能够精确地指出程序中 cache 的丢失和命中。如果需要，它还能够为我们提供 cache 丢失次数，内存引用次数，以及每行代码，每个函数，每个模块，整个程序产生的指令数，这对优化程序有很大的帮助。

**Callgrind**：生成调用图的缓存和分支预测探查器（call-graph generating cache and branch-prediction profiler），是 cachegrind 的扩展，用于检测程序代码的运行时间和调用过程，以及分析程序性能。callgrind 收集程序运行时的一些数据，建立函数调用关系图，还可以有选择地进行 cache 模拟。在运行结束时，它会把分析数据写入 一个文件。callgrind_annotate 可以把这个文件的内容转化成可读的形式。

**Massif**：堆栈探查器/分析器（heap profilers），它能测量程序在堆栈中使用了多少内存，告诉我们堆块，堆管理块和栈的大小。Massif 能帮助我们减少内存的使用，在带有虚拟内存的现代系统中，它还能够加速我们程序的运行，减少程序停留在交换区中的几率。

**Helgrind**：线程错误检测器（thread error detectors），用于检查多线程程序的竞态条件。helgrind 寻找内存中被多个线程访问，而又没有一贯加锁的区域，这些区域往往是线程之间失去同步的地方，而且会导致难以发掘的错误。helgrind 实现了名为“Eraser”的竞争检测算法，并做了进一步改进，减少了报告错误的次数。

此外，Valgrind 还有提供了 **Lackey** 和 **Nulgrind** 工具。Lackey 是小型工具，很少用到；Nulgrind 只是为开发者展示如何创建一个工具。这里不作介绍。

Valgrind 的体系结构如下图所示：

![](https://static.getiot.tech/valgrind-framework.png#center)

更多内容可查阅 [https://valgrind.org/info/tools.html](https://valgrind.org/info/tools.html)



## Valgrind 安装

Debian 和 Ubuntu 可使用 apt 安装

```bash
sudo apt install valgrind
```

CentOS 和 Fedora 可使用 yum 或 dnf 安装

```bash
sudo yum install valgrind
sudo dnf install valgrind
```

Arch Linux 可使用 pacman 安装

```bash
sudo pacman -S valgrind
```

亦可使用源码编译安装（可以在 [valgrind 官网](https://www.valgrind.org/downloads/current.html) 下载源码压缩包，比如 valgrind-3.17.0）

```bash
wget https://sourceware.org/pub/valgrind/valgrind-3.17.0.tar.bz2
tar -xf valgrind-3.17.0.tar.bz2
cd valgrind-3.17.0
./configure
make
make install
```

检查是否安装成功

```bash
valgrind --version
```



## 使用示例

### 内存泄漏

在源文件 memoryLeak.c 中申请一块内存空间，但不释放，如下：

```c showLineNumbers title="memoryLeak.c"
#include <stdlib.h>

int main(void)
{
    // create an array of ARR_SIZE ints
    int *intArray = malloc(sizeof(int) * 1000);

    // end without freeing!
    return 0;
}
```

编译，生成 memoryLeak

```bash
gcc memoryLeak.c -o memoryLeak
```

使用 valgrind 对程序进行检测

```bash
valgrind ./memoryLeak
```

分析结果如下：

```bash
==8079== Memcheck, a memory error detector
==8079== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==8079== Using Valgrind-3.15.0 and LibVEX; rerun with -h for copyright info
==8079== Command: ./memoryLeak
==8079==
==8079==
==8079== HEAP SUMMARY:
==8079==     in use at exit: 4,000 bytes in 1 blocks
==8079==   total heap usage: 1 allocs, 0 frees, 4,000 bytes allocated
==8079==
==8079== LEAK SUMMARY:
==8079==    definitely lost: 4,000 bytes in 1 blocks
==8079==    indirectly lost: 0 bytes in 0 blocks
==8079==      possibly lost: 0 bytes in 0 blocks
==8079==    still reachable: 0 bytes in 0 blocks
==8079==         suppressed: 0 bytes in 0 blocks
==8079== Rerun with --leak-check=full to see details of leaked memory
==8079==
==8079== For lists of detected and suppressed errors, rerun with: -s
==8079== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
```

可以看到第 9 行显示，申请了 1 个 4000 字节的内存空间，但是没有释放。

添加 `--leak-check=full` 参数，可以看到内存泄漏的更多细节。

```bash
valgrind --leak-check=full ./memoryLeak
```

输出结果：

```bash
==8183== Memcheck, a memory error detector
==8183== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==8183== Using Valgrind-3.15.0 and LibVEX; rerun with -h for copyright info
==8183== Command: ./memoryLeak
==8183==
==8183==
==8183== HEAP SUMMARY:
==8183==     in use at exit: 4,000 bytes in 1 blocks
==8183==   total heap usage: 1 allocs, 0 frees, 4,000 bytes allocated
==8183==
==8183== 4,000 bytes in 1 blocks are definitely lost in loss record 1 of 1
==8183==    at 0x483B7F3: malloc (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==8183==    by 0x109167: main (memoryLeak.c:6)
==8183==
==8183== LEAK SUMMARY:
==8183==    definitely lost: 4,000 bytes in 1 blocks
==8183==    indirectly lost: 0 bytes in 0 blocks
==8183==      possibly lost: 0 bytes in 0 blocks
==8183==    still reachable: 0 bytes in 0 blocks
==8183==         suppressed: 0 bytes in 0 blocks
==8183==
==8183== For lists of detected and suppressed errors, rerun with: -s
==8183== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 from 0)
```

可以看到第 13 行显示，内存泄漏发生在 memoryLeak.c 的第 6 行代码。

接着，我们增加一行代码修复内存泄漏。

```c showLineNumbers title="memoryLeak.c"
#include <stdlib.h>

int main(void)
{
    // create an array of ARR_SIZE ints
    int *intArray = malloc(sizeof(int) * 1000);

    // end without freeing!
    free(intArray);
    return 0;
}
```

重新编译并检测

```bash
gcc memoryLeak.c -o memoryLeak
valgrind ./memoryLeak
```

输出结果如下：

```bash
==8426== Memcheck, a memory error detector
==8426== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==8426== Using Valgrind-3.15.0 and LibVEX; rerun with -h for copyright info
==8426== Command: ./memoryLeak
==8426==
==8426==
==8426== HEAP SUMMARY:
==8426==     in use at exit: 0 bytes in 0 blocks
==8426==   total heap usage: 1 allocs, 1 frees, 4,000 bytes allocated
==8426==
==8426== All heap blocks were freed -- no leaks are possible
==8426==
==8426== For lists of detected and suppressed errors, rerun with: -s
==8426== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
```

可以看到，内存泄漏已经消除。



