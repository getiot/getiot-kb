---
sidebar_position: 18
slug: /pgrep
---

# pgrep 命令



## 介绍

**pgrep**（英文全拼：process global regular expression print）是 Linux 系统中用于检索进程 PID 的命令。与 [pidof](/linux-command/pidof) 命令必须准确输入服务名称不同，pgrep 命令通过正则表达式进行检索，因此用户只需要输入服务名称中的一部分即可进行搜索操作，对于不记得全名的服务程序特别好用。

pgrep 常用于通过进程名快速定位正在运行的进程，尤其在脚本或命令行中很有用。

**语法**：

```bash
pgrep [options] <pattern>
```

说明：*pattern* 指定用于匹配进程名称或命令行的扩展正则表达式。简单地，你可以把它当作进程名。

**选项**：

- `-d, --delimiter <string>`：指定输出分隔符。
- `-l, --list-name`：显示 PID 和进程名。
- `-a, --list-full`：显示 PID 和完整的命令行信息。
- `-v, --inverse`：反向匹配。
- `-w, --lightweight`：显示所有线程的 TID。
- `-c, --count`：显示匹配进程的数量。
- `-f, --full`：使用完整的进程名称来匹配。
- `-g, --pgroup <PGID,...>`：匹配列出的进程组 ID。
- `-G, --group <GID,...>`：匹配真实的组 ID。
- `-i, --ignore-case`：不区分大小写匹配。
- `-n, --newest`：仅显示最新的匹配进程。
- `-o, --oldest`：仅显示最老的匹配进程。
- `-P, --parent <PPID,...>`：仅匹配给定父进程的子进程。
- `-s, --session <SID,...>`：匹配会话 ID。
- `-t, --terminal <tty,...>`：通过控制终端进行匹配。
- `-u, --euid <ID,...>`：通过有效 ID（EUID）进行匹配，即仅显示指定用户运行的进程。
- `-U, --uid <ID,...>`：根据真实 ID（UID）进行匹配。
- `-x, --exact`：与命令名称完全匹配。
- `-F, --pidfile <file>`：从文件中读取 PID。
- `-L, --logpidfile`：如果 PID 文件未锁定则失败。
- `-r, --runstates <state>`：匹配运行状态 [D,S,Z,...]。
- `--ns <PID>`：匹配与 `<pid>` 属于同一命名空间的进程。
- `--nslist <ns,...>`：列出 `--ns` 选项将考虑哪些命名空间，可用命名空间包括 ipc、mnt、net、pid、user、uts。
- `-h, --help`：显示帮助信息。
- `-V, --version`：显示程序版本。



## 示例

显示所有包含 `firefox` 进程名的进程 PID：

```bash
pgrep firefox
```

显示所有包含 `firefox` 进程名的进程 PID 和进程名：

```bash
pgrep -l firefox
```

显示所有包含 `firefox` 进程名的进程 PID 和完整的命令行：

```bash
pgrep -a firefox
```

仅显示指定用户运行的包含 `firefox` 进程名的进程 PID：

```bash
pgrep -u rudy firefox
```

