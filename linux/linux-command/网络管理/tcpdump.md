---
sidebar_label: tcpdump 命令
sidebar_position: 32
slug: /tcpdump
---

# Linux tcpdump 命令 - 数据包捕获分析工具



## 介绍

**tcpdump** 命令是 Linux 系统中的一个网络数据包截获分析工具，支持针对网络层、协议、主机、网络或端口的过滤，并提供 and、or、not 等逻辑语句帮助过滤无用的信息。

tcpdump 命令通常默认不安装，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install tcpdump
```

**语法**：

```bash
tcpdump [-adeflnNOpqStvx]
        [-c <count>] [-dd] [-ddd] [-F <file>]
        [-i <interface>] [-r <file>]
        [-s <snaplen>] [-tt] [-T <type>]
        [-vv] [-w <file>]
```

**选项**：

- `-a` ：尝试将网络和广播地址转换成名称。
- `-c <数据包数目>` ：收到指定的数据包数目后，就停止进行倾倒操作。
- `-d` ：把编译过的数据包编码转换成可阅读的格式，并倾倒到标准输出。
- `-dd` ：把编译过的数据包编码转换成 C 语言的格式，并倾倒到标准输出。
- `-ddd` ：把编译过的数据包编码转换成十进制数字的格式，并倾倒到标准输出。
- `-e` ：在每列倾倒资料上显示连接层级的文件头。
- `-f` ：用数字显示网际网络地址。
- `-F <表达文件>` ：指定内含表达方式的文件。
- `-i <网络界面>` ：使用指定的网络截面送出数据包。
- `-l` ：使用标准输出列的缓冲区。
- `-n` ：不把主机的网络地址转换成名字。
- `-N` ：不列出域名。
- `-O` ：不将数据包编码最佳化。
- `-p` ：不让网络界面进入混杂模式。
- `-q` ：快速输出，仅列出少数的传输协议信息。
- `-r <数据包文件>` ：从指定的文件读取数据包数据。
- `-s <数据包大小>` ：设置每个数据包的大小。
- `-S` ：用绝对而非相对数值列出 TCP 关联数。
- `-t` ：在每列倾倒资料上不显示时间戳记。
- `-tt` ：在每列倾倒资料上显示未经格式化的时间戳记。
- `-T <数据包类型>` ：强制将表达方式所指定的数据包转译成设置的数据包类型。
- `-v` ：详细显示指令执行过程。
- `-vv` ：更详细显示指令执行过程。
- `-x` ：用十六进制字码列出数据包资料。
- `-w <数据包文件>` ：把数据包数据写入指定的文件。



## 示例

提示：运行 tcpdump 需要超级用户（root）权限，普通用户执行下列命令时需要加上 sudo 提权，否则会收到一条错误消息：“You don’t have permission to capture on that device”。

显示所有网络数据包信息

```bash
tcpdump
```

打印 tcpdump 所有可用网络接口（包括以太网口、Wi-Fi、蓝牙等）

```bash
tcpdump -D
```

捕获来自所有接口的所有数据包（`any` 表示捕获所有活动的接口）

```bash
tcpdump -i any
```

默认情况下，tcpdump 会对 IP 地址执行反向 DNS 解析，并将端口号转换为名称。使用 `-n` 选项可禁用翻译：

```bash
tcpdump -n
```

提示：跳过 DNS 查找可避免生成 DNS 流量，并使输出更具可读性。建议每次调用 tcpdump 时都使用 `-n` 选项。

捕获 10 个数据包

```bash
tcpdump -c 10
```

以精简模式显示 10 个数据包信息

```bash
tcpdump -c 10 -q
```

以详细模式显示 10 个数据包信息

```bash
tcpdump -c 10 -vv
```

仅捕获 UDP 数据包（将该协议指定为过滤器）

```bash
tcpdump -n udp
```

仅捕获指定端口（如 51180）的数据包（使用 `port` 限定符）

```bash
tcpdump -n port 51180
```

仅捕获指定主机相关的数据包（使用 `host` 限定符）

```bash
tcpdump -n host 192.168.1.100
```

提示：使用 `net` 限定符可以过滤指定的 IP 范围

仅捕获来自 192.168.1.100 的主机的传入数据包（使用 `src` 指定源地址，`dst` 指定目的地址）

```bash
tcpdump -n src host 192.168.1.100
```

捕获所有发送到 80 端口的数据包

```bash
tcpdump -n dst port 80
```

对于复杂的过滤条件，可以使用 `and`（`&&`）、`or`（`||`）和 `not`（`!`）运算符进行组合。

例如：捕获来自某个源IP地址 192.168.1.100 的所有 HTTP 通信

```bash
tcpdump -n src 192.168.1.100 and tcp port 80
```

以及 HTTPS 通信

```bash
tcpdump -n 'host 192.168.1.100 and (tcp port 80 or tcp port 443)'
```

提示：为避免使用特殊字符时解析错误，可将过滤器括在单引号内。

捕获源 IP 地址 192.168.1.100 除 SSH 以外的所有流量

```bash
tcpdump -n src 192.168.1.100 and not dst port 22
```

将捕获的网络数据包信息保存到文件中（使用重定向操作符 `>` 和 `>>` 将其重定向到文件）

```bash
tcpdump -n -i any > file.out
```

如果你想在保存到文件的同时在终端观看数据，可以借助 [tee](/linux-command/tee/) 命令

```bash
tcpdump -n -l | tee file.out
```

注意：上面命令中的 `-l` 选项告诉 tcpdump 缓冲输出。如果不使用此选项时，那么在生成新行时，输出将不会显示在屏幕上。

将捕获的网络数据包导出到文件（使用 `-w` 选项）

```bash
tcpdump -n -w data.pcap
```

提示：你可以根据需要命名文件，但是使用 `.pcap` 扩展名（数据包捕获）是一种常见的约定。

注意：使用 `-w` 选项时，tcpdump 的输出不显示在屏幕上，并将原始数据包写入到一个二进制文件，而非文本文件，这一点和重定向保存到文件不同。

如果想要查看 pcap 文件的内容，请使用 `-r` 选项，例如：

```bash
tcpdump -r data.pcap
```

如果想要捕获一段时间内的数据包，可以与 [timeout](/linux-command/timeout/) 命令配合使用。例如捕获 5 分钟的网络数据：

```bash
timeout 300 tcpdump -n -w data.pcap
```



