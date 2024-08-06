---
sidebar_position: 25
slug: /swapon
---

# swapon 命令



## 介绍

**swapon** 命令用于检查或启用 Linux 系统中用于分页和交换的设备和文件。

相关命令：[swapoff](/linux-command/swapoff)

**语法**：

```bash
swapon [options] [specialfile...]
```

**选项**：

- `-a`, `--all` ：使能所有在 /etc/fstab 中被标记为 "swap" 的块设备，带 "noauto" 选项的除外，已被用作 swap 的设备也将会默默跳过。

- `-d`, `--discard[=policy]` ：如果 swap 设备支持丢弃或修剪操作，则启用交换丢弃。这可能会提高某些固态设备的性能，但通常不会。该选项允许在两种可用的交换丢弃策略之间进行选择： 

  - `--discard=once` 对整个交换区域执行一次丢弃操作；
  - `--discard=pages` 在它们可用于重用之前异步丢弃已释放的交换页面。 

  如果未选择任何策略，则默认行为是启用两种丢弃类型。 /etc/fstab 挂载选项discard、discard=once 或discard=pages 也可用于启用丢弃标志。

- `-e`, `--ifexists` ：默默跳过不存在的设备，/etc/fstab 挂载选项 "nofail" 也可用于跳过不存在的设备。

- `-f`, `--fixpgsz` ：如果交换空间的页面大小与当前运行内核的页面大小不匹配，则重新初始化（执行 mkswap）交换空间，mkswap 会初始化整个设备并且不检查坏块。

- `-h`, `--help` ：显示帮助信息并退出。

- `-L label` ：使用具有指定标签的分区（可以访问 /proc/partitions 获知）。

- `-o`, `--options opts` ：通过 fstab 兼容的逗号分隔字符串指定交换选项。

- `-p`, `--priority priority` ：指定 swap 设备的优先级。优先级是一个介于 -1 和 32767 之间的值，数字越大表示优先级越高，可以将 `pri=value` 添加到 /etc/fstab 的选项字段以与 `swapon -a` 一起使用，如果未定义优先级，则默认为 -1。 

- `-s`, `--summary` ：按设备显示 swap 使用情况摘要，相当于 "cat /proc/swaps"。此输出格式已被弃用，使用 `--show` 能得到更好地控制输出数据。

- `--show[=column...]` ：显示可定义的交换区域表。

- `--output-all` ：输出所有可用的列。

- `--noheadings` ：显示 `--show` 输出时不要打印标题。

- `--raw`  ：显示 `--show` 输出时忽略表格对齐。

- `--bytes` ：显示 `--show` 输出时以字节为单位，而不是用户友好的单位。

- `-U uuid` ：使用 uuid 指定磁盘分区。

- `-v`, `--verbose` ：详细模式。

- `-V`, `--version` ：显示版本信息并退出。

**参数**：指定的 swap 设备（分区、逻辑卷或文件）。



## 示例

读取 swap 区域的摘要信息（以千字节为单位）

```bash
$ swapon -s
Filename          Type           Size          Used        Priority
/dev/sdb5         partition      16438268      100352      -2
```

禁用 /dev/sdb5 交换区域

```bash
$ sudo swapoff /dev/sdb5
```

再启用 /dev/sdb5 交换区域

```bash
$ sudo swapon /dev/sdb5
```

启用交换区域时可附加选项

```bash
$ swapon -o pri=1,discard=pages,nofail /dev/sdb5
```

