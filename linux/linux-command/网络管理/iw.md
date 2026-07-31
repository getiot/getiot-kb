---
sidebar_label: iw 命令
sidebar_position: 47
slug: /iw
description: "iw 命令是用于配置和管理基于 nl80211 驱动的无线网络接口的工具，可查看网卡信息、扫描 Wi-Fi 热点、连接网络、设置发射功率等。"
---

# Linux iw 命令 - 配置无线网络接口



## 介绍

**iw** 命令是用于配置和管理基于 nl80211 驱动的无线网络接口的工具，可查看网卡信息、扫描 Wi-Fi 热点、连接网络、设置发射功率等。它是传统 `iwconfig` 的现代替代方案，支持更多 Wi-Fi 新特性（如 802.11n/ac/ax）。

iw 命令由 iw 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install iw
```

**语法**：

```bash
iw [options] command
```

**常用子命令**：

- `iw dev`：列出所有无线设备
- `iw dev <devname> info`：显示指定设备的详细信息
- `iw dev <devname> link`：显示当前连接状态
- `iw dev <devname> scan`：扫描附近 Wi-Fi 热点
- `iw dev <devname> scan dump`：以详细格式输出扫描结果
- `iw dev <devname> set type <type>`：设置设备类型（如 `managed`、`monitor`、`ap`）
- `iw dev <devname> set channel <channel>`：设置信道
- `iw dev <devname> set txpower <power>`：设置发射功率
- `iw dev <devname> interface add <name> type <type>`：创建虚拟接口
- `iw dev <devname> del`：删除虚拟接口
- `iw phy`：列出物理无线设备
- `iw phy <phyname> info`：显示物理设备信息
- `iw reg get`：查看当前无线电监管域
- `iw reg set <country>`：设置监管域（如 `CN`、`US`）

相关命令：[nmcli](/linux-command/nmcli/)、[ip](/linux-command/ip/)、[ss](/linux-command/ss/)



## 示例

1、列出所有无线网卡：

```bash
iw dev
```

2、查看 wlan0 的详细信息：

```bash
iw dev wlan0 info
```

3、查看当前 Wi-Fi 连接状态：

```bash
iw dev wlan0 link
```

4、扫描附近 Wi-Fi 热点：

```bash
sudo iw dev wlan0 scan | grep SSID
```

5、以详细格式导出扫描结果：

```bash
sudo iw dev wlan0 scan dump
```

6、将网卡设置为监听模式（用于抓包）：

```bash
sudo iw dev wlan0 set type monitor
```

7、恢复为普通管理模式：

```bash
sudo iw dev wlan0 set type managed
```

8、查看当前无线电监管域：

```bash
iw reg get
```

9、查看物理设备支持的频段和信道：

```bash
iw phy phy0 info
```
