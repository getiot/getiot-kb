---
sidebar_label: candump 命令
sidebar_position: 13
slug: /candump
description: "candump 命令用于监听 CAN 总线上的报文，并以可读格式在终端输出。它是 CAN 总线调试中最常用的工具之一，支持多接口同时监听、报文过滤、时间戳显示、日志记录以及 CAN FD 报文的解析。"
---

# Linux candump 命令 - 抓取并显示 CAN 总线报文



## 介绍

**candump** 命令用于监听 CAN 总线上的报文，并以可读格式在终端输出。它是 CAN 总线调试中最常用的工具之一，支持多接口同时监听、报文过滤、时间戳显示、日志记录以及 CAN FD 报文的解析。

candump 命令由 can-utils 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install can-utils
```

使用前需先配置并启动 CAN 接口，例如：

```bash
sudo ip link set can0 type can bitrate 500000
sudo ip link set can0 up
```

**语法**：

```bash
candump [options] <CAN interface>+
```

可同时指定最多 16 个 CAN 接口，每个接口可附加可选的过滤器，格式为：`<ifname>[,filter]*`。使用 `CTRL-C` 终止程序。

**选项**：

- `-t <type>`：时间戳格式，可选 `(a)bsolute`（绝对时间）、`(d)elta`（增量）、`(z)ero`（归零）、`(A)bsolute w date`（带日期的绝对时间）
- `-H`：读取硬件时间戳，而非系统时间戳
- `-c`：递增彩色输出级别
- `-i`：以二进制格式输出（每行可能超过 80 字符）
- `-a`：额外输出 ASCII 字符
- `-S`：交换输出中 CAN 数据字节的字节序（以 `` ` `` 标记）
- `-s <level>`：静默模式，`0` 关闭（默认）、`1` 动画、`2` 静默
- `-l`：将 CAN 帧记录到文件（默认同时设置 `-s 2`）
- `-L`：在标准输出上使用日志文件格式
- `-n <count>`：接收 `<count>` 帧后退出
- `-r <size>`：设置 socket 接收缓冲区大小
- `-D`：当检测到的 CAN 设备下线时不退出
- `-d`：监控被丢弃的 CAN 帧
- `-e`：以人类可读格式输出 CAN 错误帧
- `-x`：打印额外报文信息（rx/tx、brs、esi）
- `-T <msecs>`：超过 `<msecs>` 毫秒未收到报文则退出

**过滤器**：

每个 CAN 接口可指定逗号分隔的过滤器：

- `<can_id>:<can_mask>`：当 `received_can_id & mask == can_id & mask` 时匹配
- `<can_id>~<can_mask>`：当 `received_can_id & mask != can_id & mask` 时匹配
- `#<error_mask>`：设置错误帧过滤器（参见 `include/linux/can/error.h`）
- `[j|J]`：将多个过滤器以逻辑 AND 方式组合

CAN ID、掩码和数据内容均使用十六进制表示。当 can_id 为 8 位十六进制时，自动设置 `CAN_EFF_FLAG`（29 位扩展帧）。未指定过滤器时，默认接收所有数据帧（`0:0`）。使用接口名 `any` 可从所有 CAN 接口接收。

相关命令：[cansend](/linux-command/cansend/)、[cangen](/linux-command/cangen/)、[cansniffer](/linux-command/cansniffer/)、[canbusload](/linux-command/canbusload/)、[canplayer](/linux-command/canplayer/)



## 示例

1、监听 can0 接口上的所有报文：

```bash
candump can0
```

2、带绝对时间戳和彩色输出，同时监听 can0 和 can2：

```bash
candump -c -ta can0 can2
```

3、只接收 can0 上 ID 为 0x123 的标准帧（含 EFF 和 RTR）：

```bash
candump can0,123:7FF
```

4、只接收 can0 上 ID 为 0x123 的标准帧（仅 SFF、非 RTR）：

```bash
candump can0,123:C00007FF
```

5、匹配扩展帧 ID 0x12345678：

```bash
candump can0,12345678:DFFFFFFF
```

6、将报文记录到日志文件（静默模式）：

```bash
candump -l can0
```

7、接收 100 帧后自动退出：

```bash
candump -n 100 can0
```

8、多接口带过滤器，同时监听多个总线：

```bash
candump -c -ta can0,123:7FF,400:700 can2,400~7F0 can3
```

9、监听所有 can 接口上的所有报文：

```bash
candump any
```

