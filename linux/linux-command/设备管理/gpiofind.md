---
sidebar_position: 17
slug: /gpiofind
---

# gpiofind 命令



## 介绍

**gpiofind** 命令用于通过名称找到对应的 gpiochip 及行内偏移量。

gpiofind 命令由 [libgpiod](https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/) 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install gpiod
```

实际上，从 Linux 4.8 开始，不再推荐使用 sysfs 接口（/sys/class/gpio）操作 GPIO，而是建议在用户空间使用字符设备进行操作，libgpiod 就是一个用于操作 GPIO 字符设备的库，同时提供了一些工具，方便开发者进行调试。

libgpiod 包含一系列命令，除了 gpiofind，还有 [gpiodetect](/linux-command/gpiodetect)、[gpioinfo](/linux-command/gpioinfo)、[gpioget](/linux-command/gpioget)、[gpioset](/linux-command/gpioset) 和 [gpiomon](/linux-command/gpiomon) 命令。

**语法**：

```bash
gpiofind [OPTIONS] <name>
```

**选项**：

- `-h`, `--help` ：查看帮助并退出
- `-v`, `--version` ：查看版本信息并退出

**参数**：GPIO line 的名称 name



## 示例

查找树莓派 4B 系统上名为 "BT_ON" 的 GPIO line（非 root 用户需添加 sudo）

```bash
pi@raspberry:~$ sudo gpiofind "BT_ON"
gpiochip1 0
```

输出的 gpiochip 及行内偏移量可作为 gpioget 和 gpioset 的输入，例如：

```bash
gpiofind "BT_ON" | xargs gpioget
```

或

```bash
gpioget `gpiofind "BT_ON"`
```

