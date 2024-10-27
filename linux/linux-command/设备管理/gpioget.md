---
sidebar_label: gpioget 命令
sidebar_position: 18
slug: /gpioget
---

# gpioget 命令



## 介绍

**gpioget** 命令用于读取指定 GPIO line 的值。

gpioget 命令由 [libgpiod](https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/) 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install gpiod
```

实际上，从 Linux 4.8 开始，不再推荐使用 sysfs 接口（/sys/class/gpio）操作 GPIO，而是建议在用户空间使用字符设备进行操作，libgpiod 就是一个用于操作 GPIO 字符设备的库，同时提供了一些工具，方便开发者进行调试。

libgpiod 包含一系列命令，除了 gpioget，还有 [gpioset](/linux-command/gpioset)、[gpiodetect](/linux-command/gpiodetect)、[gpioinfo](/linux-command/gpioinfo)、[gpiofind](/linux-command/gpiofind) 和 [gpiomon](/linux-command/gpiomon) 命令。

**语法**：

```bash
gpioget [OPTIONS] <chip name/number> <offset 1> <offset 2> ...
```

**选项**：

- `-l`, `--active-low` ：设置低电平为有效电平
- `-B`, `--bias=[as-is|disable|pull-down|pull-up]` ：设置 bias（默认使用 `as-is`）
- `-h`, `--help` ：查看帮助并退出
- `-v`, `--version` ：查看版本信息并退出

**参数**：指定 gpiochip 和 offset（行内偏移量），可同时指定多个 line。



## 示例

查看树莓派 4B 系统上 gpiochip1 的 line 信息（非 root 用户需添加 sudo）

```bash
pi@raspberry:~$ sudo gpioinfo gpiochip1
gpiochip1 - 8 lines:
        line   0:      "BT_ON"       unused   input  active-high
        line   1:      "WL_ON"       unused   input  active-high
        line   2: "PWR_LED_OFF" "led1" output active-low [used]
        line   3: "GLOBAL_RESET" unused output active-high
        line   4: "VDD_SD_IO_SEL" "vdd-sd-io" output active-high [used]
        line   5:   "CAM_GPIO"       unused  output  active-high
        line   6:  "SD_PWR_ON" "sd_vcc_reg"  output  active-high [used]
        line   7:    "SD_OC_N"       unused   input  active-high
```

读取 gpiochip1 的 line 0（也就是 BT_ON）的值

```bash
pi@raspberry:~$ sudo gpioget gpiochip1 0
1
```

注意：只能读取 unused 状态的 line 值。

