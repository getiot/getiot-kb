---
sidebar_label: gpspipe 命令
sidebar_position: 17
slug: /gpspipe
---

# gpspipe 命令 - 显示 GPS 数据流



## 介绍

**gpspipe**（英文全拼：GPS pipe）是 GPSD 软件包中的一个命令行工具，用于连接 gpsd 守护进程并将接收到的数据输出到 stdout。这使得 gpspipe 可用作从 gpsd 到另一个程序或文件的管道，从而实现读取实时的 GPS 数据流的功能。

gpspipe 的输出将包含原始 NMEA 或本地 GPSD 语句之一或两者，每行都可以选择带有时间戳。gpspipe 默认从本地主机的 2947 端口上获取并监视 gpsd 打开的所有设备，你也可以选择指定的服务器、TCP/IP 端口号和远程设备。

:::tip

执行 gpspipe 命令不需要 root 权限，并且可以与连接到本地 gpsd 的其他工具同时运行。

:::

**语法**：

```bash
gpspipe [OPTIONS] [server[:port[:device]]]
```

**选项**：

- `-2`：设置 split24 标志。
- `-d`：作为守护进程运行。
- `-h`：显示帮助信息。
- `-l`：连接 gpsd 之前休眠十秒钟。
- `-n [count]`：计数数据包后退出。
- `-o [file]`：将输出写入文件。
- `-P`：在 NMEA 或原始模式下包含 JSON 格式的 PPS 信息。
- `-p`：在 JSON 中包含分析信息。
- `-r`：转储原始 NMEA。
- `-R`：转储超级原始模式（GPS 二进制）。
- `-s [serial dev]`：在串口上模拟 4800bps NMEA GPS（需要与 `-r` 选项一起使用）。
- `-S`：设置缩放标志（用于 AIS 和子帧数据）。
- `-T [format]`：设置时间戳格式（类似于 strftime，隐含 `-t` 选项）。
- `-t`：为数据添加时间戳。
- `-u`：usec 时间戳（隐含 `-t` 选项）。使用 `-uu` 输出 *sec.usec*。
- `-v`：打印一个小旋转器（spinner）。
- `-V`：显示版本信息并退出。
- `-w`：转储 gpsd 本机数据。
- `-x [seconds]`：指定延迟 seconds 秒后退出。
- `-Z`：设置时间戳格式为 iso8601（隐含 `-t` 选项）。

:::tip

选项 `-r`、`-R` 或 `-w` 必须选择一个或多个；如果使用 `-d` 选项，那么必须使用 `-o` 选项。

:::



## 示例

以默认格式显示 GPS 数据：

```bash
gpspipe
```

以原始 NMEA 格式显示 GPS 数据：

```bash
gpspipe -r
```

使用 grep 命令在 gpspipe 中过滤数据并显示特定信息。例如，要显示 GPS Fix 数据：

```bash
gpspipe -w | grep -m 1 'TPV' | jq '.tpv | {lat, lon, alt}'
```

这会在标准输出中显示最新的 GPS Fix 数据，并仅显示经度、纬度和高度信息。在此命令中，管道（`|`）符号用于将 gpspipe 所生成的输出输入到 grep 中。-m 参数指定仅匹配一次，以便仅显示最新数据。你可以根据你的需求，使用其他选项来过滤数据。

注意：在上述命令中，使用了 [jq](/linux-command/jq) 命令来格式化 JSON 数据并仅显示特定字段。

