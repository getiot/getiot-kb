---
sidebar_label: last 命令
sidebar_position: 40
slug: /last
---

# Linux last 命令 - 显示登录记录



## 介绍

**last** 命令用于显示 Linux 系统近期用户或终端的登录情况，通过查看系统记录的日志文件内容，进而使管理员可以获知谁曾经或者企图连接系统。

执行 last 命令时，它会读取 /var/log/wtmp 文件，并把该文件记录的登录系统或终端的用户名单全部显示出来。默认显示 /var/log/wtmp 的记录，/var/log/btmp 能显示的更详细，可以显示远程登录，例如 ssh 登录。

相关命令：[uptime](/linux-command/uptime)，[who](/linux-command/who)

**语法**：

```bash
last [options] [username...] [tty...]
```

**选项**：

- `-R`, `--nohostname` ：省略 hostname 的栏位。
- `-f`, `--file <file>` ：指定文件以替代默认的 /var/log/wtmp。
- `-F`, `--fulltimes` ：显示完整的登录和登出时间和日期。
- `-n`, `--limit number` ：显示最近的 number 行记录。
- `username` ：显示 username 的登录信息。
- `-x`, `--system` ：显示系统关机条目和运行级别更改信息。



## 示例

简略显示最新的5行记录

```bash
last -n 5 -R
```

使用 /var/log/btmp 文件

```bash
sudo last -f /var/log/btmp
```

显示系统历史启动的时间

```bash
last -x reboot
```

只查看最后一次系统启动的时间

```bash
last -x reboot | head -1
```

显示系统历史关机时间

```bash
last -x shutdown
```

只查看最后一次系统关机的时间

```bash
last -x shutdown | head -1
```

