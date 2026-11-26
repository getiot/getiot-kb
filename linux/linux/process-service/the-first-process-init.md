---
sidebar_position: 3
sidebar_label: 一号进程
slug: /the-first-process-init
authors: [luhuadong]
---

# Linux 一号进程

在 Linux 中，每个进程都有一个 PID。PID 是 Process ID 的缩写，也就是进程编号。

PID 为 `1` 的进程很特殊，它通常是系统启动后进入用户空间的第一个长期存在的进程。我们常把它叫做“一号进程”，也常叫 `init` 进程。

理解一号进程，你就能更容易理解 Linux 是如何启动系统服务、管理后台进程、完成关机重启，以及为什么现代 Linux 经常把 systemd 放在核心位置。

## 查看一号进程

在终端中运行：

```bash
ps -p 1
```

在许多现代 Linux 发行版中，你会看到类似输出：

```text
    PID TTY          TIME CMD
      1 ?        00:00:05 systemd
```

这说明当前系统的一号进程是 `systemd`。

你也可以查看更完整的信息：

```bash
ps -p 1 -o pid,ppid,user,stat,comm,args
```

输出可能类似：

```text
    PID    PPID USER     STAT COMMAND         COMMAND
      1       0 root     Ss   systemd         /sbin/init
```

这里有几个点值得注意：

- `PID` 是 `1`。
- `PPID` 是 `0`，表示它不是由普通用户进程创建的。
- `USER` 通常是 `root`。
- `COMMAND` 可能显示 `systemd`，也可能显示 `/sbin/init`。

## /sbin/init 是什么

很多系统中，`/sbin/init` 是一个符号链接。你可以查看它指向哪里：

```bash
ls -l /sbin/init
```

在使用 systemd 的系统中，输出可能类似：

```text
lrwxrwxrwx 1 root root 20 Mar 18 05:36 /sbin/init -> /lib/systemd/systemd
```

也可能是：

```text
/sbin/init -> /usr/lib/systemd/systemd
```

路径因发行版而异，但意思类似：内核启动用户空间时执行的是 `/sbin/init`，而这个入口最终指向 systemd。

:::note
不要把 `/sbin/init` 理解成某个固定实现。它是“系统初始化程序”的传统入口，背后可能是 systemd、SysV init、BusyBox init、OpenRC、runit、s6 等不同实现。
:::

## Linux 启动到一号进程的大致过程

一台 Linux 机器启动时，大致经历这些阶段：

1. 固件启动硬件，例如 BIOS 或 UEFI。
2. Bootloader 加载 Linux kernel，例如 GRUB、U-Boot。
3. Linux kernel 初始化 CPU、内存、驱动和根文件系统。
4. kernel 启动第一个用户空间进程。
5. 一号进程继续启动系统服务、挂载文件系统、进入可登录状态。

在普通发行版中，你最终看到的一号进程通常是 systemd。在嵌入式系统中，可能是 BusyBox init。在容器中，PID 1 甚至可能就是你的应用程序。

有些系统还会使用 initramfs。initramfs 是启动早期的临时根文件系统，里面也可能有一个早期 `/init`。它完成磁盘解密、加载驱动、挂载真正根文件系统等工作后，再切换到真正系统中的 init。对初学者来说，你可以先记住：最终负责长期管理用户空间的那个 PID 1，才是我们日常讨论的一号进程。

## 一号进程负责什么

一号进程的职责可以概括为：把系统带起来，并在系统运行期间维持用户空间秩序。

常见职责包括：

- 启动系统服务。
- 管理服务依赖关系。
- 挂载必要文件系统。
- 准备登录终端或图形界面。
- 接管孤儿进程。
- 回收子进程退出状态，避免僵尸进程长期堆积。
- 处理关机、重启、休眠等系统级动作。

其中“接管孤儿进程”和“回收子进程”对初学者不太直观，但很重要。

## 孤儿进程和僵尸进程

一个进程通常由另一个进程创建。创建者叫父进程，被创建者叫子进程。

如果父进程先退出，子进程还在运行，这个子进程就会变成孤儿进程。传统情况下，孤儿进程会被一号进程接管。现代 Linux 中还存在 subreaper 机制，某些进程也可以承担类似“中间收养者”的角色，但 PID 1 仍然是最终兜底者。

当子进程结束后，父进程需要读取它的退出状态。如果父进程一直不读取，子进程就会短暂停留为僵尸进程。僵尸进程本身不再运行，但还占着进程表记录。

一号进程必须能正确回收它负责的子进程，否则系统中可能出现大量僵尸进程。

你可以用下面命令观察父子关系：

```bash
ps -eo pid,ppid,stat,comm | head
```

其中：

- `PID` 是进程自己的编号。
- `PPID` 是父进程编号。
- `STAT` 中如果出现 `Z`，表示僵尸进程。

## 为什么现代系统多使用 systemd

早期 Linux 系统常使用 SysV init。SysV init 按运行级别和脚本目录启动服务，例如 `/etc/init.d/` 和 `/etc/rc*.d/`。

后来一些发行版使用过 Upstart。现在许多主流发行版默认使用 systemd。

systemd 不只是一个 PID 1 程序，它还提供了一套系统管理框架，包括：

- service：管理系统服务。
- target：组织系统状态，类似但不等同于传统 runlevel。
- socket：按需激活服务。
- timer：定时任务。
- mount：管理挂载点。
- journal：收集日志。
- cgroup 集成：跟踪和限制服务进程。

你在日常使用中最常接触的是 [systemctl](/linux-command/systemctl/)：

```bash
systemctl status
systemctl list-units --type=service --state=running
```

查看系统日志时常用：

```bash
journalctl -b
```

关于 systemd 服务文件和开机启动，可以继续阅读 [Linux 系统服务管理](linux-systemd.md)。

## init 和 runlevel、target 的关系

传统 SysV init 使用 runlevel 表示系统运行级别，例如字符界面、多用户模式、图形界面、关机、重启等。

systemd 使用 target 表示系统状态。常见 target 包括：

- `multi-user.target`：多用户命令行环境。
- `graphical.target`：图形界面环境。
- `rescue.target`：救援模式。
- `poweroff.target`：关机。
- `reboot.target`：重启。

它们和传统 runlevel 有对应关系，但不是简单的一一等价。你可以把 target 理解为 systemd 时代更灵活的系统状态组织方式。

关于传统 runlevel，可以继续阅读 [Linux 运行级别](linux-runlevel.md)。

## 一号进程不能随便结束

普通进程异常退出，影响通常局限在这个程序本身。一号进程如果退出，系统用户空间就失去了核心管理者，后果非常严重。

Linux kernel 对 PID 1 有特殊处理。很多对普通进程有效的默认终止信号，并不会让 PID 1 像普通进程那样退出。

:::warning
不要在真实系统中尝试结束 PID 1，也不要用 `kill` 对一号进程做实验。关机和重启应使用 [shutdown](/linux-command/shutdown/)、[poweroff](/linux-command/poweroff/)、[reboot](/linux-command/reboot/) 或 `systemctl poweroff`、`systemctl reboot`。
:::

## 容器里的 PID 1

在容器中，情况会有一点不同。容器有自己的 PID namespace，所以容器内部看到的 PID 1 可能不是宿主机的 systemd，而是容器启动的应用程序。

例如一个容器里运行：

```bash
ps -p 1
```

可能看到：

```text
    PID TTY          TIME CMD
      1 ?        00:00:00 nginx
```

这说明在这个容器命名空间中，`nginx` 是 PID 1。

这会带来一个实践问题：如果应用程序作为 PID 1，却没有正确处理信号和回收子进程，容器停止、日志收集、僵尸进程处理都可能出问题。因此很多容器会使用 `tini`、`dumb-init` 或 Docker 的 `--init` 选项，让一个轻量 init 进程做 PID 1。

如果你只是学习普通 Linux 系统，可以先知道有这个差异；等学习 Docker 或容器运行时再深入。

## 常用观察命令

查看 PID 1：

```bash
ps -p 1
```

查看详细信息：

```bash
ps -p 1 -o pid,ppid,user,stat,comm,args
```

查看命令名：

```bash
cat /proc/1/comm
```

查看启动参数：

```bash
tr '\0' ' ' < /proc/1/cmdline
echo
```

查看 `/sbin/init` 指向：

```bash
ls -l /sbin/init
```

如果系统使用 systemd，还可以查看系统整体状态：

```bash
systemctl status
```

## 常见问题

### 为什么我看到的不是 systemd

可能原因包括：

- 你在容器里。
- 你使用的是嵌入式 Linux。
- 发行版使用 BusyBox init、OpenRC、runit、s6 等其他 init 系统。
- 当前系统是特殊 rescue、initramfs 或精简环境。

这并不一定是错误。关键是理解：PID 1 是当前进程命名空间中的一号进程，不同环境可能不同。

### /sbin/init 和 systemd 是什么关系

在很多现代发行版里，`/sbin/init` 是指向 systemd 的符号链接。内核或启动流程仍然可以使用传统入口 `/sbin/init`，但实际执行的是 systemd。

### systemd 是不是 Linux 内核的一部分

不是。Linux kernel 运行在内核空间，systemd 运行在用户空间。systemd 很重要，但它不是内核。

### 一号进程是不是所有进程的祖先

在传统视角下，用户空间进程树最终可以追溯到 PID 1。但现代系统有线程、内核线程、PID namespace、subreaper 等机制，所以不要把这句话理解得过于绝对。对入门学习来说，把 PID 1 理解为用户空间进程管理的根节点，是足够实用的。

## 小结

你需要记住：

- PID 1 是 Linux 用户空间中非常特殊的一号进程。
- 它通常叫 init，现代发行版里常由 systemd 承担。
- 它负责启动服务、管理系统状态、接管孤儿进程、回收子进程。
- `/sbin/init` 是传统入口，可能指向 systemd 或其他 init 实现。
- 容器内部的 PID 1 可能是普通应用程序。
- 不要尝试结束 PID 1，关机重启应使用标准系统命令。

理解一号进程后，再学习 [Linux 运行级别](linux-runlevel.md)、[Linux 系统服务管理](linux-systemd.md) 和 [journalctl 日志查看](linux-journalctl.md) 会更自然。
