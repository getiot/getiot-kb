---
sidebar_label: mergecap 命令
sidebar_position: 21
slug: /mergecap
---

# Linux mergecap 命令 - 合并多个 pcap 文件



## 介绍

**mergecap** 是 Wireshark 工具集中的一个命令，用于将多个 pcap 文件（网络捕获文件）合并为一个文件。这个命令允许你将多个捕获文件的数据合并到一个文件中，方便进行整体分析和处理。

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

相关命令：[editcap](/linux-command/editcap), [capinfos](/linux-command/capinfos)

**语法**：

```bash
mergecap [options] -w <outfile>|- <infile> [<infile> ...]
```

**选项**：

- `-a`：连接而不是合并文件，默认是根据帧时间戳进行合并。
- `-s <snaplen>`：将数据包截断为 `<snaplen>` 数据字节。
- `-w <outfile>|-`：将输出文件名设置为 `<outfile>` 或标准输出的 `-`。
- `-F <capture type>`：设置输出文件类型； 默认为 pcapng。空的 `-F` 选项将列出文件类型。
- `-I <IDB merge mode>`：设置接口描述块的合并模式，默认为 all。空的 `-I` 选项将列出合并模式。



## 示例

列出支持的所有合并模式：

```bash
$ mergecap -I
mergecap: option requires an argument: I
mergecap: The available IDB merge modes for the "-I" flag are:
    none
    all
    any
```

将合并 `file1.pcap` 和 `file2.pcap` 两个文件，并将结果保存到 `new.pcap` 中：

```bash
mergecap file1.pcap file2.pcap -w new.pcap
```

也可以使用通配符来检索输入文件，例如：

```bash
mergecap file*.pcap -w new.pcap
```

在输入文件特别多的情况下非常有用！
