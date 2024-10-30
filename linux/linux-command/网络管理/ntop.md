---
sidebar_label: ntop 命令
sidebar_position: 25
slug: /ntop
---

# Linux ntop 命令 - 网络流量分析工具



## 介绍

**ntop** 是一个网络流量监控工具，用于实时显示网络流量和连接信息。它提供了一个基于 Web 的用户界面，可以通过浏览器查看网络统计数据。

:::tip

ntop 目前已被 **[ntopng](/linux-command/ntopng)** 取代，可在其官网 [https://www.ntop.org](https://www.ntop.org) 了解更多信息。

:::

**语法**：

```bash
ntop [options]
```

**选项**：

- `-h <主机>`： 指定 `ntop` 监听的主机地址。
- `-p <端口>`： 指定 `ntop` 使用的端口号。
- `-u <用户名>`： 指定 Web 界面的用户名。
- `-P <密码>`： 指定 Web 界面的密码。
- `-i <网络接口>`： 指定要监控的网络接口。



## 示例

启动 ntop 监听默认端口（3000），启动后可通过 http://localhost:3000 访问 Web 界面：

```bash
ntop
```

指定监听的主机和端口：

```bash
ntop -h 192.168.1.2 -p 8080
```

启动 ntop 并设置 Web 界面的用户名和密码：

```bash
ntop -u myuser -P mypassword
```

指定要监控的网络接口（例如 `eth0`）：

```bash
ntop -i eth0
```


