---
sidebar_label: capinfos 命令
sidebar_position: 19
slug: /capinfos
---

# Linux capinfos 命令 - 显示 pcap 文件信息



## 介绍

**capinfos** 是 Wireshark 工具集中的一个命令，用于查看 pcap 文件（网络捕获文件）的基本信息，包括文件大小、记录数量、时间戳范围等信息。

使用前请确保你的系统上已经安装 Wireshark 工具，如果未安装，可以参考下面安装方法：

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="apt" label="Ubuntu" default>
    ```bash
    sudo apt install wireshark
    ```
  </TabItem>
  <TabItem value="yum" label="CentOS/RHEL">
    ```bash
    sudo yum install wireshark
    ```
  </TabItem>
</Tabs>

相关命令：[editcap](/linux-command/editcap/), [mergecap](/linux-command/mergecap/)

**语法**：

```bash
capinfos [options] <infile> ...
```

**选项**：

- General infos:
  - `-t`：显示捕获文件的类型。
  - `-E`：显示捕获文件封装（encapsulation）。
  - `-I`：显示抓包文件接口信息。
  - `-F`：显示附加捕获文件信息。
  - `-H`：显示文件的 SHA256、RIPEMD160 和 SHA1 哈希值。
  - `-k`：显示捕获的注释（comment）。

- Size infos:
  - `-c`：显示数据包数量。
  - `-s`：显示文件的大小（以字节为单位）。
  - `-d`：显示所有数据包的总长度（以字节为单位）。
  - `-l`：显示数据包大小限制（快照长度）。

- Time infos:
  - `-u`：显示捕获持续时间（以秒为单位）。
  - `-a`：显示捕获开始时间。
  - `-e`：显示捕获结束时间。
  - `-o`：显示捕获文件的时间顺序状态（True/False）。
  - `-S`：将开始和结束时间显示为秒。

- Statistic infos:
  - `-y`：显示平均数据速率（以字节/秒为单位）。
  - `-i`：显示平均数据速率（以位/秒为单位）。
  - `-z`：显示平均数据包大小（以字节为单位）。
  - `-x`：显示平均数据包速率（以数据包/秒为单位）。

- Metadata infos:
  - `-n`：显示已解析的 IPv4 和 IPv6 地址的数量。
  - `-D`：显示解密密钥（decryption secrets）的数量。

- Output format:
  - `-L`：生成长报告（默认）。
  - `-T`：生成表格报告。
  - `-M`：在长报告中显示机器可读的值。

- Table report options:
  - `-R`：生成头记录（默认）。
  - `-r`：不生成头记录。
  - `-B`：用 TAB 字符分隔信息（默认）。
  - `-m`：用逗号（`,`）字符分隔信息。
  - `-b`：用 SPACE（空格）字符分隔信息。
  - `-N`：不引用信息（默认）。
  - `-q`：用单引号（`'`）引用信息。
  - `-Q`：用双引号（`"`）引用信息。

- Miscellaneous:
  - `-h, --help`：显示帮助信息并退出。
  - `-v, --version`：显示版本信息并退出。
  - `-C`：如果文件打开失败则取消处理（默认为继续）。
  - `-A`：生成所有信息（默认）。
  - `-K`：禁用显示捕获注释（comment）。



## 示例

不带任何选项参数，以默认方式显示 pcap 文件的所有基本信息：

```bash
$ capinfos 2023-09-26-14-31-42-30s.pcap
File name:           2023-09-26-14-31-42-30s.pcap
File type:           Wireshark/tcpdump/... - pcap
File encapsulation:  Ethernet
File timestamp precision:  microseconds (6)
Packet size limit:   file hdr: 65535 bytes
Number of packets:   300 k
File size:           261 MB
Data size:           256 MB
Capture duration:    30.096327 seconds
First packet time:   2023-09-26 14:33:25.555011
Last packet time:    2023-09-26 14:33:55.651338
Data byte rate:      8,512 kBps
Data bit rate:       68 Mbps
Average packet size: 854.00 bytes
Average packet rate: 9,967 packets/s
SHA256:              4cd82ce1b8fd3d498794d14e2ada82a3acbafca64f1e699574e58a6deec600cc
RIPEMD160:           347128fa0c6a4aeabcdeb71b1e6cdaf94d100999
SHA1:                a800fa328b3e65af40d2b783b37e0a2b5d80591f
Strict time order:   True
Number of interfaces in file: 1
Interface #0 info:
                     Encapsulation = Ethernet (1 - ether)
                     Capture length = 65535
                     Time precision = microseconds (6)
                     Time ticks per second = 1000000
                     Number of stat entries = 0
                     Number of packets = 300000
```

显示 pcap 文件的总大小：

```bash
$ capinfos -s 2023-09-26-14-31-42-30s.pcap
File name:           2023-09-26-14-31-42-30s.pcap
File size:           261 MB
```

显示 pcap 文件的时间长度：

```bash
$ capinfos -u 2023-09-26-14-31-42-30s.pcap
File name:           2023-09-26-14-31-42-30s.pcap
Capture duration:    30.096327 seconds
```

显示 pcap 文件的数据包总量：

```bash
$ capinfos -c 2023-09-26-14-31-42-30s.pcap
File name:           2023-09-26-14-31-42-30s.pcap
Number of packets:   300 k
```

