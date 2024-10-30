---
sidebar_label: phc_ctl 命令
sidebar_position: 12
slug: /phc_ctl
---

# phc_ctl 命令 - 管理 PTP 硬件时钟



## 介绍

**phc_ctl**（英文全拼：PTP hardware clock control）是 linuxptp 套件中的一个命令，可以用来直接控制 PHC 时钟设备。`phc_ctl` 命令通常用于调试目的，很少用于设备的一般控制。对于 PHC 时钟设备的一般控制，应该使用 `phc2sys` 命令。

相关命令：[ptp4l](/linux-command/ptp4l)、[phc2sys](/linux-command/phc2sys)、[pmc](/linux-command/pmc)

关于 PTP 详细介绍，请参考《[PTP 精确时间协议](/protocol/ptp)》。

**安装**：

ptp4l 命令由 LinuxPTP 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install linuxptp
```

**语法**：

```bash
phc_ctl [ options ] <device> [ commands ]
```

其中，device 用于指定以太网卡或 PTP 时钟设备。

**选项**：

- `-l print-level`：设置日志记录级别。
- `-q`：不将消息打印到 syslog 系统日志。
- `-Q`：不将消息打印到 stdout 标准输出。
- `-v`：打印软件版本并退出。
- `-h`：打印帮助信息并退出。

**命令**：

除了选项，还可以指定带有参数的命令（command），并且可以指定多个命令依次执行。

- `set [seconds]`：设置 PHC 时间（默认为 CLOCK_REALTIME 上的时间）。
- `get`：获取 PHC 时间。
- `adj <seconds>`：通过偏移量 seconds 调整 PHC 时间。
- `freq [ppb]`：调整 PHC 频率（默认返回当前偏移）。
- `cmp`：将 PHC 偏移量与 CLOCK_REALTIME 进行比较。
- `caps`：显示设备功能（如果没有指定命令，默认为该模式）。
- `wait <seconds>`：命令之间暂停 seconds 秒。

:::tip

命令中的参数 seconds 被读取为双精度浮点值。

:::



## 示例

从 PTP 设备读取当前时钟时间：

```bash
phc_ctl /dev/ptp0 get
```

将 PHC 时钟时间设置为 CLOCK_REALTIME：

```bash
phc_ctl /dev/ptp0 set
```

将 PHC 时钟时间设置为 0（自 Epoch 纪元以来的秒数，即 1970-01-01 00:00:00 UTC）：

```bash
phc_ctl /dev/ptp0 set 0.0
```

通过将转换频率设置为正 10%，将时钟重置为 0.0 时间，等待 10 秒，然后读取时间，快速检查频率转换的完整性。回读的时间应（大约）为 11 秒，因为时钟转动速度快了 10%。

```bash
phc_ctl /dev/ptp0 freq 100000000 set 0.0 wait 10.0 get
```

