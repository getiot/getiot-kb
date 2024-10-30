---
sidebar_label: arecord 命令
sidebar_position: 2
slug: /arecord
---

# arecord 命令 - 录制音频文件



## 介绍

**arecord** 是 Linux 系统中用于录制音频文件的命令行工具，它可以通过 ALSA 驱动从音频输入设备录制音频，并保存为音频文件。arecord 是 ALSA（Advanced Linux Sound Architecture）项目的一部分。

arecord 支持大多数音频文件格式，如 WAV、MP3、OGG 等，录制完成后可以将录音保存为相应格式。arecord 还支持基本的录音效果，如混响等。

**语法**：

```bash
arecord [options] [filename]
```

**选项**：

- `-l, --list-devices`：列出所有声卡和数字音频设备。
- `-L, --list-pcms`：列出所有 PCM 设备名称。
- `-D, --device=NAME`：按名称选择 PCM 设备。
- `-q, --quiet`：安静模式。
- `-t, --file-type TYPE`：指定文件类型（如 voc、wav、raw 或 au）。
- `-c, --channels=#`：指定音频文件的通道数。
- `-f, --format=FORMAT`：指定音频文件的采样格式（不区分大小写）。
- `-r, --rate=#`：指定音频文件的采样率。
- `-d, --duration=#`：`#` 秒后中断。
- `-s, --samples=#`：每个通道采样 `#` 次后中断。
- `-v, --verbose`：显示 PCM 结构和设置（累计）。
- `-i, --interactive`：允许来自 stdin 的交互操作。
- `-h, --help`：显示帮助信息。
- `--version`： 显示版本信息。



## 示例

录制 wav 格式音频，输入设备为 `hw:0.0`，录制时间为 5 秒，采样率为 44100Hz（CD 音质），保存为 sample.wav：

```bash
arecord -D hw:0.0 -d 5 -r 44100 -f cd sample.wav
```

