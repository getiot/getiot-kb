---
sidebar_position: 11
slug: /phc2sys
---

# phc2sys 命令



## 介绍

**phc2sys**（英文全拼：PTP hardware clock to system）命令用于同步两个或多个时钟。最常见的用法是，将系统时钟同步到网卡上的 PTP 硬件时钟（PHC）。PHC 本身可以使用 `ptp4l` 同步，系统时钟被视为从属时钟，而网卡上的时钟则为主时钟。

相关命令：[ptp4l](/linux-command/ptp4l)、[phc_ctl](/linux-command/phc_ctl)、[pmc](/linux-command/pmc)

关于 PTP 详细介绍，请参考《[PTP 精确时间协议](/protocol/ptp)》。

**安装**：

phc2sys 命令由 LinuxPTP 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install linuxptp
```

**语法**：

```bash
phc2sys -a [ -r ] [ -r ] [ options ]
phc2sys [ -d pps-device ] [ -s device ] [ -c device ] [ -O offset ] [ -w ] [ options ]
```

**选项**：

自动配置：

- `-a`：开启自动配置。
- `-r`：同步系统（实时）时钟，重复 `-r` 将其也视为时间源。

手动配置：

- `-c [dev|name]`：从时钟（CLOCK_REALTIME）。
- `-d [dev]`：主 PPS 设备。
- `-s [dev|name]`：主时钟。
- `-O [offset]`：从主时间偏移量，默认为 0。
- `-w`：等待 ptp4l。

通用选项：

- `-E [pi|linreg]`：时钟伺服，默认为 pi。
- `-P [kp]`：比例常数，默认为 0.7。
- `-I [ki]`：积分常数，默认为 0.3。
- `-S [step]`：设置步阈值，默认不开启。
- `-F [step]`：仅在开始时设置步阈值，默认为 0.00002。
- `-R [rate]`：以 HZ 为单位的从属时钟更新率，默认为 1 HZ。
- `-N [num]`：每次更新的主时钟读数数量，默认为 5。
- `-L [limit]`：以 ppb 为单位的健全频率限制，默认为 200000000。
- `-M [num]`：NTP SHM 段号，默认为 0。
- `-u [num]`：摘要统计中的时钟更新次数，默认为 0。
- `-n [num]`：域编号（domain number），默认为 0。
- `-x`：通过伺服而不是内核应用闰秒。
- `-z [path]`：UDS 的服务器地址（/var/run/ptp4l）。
- `-l [num]`：将日志记录级别设置为 num，默认为 6。
- `-t [tag]`：为日志消息添加标记（tag）。
- `-m`：将消息打印到标准输出（stdout）。
- `-q`：不要将消息打印到系统日志（syslog）。
- `-v`：显示版本信息并退出。
- `-h`：显示帮助信息并退出。



## 示例

将系统时钟同步到网卡上的 PTP 硬件时钟（PHC），使用 `-s` 可按设备或网络接口指定主时钟，使用 `-w` 可等待直到 `ptp4l` 进入已同步状态：

```bash
sudo phc2sys -s eth0 -w
```

PTP 按国际原子时（TAI）运行，而系统时钟使用的是协调世界时（UTC）。如果不指定 `-w` 来等待 `ptp4l` 同步，可以使用 `-O` 来指定 TAI 与 UTC 之间的偏差（以秒为单位）：

```bash
sudo phc2sys -s eth0 -O -35
```

将 `phc2sys` 作为服务运行：

```bash
sudo systemctl start phc2sys
```

