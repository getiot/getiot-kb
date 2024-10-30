---
sidebar_label: nslookup 命令
sidebar_position: 8
slug: /nslookup
---

# Linux nslookup 命令 - 查询 DNS 域名和 IP



## 介绍

**nslookup**（英文全拼：name server lookup）是一个域名查询工具，可用于查询 DNS 记录信息、查看域名解析是否正常。nslookup 是诊断网络故障的常用工具之一。

**语法**：

```bash
nslookup [-option] [name | -] [server]
```

nslookup 有两种工作模式，即“交互模式”（Interactive mode）和“非交互模式”（Non-interactive mode）。在“交互模式”下，用户可以向域名服务器查询各类主机、域名的信息，或者输出域名中的主机列表。而在“非交互模式”下，用户可以针对一个主机或域名仅仅获取特定的名称或所需信息。

进入交互模式的方法是直接输入 nslookup 命令（不加任何参数），此时 nslookup 会连接到默认的域名服务器（即 `/etc/resolv.conf` 的第一个 dns 地址）。或者输入 `nslookup -nameserver/ip` 命令指定 dns 地址。在交互模式输入想要查询的域名即可，输入 `exit` 退出交互模式。

而非交互模式，则直接输入 `nslookup 域名` 就可以了。在非交互模式，可以在域名 name 后面添加 DNS 服务器地址，指定要使用的域名服务器。



## 示例

查询 getiot.tech 域名信息：

```bash
$ nslookup getiot.tech
Server:		127.0.0.53
Address:	127.0.0.53#53

Non-authoritative answer:
Name:	getiot.tech
Address: 42.192.64.149
```

指定 DNS 服务器查询 getiot.tech 域名信息：

```bash
$ nslookup getiot.tech 8.8.8.8
Server:		8.8.8.8
Address:	8.8.8.8#53

Non-authoritative answer:
Name:	getiot.tech
Address: 42.192.64.149
```

