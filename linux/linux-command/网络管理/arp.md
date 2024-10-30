---
sidebar_label: arp 命令
sidebar_position: 1
slug: /arp
---

# Linux arp 命令 - 显示和修改 ARP 缓存



## 介绍

在 Linux 系统中，**arp**（英文全拼：Address Resolution Protocol）命令用于显示和修改系统的 ARP 缓存表，即存储 IP 地址与对应 MAC 地址的映射关系。

**语法**：

```bash
arp [选项] [参数]
```

详细语法格式：

```bash
arp [-vn] [-H type] [-i if] [-ae] [hostname]
arp [-v] [-i if] -d hostname [pub]
arp [-v] [-H type] [-i if] -s hostname hw_addr [temp]
arp [-v] [-H type] [-i if] -s hostname hw_addr [netmask nm] pub
arp [-v] [-H type] [-i if] -Ds hostname ifname [netmask nm] pub
arp [-vnD] [-H type] [-i if] -f [filename]
```

**选项**：

- `-a`：以另一种（BSD）风格显示 ARP 缓存的所有条目（主机）。
- `-e`：以默认（Linux）样式显示 ARP 缓存的所有条目（主机）。
- `-s, --set`：设置一个新的 ARP 记录。
- `-d, --delete`：删除指定记录。
- `-v, --verbose`：显示详细的 ARP 缓存条目，包括缓存条目的统计信息。
- `-n, --numeric`：以数字方式（不解析名称）显示 ARP 缓存中的条目。
- `-i, --device`：指定网络接口（如 eth0）。
- `-D, --use-device`：读取所给定设备的硬件地址。
- `-A, -p, --protocol`：指定协议族。
- `-f, --file`：从文件或 /etc/ethers 中读取新记录。



## 示例

显示本机 ARP 缓存表中所有记录：

```bash
arp
```

以数字方式显示指定主机 ARP 缓存表条目：

```bash
arp -n 192.168.0.1
```

删除指定主机网卡上的 ARP 条目（例如 eth1 上 192.168.0.1）：

```bash
arp -i eth1 -d 192.168.0.1
```

这将使用 eth1 的 MAC 地址应答 eth0 上 192.168.0.2 的 ARP 请求：

```bash
arp -i eth0 -Ds 192.168.0.2 eth1 pub
```

添加对指定的 IP 地址和 MAC 地址进行静态映射的条目：

```bash
arp -s 192.168.0.10 c0:25:a5:29:12:e1
```

