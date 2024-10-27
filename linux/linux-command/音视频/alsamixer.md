---
sidebar_label: alsamixer 命令
sidebar_position: 4
slug: /alsamixer
---

# alsamixer 命令



## 介绍

**alsamixer** 是 Linux 系统中的一个命令行工具，用于调整 ALSA（Advanced Linux Sound Architecture）音频设置，例如调整音频设备的音量、通道、输入输出等参数。和 [amixer](/linux-command/amixer) 不同，alsamixer 提供一个交互式的文本界面。

**语法**：

```bash
alsamixer [options]
```

**选项**：

- `-h`, `--help` ：显示帮助信息。
- `-c, --card <card number or identification>`：如果你有多个声卡，请选择要使用的声卡。声卡编号从 0（默认）开始。
- `-D, --device <device identification>`：选择要控制的混音器设备（mixer device）。
- `-V, --view <mode>`：选择起始视图模式，播放（playback）、捕捉（capture）或全部（all）。
- `-g, --no-color`：切换颜色的使用。

**交互操作**：

- 左右箭头键：选择不同的控制元素。
- 上下箭头键：调整所选控制元素的值。
- M 键：静音/取消静音。
- Esc 键：退出 alsamixer。



## 示例

启动 alsamixer 程序：

```bash
alsamixer
```

可以看到类似如下界面：

![](https://static.getiot.tech/alsamixer-screenshot.png#center)

