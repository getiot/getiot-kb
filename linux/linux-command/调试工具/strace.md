---
sidebar_label: strace 命令
sidebar_position: 5
slug: /strace
---

# strace 命令 - 跟踪系统调用和信号



## 介绍

**strace**（英文全拼：system trace）是 Linux 系统中一个功能强大的调试、分析、诊断工具，可以对系统调用和信号传递的跟踪结果进行分析，从而解决问题。在调试应用程序时，strace 是一个很好的工具，并且经常被工程师用来检查操作系统及其程序中可能出现的某些问题。

Linux 系统中进程不能直接访问硬件设备，当进程需要读取磁盘文件或接收网络数据时，必须由用户态模式切换至内核态模式，通过系统调用访问硬件设备。而 strace 命令则可以跟踪到一个进程产生的系统调用数据 —— 包括参数，返回值，执行消耗时间等信息。

**语法**：

```bash
strace [ -dffhiqrtttTvxx ] [ -a column ] [ -e expr ] ... [ -o file ] [ -p pid ] ... [ -s strsize ] [ -u username ] [ command [ args ... ] ]
strace -c [ -e expr ] ... [ -O overhead ] [ -S sortby ] [ command [ args ... ] ]
```

**选项**：

- `-c`：统计每一系统调用的所执行的时间，次数和出错的次数等。
- `-d`：输出 strace 关于标准错误的调试信息。
- `-f`：跟踪由 fork 调用所产生的子进程。
- `-ff`：如果提供 `-o filename`，则所有进程的跟踪结果输出到相应的 filename.pid 中，pid 是各进程的进程号。
- `-F`：尝试跟踪 vfork 调用。在 `-f` 时，vfork 不被跟踪。
- `-h`：输出简要的帮助信息。
- `-i`：输出系统调用的入口指针。
- `-q`：禁止输出关于脱离的消息。
- `-r`：打印出每一个系统调用的相对时间。
- `-t`：在输出中的每一行前加上时间信息。
- `-tt`：在输出中的每一行前加上时间信息，微秒级。
- `-ttt`：微秒级输出，以秒了表示时间。
- `-T`：显示每一调用所耗的时间。
- `-v`：输出所有的系统调用。一些调用关于环境变量、状态、输入输出等调用由于使用频繁，默认不输出。
- `-V`：输出 strace 的版本信息。
- `-x`：以十六进制形式输出非标准字符串。
- `-xx`：所有字符串以十六进制形式输出。
- `-a column`：设置返回值的输出位置，默认为 40。
- `-e expr`：指定一个表达式，用来控制如何跟踪。格式为 `[qualifier=][!]value1[,value2]...`，qualifier 只能是 trace、abbrev、verbose、raw、signal、read、write 其中之一，value 是用来限定的符号或数字，默认的 qualifier 是 trace。感叹号是否定符号，例如 `-eopen` 等价于 `-e trace=open`，表示只跟踪 open 调用，而 `-etrace!=open` 表示跟踪除了 open 以外的其他调用，有两个特殊的符号 all 和 none。
- `-e trace=set`：只跟踪指定的系统调用。例如 -e trace=open,close,rean,write 表示只跟踪这四个系统调用，默认的为 set=all。
- `-e trace=file`：只跟踪有关文件操作的系统调用。
- `-e trace=process`：只跟踪有关进程控制的系统调用。
- `-e trace=network`：跟踪与网络有关的所有系统调用。
- `-e strace=signal`：跟踪所有与系统信号有关的系统调用。
- `-e trace=ipc`：跟踪所有与进程通讯有关的系统调用。
- `-e abbrev=set`：设定 strace 输出的系统调用的结果集。-v 等与 abbrev=none，默认为 abbrev=all。
- `-e raw=set`：将指定的系统调用的参数以十六进制显示。
- `-e signal=set`：指定跟踪的系统信号，默认为 all。如 signal=!SIGIO（或者 signal=!io），表示不跟踪 SIGIO 信号。
- `-e read=set`：输出从指定文件中读出的数据，例如 `-e read=3,5`。
- `-e write=set`：输出写入到指定文件中的数据。
- `-o filename`：将 strace 的输出写入文件 filename。
- `-p pid`：跟踪指定的进程 pid。
- `-s strsize`：指定输出的字符串的最大长度，默认为 32。文件名一直全部输出。
- `-u username`：以 username 的 UID 和 GID 执行被跟踪的命令。



## 示例

跟踪 46725 进程的所有系统调用（`-e trace=all`），并统计系统调用的花费时间，以及开始时间（并以可视化的时分秒格式显示），最后将记录结果存在 output.txt 文件里面：

```bash
$ strace -o output.txt -T -tt -e trace=all -p 46725
```

启动和调试 hello 程序，同时跟踪其 fork 和 vfork 出来的进程，并将记录结果存在 hello-strace.txt 文件：

```bash
$ strace -f -F -o hello-strace.txt ./hello
```

hello-strace.txt 文件的内容如下：

```bash showLineNumbers
execve("/usr/bin/hello", ["hello"], 0x7ffd2d9b6ff0 /* 72 vars */) = 0
brk(NULL)                               = 0x557a46673000
arch_prctl(0x3001 /* ARCH_??? */, 0x7ffd1d54a690) = -1 EINVAL (无效的参数)
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fe67e2b7000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (没有那个文件或目录)
......
```

查看在 configure 脚本里面执行的程序（需要监视的系统调用是 execve），只记录 execve 的调用：

```bash
$ strace -f -o configure-strace.txt -e execve ./configure
```
