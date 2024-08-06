---
sidebar_position: 10
slug: /i2ctransfer
---

# i2ctransfer 命令



## 介绍

**i2ctransfer** 是 Linux 系统中的一个命令行工具，用于创建 I2C 消息并将它们作为一次传输合并发送到 I2C 总线。同时，`i2ctransfer` 也可以用于读取消息，将接收到的缓冲区的内容将打印到标准输出，每条读取消息打印一行。

i2ctransfer 命令由 i2c-tools 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
$ sudo apt install i2c-tools
```

**语法**：

```bash
i2ctransfer [-f] [-y] [-v] [-a] i2cbus desc [data] [desc [data]] ...
i2ctransfer -V
```

**选项**：

- `-f`：即使设备繁忙，也强制访问该设备。注意这是危险操作，只有在你知道自己在做什么的情况下才可以使用，风险自负。
- `-y`：关闭交互模式。
- `-v`：开启详细输出模式。
- `-a`：允许使用非常规地址（0x00 - 0x02 和 0x78 - 0x7f 之间的地址），一般不建议使用。
- `-V`：显示版本信息并退出。

**参数**：

- `i2cbus`：I2C 总线数字序号，对应于 `i2cdetect -l` 扫描的序号。

- `desc`：一个或多个 desc 块，用于描述读写属性、消息大小以及设备地址等信息。块的数量受到 Linux 内核的限制，并由 `I2C_RDWR_IOCTL_MAX_MSGS` 定义（从内核 v4.10 开始为 42）。

  desc 块的组成如下：

  ```bash
  {r|w}<length_of_message>[@address]
  ```

- `data`：要传输的数据。

相关命令：[i2cdetect](/linux-command/i2cdetect)、[i2cdump](/linux-command/i2cdump)、[i2cget](/linux-command/i2cget)、[i2cset](/linux-command/i2cset)、sensors-detect、i2c-stub-from-dump



## 示例

在总线 0 上，访问地址 0x50 的 EEPROM 设备，从偏移量 0x64 读取 8 个字节（第一个消息写入一个字节以将内存指针设置为 0x64，第二个消息从同一芯片读取数据）：

```bash
i2ctransfer 0 w1@0x50 0x64 r8
```

对于同一个 EEPROM，在偏移量 0x42 处写入 0xff 0xfe ... 0xf0（一条写入消息；第一个字节将内存指针设置为 0x42，0xff 是第一个数据字节，所有后续数据字节减一）：

```bash
i2ctransfer 0 w17@0x50 0x42 0xff-
```

