---
sidebar_label: canplayer 命令
sidebar_position: 18
slug: /canplayer
---

# Linux canplayer 命令 - 回放 CAN 日志文件



## 介绍

**canplayer** 命令用于将紧凑格式的 CAN 日志文件回放到 CAN 设备上。通常与 [candump](/linux-command/candump/) 的 `-l` 选项配合使用：先用 `candump -l` 录制总线报文，再用 `canplayer` 按原始时间戳回放，适合离线分析和回归测试。

canplayer 命令由 can-utils 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install can-utils
```

**语法**：

```bash
canplayer <options> [interface assignment]*
```

**选项**：

- `-I <infile>`：输入日志文件（默认从标准输入读取）
- `-l <num>`：处理输入文件 `<num>` 次；使用 `i` 表示无限循环（默认 1 次）
- `-t`：忽略时间戳，立即发送所有帧
- `-g <ms>`：帧间最小间隔，单位毫秒（默认 1 ms）
- `-s <s>`：跳过时间戳间隔超过 `<s>` 秒的空隙
- `-x`：禁用本地回环
- `-v`：详细模式，打印已发送的 CAN 帧

**接口映射**：

格式为 `<write-if>=<log-if>`，将日志中来自 `<log-if>` 的帧发送到 `<write-if>`。例如 `vcan2=can0` 表示将日志中 can0 的帧发送到 vcan2。不指定映射时，帧将发送到日志中记录的原始接口。日志文件中不以 `(` 开头的行会被忽略。

相关命令：[candump](/linux-command/candump/)、[canlogserver](/linux-command/canlogserver/)



## 示例

1、回放日志文件到原始接口：

```bash
canplayer -I can0.log
```

2、将日志中 can0 的帧发送到 vcan0：

```bash
canplayer -I can0.log vcan0=can0
```

3、忽略时间戳，以最快速度回放：

```bash
canplayer -t -I can0.log
```

4、无限循环回放，帧间间隔 5 ms：

```bash
canplayer -l i -g 5 -I can0.log
```

5、从管道读取并回放：

```bash
cat can0.log | canplayer
```

6、详细模式回放，跳过超过 2 秒的空隙：

```bash
canplayer -v -s 2 -I can0.log
```
