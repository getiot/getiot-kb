---
sidebar_position: 1
sidebar_label: Proc 文件系统
slug: /linux-proc-filesystem
authors: [luhuadong]
---

# Linux Proc 文件系统



## 概述

Linux 系统上的 /proc 目录是一种文件系统，即 proc 文件系统（procfs），它以文件系统的方式为用户提供访问系统内核数据的操作接口。proc 文件系统是一种内核和内核模块用来向进程（process）发送信息的机制，因此被称为 proc。

与其它常见的文件系统不同的是，proc 是一种伪文件系统（也即虚拟文件系统），它只存在于内存当中，因此它会在系统启动时创建并挂载到 /proc 目录，在系统关闭时卸载并释放。

下面是某设备上 /proc 的挂载信息。 

```bash
$ mount | grep proc
proc on /proc type proc (rw,relatime)
```

Proc 文件系统存储的是当前内核运行状态的一系列特殊文件，用户可以通过这些文件查看系统和进程的信息，或者改变内核的运行状态，因此可以把它视为 Linux 内核开放给用户的控制和信息中心。实际上，proc 文件系统是内核空间和用户空间之间的一种通信媒介。

![Linux Proc 文件系统](https://static.getiot.tech/linux-proc-filesystem-work.png#center)



## /proc 目录

### 进程目录

在 Linux 系统中，每一个运行的进程在 /proc 下都有一个以该进程 PID 命名的专属目录，包括内核进程。

```bash
$ ls -l /proc/ | head
total 0
dr-xr-xr-x  9 root             root                 0 6月   1 08:48 1
dr-xr-xr-x  9 root             root                 0 6月   3 13:52 10
dr-xr-xr-x  9 www-data         www-data             0 6月   3 13:52 1000
dr-xr-xr-x  9 www-data         www-data             0 6月   3 13:52 1001
dr-xr-xr-x  9 rudy             rudy                 0 6月   3 13:52 100743
dr-xr-xr-x  9 root             root                 0 6月   3 13:52 101
dr-xr-xr-x  9 rudy             rudy                 0 6月   3 13:52 101638
dr-xr-xr-x  9 rudy             rudy                 0 6月   3 13:52 101640
dr-xr-xr-x  9 rudy             rudy                 0 6月   3 13:52 101641
```

进程目录是读取进程信息的接口，其中包含许多文件和子目录。

```bash
total 0
-rw-r--r--  1 mandeep mandeep 0 Apr  1 01:14 oom_score_adj
dr-xr-xr-x 13 mandeep mandeep 0 Apr  1 01:14 task
-r--r--r--  1 mandeep mandeep 0 Apr  1 01:16 status
-r--r--r--  1 mandeep mandeep 0 Apr  1 01:16 stat
-r--r--r--  1 mandeep mandeep 0 Apr  1 01:16 cmdline
-r--r--r--  1 mandeep mandeep 0 Apr  1 01:17 wchan
-rw-r--r--  1 mandeep mandeep 0 Apr  1 01:17 uid_map
-rw-rw-rw-  1 mandeep mandeep 0 Apr  1 01:17 timerslack_ns
-r--r--r--  1 mandeep mandeep 0 Apr  1 01:17 timers
-r--------  1 mandeep mandeep 0 Apr  1 01:17 syscall
-r--r--r--  1 mandeep mandeep 0 Apr  1 01:17 statm
-r--------  1 mandeep mandeep 0 Apr  1 01:17 stack
-r--r--r--  1 mandeep mandeep 0 Apr  1 01:17 smaps
-rw-r--r--  1 mandeep mandeep 0 Apr  1 01:17 setgroups
-r--r--r--  1 mandeep mandeep 0 Apr  1 01:17 sessionid
-r--r--r--  1 mandeep mandeep 0 Apr  1 01:17 schedstat
-rw-r--r--  1 mandeep mandeep 0 Apr  1 01:17 sched
lrwxrwxrwx  1 mandeep mandeep 0 Apr  1 01:17 root -> /proc/2341/fdinfo
-rw-r--r--  1 mandeep mandeep 0 Apr  1 01:17 projid_map
-r--------  1 mandeep mandeep 0 Apr  1 01:17 personality
...
```

下表是 `/proc/<PID>` 进程目录常用文件和子目录说明。

| 目录              | 描述                                                         |
| ----------------- | ------------------------------------------------------------ |
| /proc/PID/cmdline | 启动当前进程的完整命令，但僵尸进程目录中的此文件不包含任何信息。 |
| /proc/PID/cwd     | 指向当前进程运行目录的一个符号链接。                         |
| /proc/PID/environ | 进程环境变量列表。                                           |
| /proc/PID/exe     | 指向启动当前进程的可执行文件（完整路径）的符号链接，可以通过它来启动当前进程的一个拷贝。 |
| /proc/PID/fd      | 包含进程相关的所有的文件描述符。                             |
| /proc/PID/maps    | 与进程（可执行文件和库）相关的内存映射信息。                 |
| /proc/PID/mem     | 指代进程持有的内存，不可读。                                 |
| /proc/PID/root    | 链接到进程的根目录。                                         |
| /proc/PID/stat    | 进程状态信息。                                               |
| /proc/PID/statm   | 进程使用的内存状态信息。                                     |
| /proc/PID/status  | 进程状态信息，比 stat/statm 更具可读性。                     |
| /proc/self        | 链接到当前正在执行的进程。                                   |

除了通过 `/proc/<PID>` 来获取指定进程的信息，Linux 还提供了一个有趣的 `/proc/self` 目录。这个目录的特别之处在于，不同的进程访问该目录时获得的信息是不同的，进程通过访问 `/proc/self` 目录可以获取该进程自己的信息，而不用每次都获取 PID，内容等价于 `/proc/<self-pid>`。在 fork、daemon 等 PID 可能发生变化的情形下很实用。



### 子文件

除了获取进程信息，我们通常还会用 /proc 来追踪进程的状态、内核的状态、内存信息、CPU 使用率、系统启动时间（可以使用系统正常运行时间）等相应的信息。

/proc 目录中的文件及其说明如下：

| 文件                | 描述                                                         |
| ------------------- | ------------------------------------------------------------ |
| /proc/buddyinfo     | 每个内存区中的每个 order 有多少块可用，和内存碎片问题有关。  |
| /proc/cmdline       | 启动时传递给 kernel 的参数信息。                             |
| /proc/cpuinfo       | CPU 信息。                                                   |
| /proc/crypto        | 内核可用的加密模块及细节。                                   |
| /proc/devices       | 已装载的设备（包括字符设备和块设备）。                       |
| /proc/diskstats     | 每个逻辑磁盘设备的信息（包括设备编号） 。                    |
| /proc/dma           | 已注册使用的 ISA DMA 通道列表。                              |
| /proc/execdomains   | Linux 内核当前支持的 execution domains。                     |
| /proc/fb            | 帧缓冲设备列表，包括数量和控制它的驱动。                     |
| /proc/filesystems   | 内核当前支持的文件系统类型。                                 |
| /proc/interrupts    | 当前系统使用的中断信息。                                     |
| /proc/iomem         | 每个物理设备当前在系统内存中的映射。                         |
| /proc/ioports       | 一个设备的输入输出所使用的注册端口范围。                     |
| /proc/kcore         | 代表系统的物理内存，存储为核心文件格式。                     |
| /proc/kmsg          | 等待内核输出信息，可以通过 /sbin/klogd 或 /bin/dmesg 来处理。 |
| /proc/loadavg       | 依据过去一段时间内 CPU 和 IO 的状态得出的负载形态，与 uptime 命令有关。 |
| /proc/locks         | 内核锁住的文件列表。                                         |
| /proc/mdstat        | 多硬盘，RAID 配置信息（md=multiple disks）。                 |
| /proc/meminfo       | 内核管理内存的信息。                                         |
| /proc/misc          | 在杂项设备（设备号为10）上注册的驱动。                       |
| /proc/modules       | 所有装载到内核的模块列表。                                   |
| /proc/mounts        | 系统当前的所有挂载信息。                                     |
| /proc/mtrr          | 系统使用的 Memory Type Range Registers（MTRRs）。            |
| /proc/partitions    | 磁盘分区中的块分配信息。                                     |
| /proc/slabinfo      | 系统中所有活动的 slab 缓存信息。                             |
| /proc/stat          | 所有的 CPU 活动信息。                                        |
| /proc/sysrq-trigger | 该文件是只写的。使用 echo 命令来写这个文件的时候，远程 root 用户可以执行大多数的系统请求关键命令，就好像在本地终端执行一样。要写入这个文件，需要把 /proc/sys/kernel/sysrq 设置为1，开启 SysRq（Magic System Request Key）功能。 |
| /proc/uptime        | 系统自开机以来的运行时间。                                   |
| /proc/schedstat     | kernel 调度器的统计信息。                                    |
| /proc/swaps         | 交换区域的使用情况。                                         |
| /proc/version       | 当前 Linux 内核版本、发行版号、gcc 版本号、更新时间等信息。  |
| /proc/vmcore        | 内核 panic 时的内存映像。                                    |
| /proc/vmstat        | 虚拟内存统计信息。                                           |
| /proc/zoneinfo      | 显示内存空间的统计信息，对分析虚拟内存行为很有用。           |



### 子目录

/proc 目录中的子目录及其说明如下：

| 子目录              | 描述                                                         |
| ------------------- | ------------------------------------------------------------ |
| /proc/acpi          | 高级配置和电源接口。如果内核在引导系统时检测到 ACPI BIOS，将会自动激活 ACPI。 |
| /proc/asound        | ALSA 声卡设备信息。                                          |
| /proc/bus           | 系统总线（Bus）信息，例如 /proc/bus/input/、/proc/bus/pci 等。 |
| /proc/device-tree   | 设备树信息。                                                 |
| /proc/driver        | 驱动信息。                                                   |
| /proc/dynamic_debug | 控制动态打印调试。                                           |
| /proc/fs            | 文件系统信息。                                               |
| /proc/irq           | 中断请求设备信息。                                           |
| /proc/net           | 网卡设备信息。例如 /proc/net/dev 显示网络适配器及统计信息。  |
| /proc/pressure      | 系统资源的压力信息，包括 cpu、io 和 memory。                 |
| /proc/scsi          | scsi 设备信息（通过 SCSI 或 RAID 控制器连接的所有设备）。    |
| /proc/sys           | 包括所有的内核参数信息，与 `sysctl -a` 相似                  |
| /proc/sysvipc       | 系统 ipc 信息，包括 msg、sem 和 shm。                        |
| /proc/tty           | tty 设备信息。                                               |

注意：上述文件和目录并不一定都会出现在你的系统，这取决于 Linux 系统内核的配置和装载的模块。

