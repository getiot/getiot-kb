---
sidebar_label: kill 命令
sidebar_position: 4
slug: /kill
---

# Linux kill 命令 - 终止进程



## 介绍

**kill** 命令用于删除执行中的程序或任务。

kill 的工作原理是将指定的信息发送至指定程序，预设的信息为 `SIGTERM(15)`，可将指定程序终止。若仍无法终止该程序，可使用 `SIGKILL(9)` 信息尝试强制删除程序。程序或任务的编号（PID）可利用 [ps](/linux-command/ps/) 或 [jobs](/linux-command/jobs/) 命令查看。

**语法**：

```bash
kill [options] <pid> [...]
```

**选项**：

- `-a`：当处理当前进程时，不限制命令名和进程号的对应关系。
- `-l [signal]`：列出信号名称（若不加 `[signal]` 选项，则 `-l` 参数会列出全部的信号名称）。
- `-p`：指定 kill 命令只打印相关进程的进程号，而不发送任何信号。
- `-s <signal>`：指定要送出的信号（亦可采用 `-<signal>` 写法）。
- `-u`：指定用户。

**参数**：程序的 PID 或是 PGID，也可以是工作编号。



## 示例

列出所有可用信号：

```bash
$ kill -l
 1) SIGHUP	 2) SIGINT	 3) SIGQUIT	 4) SIGILL	 5) SIGTRAP
 6) SIGABRT	 7) SIGBUS	 8) SIGFPE	 9) SIGKILL	10) SIGUSR1
11) SIGSEGV	12) SIGUSR2	13) SIGPIPE	14) SIGALRM	15) SIGTERM
16) SIGSTKFLT	17) SIGCHLD	18) SIGCONT	19) SIGSTOP	20) SIGTSTP
21) SIGTTIN	22) SIGTTOU	23) SIGURG	24) SIGXCPU	25) SIGXFSZ
26) SIGVTALRM	27) SIGPROF	28) SIGWINCH	29) SIGIO	30) SIGPWR
31) SIGSYS	34) SIGRTMIN	35) SIGRTMIN+1	36) SIGRTMIN+2	37) SIGRTMIN+3
38) SIGRTMIN+4	39) SIGRTMIN+5	40) SIGRTMIN+6	41) SIGRTMIN+7	42) SIGRTMIN+8
43) SIGRTMIN+9	44) SIGRTMIN+10	45) SIGRTMIN+11	46) SIGRTMIN+12	47) SIGRTMIN+13
48) SIGRTMIN+14	49) SIGRTMIN+15	50) SIGRTMAX-14	51) SIGRTMAX-13	52) SIGRTMAX-12
53) SIGRTMAX-11	54) SIGRTMAX-10	55) SIGRTMAX-9	56) SIGRTMAX-8	57) SIGRTMAX-7
58) SIGRTMAX-6	59) SIGRTMAX-5	60) SIGRTMAX-4	61) SIGRTMAX-3	62) SIGRTMAX-2
63) SIGRTMAX-1	64) SIGRTMAX
```

常用的信号有：

- 1 (HUP)：重新加载进程
- 9 (KILL)：杀死一个进程
- 15 (TERM)：正常停止一个进程

杀死 PID 为 12345 的进程：

```bash
$ kill 12345
```

强制杀死 PID 为 12345 进程：

```bash
$ kill -KILL 12345
```

信号的指定可以使用 `-9`、`-SIGKILL` 或 `-KILL`，三种方式是等效的。

杀死指定用户所有进程：

```bash
$ kill -9 $(ps -ef | grep guest) # 方法1：过滤出 guest 用户进程
$ kill -u guest                  # 方法2
```

