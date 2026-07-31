---
sidebar_label: canlogserver 命令
sidebar_position: 17
slug: /canlogserver
description: "canlogserver 命令用于在指定端口上启动 CAN 报文日志网络服务，将接收到的 CAN 帧通过网络转发给远程客户端。适合在嵌入式设备上集中采集总线数据，或配合远程分析工具使用。"
---

# Linux canlogserver 命令 - CAN 报文日志网络服务



## 介绍

**canlogserver** 命令用于在指定端口上启动 CAN 报文日志网络服务，将接收到的 CAN 帧通过网络转发给远程客户端。适合在嵌入式设备上集中采集总线数据，或配合远程分析工具使用。

canlogserver 命令由 can-utils 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install can-utils
```

**语法**：

```bash
canlogserver [options] <CAN interface>+
```

使用 `CTRL-C` 终止服务。

**选项**：

- `-m <mask>`：CAN ID 过滤掩码（默认 `0x00000000`）
- `-v <value>`：CAN ID 过滤值（默认 `0x00000000`）
- `-i <0|1>`：反转 ID 过滤器
- `-e <emask>`：错误帧掩码
- `-p <port>`：监听端口（默认 `28700`）

**过滤器匹配条件**：

`received_can_id & mask == value & mask`

使用多个 CAN 接口时，`-m`、`-v`、`-i`、`-e` 可用逗号分隔多个值，例如 `-m 0,7FF,0`。使用接口名 `any` 可从所有 CAN 接口接收。

相关命令：[candump](/linux-command/candump/)、[canplayer](/linux-command/canplayer/)



## 示例

1、在默认端口 28700 上监听 can0 的所有报文：

```bash
canlogserver can0
```

2、指定端口 28888：

```bash
canlogserver -p 28888 can0
```

3、只转发 ID 为 0x100～0x1FF 的报文：

```bash
canlogserver -m 7FF -v 100 can0
```

4、同时监听 can0 和 can1，各自使用不同的过滤器：

```bash
canlogserver -m 0,7FF -v 0,200 can0 can1
```

5、从所有 CAN 接口接收并转发：

```bash
canlogserver any
```
