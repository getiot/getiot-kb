---
sidebar_label: df 命令
sidebar_position: 5
slug: /df
---

# df 命令 - 显示磁盘使用情况



## 介绍

**df**（英文全拼：disk free） 命令用于显示目前在 Linux 系统上的文件系统磁盘使用情况统计。

语法：

```bash
df [OPTION]... [FILE]...
```

选项：

- `-a` 或 `--all`：包含全部的文件系统；
- `--block-size=<区块大小>`：以指定的区块大小来显示区块数目；
- `-h` 或 `--human-readable`：以可读性较高的方式来显示信息；
- `-H` 或 `--si`：与-h参数相同，但在计算时是以 1000 Bytes 为换算单位而非 1024 Bytes；
- `-i` 或 `--inodes`：显示 inode 的信息；
- `-k` 或 `--kilobytes`：指定区块大小为 1024 字节；
- `-l` 或 `--local`：仅显示本地端的文件系统；
- `-m` 或 `--megabytes`：指定区块大小为 1048576 字节；
- `--no-sync`：在取得磁盘使用信息前，不要执行 sync 指令，此为预设值；
- `-P` 或 `--portability`：使用 POSIX 的输出格式；
- `--sync`：在取得磁盘使用信息前，先执行sync指令；
- `-t <文件系统类型>` 或 `--type=<文件系统类型>`：仅显示指定文件系统类型的磁盘信息；
- `-T` 或 `--print-type`：显示文件系统的类型；
- `-x <文件系统类型>` 或 `--exclude-type=<文件系统类型>`：不要显示指定文件系统类型的磁盘信息；
- `--help`：显示帮助；
- `--version`：显示版本信息。



## 示例

显示文件系统的磁盘使用情况统计

```bash
$ df 
Filesystem     1K-blocks    Used     Available Use% Mounted on 
udev             3914416         0   3914416    0%   /dev
tmpfs             788796      1956    786840    1%   /run
/dev/sdb1      195811956  96620276  89175324   53%   /
tmpfs            3943968    303828   3640140    8%   /dev/shm
tmpfs               5120         4      5116    1%   /run/lock
```

第1列指定文件系统的名称，第2列指定一个特定的文件系统1K-块（1K是1024字节）为单位的总内存，Used 和 Available 列表示已使用和可用的内存容量，Use% 列显示使用的内存的百分比，而最后一列"Mounted on"显示的文件系统的挂载点。

df 也可以显示磁盘使用的文件系统信息

```bash
$ df /dev/shm/
Filesystem     1K-blocks    Used      Available Use% Mounted on 
tmpfs          3943968      293584    3650384    8%   /dev/shm
```

用 `-i` 选项的 `df` 命令的输出显示 `inode` 信息而非块使用量

```bash
df -i 
```

显示所有的信息:

```bash
df --total 
```

我们看到输出的末尾，包含一个额外的行，显示总的每一列。

用 `-h` 选项，通过它可以产生可读的格式 df 命令的输出

```bash
df -h
```

输出的数字以 G（千兆字节）、M（兆字节）和 K（千字节）为单位。