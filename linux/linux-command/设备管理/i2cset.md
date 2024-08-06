---
sidebar_position: 9
slug: /i2cset
---

# i2cset 命令



## 介绍

**i2cset** 是 Linux 系统中的一个命令行工具，用于向 I2C 设备写入数据。

I2C（Inter-Integrated Circuit）是一种串行通信协议，常用于连接各种外设和传感器。`i2cset` 允许用户以不同的格式向指定的 I2C 设备和寄存器地址中写入数据，支持多种输入格式，包括字节、字和其他格式。

i2cset 命令由 i2c-tools 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
$ sudo apt install i2c-tools
```

**语法**：

```bash
i2cset [-f] [-y] [-m mask] [-r] [-a] i2cbus chip-address data-address [value] ...  [mode]
i2cset -V
```

**选项**：

- `-f`：即使设备繁忙，也强制访问该设备。注意这是危险操作，只有在你知道自己在做什么的情况下才可以使用，风险自负。
- `-y`：关闭交互模式。
- `-m mask`：掩码参数 mask（如果指定）描述了哪些位值将实际写入数据地址。掩码中设置为 1 的位是从值中获取的，而设置为 0 的位将从数据地址中读取，从而由操作保留。
- `-r`：写入后立即读回，并将结果与写入的值进行比较。这曾经是默认行为。
- `-a`：允许使用非常规地址（0x00 - 0x02 和 0x78 - 0x7f 之间的地址），一般不建议使用。
- `-V`：显示版本信息并退出。

**参数**：

- `i2cbus`：I2C 总线数字序号，对应于 `i2cdetect -l` 扫描的序号。
- `chip-address`：指定 I2C 设备的地址，默认是 0x08 到 0x77 之间的整数。
- `data-address`：指定要读取的设备上的寄存器地址，是 0x00 到 0xFF 之间的整数。如果省略，则将读取当前活动的寄存器（如果所用芯片支持）。
- `value`： 要写入芯片上该位置的值。如果省略此参数，则发出短写入（short write）。
- `mode`：模式支持以下任意一种：
  - `b`（byte，默认）
  - `w`（word）
  - `c`（consecutive byte）

相关命令：[i2cdetect](/linux-command/i2cdetect)、[i2cdump](/linux-command/i2cdump)、[i2cget](/linux-command/i2cget)、[i2ctransfer](/linux-command/i2ctransfer)、sensors-detect、i2c-stub-from-dump



## 示例

将值 0x42 写入总线 1（i2c-1）上地址为 0x2d 的 I2C 设备的 8 位寄存器 0x11 中（需要用户确认）：

```bash
i2cset 1 0x2d 0x11 0x42
```

立即清除总线 1（i2c-1）上地址为 0x2d 的 I2C 设备的 8 位寄存器 0x11 的 3 个最低有效位（无需用户确认）：

```bash
i2cset -y -m 0x07 1 0x2d 0x11 0x00
```

将值 0x5000 写入总线 1（i2c-1）上地址为 0x48 的 I2C 设备的 16 位寄存器 0x02 中（需要用户确认）：

```bash
i2cset 1 0x48 0x02 0x5000 w
```

