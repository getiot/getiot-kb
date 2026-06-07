---
sidebar_label: cangen 命令
sidebar_position: 15
slug: /cangen
---

# Linux cangen 命令 - 生成 CAN 测试报文



## 介绍

**cangen** 命令用于在指定 CAN 接口上持续生成测试报文，可配置发送间隔、帧类型、ID 和数据内容的生成方式。常用于总线压力测试、接口验证和与 [candump](/linux-command/candump/) 配合调试。

cangen 命令由 can-utils 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install can-utils
```

**语法**：

```bash
cangen [options] <CAN interface>
```

**选项**：

- `-g <ms>`：报文发送间隔，单位毫秒（默认 200 ms）
- `-e`：生成扩展帧（EFF，29 位 ID）
- `-f`：生成 CAN FD 帧
- `-b`：生成带比特率切换（BRS）的 CAN FD 帧
- `-E`：生成带错误状态指示（ESI）的 CAN FD 帧
- `-R`：发送 RTR 帧
- `-m`：混合生成 `-e`、`-f`、`-b`、`-E`、`-R` 各类帧
- `-I <mode>`：CAN ID 生成模式
- `-L <mode>`：数据长度（DLC）生成模式
- `-D <mode>`：数据负载生成模式
- `-p <timeout>`：遇到 `-ENOBUFS` 时以 `<timeout>` 毫秒轮询重试
- `-n <count>`：发送 `<count>` 帧后退出（默认无限）
- `-i`：忽略 `write()` 返回的 `-ENOBUFS` 错误
- `-x`：禁用本地回环（loopback）
- `-c`：每次突发发送的报文数量（默认 1）
- `-v`：递增详细输出级别（可重复使用）

**生成模式**（适用于 `-I`、`-L`、`-D`）：

- `r`：随机值（默认）
- `i`：递增值
- `<hexvalue>`：固定十六进制值

递增 CAN 数据时，DLC 最小值为 1。CAN ID 和数据内容均使用十六进制表示。

相关命令：[candump](/linux-command/candump/)、[cansend](/linux-command/cansend/)、[canbusload](/linux-command/canbusload/)



## 示例

1、以默认间隔（200 ms）在 vcan0 上生成随机报文：

```bash
cangen vcan0
```

2、固定 CAN ID 为 0x42A、DLC 为 1，数据递增，每 4 ms 发送一帧：

```bash
cangen vcan0 -g 4 -I 42A -L 1 -D i -v -v
```

3、生成扩展帧，DLC 递增：

```bash
cangen vcan0 -e -L i -v -v -v
```

4、固定 8 字节数据负载：

```bash
cangen vcan0 -D 11223344DEADBEEF -L 8
```

5、满负载压力测试（忽略缓冲区满错误）：

```bash
cangen vcan0 -g 0 -i -x
```

6、满负载测试，缓冲区满时轮询等待 10 ms：

```bash
cangen vcan0 -g 0 -p 10 -x
```

7、发送 1000 帧后退出：

```bash
cangen can0 -n 1000 -g 10
```
