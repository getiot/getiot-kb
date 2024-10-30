---
sidebar_label: ps 命令
sidebar_position: 1
slug: /ps
---

# Linux ps 命令 - 显示当前运行的进程



## 介绍

**ps**（英文全拼：process status）是 Linux 系统中非常常用的一个命令，用于查看当前运行的进程状态，类似于 Windows 的任务管理器。通过 ps 命令，我们可以获取进程的 ID、父进程 ID、优先级、执行时间、CPU 使用情况等关键信息。

### 命令语法

```bash
ps [选项]
```

### 选项参数

ps 命令的选项参数非常多，可以分为 simple、list、output、threads、misc 五大类，可以通过如下命令查看详细说明。

```bash
ps --help <simple|list|output|threads|misc|all>
# 或者
ps --help <s|l|o|t|m|a>
```

下面列出比较常用的一些选项参数：

**简单的进程选择（simple）**

- `-A`：列出所有的进程。
- `-e`：此选项的效果和指定"A"选项相同。
- `-a`：选择由终端（tty）启动的所有进程。
- `r`：只选择运行中的进程。
- `T`：只选择当前终端启动的进程。
- `x`：脱离终端控制的进程。

**通过列表选择进程（list）**

- `-C <cmdlist>`：cmdlist 可以是一个或多个进程名称，中间使用逗号分隔。
- `-G, --Group <GID>`：通过组 ID 或组名称选择进程。
- `-p, p, --pid <PID>`：根据进程 ID 选择进程。
- `--ppid <PID>`：根据父进程 ID 选择进程。
- `-u, U, --user <UID>`：根据用户 ID 或用户名称选择进程。

**输出格式控制（output）**

- `-f`：显示 UID、PPIP、C 与 STIME 栏目，f 代表 full format。
- `-o, o, --format <format>`：用户定义的格式，format 是列名，可以输出多个列，中间使用逗号分隔。

**多线程进程（threads）**

- `H`：显示进程层次结构。
- `-L`：可能使用 LWP 和 NLWP 色谱柱。
- `-T`：可能带有 SPID 列。

**其他（misc）**

- `-w`：显示加宽可以显示较多信息

ps 命令有两种展示风格：

|          | `ps -ef` 命令        | `ps aux` 命令     |
| -------- | -------------------- | ----------------- |
| 展示风格 | System V 风格        | BSD 风格          |
| 指令名称 | 显示带全路径的进程名 | 会截断 command 列 |



## 示例

### 查看进程（System V 风格）

```bash
$ ps -ef | head
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 09:19 ?        00:00:03 /sbin/init splash
root         2     0  0 09:19 ?        00:00:00 [kthreadd]
root         4     2  0 09:19 ?        00:00:00 [kworker/0:0H]
root         6     2  0 09:19 ?        00:00:00 [mm_percpu_wq]
root         7     2  0 09:19 ?        00:00:00 [ksoftirqd/0]
root         8     2  0 09:19 ?        00:00:40 [rcu_sched]
root         9     2  0 09:19 ?        00:00:00 [rcu_bh]
root        10     2  0 09:19 ?        00:00:00 [migration/0]
root        11     2  0 09:19 ?        00:00:00 [watchdog/0]
```

列表含义：

- `UID` ：程序被该 UID 所拥有
- `PID` ：就是这个程序的进程 ID
- `PPID` ：是其上级父进程的 ID
- `C` ：表示 CPU 使用的资源百分比
- `STIME` ：表示进程启动时间
- `TTY` ：登入者的终端机位置
- `TIME` ：使用掉的 CPU 时间
- `CMD` ：所下达的指令为何

### 查看进程（BSD 风格）

`ps aux` 表示显示所有包含其他使用者的行程。

```bash
$ ps aux | head
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0 185576  6164 ?        Ss   09:19   0:03 /sbin/init splash
root         2  0.0  0.0      0     0 ?        S    09:19   0:00 [kthreadd]
root         4  0.0  0.0      0     0 ?        I<   09:19   0:00 [kworker/0:0H]
root         6  0.0  0.0      0     0 ?        I<   09:19   0:00 [mm_percpu_wq]
root         7  0.0  0.0      0     0 ?        S    09:19   0:00 [ksoftirqd/0]
root         8  0.1  0.0      0     0 ?        I    09:19   0:41 [rcu_sched]
root         9  0.0  0.0      0     0 ?        I    09:19   0:00 [rcu_bh]
root        10  0.0  0.0      0     0 ?        S    09:19   0:00 [migration/0]
root        11  0.0  0.0      0     0 ?        S    09:19   0:00 [watchdog/0]
```

列表含义：

- `USER` ：进程拥有者。
- `PID` ：进程 ID。
- `%CPU` ：进程占用的 CPU 使用率。
- `%MEM` ：进程占用的内存使用率。
- `VSZ` ：进程占用的虚拟内存大小（Virtual Memory Size）。注意：VSZ 表示进程占用的全部地址空间，共享库、预分配内存、交换分区等都包含在里面，因此 VSZ 远远大于实际的占用的内存空间。
- `RSS` ：进程占用的物理内存大小（Resident Set Size）。注意：RSS 表示进程实际占用的物理内存，它包含共享库，但不包含在交换分区的空间。随着程序的运行，RSS 也会跟着增长，VSZ 将是它的上限。
- `TTY` ：终端的次要装置号码（minor device number of tty）。`?` 是表示这些进程是由系统启动的，不属于任何 TTY；tty1-tty6 是本机登录用户启动的程序，pts/0 之类的则表示为由网络连接进主机的程序。
- `STAT` ：进程的状态，Linux 的进程有以下 5 种状态：
  - `D` ：不可中断 uninterruptible sleep（usually IO）
  - `R` ：运行 runnable（on run queue）
  - `S` ：中断 sleeping
  - `T` ：停止 traced or stopped
  - `Z` ：僵死 a defunct ("zombie") process
  - 注：其他状态还包括 `W`（无驻留页），`<`（高优先级进程），`N`（低优先级进程），`L`（内存锁页）。
- `START` ：进程开始时间。
- `TIME` ：进程执行时间，统计该进程消耗 CPU 的时间。
- `COMMAND` ：启动进程的命令。

### 显示指定用户信息

例如显示由 root 用户创建的所有进程：

```bash
$ ps -u root
```

### 列出一个进程创建的所有线程

下面列出了由进程号为 pid 的进程创建的所有线程：

```bash
$ ps -T -p <pid>
```

输出信息可能如下：

```bash
    PID    SPID TTY          TIME CMD
3057403 3057403 ?        00:06:01 chrome
3057403 3057478 ?        00:00:00 chrome:disk$0
3057403 3057495 ?        00:00:01 chrome:gdrv0
3057403 3057556 ?        00:00:00 GpuWatchdog
3057403 3057557 ?        00:00:00 ThreadPoolServi
3057403 3057558 ?        00:00:13 ThreadPoolForeg
3057403 3057559 ?        00:05:35 Chrome_ChildIOT
3057403 3057562 ?        00:14:22 VizCompositorTh
3057403 3057571 ?        00:00:00 chrome:disk$0
3057403 3075540 ?        00:00:00 MemoryInfra
3057403 3103487 ?        00:00:00 ThreadPoolSingl
3057403 3103488 ?        00:00:00 ThreadPoolSingl
3057403 3822403 ?        00:00:00 ThreadPoolForeg
```

其中，字段 `SPID` 为线程 ID，`CMD` 为线程名称。

### 根据进程名查找进程号

例如查找 mysqld 的进程号（PID）：

```bash
ps -C mysqld
```

此时输出如下：

```bash
    PID TTY          TIME CMD
   1834 ?        00:00:28 mysqld
```

PID 列为进程号，如果只想输出 PID，可以加上 `-o` 选项：

```bash
ps -C mysqld -o pid=
```

### 根据进程号查找进程名

例如查找 PID 为 1834 的进程名：

```bash
ps -p 1834
```

此时输出如下：

```bash
    PID TTY          TIME CMD
   1834 ?        00:00:28 mysqld
```

CMD 列为进程名称，如果只想输出进程名，可以加上 `-o` 选项：

```bash
$ ps -p 1834 -o cmd=
/usr/sbin/mysqld
$ ps -p 1834 -o comm=
mysqld
```

