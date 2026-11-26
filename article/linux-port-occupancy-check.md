---
sidebar_position: 16
slug: /linux-port-occupancy-check
---

# Linux 查看端口占用进程



在 Linux 运维中，有时候会发生 TCP/IP 端口占用情况，这时候就需要排查到底是哪个进程占用了该端口。通常会使用 [lsof](/linux-command/lsof/) 和 [netstat](/linux-command/netstat/) 命令。



## lsof 命令

使用 -i 选项，命令格式如下：

```bash
lsof -i:端口号
```

例如：

```bash
$ sudo lsof -i:1883
COMMAND    PID      USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
mosquitto 1623 mosquitto    6u  IPv4  49406      0t0  TCP *:1883 (LISTEN)
mosquitto 1623 mosquitto    7u  IPv6  49407      0t0  TCP *:1883 (LISTEN)
```

注意：Ubuntu 需要添加 sudo 才能看到输出信息。



## netstat 命令

netstat 命令的关键则是使用 -p 选项，表示显示正在使用 socket 的程序识别码和程序名称。

例如：

```bash
$ sudo netstat -tunpl | grep 1883
tcp      0    0 0.0.0.0:1883    0.0.0.0:*     LISTEN      1623/mosquitto      
tcp6     0    0 :::1883         :::*          LISTEN      1623/mosquitto
```

可以看到，占用 1883 端口的是 mosquitto，进程 ID 是 1623。

注意：使用 netstat 命令时，并非所有进程都能被检测到，所有非本用户的进程信息将不会显示，如果想看到所有信息，则必须切换到 root 用户（添加 sudo）。

