---
sidebar_label: uptime 命令
sidebar_position: 16
slug: /uptime
---

# Linux uptime 命令 - 显示系统运行时间



## 介绍

**uptime** 命令用于显示系统运行时间。

和 [who](/linux-command/who/) 命令一样，uptime 命令也会从 /var/run/utmp 文件获取系统信息，也可以从 /proc/uptime 中读取。

**语法**：

```shell
uptime [options]
```

**选项**：

- `-p`, `--pretty` ：以漂亮的格式显示正常运行时间。
- `-s`, `--since` ：以 yyyy-mm-dd HH:MM:SS 格式显示系统启动时间。
- `-h`, `--help` ：显示帮助信息。
- `-V`, `--version` ：显示版本信息。



## 示例

显示系统运行时间：

```shell
$ uptime 
 00:00:01 up  5:27,  1 user,  load average: 0.33, 0.40, 0.33
```

以更便于阅读的格式显示系统运行时间：

```shell
$ uptime -p
up 5 hours, 27 minutes
```

显示系统启动时间：

```shell
$ uptime -s
2021-04-30 18:32:54
```

