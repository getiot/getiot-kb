---
sidebar_label: amixer 命令
sidebar_position: 3
slug: /amixer
---

# amixer 命令



## 介绍

**amixer** 是 Linux 系统中的一个命令行工具，用于调整音频设置，包括音量、音频输入和输出设备等。它是 ALSA（Advanced Linux Sound Architecture）项目的一部分。

**语法**：

```bash
amixer [-option] [cmd]
```

**选项**：

- `-c`, `--card N` ：选择声卡卡号。
- `-D`, `--device N` ：选择声卡设备，默认为 'default'。
- `-d`, `--debug` ：调试模式。
- `-n`, `--nocheck` ：不执行范围检查。
- `-q`, `--quiet` ：安静模式。
- `-i`, `--inactive` ：也显示不活动的控件。
- `-a`, `--abstract L` ：选择抽象级别（none 或 basic）。
- `-s`, `--stdin` ：从标准输入顺序读取和执行命令。
- `-h`, `--help` ：显示帮助信息。
- `-v`, `--version` ：打印版本信息。

**命令**：

- `scontrols` ：显示所有混音器简单控件。
- `scontents` ：显示所有混音器简单控件的内容（默认命令）。
- `sset sID P` ：为一个混音器简单控件设置内容。
- `sget sID` ：获取一个混音器简单控件的内容。
- `controls` ：显示指定声卡的所有控件。
- `contents` ：显示指定声卡的所有控件的内容。
- `cset cID P` ：为一个控件设置控件内容。set control contents for one control  
- `cget cID` ：获取一个控件的控件内容。



## 示例

列出可用的音频控制元素：

```bash
amixer controls
```

获取 `Master` 通道的音量信息（显示当前音量）：

```bash
amixer sget Master
```

将 `Master` 通道的音量设置为最大值：

```bash
amixer sset Master 100%
```

调整 PCM 通道的音量（设置为 80%）：

```bash
amixer sset PCM 80%
```

获取 PCM 通道的音量：

```bash
amixer sget PCM
```

切换 `Master` 通道的静音状态（静音/取消静音）：

```bash
amixer sset Master toggle
```

设置 PCM 通道的控制参数（设置 `numid` 为 3 的控制参数为 2）：

```bash
amixer cset numid=3 2
```

获取 PCM 通道的控制参数（获取 `numid` 为 3 的控制参数）：

```bash
amixer cget numid=3
```

指定音频卡设备为 `hw:0`，并将 `Master` 通道的音量设置为 50%：

```bash
amixer -D hw:0 sset Master 50%
```

