---
sidebar_position: 46
slug: /ss
---

# ss 命令



## 介绍

**ss**（英文全拼：socket statistics）命令用于获取 socket 统计信息，其输出的结果类似于 netstat 输出的内容，但能显示更多、更详细的 TCP 连接状态的信息，而且比 netstat 更快速高效。

**语法**：

```shell
ss [options] [ FILTER ]
```

**选项**：

- `-h`, `--help` ：显示帮助信息。
- `-V`, `--version` ：显示版本信息。
- `-n`, `--numeric` ：不解析服务名称。
- `-r`, `--resolve` ：解析主机名。
- `-a`, `--all` ：显示所有套接字（sockets）。
- `-l`, `--listening` ：显示监听状态的套接字。
- `-o`, `--options` ：显示计时器信息。
- `-e`, `--extended` ：显示详细的套接字信息。
- `-m`, `--memory` ：显示套接字的内存使用情况。
- `-p`, `--processes` ：显示使用套接字的进程。
- `-i`, `--info` ：显示 TCP 内部信息。
- `-s`, `--summary` ：显示套接字使用概况。
- `-4`, `--ipv4` ：仅显示 IPv4 的套接字。
- `-6`, `--ipv6` ：仅显示 IPv6 的套接字。
- `-0`, `--packet` ：显示 PACKET 套接字。
- `-t`, `--tcp` ：仅显示 TCP 套接字。
- `-u`, `--udp` ：仅显示 UCP 套接字。
- `-d`, `--dccp` ：仅显示 DCCP 套接字。
- `-w`, `--raw` ：仅显示 RAW 套接字。
- `-x`, `--unix` ：仅显示 UNIX 套接字。
- `-f`, `--family=FAMILY` ：显示 FAMILY 类型的套接字，FAMILY 可选 unix、inet、inet6、link、netlink、vsock、xdp。
- `-A`, `--query=QUERY`, `--socket=QUERY` ：QUERY 可选 all、inet、tcp、udp、raw、unix、packet、netlink 等。
- `-D`, `--diag=FILE` ：将原始 TCP 套接字信息转储到文件 FILE。
- `-F`, `--filter=FILE` ：从文件 FILE 中读取过滤器信息。

**参数**：FILTER（可选），过滤器表达式。



## 示例

显示所有 TCP 套接字

```shell
ss -t -a
```

显示所有带有进程 SELinux 安全上下文的 TCP 套接字

```shell
ss -t -a -Z
```

显示所有 UDP 套接字

```shell
ss -u -a
```

显示所有已建立的 ssh 连接

```shell
ss -o state established '( dport = :ssh or sport = :ssh )'
```

查找所有连接到 X 服务器的本地进程

```shell
ss -x src /tmp/.X11-unix/*
```

列出我们的 apache 到网络 193.233.7/24 的状态为 FIN-WAIT-1 的所有 tcp 套接字并查看它们的计时器

```shell
ss -o state fin-wait-1 '( sport = :http or sport = :https )' dst 193.233.7/24
```

列出所有套接字表中所有状态的套接字（但 TCP 除外）

```shell
ss -a -A 'all,!tcp'
```

