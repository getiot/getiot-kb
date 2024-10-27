---
sidebar_label: modpoll 命令
sidebar_position: 23
slug: /modpoll
---

# modpoll 命令



## 介绍

**modpoll** 是一个基于 libmodbus 库的 Modbus 主站仿真工具，支持基于串行链路的 Modbus RTU、Modbus ASCII 和基于以太网的 Modbus TCP 协议。

如果您的系统没有 modpoll 命令，可以通过如下命令下载获得。

```bash
wget https://www.modbusdriver.com/downloads/modpoll.tgz
```

**语法**：

```bash
modpoll [OPTIONS] SERIALPORT|HOST [WRITEVALUES...]
```

**选项**：

- `-m ascii` ：Modbus ASCII 协议。
- `-m rtu` ：Modbus RTU 协议（如果 SERIALPORT 参数包含 / 则默认为该模式）。
- `-m tcp` ：MODBUS TCP 协议（如果 SERIALPORT 参数不包含 / 则默认为该模式）。
- `-m udp` ：MODBUS UDP 协议。
- `-m enc` ：基于 TCP 的封装 Modbus RTU（Encapsulated Modbus RTU over TCP）。
- `-a #` ：从站地址（串行链路取值范围 1-247，TCP 取值范围 0-255，默认值为 1）。
- `-r #` ：起始地址（取值范围 1-65536，默认为 100）。
- `-c #` ：要读取的值的数量（1-125，默认值为 1），写入可选（使用 -c 1 强制 FC5 或 FC6）。
- `-t 0` ：离散输出（线圈）数据类型。
- `-t 1` ：离散输入数据类型。
- `-t 3` ：16 位输入寄存器数据类型。
- `-t 3:hex` ：16 位输入寄存器数据类型（以十六进制显示）。
- `-t 3:int` ：输入寄存器表中的 32 位整数数据类型。
- `-t 3:mod` ：输入寄存器表中的 32 位模块 10000 数据类型。
- `-t 3:float` ：输入寄存器表中的 32 位浮点数据类型。
- `-t 4` ：16 位输出（保持）寄存器数据类型（默认）。
- `-t 4:hex` ：16 位输出（保持）寄存器数据类型（以十六进制显示）。
- `-t 4:int` ：输出（保持）寄存器表中的 32 位整数数据类型。
- `-t 4:mod` ：输出（保持）寄存器表中的 32 位模块 10000 类型。
- `-t 4:float` ：输出（保持）寄存器表中的 32 位浮点数据类型。
- `-i` ：从站设备以大端字节序操作 32 位整数。
- `-f` ：从站设备以大端字节序操作 32 位浮点数。
- `-e` ：使用 Daniel/Enron 单寄存器 32 位模式（暗示 -i 和 -f）。
- `-0` ：第一个引用（起始地址）是 0（PDU 寻址）而不是 1。
- `-1` ：只轮询一次，否则以设定的轮询间隔循环执行。
- `-l #` ：以毫秒为单位的轮询时间（默认为 1000）。
- `-o #` ：以秒为单位的超时（0.01 - 10.0，默认为 1.0 秒）。
- `-h` ：显示帮助信息。

以下选项仅适用 MODBUS/TCP, UDP 和 RTU over TCP：

- `-p #` ：IP 协议端口号（默认为 502）

以下选项仅适用 Modbus ASCII 和 Modbus RTU：

- `-b #` ：波特率（例如 9600, 19200, ...），默认为 19200。
- `-d #` ：数据位（ASCII 协议为 7 或 8，RTU 协议为 8)。
- `-s #` ：停止位（1 或 2，默认为 1）。
- `-p none` ：无校验。
- `-p even` ：偶校验（默认）。
- `-p odd` ：奇校验。
- `-4 #` ：RS-485 模式，传输时开启 RTS，之后还有 # 毫秒。

**参数**：

- `SERIALPORT` ：串口设备，在 Windows 下如 COM1、COM2 等，在 Linux 下如 /dev/ttyS0、/dev/ttyS1 等。
- `HOST` ：主机名或 IP 地址。
- `WRITEVALUES` ：对于 Modbus 写入命令，需要在此依次填入数据域的数据，以空格分隔。



## 示例

通过 Modbus RTU 从 ID 为 3 的从站设备中读取 500 地址开始的连续 10 个保持寄存器的值。（串口 COM1，波特率 9600，无奇偶校验）

```bash
modpoll -b 9600 -p none -m rtu -a 3 -r 500 -c 10 COM1
```

通过 Modbus TCP 从 10.0.0.100 设备读取 100 地址开始的连续 5 个浮点数值。

```bash
modpoll -t4:float -r 100 -c 5 -1 10.0.0.100
```

通过 Modbus TCP 往 10.0.0.100 设备 1201 地址写保持寄存器，值为 1234。（使用 FC 16 功能码）

```bash
modpoll -r 1201 10.0.0.100 1234
```

通过 Modbus TCP 往 10.0.0.100 设备 1201 地址写保持寄存器，值为 1234。（使用 FC 6 功能码）

```bash
modpoll -r 1201 -c 1 10.0.0.100 1234
```

通过 Modbus RTU 执行一次「写单个线圈」命令，开启 1 号继电器。

```bash
modpoll -m rtu -1 -a 1 -r 1 -c 1 -b 9600 -p none -t 0 /dev/ttyUSB1 1
```

通过 Modbus RTU 执行一次「写单个线圈」命令，关闭 1 号继电器。

```bash
modpoll -m rtu -1 -a 1 -r 1 -c 1 -b 9600 -p none -t 0 /dev/ttyUSB1 0
```

通过 Modbus RTU 循环执行「读线圈状态」命令，读取 1 号继电器状态。

```bash
modpoll -m rtu -a 1 -r 1 -c 1 -b 9600 -p none -t 0 /dev/ttyUSB1
```





