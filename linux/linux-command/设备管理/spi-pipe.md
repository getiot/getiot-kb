---
sidebar_label: spi-pipe 命令
sidebar_position: 5
slug: /spi-pipe
---

# spi-pipe 命令



## 介绍

**spi-pipe** 命令用于在用户空间进行全双工 SPI 通讯测试。

spi-pipe 命令由 spi-tools 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install spi-tools
```

**语法**：

```bash
spi-pipe [options...]
```

**选项**：

- `-d`, `--device=DEVICE` ：使用指定的 spidev 字符设备
- `-s`, `--speed=<int>` ：设置目标 SPI 传输速度
- `-b`, `--blocksize=<int>` ：设置要传输的块大小（单位字节）
- `-n`, `--number=<int>` ：设置要传输的块数（-1表示连续传输）
- `-h`, `--help` ：查看帮助并退出
- `-v`, `--version` ：查看版本信息并退出

相关命令：[spi-config](/linux-command/spi-config)



## 示例

同时发送和接收

```bash
command-1 | spi-pipe --device=/dev/spidev0.0 | command-2
```

注意：*command-1*, *command-2* 和 **spi-pipe** 需要在三个不同的进程中同时运行。

将数据发送到 SPI 连接

```bash
command-1 | spi-pipe --device=/dev/spidev0.0
```

从 SPI 连接中接收数据

```bash
spi-pipe --device=/dev/spidev0.0 < /dev/zero | command-2
```

提示：使用 `command-2 < /dev/spidev0.0` 命令也可以接收数据（数据始终为 0），但是使用 **spi-pipe** 可以控制发送到设备的内容。

从 SPI 连接读取 40 个 4 字节的块

```bash
spi-pipe --device=/dev/spidev0.0 -b 4 -n 40 < /dev/zero | command-2
```

