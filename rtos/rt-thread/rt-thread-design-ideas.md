---
sidebar_position: 6
authors: [luhuadong]
---

# RT-Thread 设计思想



RT-Thread 有许多巧妙的设计思想，篇幅有限，这里先介绍几个，其他留给您慢慢探索。

### 任务调度

RT-Thread 支持多任务，允许多个任务同时运行，但并不是真正的同时运行（对于单核的 MCU），而是宏观上的并行，这就需要线程调度器（任务调度器）来完成任务的调度了。

![](https://static.getiot.tech/20201226034909451.png)


RT-Thread 最大支持 256 级优先级（0~255），数值越小优先级越高。可以根据实际情况选择 8 或 32 级，对于 ARM Cortex-M 系列，通常采用 32 级优先级。

调度器是操作系统的核心，其主要功能就是实现线程的切换。RT-Thread 通过管理就绪列表，当需要调度时可以直接找出就绪列表中优先级最高的线程，然后执行该线程，时间复杂度为 O(1)。

```c
/* ready thread list */
rt_list_t rt_thread_priority_table[RT_THREAD_PRIORITY_MAX];

/* get highest ready priority thread */
highest_priority_thread = rt_list_entry(rt_thread_priority_table[highest_ready_priority].next,
                          struct rt_thread,
                          tlist);
```

同时，RT-Thread 还采用 round-robin 策略确保对具有相同优先级的所有线程进行同等调度。RT-Thread 的每个线程都有时间片参数，如果您希望控制相同优先级的多个线程的单次运行时长，可以分别给它们设置不同的时间片。



### 启动流程

RT-Thread 系统的初始化在 main() 函数之前，这意味着您不需要操心 RT-Thread 的初始化操作，可以专心编写应用程序。

RT-Thread 还提供了自动初始化机制，初始化函数只需要在函数定义处通过宏定义的方式进行声明，就会在系统启动过程中自动执行，不需要在应用代码中显示调用，相当优雅。

针对不同层级，RT-Thread 提供了不同的宏接口：

| **初始化顺序** | **宏接口**                  | **描述**                                     |
| -------------- | --------------------------- | -------------------------------------------- |
| 1              | `INIT_BOARD_EXPORT(fn)`     | 非常早期的初始化，此时调度器还未启动         |
| 2              | `INIT_PREV_EXPORT(fn)`      | 主要是用于纯软件的初始化、没有太多依赖的函数 |
| 3              | `INIT_DEVICE_EXPORT(fn)`    | 外设驱动初始化相关，比如网卡设备             |
| 4              | `INIT_COMPONENT_EXPORT(fn)` | 组件初始化，比如文件系统或者 LWIP            |
| 5              | `INIT_ENV_EXPORT(fn)`       | 系统环境初始化，比如挂载文件系统             |
| 6              | `INIT_APP_EXPORT(fn)`       | 应用初始化，比如 GUI 应用                    |



### 内核对象

RT-Thread 内核采用面向对象的设计思想进行设计，系统级的基础设施都是内核对象，比如线程、信号量、互斥量、事件、邮箱、消息队列、定时器、内存池、设备驱动等等。然后通过内核对象管理系统来访问/管理所有内核对象，例如当您创建一个对象时，内核对象管理系统就会将这个对象放到一个叫对象容器的地方。

![](https://static.getiot.tech/20201226034936434.png)


这样做是为了方便管理内核资源，在后续的开发调试阶段可以很方便地获取各个内核对象的状态，并通过 FinSH 输出调试信息。



### FinSH 控制台

FinSH 是 RT-Thread 最早的组件之一，提供了一套类似于 Linux Shell 的操作接口，您可以通过 串口/以太网/USB 等方式与 PC 机进行通信，通过命令行查看系统信息或用于调试。

![](https://static.getiot.tech/20201226034959152.png)


RT-Thread 默认内置了一些 FinSH 命令，比如 `list_thread` 和 `ps` 用于查看线程信息，`list_sem` 用于查看系统信号量信息，`free` 用于查看系统内存使用情况等等。如果开启 DFS 组件，还可以使用 `ls`、`cd`、`cp` 等命令操作文件系统。
