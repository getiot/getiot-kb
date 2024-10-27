---
sidebar_label: dmesg 命令
sidebar_position: 19
slug: /dmesg
---

# dmesg 命令



## 介绍

**dmesg**（英文全拼：diagnostic messages）命令用于显示和控制 Linux 内核环形缓冲区中的信息。

kernel 会将开机信息存储在 ring buffer 中。开机时来不及查看的信息，后续可利用 dmesg 来仔细查看。同时，开机信息也会保存在 /var/log/dmesg 文件里。

dmesg 中的 'd' 通常被认为是 display 或 debug 的意思，但最开始的含义应该是 diagnostic，也就是诊断信息。

**语法**：

```shell
dmesg [options]
```

**选项**：

- `-c`, `--read-clear` ：显示信息后，清除 ring buffer 中的内容。
- `-s`, `--buffer-size <size>` ：指定用于查询的缓冲区大小。预设置为 8196，刚好等于 ring buffer 的大小。
- `-n`, `--console-level <level>` ：设置记录信息的层级。
- `-k`, `--kernel` ：打印内核信息。
- `-H`, `--human` ：以便于人类阅读的方式输出。



## 示例

输出所有诊断信息：

```shell
dmesg
```

上述命令输出的内容很多，不便于查看，可以加 `-H` 参数：

```shell
dmesg -H
```

通常可以使用管道配合其他工具查看，比如 more 分页显示：

```shell
dmesg | more
```

按关键词搜索：

```shell
dmesg | grep usb
```

忽略大小写搜索关键词：

```shell
dmesg | grep -i memory 
```

显示开机信息的前20行：

```shell
dmesg | head -20
```

显示开机信息的最后20行：

```shell
dmesg | tail -20
```

清空 dmesg 环形缓冲区中的日志：

```shell
dmesg -c
```

