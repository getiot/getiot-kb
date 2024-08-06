---
sidebar_position: 13
slug: /microcom
---

# microcom 命令



## 介绍

**microcom** 是一个用于与串行调制解调器通信的命令。

我们可以把 microcom 理解为是一个在终端命令行运行的串口调试助手，在调试串口时非常有用，例如调试 AT 指令。

如果您的设备使用 Busybox，可以在 busybox/miscutils/microcom.c 中找到源代码，编译添加到文件系统中，就可以使用 microcom 命令了。如果您使用 Linux 发行版，比如 Debian/Ubuntu 可以使用如下命令进行安装：

```bash
sudo apt install microcom
```

**语法**：

```bash
microcom [-d DELAY] [-t TIMEOUT] [-s SPEED] [-X] TTY
```

**选项**：

- `-d <DELAY>` ：表示延时时间。
- `-t <TIMEOUT>` ：表示超时时间，超多少时间就自动退出（单位为 ms）。
- `-s <SPEED>` ：表示传输速度，波特率的意思，这个根据自己的情况而定。
- `-X` ：从 stdin 禁用 `NUL` 和 `Ctrl-X` 的特殊含义。

**参数**：指定串口设备 TTY（如 /dev/ttyS0）。



## 示例

将要测试串口与 PC 端连接，在 PC 端开启串口调试工具，波特率设置为 115200。

接着在设备端运行如下命令，打开 /dev/ttymxc1 串口设备：

```bash
microcom -s 115200 /dev/ttymxc1
```

此时，在设备终端中输入的字符，将在 PC 端的窗口中显示；反过来，在 PC 端输入的字符，也会在设备端的 microcom 中显示。通过该方法，可以验证串口设备是否正常工作。

如果您通过串口连接了支持 AT 指令的模块，就可以用 microcom 工具向模块发送 AT 指令。不过，直接在键盘输入 AT 指令有些麻烦，我们可以将 AT 指令写在文件中，再重定向到 microcom，比如：

```bash
microcom -s 115200 /dev/ttymxc1 < at.txt
```

```bash
cat at.txt | microcom -s 115200 /dev/ttymxc1
```

```bash
tail -f at.txt | microcom -s 115200 /dev/ttymxc1
```

按 Ctrl + X 退出。



