---
sidebar_label: cansequence 命令
sidebar_position: 20
slug: /cansequence
description: "cansequence 命令用于测试 CAN 链路的可靠性。发送端持续发送携带递增序列号的报文，接收端（-r 模式）校验序列号连续性，发现丢帧或乱序时输出错误信息。"
---

# Linux cansequence 命令 - CAN 链路可靠性测试



## 介绍

**cansequence** 命令用于测试 CAN 链路的可靠性。发送端持续发送携带递增序列号的报文，接收端（`-r` 模式）校验序列号连续性，发现丢帧或乱序时输出错误信息。

cansequence 命令由 can-utils 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install can-utils
```

**语法**：

```bash
cansequence [<can-interface>] [options]
```

**选项**：

- `-e, --extended`：发送扩展帧（29 位 ID）
- `-i, --identifier=ID`：CAN 标识符（默认 `2`）
- `--loop=COUNT`：发送 `COUNT` 次后退出
- `-p, --poll`：发送时使用 `poll(2)` 等待缓冲区空间
- `-q, --quit <num>`：检测到 `<num>` 次序列错误后退出
- `-r, --receive`：以接收端模式运行
- `-v, --verbose`：详细输出（使用两次更加详细）
- `-h, --help`：显示帮助
- `--version`：显示版本信息

相关命令：[canfdtest](/linux-command/canfdtest/)、[cangen](/linux-command/cangen/)、[candump](/linux-command/candump/)



## 示例

1、在 can0 上持续发送递增序列号报文（发送端）：

```bash
cansequence can0
```

2、在另一终端以接收端模式监听并校验：

```bash
cansequence -r can0
```

3、使用扩展帧，CAN ID 为 0x100：

```bash
cansequence -e -i 100 can0
```

4、发送 10000 帧后退出：

```bash
cansequence --loop=10000 can0
```

5、接收端模式，检测到 5 次序列错误后退出：

```bash
cansequence -r -q 5 -v can0
```

6、高负载发送，使用 poll 等待缓冲区：

```bash
cansequence -p -v -v can0
```
