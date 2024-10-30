---
sidebar_label: cgps 命令
sidebar_position: 15
slug: /cgps
---

# Linux cgps 命令 - 显示 GPS 信息和位置



## 介绍

**cgps** 是 gpsd 软件包中的一个客户端命令行工具，它可以以更友好的方式展示 GPS 数据（NMEA 报文格式），可用于测试 GPS 设备故障情况。

**语法**：

```bash
cgps [-h] [-l {d|m|s}] [-m] [-s] [-V] [server[:port:[device]]]
```

**选项**：

- `-D debug-level`：设置 debug 等级。

- `-l {d|m|s}`：选择 lat/lon 输出格式，其中：

  `d` 表示 `DD.ddddddd`（默认）

  `m` 表示 `DD MM.mmmmmm'`

  `s` 表示 `DD MM' SS.sssss"`

- `-m`：显示你的磁轨（但不是真实的磁轨），这是计算值，而不是测量值。磁力变化总是可能会出现较大的误差，但通常优于两度。

- `-s`：安静模式（不打印原始 gpsd 数据）。

- `-h`：显示帮助信息。

- `-V`：显示版本信息。



## 示例

连接好 GPS 设备，启动 gpsd 守护进程后，执行 `cgps` 启动客户端：

```bash
cgps
```

可以看到类似如下的数据展示界面：

![](https://static.getiot.tech/linux-gpsd-cgps.png#center)

提示：可参考《[Linux 使用 gpsd 获取 GPS 数据](/linux-note/linux-get-gps-data-using-gpsd)》。
