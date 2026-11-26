---
sidebar_position: 10
---

# Linux 使用 gpsd 获取 GPS 数据



在 Linux 系统中，如果你需要连接 GPS 传感器进行测试，那么使用 GPSD 可以满足你的需求，帮助你快速实现 GPS 数据的获取。本文将使用导远 INS570D 传感器（车载高精度组合导航系统），演示如何在 Ubuntu 系统中获取其 RS-232 接口输出的 GPS NMEA 格式数据，并将时间、经度、纬度、海拔等信息展示出来。

你可以使用其他 GPS 传感器来完成本次实验，只要兼容 NMEA-0183 协议即可。关于 NMEA 协议的详细介绍，请参考《[GPS NMEA 协议](/protocol/gps-nmea/)》。



## GPSD 简介

GPSD 是一系列管理 GPS 设备和其他用于导航与精确计时的传感器的工具，包括航海自动识别系统（Automatic Identification System）的无线电广播设备和电子罗盘。其中最主要的程序是一个叫做 gpsd 的服务守护进程，它管理着这些传感器，并且在 TCP/IP 端口生成 JSON 流报告。其他的程序包括用来展示代码模型和各种诊断工具的客户端。

![](https://static.getiot.tech/gpsd-logo.png#center)

简单来说，GPSD 具有如下功能特性：

- 自动探测并识别 GPS 协议，同时支持多个 GPS 设备，并且可以动态进行设备控制；
- 支持 PPS 并且与 NTPD 结合，实现时间服务；
- 统一生成 JSON 流报告给上层客户端；
- 支持 DBUS，共享内存以及本地 SOCKET 等方式与客户端通讯，最大支持 64 个；
- 提供丰富的组件及工具用来调试及测试。



## 安装 GPSD

在开始之前，请先执行下面命令安装 gpsd 及各客户端程序。

```bash
sudo apt install gpsd gpsd-clients
```

安装完成后，你的 Linux 系统会增加几个命令：

| 命令      | 说明                                                         |
| --------- | ------------------------------------------------------------ |
| gpsd      | 最重要的 GPSD 服务守护进程。                                 |
| gpsprof   | 一个为错误统计和设备超时产生报告的分析器。                   |
| gpsctl    | 一个调整设备设置的公共程序。                                 |
| gpsdecode | 一个把传感器日志批量转换成可读的 JSON 的程序。               |
| gpsfake   | 一个能够连接任意数目的活动传感器日志的测试套件，可以重复运行有错误报告的传感器日志来重新产生特定的问题。 |
| cgps      | 将 GPS 结果以图形化显示。                                    |
| gpsmon    | 将 GPS 结果以图形化显示。                                    |



## 启动 GPSD

虽然 gpsd 作为一个服务程序通常使用 systemd 启动和停止（并且通常在启动时启动），例如：

以 systemd 方式启动 gpsd 服务

```bash
sudo systemctl start gpsd
```

以 systemd 方式停止 gpsd 服务

```bash
sudo systemctl stop gpsd
sudo systemctl stop gpsd.socket
```

查看 gpsd 服务状态

```bash
sudo systemctl status gpsd
```

但是为了简单起见，我们还是手动运行它。这样会更加灵活一点，尤其是当我们需要处理来自 GPS 设备的数据时，比如我们通过串行或 USB 端口连接 GPS 传感器，这样可以在启动 gpsd 服务时指定设备节点。

手动方式启动 gpsd 守护进程

```bash
gpsd /dev/ttyUSB0
```

当然，你的设备节点有可能不是 /dev/ttyUSB0。在 Linux 系统中，你可以通过 [minicom](/linux-command/minicom/) 或 [socat](/linux-command/socat/) 命令简单测试一下，看看能够读取 GPS 设备的数据。

例如，在我们这里，打开 /dev/ttyUSB0 串口，可以看到 INS570D 输出如下数据，即可确定该设备名称是正确的。

```bash showLineNumbers
$GPGGA,125657.00,2309.61109941,N,11329.63396336,E,1,28,0.6,51.3817,M,-6.1780,M,,*42
$GPRMC,125657.00,A,2309.61109941,N,11329.63396336,E,0.006,9.7,081222,3.2,W,A*2B
```

注意：如果没有收到 GPS 数据，可能是权限问题导致的。执行下面命令将当前用户（非 root 用户）添加到 dialout 用户组，然后重启系统后再次尝试。

```bash
sudo usermod -a -G dialout $USER
```



## 配置 GPSD

根据所使用 GPS 设备的不同，你可能需要修改 GPSD 的配置文件，指定设备节点、串口波特率等参数。例如我们这里使用的 INS570D 设备默认波特率为 115200，设备节点默认为 /dev/ttyUSB0，因此我们修改以下两个文件。

**/etc/default/gpsd**

```bash showLineNumbers
# Devices gpsd should collect to at boot time.
# They need to be read/writeable, either by user gpsd or the group dialout.
DEVICES="/dev/ttyUSB0"

# Other options you want to pass to gpsd
GPSD_OPTIONS="-F /var/run/gpsd.sock"

# Automatically hot add/remove USB GPS devices via gpsdctl
USBAUTO="true"
```

**/lib/systemd/system/gpsd.service**

```bash showLineNumbers
[Unit]
Description=GPS (Global Positioning System) Daemon
Requires=gpsd.socket
# Needed with chrony SOCK refclock
After=chronyd.service

[Service]
Type=forking
EnvironmentFile=-/etc/default/gpsd
ExecStartPre=/bin/stty speed 115200 -F $DEVICES
ExecStart=/usr/sbin/gpsd $GPSD_OPTIONS $DEVICES

[Install]
WantedBy=multi-user.target
Also=gpsd.socket
```

重启 gpsd 服务使用新的配置。



## 观测 GPS 信息

当我们启动 gpsd 守护进程之后，就可以使用 GPSD 自带的客户端程序观察 GPS 数据了。

启动 cgps 客户端观测数据：

```bash
cgps
```

可以看到如下界面：

![](https://static.getiot.tech/linux-gpsd-cgps.png#center)

启动 gpsmon 客户端观测数据：

```bash
gpsmon
```

可以看到如下界面：

![](https://static.getiot.tech/linux-gpsd-gpsmon.png#center)

这样就可以很直观地看到来自 GPS 传感器的位置、速度、时间等信息啦！



## 动手写程序

如果你想自己编写应用程序获取来自 gpsd 的数据，可以使用 libgps 库，具体使用方法请参考《[libgps 使用教程](/awesome-c/libgps/)》。

示例代码：[read_gps_data.c](https://github.com/getiot/linux-c/blob/main/peripherals/gps/read_gps_data.c)



