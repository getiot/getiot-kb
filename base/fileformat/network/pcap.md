---
sidebar_position: 1
slug: /pcap
---

# PCAP 文件格式

**PCAP**（Packet Capture，网络数据包捕获格式）由 libpcap/WinPcap 开发团队于 1990 年代提出，是网络流量分析的通用存储格式。以二进制形式记录原始网络数据包（含帧头、载荷和时间戳），支持 Wireshark 等工具解析，但缺乏元数据扩展能力，仅保存单一网卡捕获数据。

如今，PCAP 已成为行业标准的网络数据包捕获格式。如果你是网络开发人员，那么通常会使用 Wireshark、Tcpdump 或 WinDump 等网络分析器捕获 TCP/IP 数据包，而抓包后存盘的文件格式就是 .pcap 文件。



## 文件格式

Pcap 文件格式是一种二进制格式，支持纳秒级精度的时间戳。虽然这种格式在不同的实现中有所不同，但是所有的 pcap 文件都具有如下图所示的一般结构。

![PCAP 文件格式](https://static.getiot.tech/pcap-file-format.png#center)

### 全局报头

全局报头（Global Header）包含魔数（Magic number）、GMT 偏移量、时间戳精度、捕获的数据包的最大长度，以及数据链路的类型。内部具体格式和区域划分如下：

```bash
                           1                   2                   3
       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    0 |                          Magic Number                         |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    4 |          Major Version        |         Minor Version         |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    8 |                           Reserved1                           |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   12 |                           Reserved2                           |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   16 |                            SnapLen                            |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   20 | FCS |f|                   LinkType                            |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

Pcap 文件全局报头的长度为 24 字节，各区域/字段说明如下：

- **Magic Number**（32 位）

  一个无符号幻数，其值为十六进制数 0xA1B2C3D4 或十六进制数 0xA1B23C4D。如果值为 0xA1B2C3D4，则 Packet Records 中的时间戳以秒和微秒为单位；如果是 0xA1B23C4D，则数据包记录中的时间戳以秒和纳秒为单位。另外，这个幻数也可用于区分保存在小端机器上的部分和保存在大端机器上的部分，并自动识别 pcap 文件。

- **Major Version**（16 位）

  一个无符号值，给出 pcap 格式的当前主要版本的编号。

- **Minor Version**（16 位）

  一个无符号值，给出 pcap 格式的当前次要版本的编号。

- **Reserved1**（32 位）

  未使用的保留字段，pcap 文件写入器应填充 0，pcap 文件读取器必须忽略。这个值被一些较早的实现记录为“gmt to local correction”，因此一些较旧的 pcap 文件编写器在此字段中存储了非零值。

- **Reserved2**（32 位）

  未使用的保留字段，pcap 文件写入器应填充 0，pcap 文件读取器必须忽略。这个值被一些较旧的实现记录为“accuracy of timestamps”，因此一些较旧的 pcap 文件编写器在此字段中存储了非零值。

- **SnapLen**（32 位）

  一个无符号值，表示从每个数据包中捕获的最大字节数。每个数据包中超过此值的部分将不会存储在文件中。注意：该值不得为零；如果未指定限制，则该值应为大于或等于文件中最大数据包长度的数字。

- **LinkType**（28 位）

  一个无符号值，在全局报头最后 4 字节的低 28 位中定义文件中数据包的链路层类型。

- **Frame Cyclic Sequence present**（4 位）

  如果设置了“f”位，则 FCS 位提供附加到每个数据包的 FCS 字节数，有效值介于 0 和 7 之间。

在全局报头后面，跟着 0 条或多条捕获的数据包数据记录（Packet Record）。



### 数据记录

数据包记录（Packet Record）是存储来自网络的数据包的标准容器，包括 Packet Header 和 Packet Data 两部分。其中，Packet Header 长度固定为 16 字节，Packet Data 则是可变长度的负荷数据。

Packet Record 内部具体格式和区域划分如下：

```bash
                          1                   2                   3
      0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    0 |                      Timestamp (Seconds)                      |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    4 |            Timestamp (Microseconds or nanoseconds)            |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    8 |                    Captured Packet Length                     |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   12 |                    Original Packet Length                     |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   16 /                                                               /
      /                          Packet Data                          /
      /                        variable length                        /
      /                                                               /
      +---------------------------------------------------------------+
```

数据记录各区域/字段说明如下：

- **Timestamp（秒）和 Timestamp（微秒或纳秒）**

  时间戳，包括整数（秒数）和小数（微秒或纳秒）部分。秒值是一个 32 位无符号整数，表示自 1970 年 1 月 1 日 00:00:00 UTC 以来经过的秒数，微秒或纳秒值表示自那以后经过的微秒或纳秒数秒。值得一提的是，该值是表示微秒还是纳秒，由文件头中的幻数指定。

- **Captured Packet Length**（32 位）

  一个无符号值，表示从数据包中捕获的字节数（即数据包数据字段的长度）。它将是原始数据包长度（Original Packet Length）和接口的快照长度（上图中的 SnapLen 定义）中的最小值。

- **Original Packet Length**（32 位）

  一个无符号值，表示数据包在网络上传输时的实际长度。如果数据包已被捕获过程截断，则它可能与捕获的数据包长度不同。

- **Packet Data**

  来自网络的数据，包括链路层标头。该字段的实际长度为 Captured Packet Length。链路层头部的格式取决于文件头中指定的 LinkType 字段。



## pcap 库

libpcap 是用 C 语言编写的 pcap 库，在类 Unix 系统中透过 libpcap 库来实现 pcap，在 Microsoft Windows 上则是透过 Npcap 库来实现，之前还可以透过 WinPcap 库来实现，但 WinPcap 库已不再维护。

我们自己设计的监控软件可以使用 libpcap 来捕获在计算机网络上传输的网络数据包。

详细请参阅《[libpcap 使用教程](/awesome-c/libpcap)》。



## 相关链接

- [tcpdump 官方网站（基于 libpcap）](http://www.tcpdump.org/)
- [Wireshark 官方网站](https://www.wireshark.org)
- [WinPcap 官方网站](http://www.winpcap.org/)
- [Npcap 官方网站](http://www.npcap.org/)
- [libpcap 代码仓库](https://github.com/the-tcpdump-group/libpcap)



## 参考

- [The pcap Packet Capture Format](https://www.lesliesikos.com/pcap/)
- [PCAP Capture File Format](https://tools.ietf.org/id/draft-gharris-opsawg-pcap-00.html)

