---
sidebar_label: nethogs 命令
sidebar_position: 30
slug: /nethogs
---

# nethogs 命令



## 介绍

**NetHogs** 是一个开源的小型 net top 工具，它可以按进程实时监控网络带宽使用率。

和其他按协议或按子网分解流量的工具不同，NetHogs 是按进程对带宽进行分组的，并且不依赖于加载的特殊内核模块。因此，如果突然出现大量网络流量，你可以启动 NetHogs 并立即查看是哪个 PID 导致了这种情况，如果是某种旋转进程（spinning process），就可以将其终止。

使用前请确保你的系统上已经安装 nethogs 工具，在 Debian/Ubuntu 系统上可通过 apt 进行安装：

```bash
sudo apt install nethogs
```

**语法**：

```bash
nethogs [options] [devices]
```

**选项**：

- `-V`：打印版本信息。
- `-h`：打印帮助信息。
- `-d`：延迟更新刷新率（以秒为单位），用于控制界面的更新速度。默认值为 1。
- `-v`：设置显示模式（0 = KB/s，1 = total KB，2 = total B，3 = total MB）。默认值为 0。
- `-c`：限制刷新次数，默认为 0（无限制）。
- `-t`：追踪模式（tracemode）。
- `-p`：混杂模式的嗅探器（不推荐）。
- `-s`：按照发送的流量排序。

**参数**：

- `devices`：要监控的网络设备。默认使用 `eth0`。

**交互命令**：

当 nethogs 运行时，还可以通过键盘快捷键进行交互。

- `m`：在 kb/s, kb, b, mb 几种显示模式之间循环切换。
- `r`：按 received 接收流量排序。
- `s`：按 sent 发送流量排序。
- `q`：退出。



## 示例

以默认方式启动 nethogs 程序：

```bash
$ sudo nethogs
```

设置每 5 秒刷新一次：

```bash
$ sudo nethogs -d 5 
```

指定要监视的网络设备（例如 `eth0`）：

```bash
$ sudo nethogs eth0
```

同时监视两个网络设备：

```bash
$ sudo nethogs eth0 eth1
```

使用追踪模式：

```bash
$ sudo nethogs -t 
```

:::tip

在基于 Debian 的系统（例如 Ubuntu）下要执行 nethogs 需要 root 权限，因此 `sudo` 是必须的。而基于 RedHat 系统则不需要。

:::
