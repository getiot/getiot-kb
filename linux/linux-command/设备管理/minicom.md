---
sidebar_position: 12
slug: /minicom
---

# minicom 命令



## 介绍

**Minicom** 是 Linux 下一款常用的命令行串口调试工具。其功能与 Windows 下的超级终端相似，可以通过串口控制外部的硬件设备，通常用于对嵌入式设备进行管理。

Linux 发行版通常不预装 minicom 工具，用户可自行安装，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
$ sudo apt install minicom
```

**语法**：

```bash
minicom [options] [configuration]
```

**选项**：

- `-b`, `--baudrate` ：设置波特率（忽略 config 中的值）
- `-D`, `--device` ：指定串口设备（忽略 config 中的值）
- `-s`, `--setup` ：进入设置模式
- `-o`, `--noinit` ：启动时不要初始化 modem 和 lockfiles
- `-w`, `--wrap` ：打开换行显示
- `-H`, `--displayhex` ：以十六进制显示输出
- `-z`, `--statline` ：尝试使用终端的状态栏
- `-7`, `--7bit` ：强制使用7位模式
- `-8`, `--8bit` ：强制使用8位模式
- `-c`, `--color=on/off` ：开启或关闭 ANSI 风格颜色用法
- `-a`, `--attrib=on/off` ：开启或关闭高亮属性
- `-t`, `--term=TERM` ：覆盖 TERM 环境变量
- `-S`, `--script=SCRIPT` ：启动时运行脚本
- `-p`, `--ptty=TTYP` ：连接到伪终端（pseudo terminal）
- `-C`, `--capturefile=FILE` ：捕获终端并保存到文件
- configuration ：指定 minicom 配置文件启动



## 示例

打开指定的串口终端

```bash
$ sudo minicom -D /dev/ttyUSB0
```

打开指定的串口终端，并以 ANSI 颜色风格显示

```bash
$ sudo minicom -D /dev/ttyUSB0 -c on
```

打开指定的串口终端，并将内容保存到文件

```bash
$ sudo minicom -D /dev/ttyUSB0 -C output.txt
```

设置串口终端参数

```bash
$ sudo minicom -s
```

配置完成后，选“Save setup as..”将该配置保存为指定名称，例如“stm32”

![](https://static.getiot.tech/minicom_configuration.png#center)

保存，在 /etc/minicom 目录下将会生成 minirc.stm32 文件。

之后我们就可以通过配置文件启动串口终端了

```bash
$ sudo minicom stm32
```

在 minicom 终端中，按 CTRL+A，再按 Z 将会打开配置窗口，按 X 可退出该串口终端。

![](https://static.getiot.tech/minicom_command_summary.png#center)

提示：minicom 使用前缀按键 Ctrl-A，即执行特殊操作时，都需要先按 Ctrl+A，再按某个按键使用对应的功能。比如：

- 按 Z 键查看帮助；
- 按 X 或 Q 键退出窗口；
- 按 W 键打开或关闭换行功能；
- 按 N 键打开或关闭时间戳显示；

如果串口有输出，但无法输入，通常是由于开启了硬件流控导致的。按 CTRL-A Z 进入设置页，按 O 键选择 “cOnfigure Minicom” 项，再选择 “Serial port setup” 项，按 F 键关闭 Hardware Flow Control。

有时候窗口打印数据较多，我们需要暂停输出，以便于查看。按 Ctrl+A 即可暂停输出。Ctrl+A 是 mimicom 的特殊功能前缀按键，但还有另一个很实用的作用，就是暂停屏幕输出。

如果设备端支持的话，按下 Ctrl+A，再按 S，即可向设备端发送文件；按 Ctrl+A，再按 R，可接收文件。

