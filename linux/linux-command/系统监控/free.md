---
sidebar_label: free 命令
sidebar_position: 1
slug: /free
---

# Linux free 命令 - 显示内存使用情况



## 介绍

**free** 命令用于显示系统内存的使用情况，包括物理内存、交换内存（swap）和内核缓冲区（buffer）内存。其显示的信息来自 /proc/meminfo 文件。

在 Linux 系统监控的工具中，free 命令是最经常使用的命令之一。

**语法**：

```bash
free [options]
```

**参数**：

- `-b`, `--bytes` ：以 Bytes 为单位显示内存使用情况。
- `-k`, `--kibi` ：以 Kibibytes 为单位显示内存使用情况（默认）。
- `-m`, `--mebi` ：以 Mebibytes 为单位显示内存使用情况。
- `-g`, `--gibi` ：以 Gibibytes 为单位显示内存使用情况。
- `--tebi` ：以 Tebibytes 为单位显示内存使用情况。
- `--pebi` ：以 Pebibytes 为单位显示内存使用情况。
- `--kilo` ：以 Kilobytes 为单位显示内存使用情况。
- `--mega` ：以 Megabytes 为单位显示内存使用情况。
- `--giga` ：以 Gigabytes 为单位显示内存使用情况。
- `--tera` ：以 Terabytes 为单位显示内存使用情况。
- `--peta` ：以 Petabytes 为单位显示内存使用情况。
- `-h`, `--human` ：以合适的单位显示内存使用情况，最大为三位数，自动计算对应的单位值。
- `-w`, `--wide` ：以 wide 模式显示，每行长度超过 80 个字符，buffers 和 cache 会分开两列显示。
- `-c`, `--count count` ：显示结果统计次数，需要结合 -s 选项。
- `-l`, `--lohi` ：显示详细的低和高内存统计信息。
- `-s`, `--seconds delay` ：以 delay 秒为间隔连续显示。
- `--si` ：使用 kilo、mega、giga 等（1000 倍）替代 kibi、mebi、gibi（1024 倍）。
- `-t`, `--total` ：增加一行显示列总计。
- `--help` ：显示帮助信息。
- `-V`, `--version` ：显示版本信息。



## 示例

显示系统内存使用情况

```bash
$ free
            total        used        free      shared  buff/cache   available
Mem:      7887904     2914244     1405500      352828     3568160     4316020
Swap:    16438268           0    16438268
```

加上 -h 选项，输出的结果会友好很多

```bash
$ free -h
            total        used        free      shared  buff/cache   available
Mem:        7.5Gi       2.8Gi       1.3Gi       344Mi       3.4Gi       4.1Gi
Swap:        15Gi          0B        15Gi
```

输出内容解释：

- **Mem** 行是内存的使用情况。
- **Swap** 行是交换空间的使用情况。
- **total** 列显示系统总计可用物理内存和交换空间大小。
- **used** 列显示已用的物理内存和交换空间。
- **free** 列显示还有多少空闲的物理内存和交换空间可以使用。
- **shared** 列显示共享内存大小。
- **buff/cache** 列显示内核缓冲区/页面高速缓存使用的组合内存。
- **available** 列显示还可以被应用程序使用的物理内存大小。

每隔1秒打印一次内存使用情况

```bash
$ free -h -s 1
```

利用 [watch](/linux-command/watch) 命令也能达到循环输出的效果

```bash
$ watch -n 1 free -h
```





