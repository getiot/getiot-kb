---
sidebar_label: gpiomon 命令
sidebar_position: 20
slug: /gpiomon
---

# gpiomon 命令 - 监控 GPIO 引脚的状态变化



## 介绍

**gpiomon** 命令用于等待指定 GPIO line 上的事件，或指定要监视的事件。

gpiomon 命令由 [libgpiod](https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/) 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install gpiod
```

实际上，从 Linux 4.8 开始，不再推荐使用 sysfs 接口（/sys/class/gpio）操作 GPIO，而是建议在用户空间使用字符设备进行操作，libgpiod 就是一个用于操作 GPIO 字符设备的库，同时提供了一些工具，方便开发者进行调试。

libgpiod 包含一系列命令，除了 gpiomon，还有 [gpiodetect](/linux-command/gpiodetect)、[gpioinfo](/linux-command/gpioinfo)、[gpioget](/linux-command/gpioget)、[gpioset](/linux-command/gpioset) 和 [gpiofind](/linux-command/gpiofind) 命令。

**语法**：

```bash
gpiomon [OPTIONS] <chip name/number> <offset 1> <offset 2> ...
```

**选项**：

- `-l`, `--active-low` ：设置低电平为有效电平
- `-B`, `--bias=[as-is|disable|pull-down|pull-up]` ：设置 bias（默认使用 `as-is`）
- `-n`, `--num-events=NUM` ：处理完 `NUM` 个事件后退出
- `-s`, `--silent` ：不打印事件信息
- `-r`, `--rising-edge` ：只处理上升沿事件
- `-f`, `--falling-edge` ：只处理下降沿事件
- `-b`, `--line-buffered` ：将标准输出设置为行缓冲
- `-F`, `--format=FMT` ：指定输出格式（`%o` 为 GPIO 行内偏移量，`%e` 为事件类型，`%s` 为事件时间戳秒数部分，`%n` 为事件时间戳纳秒部分）
- `-h`, `--help` ：查看帮助并退出
- `-v`, `--version` ：查看版本信息并退出



## 示例

等待三次 GPIO（gpiochip0 line1）的上升沿事件，然后退出（非 root 用户需添加 sudo）

```bash
$ sudo gpiomon --num-events=3 --rising-edge gpiochip0 1
event:  RISING EDGE offset: 3 timestamp: [    1151.814356387]
event:  RISING EDGE offset: 3 timestamp: [    1151.815449803]
event:  RISING EDGE offset: 3 timestamp: [    1152.091556803]
```

等待单次下降沿事件，并按指定格式输出

```bash
$ sudo gpiomon --format="%e %o %s %n" --falling-edge gpiochip0 1
0 1 1156 615459801
```

同时等待多个 line 上的事件，并在处理完第一个事件后退出

```bash
$ sudo gpiomon --silent --num-events=1 gpiochip0 2 3 5
```

