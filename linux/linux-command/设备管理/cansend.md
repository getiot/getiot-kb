---
sidebar_label: cansend 命令
sidebar_position: 19
slug: /cansend
---

# Linux cansend 命令 - 发送 CAN 报文



## 介绍

**cansend** 命令用于通过 CAN_RAW socket 向指定 CAN 接口发送单帧报文。适合在脚本或命令行中快速发送测试帧，支持经典 CAN 2.0 数据帧、RTR 帧以及 CAN FD 帧。

cansend 命令由 can-utils 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install can-utils
```

**语法**：

```bash
cansend <device> <can_frame>
```

**参数**：

- `<device>`：CAN 网络接口名称，如 `can0`、`vcan0`
- `<can_frame>`：报文格式，支持以下形式：
  - `<can_id>#{data}`：经典 CAN 2.0 数据帧
  - `<can_id>#R{len}`：经典 CAN 2.0 RTR 帧
  - `<can_id>##<flags>{data}`：CAN FD 帧

**报文字段说明**：

- `<can_id>`：3 位（SFF 标准帧）或 8 位（EFF 扩展帧）十六进制
- `{data}`：0～8 字节（CAN FD 为 0～64 字节）的十六进制数据，可用 `.` 分隔
- `{len}`：可选的 0～8 值，RTR 帧的有效 DLC 字段
- `<flags>`：单个十六进制字符（0～F），定义 `canfd_frame.flags`

相关命令：[candump](/linux-command/candump/)、[cangen](/linux-command/cangen/)、[canfdtest](/linux-command/canfdtest/)



## 示例

1、向 can0 发送标准帧，ID 为 0x123，数据为 4 字节：

```bash
cansend can0 123#DEADBEEF
```

2、发送 ID 为 0x5A1 的 8 字节数据帧：

```bash
cansend can0 5A1#11.2233.44556677.88
```

3、发送 RTR 帧（远程请求帧）：

```bash
cansend can0 123#R
```

4、发送带 DLC 的 RTR 帧：

```bash
cansend can0 123#R3
```

5、发送扩展帧（29 位 ID）：

```bash
cansend can0 00000123#11223344
```

6、发送 CAN FD 帧（`##` 后为 flags，此处为 `1`）：

```bash
cansend can0 123##1DEADBEEF
```

7、发送空数据帧（仅 ID，无负载）：

```bash
cansend can0 5AA#
```
