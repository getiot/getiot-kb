---
sidebar_label: telnet 命令
sidebar_position: 9
slug: /telnet
---

# Linux telnet 命令 - 远程登录协议命令



## 介绍

**telnet** 命令用于登录远程主机，并对远程主机进行管理。但由于 telnet 采用明文传送报文，安全性不好，因此通常会使用更安全的 [ssh](/linux-command/ssh) 方式登录远程主机。如今，很多 Linux 服务器都已经不开放 telnet 服务。

:::tip

Telnet 是一种应用层协议（端口 23），使用于互联网及局域网中，以虚拟终端的形式提供双向、以文字字符串为主的命令行接口交互功能。属于 TCP/IP 协议族的其中之一，是互联网远程登录服务的标准协议和主要方式。

:::

**语法**：

```bash
telnet [OPTION] [host [port]]
```

**选项**：

- `-8`：允许使用 8 位字符资料，包括输入与输出。
- `-a`：尝试自动登入远端系统。
- `-b <address>`：使用别名指定远端主机名称。
- `-d`：启动排错模式。
- `-e <escapechar>`：设置脱离字符。
- `-E`：滤除脱离字符。
- `-l <user>`：指定要登入远端主机的用户名称。
- `-L`：允许输出 8 位字符资料。
- `-n <tracefile>`：指定文件记录相关信息。
- `-r`：使用类似 rlogin 指令的用户界面。
- `-S <tos>`：设置 telnet 连线所需的 ip TOS 信息。
- `-x`：假设主机有支持数据加密的功能，就使用它。



## 示例

登录远程主机 192.168.1.100，登录时需要输入用户名和密码：

```bash
telnet 192.168.1.100
```

