---
sidebar_label: ntopng 命令
sidebar_position: 26
slug: /ntopng
---

# Linux ntopng 命令 - 网络流量监控分析



## 介绍

**ntopng** 是 [ntop](/linux-command/ntop/) 的下一代版本，它是一个用于监控网络流量的工具。相较于 ntop，ntopng 提供了一个更现代化和交互式的 Web 界面，以及支持更多的功能和详细的统计信息，包括网络流量、协议使用情况、主机信息等。

使用前请确保你的系统上已经安装 ntopng 工具，在 Debian/Ubuntu 系统上可通过 apt 进行安装：

```bash
$ sudo apt install ntopng
```

ntopng 是一个开源软件，你可以在 [GitHub](https://github.com/ntop/ntopng) 找到它。

**语法**：

```bash
ntopng [filename]
ntopng [options]
```

**选项**：

- `-n, --dns-mode <mode>`：设置 DNS 地址解析模式。

- `-i, --interface <interface|pcap>`：设置输入接口名称（通过数字或符号）、视图或 pcap 文件路径。

- `-d, --data-dir <path>`：指定数据目录（该目录必须是可写的），默认为 /var/lib/ntopng。

- `-t, --install-dir <path>`：指定安装目录，应在自定义目录下安装 ntopng 时需要设置。

- `-e, --daemon`：以守护进程方式运行。

- `-1, --httpdocs-dir <path>`：HTTP 文件根目录，默认为 httpdocs。

- `-2, --scripts-dir <path>`：脚本目录，默认为 scripts。

- `-3, --callbacks-dir <path>`：回调目录，默认为 scripts/callbacks。

- `-4, --prefs-dir <path>`：用于序列化和反序列化包含运行时首选项的文件的 Preferences 目录，默认为 /var/lib/ntopng。

- `-5, --pcap-dir <path>`：用于以 PCAP 格式进行连续流量记录的存储目录，默认为 /var/lib/ntopng。

- `-u, --no-promisc`：不要将接口设置为混杂模式。

- `-w, --http-port <[addr:]port>`：设置 HTTP 服务地址和端口，设置为 0 表示禁用 http 服务器。地址可以是 IPv4（例如 192.168.1.1）或 IPv6（例如 `[3ffe:2a00:100:7031::1]`）。注意，需要用方括号将 IPv6 地址括起来。然后在环回地址上的侦听端口之前添加一个不带 addr 的 `:`，默认端口为 3000。

  例如，下面几种表示方法都是合法的：

  ```bash
  -w :3000
  -w 192.168.1.1:3001
  -w [3ffe:2a00:100:7031::1]:3002
  ```

- `-W, --https-port <[:]https_port>`：设置 HTTPS 端口，类似于 `-w` 选项。

- `-m, --local-networks <local nets>`：本地网络列表，默认为 192.168.1.0/24。

- `-p, --ndpi-protocols <file>.protos`：指定 nDPI 协议文件，例如 protos.txt。

- `-r, --redis <fmt>`：连接 Redis 数据库，`<fmt>` 格式为 `[h[:port[:pwd]]][@db-id]`。其中 `h` 表示主机地址，`port` 表示端口号（默认为 6379），`pwd` 表示登录密码，`db-id` 表示数据库 ID（默认为 0）。另外，在 Linux 系统中，`<fmt>` 还可以是 Redis 的 socket 文件路径。

  例如，下面几种表示方法都是合法的：

  ```bash
  -r @2
  -r 129.168.1.3
  -r 129.168.1.3:6379@3
  -r 129.168.1.3:6379:nt0pngPwD@0
  -r /var/run/redis/redis.sock
  -r /var/run/redis/redis.sock@2
  ```

- `-g, --core-affinity <cpu core ids>`：将捕获/处理线程绑定到特定的 CPU 核心（指定为逗号分隔列表）。

- `-U, --user <sys user>`：使用指定用户（而不是 ntopng 用户）运行 `ntopng`。

- `-N, --instance-name <name>`：为该 ntopng 实例分配一个名称。

- `-v, --verbose <level>`：详细信息等级 `[0 (min).. 6 (debug)]`。

- `-V, --version`：显示版本信息。

- `--print-ndpi-protocols`：打印 nDPI 协议列表。

- `--ignore-vlans`：忽略流量中的 VLAN 标记。

- `--simulate-vlans`：模拟 VLAN 流量（仅限调试）。

- `-h, --help`：显示帮助信息。



## 示例

以默认方式启动 ntopng：

```bash
$ sudo ntopng
```

启动后可通过 http://localhost:3000 访问 Web 界面：

![](https://static.getiot.tech/ntopng-web.png#center)

指定端口启动 ntopng：

```bash
$ sudo ntopng -w 3001
```

执行 `ntopng -h` 会在末尾列出接口设备及编号，例如：

```bash
$ ntopng -h
...
Available interfaces (-i <interface index>):
   1. wlp0s20f3
   2. lo
   3. any
   4. enp44s0
   5. docker0
   6. bluetooth-monitor
   7. nflog
   8. nfqueue
   9. bluetooth0
```

只监控第一个网卡设备的流量（即 wlp0s20f3）：

```bash
$ sudo ntopng -i 1
```

以 pcap 文件作为输入：

```bash
$ sudo ntopng -i traffic.pcap
```

或者通过管道输入：

```bash
cat ~/traffic.pcap | sudo ntopng -i -
```

