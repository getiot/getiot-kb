---
sidebar_position: 41
authors: [luhuadong]
---

# Linux GPIO 控制

在嵌入式 Linux 系统中，你常常需要和硬件打交道，比如点亮一个 LED、读取按键输入，这些操作通常都离不开 GPIO（通用输入输出）接口的控制。本教程将带你了解 Linux 下如何使用 GPIO 接口，掌握基本的操作方式，包括导出 GPIO、设置方向、读写值等。

你将学到以下内容：

- GPIO 的基本概念
- Linux 下控制 GPIO 的两种常见方法（sysfs 接口 和 GPIO character device）
- 如何使用 sysfs 接口控制 GPIO（含代码示例）
- 简要介绍新方式：`/dev/gpiochipX` 的使用



## 什么是 GPIO？

GPIO 是 General Purpose Input/Output 的缩写，意思是“通用输入输出”。这是一种最简单的硬件接口，你可以把它配置为：

- 输入模式（读取某个开关状态）
- 输出模式（控制一个 LED 灯的亮灭）

GPIO 没有固定的功能，你可以根据软件需要控制它们的电平状态，从而实现各种硬件交互。



## Linux 下的 GPIO 接口方式

Linux 提供了两种主流方式让你控制 GPIO：

1. **sysfs 接口**（老方式）
   - 位于 `/sys/class/gpio/` 下；
   - 简单、易用；
   - 在 Linux 5.10 后逐步废弃，但仍在许多旧系统中使用。
2. **Character Device 接口**（新方式）
   - 基于 `/dev/gpiochipX`；
   - 更强大、支持事件和并发；
   - 推荐在新系统中使用；
   - 需要使用 `libgpiod` 库。



## 使用 sysfs 接口控制 GPIO

### 命令操作方法

**1. 导出 GPIO**

你需要先告诉 Linux：“我要使用某个 GPIO 引脚”。

```bash
echo 17 > /sys/class/gpio/export
```

这表示你将使用 GPIO17（通常是 BCM 编号），系统会在 `/sys/class/gpio/gpio17/` 创建目录。

**2. 设置 GPIO 方向**

你可以设置为输入（`in`）或输出（`out`）模式。

```bash
# 设置为输出
echo out > /sys/class/gpio/gpio17/direction

# 设置为输入
echo in > /sys/class/gpio/gpio17/direction
```

**3. 写入输出电平**

输出模式下，你可以设置电平：

```bash
# 设置为高电平
echo 1 > /sys/class/gpio/gpio17/value

# 设置为低电平
echo 0 > /sys/class/gpio/gpio17/value
```

**4. 读取输入值**

输入模式下，可以读取当前引脚电平：

```bash
cat /sys/class/gpio/gpio17/value
```

返回 0 表示低电平，1 表示高电平。

**5. 释放 GPIO**

用完后最好释放该引脚，避免占用：

```bash
echo 17 > /sys/class/gpio/unexport
```



### 示例 1：使用 sysfs 接口点亮 LED

下面是一个简单的 C 程序，使用 sysfs 接口点亮 LED：

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#define GPIO_PIN "17"

void write_file(const char* path, const char* value) {
    int fd = open(path, O_WRONLY);
    if (fd < 0) {
        perror("open");
        exit(1);
    }
    write(fd, value, strlen(value));
    close(fd);
}

int main() {
    write_file("/sys/class/gpio/export", GPIO_PIN);
    usleep(100000);

    write_file("/sys/class/gpio/gpio17/direction", "out");
    write_file("/sys/class/gpio/gpio17/value", "1"); // 点亮 LED
    sleep(1);
    write_file("/sys/class/gpio/gpio17/value", "0"); // 熄灭 LED

    write_file("/sys/class/gpio/unexport", GPIO_PIN);
    return 0;
}
```



## 使用 libgpiod 接口控制 GPIO

### 命令操作方法

Linux 5.x 之后推荐使用更现代的 GPIO character device 方式，即通过 `/dev/gpiochipX` 接口控制 GPIO。这种方式具有如下特点：

- 设备文件：`/dev/gpiochip0`、`/dev/gpiochip1` 等；
- 配合用户空间库 `libgpiod` 使用；
- 更强的功能（如监听 GPIO 电平变化）。

示例命令：

```bash
# 安装 libgpiod 工具
sudo apt install gpiod

# 设置 GPIO 为高电平
gpioset gpiochip0 17=1

# 读取 GPIO 电平
gpioget gpiochip0 17
```

libgpiod 库提供的命令有 [gpiodetect](/linux-command/gpiodetect/)、[gpioinfo](/linux-command/gpioinfo/)、[gpioget](/linux-command/gpioget/)、[gpioset](/linux-command/gpioset/)、[gpiofind](/linux-command/gpiofind/) 和 [gpiomon](/linux-command/gpiomon/) 等，具体可参考 Man 手册说明。



### 示例 1：使用 libgpiod 点亮 LED

使用 `libgpiod` 控制 GPIO 输出，需要调用 `gpiod_chip_open_by_name`、`gpiod_line_request_output` 等函数。在使用前，请确保你已安装 `libgpiod` 库和头文件：

```bash
sudo apt install libgpiod-dev
```

完整示例代码：

```c showLineNumbers title="led_output.c"
#include <gpiod.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define CHIP_NAME "gpiochip0"
#define LINE_OFFSET 17 // 对应 GPIO17（根据硬件修改）

int main() {
    struct gpiod_chip *chip;
    struct gpiod_line *line;
    int ret;

    // 打开 GPIO 芯片
    chip = gpiod_chip_open_by_name(CHIP_NAME);
    if (!chip) {
        perror("gpiod_chip_open_by_name");
        return 1;
    }

    // 获取 GPIO 引脚（第17号）
    line = gpiod_chip_get_line(chip, LINE_OFFSET);
    if (!line) {
        perror("gpiod_chip_get_line");
        gpiod_chip_close(chip);
        return 1;
    }

    // 请求将该引脚设置为输出，并初始为低电平
    ret = gpiod_line_request_output(line, "led_output", 0);
    if (ret < 0) {
        perror("gpiod_line_request_output");
        gpiod_chip_close(chip);
        return 1;
    }

    printf("点亮 LED\n");
    gpiod_line_set_value(line, 1);
    sleep(1);

    printf("熄灭 LED\n");
    gpiod_line_set_value(line, 0);

    // 清理资源
    gpiod_line_release(line);
    gpiod_chip_close(chip);
    return 0;
}
```

编译运行：

```bash
gcc led_output.c -o led_output -lgpiod
./led_output
```



### 示例 2：使用 libgpiod 读取按键

下面示例演示如何使用 `libgpiod` 读取 GPIO 输入，实现按键输入检测：

```c showLineNumbers title="button_input.c"
#include <gpiod.h>
#include <stdio.h>
#include <stdlib.h>

#define CHIP_NAME "gpiochip0"
#define LINE_OFFSET 18 // 改为你的按键 GPIO 编号

int main() {
    struct gpiod_chip *chip;
    struct gpiod_line *line;
    int value;

    chip = gpiod_chip_open_by_name(CHIP_NAME);
    if (!chip) {
        perror("gpiod_chip_open_by_name");
        return 1;
    }

    line = gpiod_chip_get_line(chip, LINE_OFFSET);
    if (!line) {
        perror("gpiod_chip_get_line");
        gpiod_chip_close(chip);
        return 1;
    }

    if (gpiod_line_request_input(line, "button_input") < 0) {
        perror("gpiod_line_request_input");
        gpiod_chip_close(chip);
        return 1;
    }

    value = gpiod_line_get_value(line);
    if (value < 0) {
        perror("gpiod_line_get_value");
    } else {
        printf("按键状态：%d\n", value); // 0=未按下，1=按下（取决于电路）
    }

    gpiod_line_release(line);
    gpiod_chip_close(chip);
    return 0;
}
```

编译运行：

```bash
gcc button_input.c -o button_input -lgpiod
./button_input
```



## 小结

通过本教程，你掌握了 Linux 下 GPIO 控制的基础知识，学会了如何使用 sysfs 接口导出 GPIO、设置方向、读写电平。你还了解了更现代的 character device 接口，学会了如何使用 `gpiod` 命令行工具进行 GPIO 控制，以及如何使用 `libgpiod` 控制 GPIO 的输入输出。相比传统的 sysfs 方式，`libgpiod` 更加现代化，功能也更强大，特别适合在新内核版本和复杂项目中使用。

如果你在开发树莓派、嵌入式开发板或者物联网设备，GPIO 是非常常用的控制接口。下一步你可以尝试结合中断（监听输入）、PWM 控制亮度，或用 C 写一个交互式控制工具。
