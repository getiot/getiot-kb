---
sidebar_label: gpioinfo 命令
sidebar_position: 19
slug: /gpioinfo
---

# gpioinfo 命令



## 介绍

**gpioinfo** 命令用于列出指定 gpiochip 的所有 line，以及它们的名称、使用者、方向、活动状态和其他标志。

gpioinfo 命令由 [libgpiod](https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/) 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install gpiod
```

实际上，从 Linux 4.8 开始，不再推荐使用 sysfs 接口（/sys/class/gpio）操作 GPIO，而是建议在用户空间使用字符设备进行操作，libgpiod 就是一个用于操作 GPIO 字符设备的库，同时提供了一些工具，方便开发者进行调试。

libgpiod 包含一系列命令，除了 gpioinfo，还有 [gpiodetect](/linux-command/gpiodetect)、[gpioget](/linux-command/gpioget)、[gpioset](/linux-command/gpioset)、[gpiofind](/linux-command/gpiofind) 和 [gpiomon](/linux-command/gpiomon) 命令。

**语法**：

```bash
gpioinfo [OPTIONS] <gpiochip> ...
```

**选项**：

- `-h`, `--help` ：查看帮助并退出
- `-v`, `--version` ：查看版本信息并退出

**参数**：指定 gpiochip，如 gpiochip0、gpiochip1，可同时输入多个参数。如果没有参数，则查询所有 gpiochip 的所有 line 的信息。



## 示例

查看树莓派 4B 系统上所有 gpiochip 的所有 line 的信息（非 root 用户需添加 sudo）

```bash
pi@raspberry:~$ sudo gpioinfo
gpiochip0 - 58 lines:
        line   0:     "ID_SDA"       unused   input  active-high
        line   1:     "ID_SCL"       unused   input  active-high
        line   2:       "SDA1"       unused   input  active-high
        line   3:       "SCL1"       unused   input  active-high
        ......
gpiochip1 - 8 lines:
        line   0:      "BT_ON"       unused  output  active-high
        line   1:      "WL_ON"       unused  output  active-high
        ......
```

只查看树莓派 4B 系统上 gpiochip1 的 line 信息

```bash
pi@raspberry:~$ sudo gpioinfo gpiochip1
gpiochip1 - 8 lines:
        line   0:      "BT_ON"       unused  output  active-high
        line   1:      "WL_ON"       unused  output  active-high
        line   2: "PWR_LED_OFF" "led1" output active-low [used]
        line   3: "GLOBAL_RESET" unused output active-high
        line   4: "VDD_SD_IO_SEL" "vdd-sd-io" output active-high [used]
        line   5:   "CAM_GPIO"       unused  output  active-high
        line   6:  "SD_PWR_ON" "sd_vcc_reg"  output  active-high [used]
        line   7:    "SD_OC_N"       unused   input  active-high
```

每个 line 所列出的四列数据分别表示 line 的名称（如果没有设定则显示 unnamed）、使用情况（如果未被使用则显示 unused）、方向（input 或者 output）和有效电平（active-low 或者 active-high）。

