---
sidebar_label: iostat 命令
sidebar_position: 4
slug: /iostat
---

# iostat 命令



## 介绍

**iostat**（英文全拼：I/O statistics）是 Linux 系统中用于查看系统的磁盘 I/O（输入/输出）统计信息的命令。它能够提供关于磁盘和 CPU 使用情况的详细报告，对于监控系统性能和磁盘活动非常有用。

和 [vmstat](/linux-command/vmstat) 一样，iostat 也有一个弱点，就是它不能对某个进程进行深入分析，仅对系统的整体情况进行分析。iostat 命令由 sysstat 软件包提供，使用前需要安装，安装命令如下。

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="apt" label="Debian/Ubuntu" default>
    ```bash
    sudo apt install sysstat
    ```
  </TabItem>
  <TabItem value="yum" label="RedHat/CentOS">
    ```bash
    sudo yum install sysstat
    ```
  </TabItem>
</Tabs>

**语法**：

```bash
iostat [选项] [间隔时间] [次数]
```

**选项**：

- `-c`：显示 CPU 使用情况。
- `-d`：显示磁盘活动情况。
- `-k`：以 KB 为单位显示磁盘活动情况。
- `-m`：以 MB 为单位显示磁盘活动情况。
- `-t`：在输出中添加时间戳。

**间隔时间**：指定报告之间的时间间隔，单位为秒。

**次数**：指定生成报告的次数。



## 示例

显示整体系统的平均磁盘活动情况：

```bash
$ iostat 
Linux 5.14.0-1059-oem (Latitude-3420) 	2023年12月19日 	_x86_64_	(8 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           4.17    0.04    1.32    0.16    0.00   94.31

Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd
loop0             0.00         0.00         0.00         0.00         17          0          0
loop1             0.01         0.26         0.00         0.00      30552          0          0
nvme0n1          22.66       223.72       438.86         0.00   26153612   51304365          0
sda               5.50        95.04       165.04         0.00   11110209   19294060          0
sdb               0.02         0.24         0.01         0.00      27975       1368          0
```

CPU 属性值说明：

- `%user`：CPU 处在用户模式下的时间百分比。
- `%nice`：CPU 处在带 NICE 值的用户模式下的时间百分比。
- `%system`：CPU 处在系统模式下的时间百分比。
- `%iowait`：CPU 等待输入输出完成时间的百分比。
- `%steal`：管理程序维护另一个虚拟处理器时，虚拟 CPU 的无意识等待时间百分比。
- `%idle`：CPU 空闲时间百分比。

:::tip

如果 `%iowait` 的值过高，表示硬盘存在 I/O 瓶颈；`%idle` 值高，表示 CPU 较空闲；如果 `%idle` 值高但系统响应慢时，有可能是 CPU 等待分配内存，此时应加大内存容量。`%idle` 值如果持续低于 10，那么系统的 CPU 处理能力相对较低，表明系统中最需要解决的资源是 CPU。

:::

显示磁盘活动详细信息（包括读取和写入速率、I/O 等待时间等）：

```bash
iostat -d
```

显示 CPU 使用情况的报告（包括用户、系统和空闲时间）：

```bash
iostat -c
```

每 5 秒显示一次磁盘活动的详细报告：

```bash
iostat -d 5
```

以 MB 为单位显示磁盘活动情况（而不是默认的块大小）：

```bash
iostat -m
```

