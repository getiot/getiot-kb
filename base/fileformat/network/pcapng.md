---
sidebar_position: 2
sidebar_label: PCAPNG 格式
slug: /pcapng
---

# PCAPNG 文件格式

**PCAPNG**（PCAP Next Generation）是 Wireshark 社区于 2013 年推出，用于替代 PCAP 的下一代数据包捕获格式。支持多网卡混合捕获、注释块和自定义元数据，采用模块化结构存储接口类型、加密密钥等信息，兼容 IPv6 和 5G 协议分析，现为网络取证领域的标准格式。



## 格式简介

PCAPNG 是 PCAP 格式的下一代版本，由 Wireshark 社区开发，旨在解决 PCAP 格式的局限性。PCAPNG 格式支持更丰富的元数据、多接口捕获和扩展功能，是网络数据包分析的标准格式。

PCAPNG 文件扩展名为 `.pcapng`，MIME 类型为 `application/vnd.tcpdump.pcap`。PCAPNG 格式是开放标准，被 Wireshark、tcpdump 等工具广泛支持。



## 技术特点

### 核心特性

- **多接口支持**：可以记录来自多个网络接口的数据包
- **丰富元数据**：支持接口描述、时间戳精度、自定义选项
- **注释支持**：支持数据包级别的注释
- **加密密钥**：可以存储解密密钥信息
- **扩展性**：模块化设计，易于扩展

### 与 PCAP 的区别

- **多接口**：PCAPNG 支持多接口，PCAP 仅支持单接口
- **元数据**：PCAPNG 支持更丰富的元数据
- **注释**：PCAPNG 支持注释，PCAP 不支持
- **时间戳精度**：PCAPNG 支持纳秒级精度
- **自定义选项**：PCAPNG 支持自定义选项块



## 文件结构

PCAPNG 文件由多个块组成：

```bash showLineNumbers
[Section Header Block]   # 文件头，定义字节序和版本
[Interface Description Block]  # 接口描述（可多个）
[Enhanced Packet Block]  # 数据包块（可多个）
  - 数据包头
  - 数据包数据
  - 选项
[Name Resolution Block]  # 名称解析块（可选）
[自定义块]               # 扩展块（可选）
```

### 关键块说明

- **Section Header Block**：文件开始，定义字节序
- **Interface Description Block**：描述网络接口
- **Enhanced Packet Block**：包含数据包和元数据
- **Simple Packet Block**：简化数据包块（无接口信息）



## 使用场景

### 适用场景

- **网络分析**：网络流量分析和调试
- **安全取证**：网络安全事件分析
- **协议开发**：网络协议开发和测试
- **性能分析**：网络性能监控和分析
- **教学研究**：网络教学和研究

### 优缺点

**优点：**

- 支持多接口捕获
- 丰富的元数据支持
- 支持注释和自定义选项
- 时间戳精度高
- 扩展性强

**缺点：**

- 文件结构相对复杂
- 某些旧工具可能不支持
- 文件体积可能较大（元数据多）



## 代码示例

### Python 读取 PCAPNG

```python showLineNumbers
from scapy.all import rdpcap

# 读取 PCAPNG 文件
packets = rdpcap('capture.pcapng')

# 遍历数据包
for packet in packets:
    print(f"时间: {packet.time}")
    print(f"长度: {len(packet)}")
    if packet.haslayer('IP'):
        print(f"源IP: {packet['IP'].src}")
        print(f"目标IP: {packet['IP'].dst}")
```

### Python 使用 pyshark

```python showLineNumbers
import pyshark

# 打开 PCAPNG 文件
cap = pyshark.FileCapture('capture.pcapng')

# 遍历数据包
for packet in cap:
    print(f"协议: {packet.highest_layer}")
    print(f"源: {packet.ip.src if hasattr(packet, 'ip') else 'N/A'}")
    print(f"目标: {packet.ip.dst if hasattr(packet, 'ip') else 'N/A'}")
```

### 命令行工具

```bash showLineNumbers
# 使用 tcpdump 捕获并保存为 PCAPNG
tcpdump -i eth0 -w capture.pcapng

# 使用 tshark 分析
tshark -r capture.pcapng -Y "http" -T fields -e http.host

# 使用 wireshark 命令行
wireshark -r capture.pcapng
```



## 相关工具

- **分析工具**：
  - Wireshark：图形化网络分析工具
  - tshark：Wireshark 命令行工具
  - tcpdump：命令行数据包捕获工具
- **编程库**：
  - Python: `scapy`、`pyshark`、`dpkt`
  - C/C++: `libpcap`（部分支持）
  - Go: `gopacket`



## 相关链接

- [PCAPNG 格式规范](https://github.com/pcapng/pcapng)
- [Wireshark 官方网站](https://www.wireshark.org/)
- [PCAPNG 文档](https://www.winpcap.org/ntar/draft-ietf-opsawg-pcapng.html)



## 参考

- [PCAPNG - Wikipedia](https://en.wikipedia.org/wiki/Pcap#pcapng)
- [PCAPNG 格式详解](https://github.com/pcapng/pcapng)
- [Wireshark 文档](https://www.wireshark.org/docs/)

