---
sidebar_position: 16
slug: /gpsmon
---

# gpsmon 命令



## 介绍

**gpsmon**（英文全拼：GPS monitor）是 GPSD 软件包中的一个监视器工具，用于监视来自 GPS 的数据包并将其与诊断信息一起显示。它支持可用于以各种方式调整 GPS 设置的命令，有些与设备无关，有些则随 GPS 芯片组类型而变化。当连接到未知的 GPS 类型时，它依然会表现得很正常，因为它只会转储数据包。

gpsmon 经常用于诊断 GPS 设备，因为它不会修改原始数据，不进行任何插值或建模来得出爬升/下沉或误差估计。哪怕当数据质量太低时，它也不会丢弃报告。

**语法**：

```bash
gpsmon [-?hVn] [-l logfile] [-D debuglevel] [-t type] [server[:port:[device]]]
```

**选项**：

- `-L`：以表格形式列出 gpsmon 内置支持哪些 GPS 设备类型，以及哪些通用命令可以应用于哪些 GPS 类型。注意，这并未列出与各个 GPS 类型相关的特定于类型的命令。
- `-n`：强制 gpsmon 请求 NMEA0183 数据包，而不是来自 gpsd 的原始数据流。
- `-a`：启用不使用屏幕绘制的特殊调试模式。数据包正常转储；键入任何字符都会暂停数据包转储并显示命令提示符。主要是 GPSD 开发人员对该功能感兴趣。
- `-F sockfile`：该选项仅在客户端模式下有效，它指定程序应向其发送设备控制字符串的控制套接字。必须在本地文件系统上指定 Unix 域套接字的有效路径名。
- `-l logfile`：将日志记录设置为在设备打开时立即输出到指定文件。
- `-t type`：设置设备类型。设备类型通过一个字符串区分，它包含驱动程序类型名称的前缀。
- `-D debuglevel`：设置调试等级，这可能仅对 GPSD 代码的开发人员有用。你可以参阅 packet-getter 源代码以获取相关值。
- `-h`：显示帮助信息。
- `-V`：显示版本信息并退出。



## 示例

连接好 GPS 设备，启动 gpsd 守护进程后，执行 `gpsmon` 启动监视器客户端：

```bash
gpsmon
```

可以看到类似如下的数据展示界面：

![](https://static.getiot.tech/linux-gpsd-gpsmon.png#center)

列出 gpsmon 内置支持哪些 GPS 设备类型：

```bash
$ gpsmon -L
General commands available per type. '+' means there are private commands.
i l q ^S ^Q       x  	NMEA0183
i l q ^S ^Q n     x  	Garmin NMEA
i l q ^S ^Q n     x  	Garmin Serial binary
i l q ^S ^Q       x +	Ashtech
i l q ^S ^Q       x  	San Jose Navigation FV18
i l q ^S ^Q       x  	Furuno Electric GH-79L4
i l q ^S ^Q     x x  	MTK-3301
i l q ^S ^Q          	AIVDM
i l q ^S ^Q n s   x +	SiRF
i l q ^S ^Q n s x x +	u-blox
i l q ^S ^Q         +	iTalk
i l q ^S ^Q n s   x +	SuperStarII
i l q ^S ^Q       x +	Motorola Oncore
i l q ^S ^Q   s   x +	True North
i l q ^S ^Q          	JSON slave driver
```

