---
sidebar_label: RTAI
sidebar_position: 14
slug: /rtai
---

# RTAI

**RTAI** 是实时应用接口 Real Time Application Interface 的缩写。它在 Linux 上定义了一组实时硬件抽象层 RTHAL（Real Time Hardware Abstraction Layer），RTHAL 将所有需要的 Linux 内部数据和函数的指针集合到一个 rthal 的结构中。Rthal 结构用于截取 Linux 硬件操作，在双内核结构工作时，它们可以被 RTAI 重定向，以取代 Linux 中原有的函数；同时 RTAI 只是用此程序界面与 Linux 进行沟通。通过这种方法就可以把对 Linux 内核源码的改动程度降到最低，可以避免 RT-Linux 方案对 Linux 内核源码改动过大的问题，便于在不同 Linux 版本之间的移植。

RTAI 严格来说只是一个具备了操作系统核心功能的实时的系统内核，它接管了所有的硬件资源，将 Linux 操作系统内核作为它的一个低优先级的任务来运行。RTAI 是一个完全的占先式内核，它具备了实时操作系统的诸多特性，如实时的中断响应，任务对事件的实时响应，细粒度的原子操作等。在 RTAI/Linux 双内核结构下，实时性的任务在 RTAI 的调度下运行，非实时性和需要利用完善的操作系统功能的任务在 Linux 调度下运行。由于 Linux 操作系统在 RTAI 下具有的优先级很低，当且仅当 RTAI 没有实时任务调度时，Linux 才能够得到运行。

RTAI 以 Linux 的内核模块的形式运行，提供双内核的实时服务。最基本的两个模块是 rtai_module 和 rtai_sched_module，另外还有三个增强功能的模块 rtai_fifos_module、rtai_shm_module 和 rtai_lxrt_module。

rtai_module 是一个核心模块，RTHAL 在这一模块里实现，完成对硬件的接管。以关硬件中断行为为例说明，Linux 系统中原有的关中断函数：

```c
#define _cli_asm_volatile_(“cli”:::”memory”)
```

直接通过汇编语言对硬件进行操作，而在 rtai_module 模块中，Linux 中的关中断函数被替换为执行 `processor[hard_cpu_id()].intr_flag = 0;`。可见，Linux 关中断的执行只是改变了 RTAI 中的中断标志位，并没有直接对硬件进行操作。

- rtai_sched_module 模块主要实现一个实时的任务调度，调度器基于优先级且为可抢占式的；
- rtai_fifos_module 是管道先入先出模块，负责实时应用与 Linux 应用之间的通讯；
- rtai_shm_module 模块实现共享内存的通讯方式；
- rtai_lxrt_module 允许在用户空间使用RTAI的系统服务和调度期。

## 参考

- [RTAI Beginner’s guide](https://www.rtai.org/Beginner's-guide.html)
