---
sidebar_label: can-calc-bit-timing 命令
sidebar_position: 12
slug: /can-calc-bit-timing
---

# Linux can-calc-bit-timing 命令 - 计算 CAN 位时序参数



## 介绍

**can-calc-bit-timing** 命令用于根据 CAN 控制器型号、系统时钟频率和目标比特率，计算合适的位时序寄存器参数（如 `tq`、`prop_seg`、`phase_seg1`、`phase_seg2`、`sjw` 等）。在配置 `ip link set can0 type can` 时，可借助该工具确定 `bitrate`、`sample-point` 等参数。

can-calc-bit-timing 命令由 can-utils 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install can-utils
```

**语法**：

```bash
can-calc-bit-timing [options] [<CAN-controller-name>]
```

**选项**：

- `-q`：不打印表头行
- `-l`：列出所有支持的 CAN 控制器名称
- `-b <bitrate>`：目标比特率，单位 bit/s（如 `500000` 表示 500 kbps）
- `-s <samp_pt>`：采样点，单位为千分之一百分比（如 `875` 表示 87.5%）；设为 `0` 则使用 CIA 推荐采样点
- `-c <clock>`：CAN 控制器实际系统时钟频率，单位 Hz

相关命令：[canbusload](/linux-command/canbusload/)、[candump](/linux-command/candump/)



## 示例

1、列出所有支持的 CAN 控制器：

```bash
can-calc-bit-timing -l
```

2、为 500 kbps 比特率计算位时序（使用默认控制器和 CIA 推荐采样点）：

```bash
can-calc-bit-timing -b 500000 -s 0
```

3、指定控制器型号和 48 MHz 时钟，计算 1 Mbps 位时序，采样点 80%：

```bash
can-calc-bit-timing mcp251x -b 1000000 -s 800 -c 48000000
```

4、计算结果可用于配置 CAN 接口，例如：

```bash
sudo ip link set can0 type can bitrate 500000 sample-point 0.875
sudo ip link set can0 up
```
