---
sidebar_label: aplay 命令
sidebar_position: 1
slug: /aplay
---

# aplay 命令



## 介绍

**aplay** 是 Linux 系统中用于播放音频文件的命令行工具。它是 ALSA（Advanced Linux Sound Architecture）项目的一部分，用于与音频设备进行交互。

aplay 支持大多数音频文件格式，如 WAV、MP3、OGG 等。理论上，只要有相应的 ALSA 插件支持就可以播放。

**语法**：

```bash
aplay [options] [filename [filename]] ...
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

:::info 备注

支持的采样格式有：`S8` `U8` `S16_LE` `S16_BE` `U16_LE` `U16_BE` `S24_LE` `S24_BE` `U24_LE` `U24_BE` `S32_LE` `S32_BE` `U32_LE` `U32_BE` `FLOAT_LE` `FLOAT_BE` `FLOAT64_LE` `FLOAT64_BE` `IEC958_SUBFRAME_LE` `IEC958_SUBFRAME_BE` `MU_LAW` `A_LAW` `IMA_ADPCM` `MPEG` `GSM` `SPECIAL` `S24_3LE` `S24_3BE` `U24_3LE` `U24_3BE` `S20_3LE` `S20_3BE` `U20_3LE` `U20_3BE` `S18_3LE` `S18_3BE` `U18_3LE`。

需要注意的是，并非所有硬件都完全支持这些格式。

此外，一些常用的格式有快捷方式：

- `-f cd`（16 bit little endian, 44100, stereo）等效于 `-f S16_LE -c2 -r44100`
- `-f cdr`（16 bit big endian, 44100, stereo）等效于  `-f S16_BE -c2 -f44100`
- `-f dat`（16 bit little endian, 48000, stereo）等效于 `-f S16_LE -c2 -r48000`

如果没有指定采样格式，默认使用 `U8`。

:::



## 示例

播放名为 sample.wav 的音频文件：

```bash
aplay sample.wav
```

指定使用硬件设备 `hw:0,0` 进行播放：

```bash
aplay -D hw:0,0 sample.wav
```

指定音频文件的格式为 CD 质量（16位，立体声），通道数为 2，采样率为 44100 Hz：

```bash
aplay -f cd -c 2 -r 44100 sample.wav
```

使用原始文件类型进行播放，并指定采样率、通道数和数据格式：

```bash
aplay -t raw -r 44100 -c 2 -f S16_LE sample.raw
```

从标准输入读取数据进行播放：

```bash
cat sample.wav | aplay -
```

