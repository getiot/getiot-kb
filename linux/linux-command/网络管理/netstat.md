---
sidebar_position: 7
slug: /netstat
---

# netstat 命令



## 介绍

**netstat**（英文全拼：network statistics）命令用于显示网络连接、路由表、接口统计、伪连接和组播成员等信息。

**语法**：

```bash
nfsstat [OPTION]...
```

**选项**：

- `-a` ：显示所有连线中的 socket。
- `-p` ：显示正在使用 socket 的程序识别码和程序名称。
- `-t` ：仅显示 TCP 传输协议的连线状况。
- `-u` ：仅显示 UDP 传输协议的连线状况。
- `-l` ：仅显示处于 Listen（监听）状态的 socket。
- `-i` ：显示网络界面信息表单。
- `-n` ：直接使用 IP 地址，不通过域名服务器。



## 示例

显示详细的网络状况

```bash
netstat -a
```

显示 UDP 连接状况

```bash
netstat -nu
```

显示 UDP 端口号的使用情况

```bash
netstat -apu
```

显示 TCP、UDP 的端口和进程等相关情况

```bash
netstat -tunlp
```

显示所有 4000 端口使用情况

```bash
netstat -tunlp | grep 4000
```

显示网卡列表

```bash
netstat -i
```

显示组播组的关系

```bash
netstat -g 
```





