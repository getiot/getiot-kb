---
sidebar_position: 25
slug: /ppsctl
---

# ppsctl 命令



## 介绍

**ppsctl** 命令是 pps-tools 软件包中的一部分，用于管理和配置 PPS 信号。它提供对 PPS 信号进行测试和调试的功能，允许用户查看和调整与 PPS 相关的参数。

:::tip

pps-tools 软件包提供了与 PPS（Pulse-Per-Second）信号相关的工具，该软件包提供了 ppscheck、ppsctl、ppsfind、ppsldisc、ppstest、ppswatch 等命令。

关于 LinuxPPS 命令和 API 接口的详细介绍可查阅 [http://linuxpps.org](http://linuxpps.org) 上的 Wiki 文档。

:::

**安装**：

```bash
$ sudo apt install pps-tools
```

**语法**：

```bash
ppsctl [-bBfFac] <ppsdev>
```

**选项**：

- `-b`：绑定内核 PPS 消费者。
- `-B`：解除绑定内核 PPS 消费者。
- `-f`：设置内核 NTP PPS 标志。
- `-F`：取消设置内核 NTP PPS 标志。
- `-a`：使用 assert edge。
- `-c`：使用 clear edge（默认）。



## 示例

启动 PPS 输入设备进行时间同步：

```bash
ppsctl /dev/pps0
```

检查同步状态：

```bash
ppstest /dev/pps0
```

