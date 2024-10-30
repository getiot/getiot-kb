---
sidebar_label: i2cdump 命令
sidebar_position: 7
slug: /i2cdump
---

# Linux i2cdump 命令 - 显示 I2C 设备的寄存器内容



## 介绍

**i2cdump** 命令用于在 Linux 系统用户空间读取连接到系统的 I2C 设备的数据，并以可读的格式显示 I2C 设备的寄存器内容。I2C（Inter-Integrated Circuit）是一种串行通信协议，常用于连接各种外设和传感器。`i2cdump` 命令支持对不同类型的 I2C 设备进行读取。

i2cdump 命令由 i2c-tools 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
$ sudo apt install i2c-tools
```

**语法**：

```bash
i2cdump [-f] [-r first-last] [-y] [-a] I2CBUS ADDRESS [MODE [BANK [BANKREG]]]
i2cdump -V
```

**选项**：

- `-f`：即使设备繁忙，也强制访问该设备。默认情况下，i2cdump 将拒绝访问已在内核驱动程序控制下的设备。注意，使用此标志是危险的，因为它可能会严重混淆相关的内核驱动程序，还可能导致 i2cdump 返回无效结果。因此，只有在你知道自己在做什么的情况下才可以使用，风险自负。
- `-r first-last`：限制正在访问的寄存器的范围。此选项仅适用于模式 b、w、c 和 W。对于模式 W，第一个必须是偶数，最后一个必须是奇数。
- `-y`：禁用交互模式。默认情况下，i2cdump 将等待用户的确认，然后再访问 I2C 总线。当使用该标志时，将直接执行操作，这主要是为了在脚本中使用。
- `-a`：允许使用 0x00 - 0x02 和 0x78 - 0x7f 之间的地址。一般不建议使用。
- `-V`：显示版本信息并退出。

**参数**：

- `I2CBUS`：I2C 总线数字序号，对应于 `i2cdetect -l` 扫描的序号。
- `ADDRESS`：是一个整数，范围 0x03 - 0x77，或 0x00 - 0x7f（如果使用 `-a` 选项）。
- `MODE`：模式支持以下任意一种：
  - `b`（byte，默认）
  - `w`（word）
  - `W`（word on even register addresses）
  - `s`（SMBus block）
  - `i`（I2C block）
  - `c`（consecutive byte）

另外，还可以将 `p` 附加到模式参数（`i` 和 `W` 除外）以启用 PEC。如果省略 `MODE` 参数，i2cdump 默认使用不带 PEC 的字节访问。

相关命令：[i2cdetect](/linux-command/i2cdetect)、[i2cget](/linux-command/i2cget)、[i2cset](/linux-command/i2cset)、[i2ctransfer](/linux-command/i2ctransfer)、sensors-detect、i2c-stub-from-dump



## 示例

1、使用默认读取方法（字节模式），将 I2C 总线 9（i2c-9）上地址 0x50 设备的全部内容倾倒出来（需要用户确认）：

```bash
i2cdump 9 0x50
```

2、使用 I2C 块读取模式，将 I2C 总线 9（i2c-9）上地址 0x50 设备的全部内容倾倒出来（无需用户确认）：

```bash
i2cdump -y 9 0x50 i
```

如果设备是 EEPROM，那么输出通常与前面示例的输出相同。

3、使用默认读取方法（字节模式），将 I2C 总线 1（i2c-1）上地址 0x2d 设备的寄存器 0x00 至 0x3f 的内容倾倒出来（需要用户确认）：

```bash
i2cdump -r 0x00-0x3f 1 0x2d
```

4、使用启用了错误检查的 SMBus 块读取模式，将 I2C 总线 0（i2c-0）上地址 0x69 的 SMBus 设备的寄存器的内容倾倒出来（需要用户确认）：

```bash
i2cdump 0 0x69 sp
```

