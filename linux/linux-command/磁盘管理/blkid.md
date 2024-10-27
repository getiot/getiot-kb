---
sidebar_label: blkid 命令
sidebar_position: 3
slug: /blkid
---

# blkid 命令



## 介绍

**blkid**（英文全称：block id）命令主要用来对系统的块设备（包括交换分区）所使用的文件系统类型、LABEL、UUID 等信息进行查询。

**语法**：

```bash
blkid [选项]
```

**选项**：

- `-g`, `--garbage-collect` ：收集 blkid 缓存
- `-o`, `--output <format>` ：指定输出格式
- `-s`, `--match-tag <tag>` ：显示指定 tag 的信息
- `-p`, `--probe` ：低级超级块探测（旁路缓存）
- `-i`, `--info` ：收集有关 I/O 限制的信息

注：UUID（Universally unique identifier）在 Linux 块设备中用作唯一标识符。使用如下命令也可以查看块设备的 UUID：

```bash
ls -l /dev/disk/by-uuid/
```



## 示例

显示指定设备 UUID

```bash
blkid -s UUID /dev/sda5 
```

显示所有设备 LABEL

```bash
blkid -s LABEL 
```

以列表方式查看详细信息

```bash
blkid -o list 
```

显示所有设备

```bash
blkid -o device 
```

显示所有设备文件系统

```bash
blkid -s TYPE 
```

