---
sidebar_label: i2cdetect 命令
sidebar_position: 6
slug: /i2cdetect
---

# i2cdetect 命令



## 介绍

**i2cdetect** 命令用于在 Linux 系统用户空间扫描 I2C 总线上的设备。

i2cdetect 命令由 i2c-tools 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
$ sudo apt install i2c-tools
```

**语法**：

```bash
i2cdetect [-y] [-a] [-q|-r] I2CBUS [first last]
i2cdetect -F I2CBUS
i2cdetect -V
i2cdetect -l
```

**选项**：

- `-y`：关闭交互模式
- `-a`：强制扫描非常规地址（不推荐）
- `-q`：使用 SMBus 的 "quick write" 命令进行探测（不推荐）
- `-r`：使用 SMBus 的 "receive byte" 命令进行探测（不推荐）
- `-F`：显示适配器实现的功能列表并退出
- `-V`：显示版本信息并退出
- `-l`：输出已安装 I2C 总线的列表

**参数**：

- `I2CBUS`：I2C 总线数字序号，对应于 `i2cdetect -l` 扫描的序号。

相关命令：[i2cdump](/linux-command/i2cdump)、[i2cget](/linux-command/i2cget)、[i2cset](/linux-command/i2cset)、[i2ctransfer](/linux-command/i2ctransfer)、sensors-detect、i2c-stub-from-dump



## 示例

查看系统已安装的 I2C 总线列表：

```bash
root@npi:~# i2cdetect -l
i2c-1   i2c         STM32F7 I2C(0x5c002000)         I2C adapter
i2c-2   i2c         STM32F7 I2C(0x40012000)         I2C adapter
i2c-0   i2c         STM32F7 I2C(0x40013000)         I2C adapter
```

查看 i2c-0 实现的功能列表：

```bash
root@npi:~# i2cdetect -F 0
Functionalities implemented by /dev/i2c-0:
I2C                              yes
SMBus Quick Command              yes
SMBus Send Byte                  yes
SMBus Receive Byte               yes
SMBus Write Byte                 yes
SMBus Read Byte                  yes
SMBus Write Word                 yes
SMBus Read Word                  yes
SMBus Process Call               yes
SMBus Block Write                yes
SMBus Block Read                 yes
SMBus Block Process Call         yes
SMBus PEC                        yes
I2C Block Write                  yes
I2C Block Read                   yes
```

