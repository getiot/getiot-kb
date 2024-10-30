---
sidebar_label: gpsd 命令
sidebar_position: 14
slug: /gpsd
---

# Linux gpsd 命令 - 管理 GPS 接收器服务



## 介绍

**gpsd**（英文全拼：GPS daemon）是 Linux 系统中用于接收和处理 GPS 数据的守护进程，它可以监控通过串口或 USB 端口连接到主机计算机上的一个或多个 GPS 或 AIS 接收器，并将所有 GPS 传感器位置、航向、速度等数据通过 TCP 端口 2947 提供给客户端查询。

gpsd 服务是 [GPSD](https://gitlab.com/gpsd/gpsd) 项目的一部分，该项目提供一系列管理 GPS 设备和其他用于导航与精确计时的传感器的工具。

扩展阅读：《[Linux 使用 gpsd 获取 GPS 数据](/linux-note/linux-get-gps-data-using-gpsd)》、《[libgps 使用教程](/awesome-c/libgps)》。

**安装**：

gpsd 命令由 gpsd 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install gpsd
```

**语法**：

```bash
gpsd [OPTIONS] device...
```

**选项**：

- `-b`：bluetooth-safe 模式，打开只读数据源。
- `-D integer`：设置调试等级（默认为 0）。
- `-F sockfile`：指定控制套接字（control socket）的位置。
- `-f FRAMING`：将设备帧固定为 `FRAMING`（例如 8N1、8O1 等）。
- `-G`：使 gpsd 监听 `INADDR_ANY`，在此二进制文件中强制启用。
- `-h`：显示帮助信息。
- `-n`：不要等待客户端连接来轮询 GPS。
- `-N`：不要进入后台。
- `-P pidfile`：设置记录进程 ID 的文件。
- `-r`：即使没有修正也使用 GPS 时间。
- `-S PORT`：设置守护进程的端口（默认端口为 2947）
- `-s SPEED`：将设备速度固定为 `SPEED`。
- `-V`：显示版本信息并退出。



## 示例

假设你在 Linux 系统的最小编号的 USB 端口（/dev/ttyUSB0）上连接了 GPS 设备，并且想要在默认的 2947 端口上读取它的报告，那么只需以 root 身份执行下面命令即可：

```bash
sudo gpsd /dev/ttyUSB0
```

你可以执行下面命令将当前用户（非 root 用户）添加到 dialout 用户组，这样可以免去每次都要添加 `sudo`。

```bash
sudo usermod -a -G dialout $USER
```

注意：上述命令在重启系统后生效。



