---
sidebar_position: 8
slug: /i2cget
---

# i2cget 命令



## 介绍

**i2cget** 是 Linux 系统中的一个命令行工具，用于从 I2C 设备中读取数据。

I2C（Inter-Integrated Circuit）是一种串行通信协议，常用于连接各种外设和传感器。`i2cget` 允许用户以不同的格式从指定的 I2C 设备和寄存器地址中读取数据，支持读取不同类型的数据，如字节、字、块等；并提供不同的输出格式，包括字节、字和其他格式。

i2cget 命令由 i2c-tools 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
$ sudo apt install i2c-tools
```

**语法**：

```bash
i2cget [-f] [-y] [-a] i2cbus chip-address [data-address [mode]]
i2cget -V
```

**选项**：

- `-f`：即使设备繁忙，也强制访问该设备。注意这是危险操作，只有在你知道自己在做什么的情况下才可以使用，风险自负。
- `-y`：关闭交互模式。
- `-a`：允许使用非常规地址（0x00 - 0x02 和 0x78 - 0x7f 之间的地址），一般不建议使用。
- `-V`：显示版本信息并退出。

**参数**：

- `i2cbus`：I2C 总线数字序号，对应于 `i2cdetect -l` 扫描的序号。
- `chip-address`：指定 I2C 设备的地址，默认是 0x08 到 0x77 之间的整数。
- `data-address`：指定要读取的设备上的寄存器地址，是 0x00 到 0xFF 之间的整数。如果省略，则将读取当前活动的寄存器（如果所用芯片支持）。
- `mode`：模式支持以下任意一种：
  - `b`（byte，默认）
  - `w`（word）
  - `c`（consecutive byte）

相关命令：[i2cdetect](/linux-command/i2cdetect)、[i2cdump](/linux-command/i2cdump)、[i2cset](/linux-command/i2cset)、[i2ctransfer](/linux-command/i2ctransfer)、sensors-detect、i2c-stub-from-dump



## 示例

获取 I2C 总线 1（i2c-1）上地址 0x2d 设备的寄存器 0x11 的值（需要用户确认）：

```bash
i2cget 1 0x2d 0x11
```

获取 I2C 总线 1（i2c-1）上地址 0x48 设备的 16 位寄存器 0x00 的值（需要用户确认）：

```bash
i2cget 1 0x48 0x00 w
```

