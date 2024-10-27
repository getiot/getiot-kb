---
sidebar_label: spi-config 命令
sidebar_position: 4
slug: /spi-config
---

# spi-config 命令



## 介绍

**spi-config** 命令用于在用户空间查询或设置 SPI 总线配置。

spi-config 命令由 spi-tools 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install spi-tools
```

**语法**：

```bash
spi-config [options...]
```

**选项**：

- `-d`, `--device=DEVICE` ：使用指定的 spidev 字符设备

- `-q`, `--query` ：打印当前的配置

- `-m`, `--mode=[0-3]` ：设置 SPI 模式

- `-l`, `--lsb={0,1}` ：设置数据传输方式为 LSB first (1) 或者 MSB first (0)

- `-b`, `--bits=[7...]` ：设置每个字（word）的位数

- `-s`, `--speed=FREQUENCY` ：设置时钟频率（单位 Hz）

- `-r`, `--spirdy={0,1}` ：设置 SPI READY 模式标志

- `-s`, `--wait` ：阻塞，保持文件描述符打开

- `-h`, `--help` ：查看帮助并退出

- `-v`, `--version` ：查看版本信息并退出

**SPI 模式**：

| 模式   | 描述                                       |
| ------ | ------------------------------------------ |
| mode 0 | low iddle level, sample on leading edge.   |
| mode 1 | low iddle level, sample on trailing edge.  |
| mode 2 | high iddle level, sample on leading edge.  |
| mode 3 | high iddle level, sample on trailing edge. |

相关命令：[spi-pipe](/linux-command/spi-pipe)



## 示例

查询 /dev/spidev0.0 设备当前配置

```bash
spi-config --device=/dev/spidev0.0 -q
```

修改时钟频率为1MHz

```bash
spi-config --device=/dev/spidev0.0 --speed=1000000
```

设置配置并保持设备开启

```bash
spi-config --wait -d /dev/spidev0.0 -s 1000000 & PID=$!
```

注：`$!` 是 Shell 最后运行的后台进程的 PID

关闭之前打开的设备

```bash
kill $PID
```

