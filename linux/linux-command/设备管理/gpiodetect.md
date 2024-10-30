---
sidebar_label: gpiodetect 命令
sidebar_position: 16
slug: /gpiodetect
---

# gpiodetect 命令 - 检测 GPIO 控制器



## 介绍

**gpiodetect** 命令用于列出系统上存在的所有 gpiochip，以及它们的名称、标签和 GPIO lines。

gpiodetect 命令由 [libgpiod](https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/) 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install gpiod
```

实际上，从 Linux 4.8 开始，不再推荐使用 sysfs 接口（/sys/class/gpio）操作 GPIO，而是建议在用户空间使用字符设备进行操作，libgpiod 就是一个用于操作 GPIO 字符设备的库，同时提供了一些工具，方便开发者进行调试。

libgpiod 包含一系列命令，除了 gpiodetect，还有 [gpioinfo](/linux-command/gpioinfo)、[gpioget](/linux-command/gpioget)、[gpioset](/linux-command/gpioset)、[gpiofind](/linux-command/gpiofind) 和 [gpiomon](/linux-command/gpiomon) 命令。

**语法**：

```bash
gpiodetect [OPTIONS]
```

**选项**：

- `-h`, `--help` ：查看帮助并退出
- `-v`, `--version` ：查看版本信息并退出



## 示例

查看树莓派 4B 系统上的 gpiochip 信息（非 root 用户需添加 sudo）

```bash
pi@raspberry:~$ sudo gpiodetect
gpiochip0 [pinctrl-bcm2711] (58 lines)
gpiochip1 [raspberrypi-exp-gpio] (8 lines)
```

三列数据分别是 gpiochip 的名称（name）、标签（label）和行数（lines）。

