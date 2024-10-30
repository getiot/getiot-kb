---
sidebar_label: ptp4l 命令
sidebar_position: 10
slug: /ptp4l
---

# Linux ptp4l 命令 - PTP 时间同步



## 介绍

**ptp4l**（英文全拼：PTP for Linux）命令用于 PTP 同步。

ptp4l 是根据适用于 Linux 的 IEEE 标准 1588 的精确时间协议（PTP）的实现，它实现了边界时钟（Boundary Clock）和普通时钟（Ordinary Clock），支持硬件时钟同步和软件时间同步（系统时钟同步）。

相关命令：[phc2sys](/linux-command/phc2sys)、[phc_ctl](/linux-command/phc_ctl)、[pmc](/linux-command/pmc)

关于 PTP 详细介绍，请参考《[PTP 精确时间协议](/protocol/ptp)》。

**安装**：

ptp4l 命令由 LinuxPTP 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install linuxptp
```

**语法**：

```bash
ptp4l  [ -AEP246HSLmqsv ] 
       [ -f config ] 
       [ -p phc-device ] 
       [ -l print-level ] 
       [ -i interface ] 
       [ long-options ] ...
```

**选项**：

延迟机制选项

- `-A`：自动模式，自动选择 E2E 延迟机制，当收到对等延迟请求时切换到 P2P。
- `-E`：E2E 模式，请求应答延迟机制（默认）。注意：单个 PTP 通信路径上的所有时钟必须使用相同的机制。
- `-P`：P2P 模式，对等延迟机制。

网络传输选项

- `-2`：IEEE 802.3
- `-4`：UDP IPv4（默认）
- `-6`：UDP IPv6

时间戳选项

- `-H`：硬件时间戳（默认）
- `-S`：软件模拟时间戳
- `-L`：老的硬件时间戳，LEGACY HW 需要配合 PHC 设备使用。

其他选项

- `-f [file]`：从指定文件 file 中读取配置，默认情况下不读取任何配置文件。
- `-i [dev]`：选择 PTP 接口设备，例如 eth0（可多次指定），必须至少使用此选项或配置文件指定一个端口。
- `-p [dev]`：此选项用于在旧 Linux 内核上指定要使用的 PHC 设备（例如 `/dev/ptp0` 时钟设备），默认为 auto，忽略软件/LEGACY HW 时间戳。
- `-s`：从时钟模式（Slave only mode），将覆盖配置文件。
- `-t`：透明时钟模式。
- `-l [num]`：将日志记录级别设置为 num，默认为 6。
- `-m`：将消息打印到 stdout。
- `-q`：不打印消息到 syslog。
- `-h`, `--help` ：显示帮助信息并退出。
- `-V`, `--version` ：显示版本信息并退出。



## 示例

要使用 ptp4l，首先得确定网卡支持的同步类型，可通过 [ethtool](/linux-command/ethtool) 命令测试。

```bash
sudo ethtool -T eth0
```

对于支持硬件时间戳的主机，可通过以下命令运行主时钟

```bash
sudo ptp4l -m -H -i eth0
```

运行 slave 时钟

```bash
sudo ptp4l -i eth0 -m -H -s
```

若主机不支持硬件时间戳，可通过以下命令启用 PTP 软件时间戳

```bash
sudo ptp4l -m -S -i eth0          # 主时钟
sudo ptp4l -m -S -s -i eth0       # 从时钟
```

将 ptp4l 作为服务运行

```bash
sudo systemctl start ptp4l
```

- ptp4l 的配置文件：/etc/linuxptp/ptp4l.conf
- 服务配置文件：/lib/systemd/system/ptp4l.service

