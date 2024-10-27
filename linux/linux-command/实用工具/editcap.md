---
sidebar_label: editcap 命令
sidebar_position: 20
slug: /editcap
---

# editcap 命令



## 介绍

**editcap** 是 Wireshark 工具集中的一个命令，用于编辑 pcap 文件，包括截断、拆分、过滤等操作。这个命令允许你对捕获的网络流量进行一些基本的编辑，以便更好地分析和处理。

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

相关命令：[capinfos](/linux-command/capinfos), [mergecap](/linux-command/mergecap)

**语法**：

```bash
editcap [options] ... <infile> <outfile> [ <packet#>[-<packet#>] ... ]
```

**选项**：

- `-r`：保留选定的数据包（默认是删除它们）。
- `-A <start time>`：只读取时间戳晚于（或等于）给定时间的数据包。时间格式为 `YYYY-MM-DDThh:mm:ss[.nnnnnnnnn][Z|+-hh:mm]`。
- `-B <stop time>`：只读取时间戳早于给定时间的数据包。时间格式同上。
- `-s <snaplen>`：将每个数据包截断为最大值 `<snaplen>` 字节数据。
- `-C [offset:]<choplen>`：将每个数据包切割 `<choplen>` 字节。正值在数据包开始处截断，负值在数据包结尾处截断。如果可选偏移量位于长度之前，则截断的字节将从该值开始偏移。正偏移量是从数据包开始处开始的，负偏移量是从数据包结束处开始的。你可以多次使用此选项，允许数据包内最多有 2 个斩波区域（chopping regions），前提是至少 1 个 choplen 为正值，至少 1 个为负值。
- `-c <packets per file>`：根据统一的数据包计数将数据包输出拆分到不同的文件，每个文件最多为 `<packets per file>`。
- `-i <seconds per file>`：根据统一的时间间隔将数据包输出拆分到不同的文件，每个文件的最大时间间隔为 `<seconds per file>`。
- `-F <capture type>`：设置输出文件类型，默认为 pcapng。空的 `-F` 选项将列出文件类型。
- `-T <encap type>`：设置输出文件封装类型，默认与输入文件相同。空的 `-T` 选项将列出封装类型。



## 示例

假设有个 30 秒的 pcap 文件 2023-09-26-14-31-42-30s.pcap，我们先用 [`capinfos`](/linux-command/capinfos) 命令查看它的起始和结束时间：

```bash showLineNumbers {3,6}
$ capinfos -a 2023-09-26-14-31-42-30s.pcap
File name:           2023-09-26-14-31-42-30s.pcap
First packet time:   2023-09-26 14:33:25.555011
$ capinfos -e 2023-09-26-14-31-42-30s.pcap
File name:           2023-09-26-14-31-42-30s.pcap
Last packet time:    2023-09-26 14:33:55.651338
```

现在，我们前后分别偏移 10 秒，即截取中间的 10 秒数据：

```bash
editcap -A 2023-09-26T14:33:35 -B 2023-09-26T14:33:45 2023-09-26-14-31-42-30s.pcap 2023-09-26-14-31-42-10s.pcap
```

按 1000 个包为间隔将 pcap 文件拆分成多个文件：

```bash
editcap -c 1000 2023-09-26-14-31-42-30s.pcap output.pcap
```

此时会在当前目录生成许多 `output_00*` 开头的 pcap 文件，例如 output_00214_20230926143347.pcap。

