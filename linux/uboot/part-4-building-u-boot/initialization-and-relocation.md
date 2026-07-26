---
sidebar_position: 6
sidebar_label: 初始化、重定位与主循环
slug: /initialization-and-relocation
---

# U-Boot 初始化、重定位与主循环

U-Boot 启动后不是直接进入命令行。它需要先完成一系列初始化，等内存、console、设备模型和环境变量准备好后，才会进入主循环并等待你的命令。

本章会涉及源码路径，但目标不是让你背完整调用栈。你只需要先建立一张大地图：早期初始化做什么，为什么要重定位，什么时候进入主循环。

## 1. 两个重要阶段

可以先把 U-Boot proper 的启动粗略分成两段：

- `board_init_f()`：早期初始化，运行条件有限，通常还没有完整运行环境。
- `board_init_r()`：重定位之后的初始化，运行环境更完整，最终进入主循环。

源码中可以这样查找：

```bash
# [Host]
rg "void board_init_f|board_init_r" common arch
```

在 U-Boot v2026.07 中，你还可以重点查看：

```bash
# [Host]
sed -n '1,220p' common/board_f.c
sed -n '1,220p' common/board_r.c
```

这两个文件里有初始化序列。不要一开始逐行细读，先看函数名和注释，理解每个阶段大概在准备什么。

## 2. 为什么要重定位

许多平台上，U-Boot 最初运行的位置并不是最终位置。早期代码可能在 ROM 映射区、SRAM 或固件加载地址处运行。等 DRAM 初始化完成后，U-Boot 会把自己搬到更合适的 DRAM 高地址区域，这个过程叫 relocation。

重定位之后，U-Boot 可以拥有更完整的栈、堆、全局数据和驱动运行环境。

你可以从 `bdinfo` 观察重定位相关信息：

```bash
# [U-Boot]
bdinfo
```

重点看 `relocaddr`、`reloc off`、`malloc_start`、`malloc_end` 等字段。不同平台输出可能不同，但它们能帮助你理解 U-Boot 运行位置和内存分配区域。

## 3. 早期初始化通常做什么

早期初始化阶段资源有限，所以它通常只做必须的事：

- 建立临时栈。
- 准备 Global Data。
- 初始化最基本的 console。
- 获取或初始化 DRAM 信息。
- 计算重定位地址。
- 准备把 U-Boot 搬到 DRAM 中运行。

在这个阶段，很多驱动和命令还不能用。真实硬件上如果卡在这里，可能连完整错误日志都没有。

## 4. 重定位后初始化通常做什么

重定位后，U-Boot 有了更完整的运行环境，才会继续：

- 初始化 malloc。
- 初始化 Driver Model。
- 加载 environment。
- 初始化存储、网络、USB 等设备。
- 设置 console 输入输出。
- 进入主循环。

这也是为什么有些日志在 `DRAM` 之后才出现，有些设备只有进入命令行后才可见。

## 5. Global Data

U-Boot 使用 `gd` 保存全局状态，例如：

- 重定位地址。
- malloc 区域。
- console 状态。
- board 信息。
- device model 根节点。

你在源码中会看到很多 `gd->xxx`。初学时不必记住每个字段，但要知道它是连接早期初始化和正常运行阶段的重要结构。

如果你想看结构定义，可以搜索：

```bash
# [Host]
rg "struct global_data" include arch
```

不同架构可能会扩展自己的字段。初学阶段不要陷入字段细节，先知道它是全局运行状态的集合。

## 6. 主循环

初始化完成后，U-Boot 会进入主循环。主循环大致负责：

- 处理自动启动倒计时。
- 执行 `bootcmd`。
- 如果自动启动被中断，进入命令行。
- 读取输入并执行命令。

你可以从源码中查找：

```bash
# [Host]
rg "main_loop" common
```

主循环通常会处理 `bootdelay` 和 `bootcmd`。如果自动启动被中断，你才会看到 `=>` 命令提示符。也就是说，命令行不是 U-Boot 的起点，而是初始化完成后的交互入口。

## 7. 从日志观察阶段

启动日志中的 `DRAM`、`Core`、`Flash`、`Loading Environment`、`In/Out/Err`、`Net` 等信息，往往对应不同初始化步骤。你不需要一开始就记住源码调用链，但应该学会把日志当成事件时间线。

可以按下面方式阅读：

1. 版本横幅：确认运行的 U-Boot 版本。
2. DRAM：确认内存被识别。
3. Core/malloc：确认基础运行环境。
4. Environment：确认环境变量从哪里来。
5. Console：确认输入输出设备。
6. Net/Storage：确认设备初始化。
7. Autoboot：确认自动启动逻辑。

如果日志停在某一行，优先排查该阶段刚要初始化的资源。

## 8. QEMU 与真实硬件的差异

QEMU ARM64 `virt` 省略了很多真实硬件早期难题。真实开发板上，DRAM 初始化、时钟、pinmux、电源、SPL 和外部固件都可能影响 U-Boot 是否能走到主循环。

所以本章的初始化模型可以迁移，但不要把 QEMU 日志的每一行顺序当成所有开发板的标准答案。

## 本章小结

U-Boot 的初始化路径可以先按“早期初始化、重定位、后期初始化、主循环”理解。这个框架能帮助你读启动日志，也能帮助你定位某个驱动或命令为什么还不可用。

## 思考与练习

1. 使用 `bdinfo` 找到 `relocaddr`。
2. 在源码中找到 `board_init_f()` 和 `board_init_r()`。
3. 解释为什么某些设备命令不能在早期初始化阶段使用。
