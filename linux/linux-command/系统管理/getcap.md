---
sidebar_label: getcap 命令
sidebar_position: 56
slug: /getcap
---

# Linux getcap 命令 - 查看文件的特殊权限



## 介绍

**getcap** 命令是在 Linux 系统中用于查看文件的特殊权限（capabilities）的工具。通过运行 `getcap` 命令，你可以查询指定文件或目录上设置的特殊权限。这些特殊权限描述了该文件或目录在执行时是否有一些超出普通权限的能力。

特殊权限是 Linux 内核引入的一种机制，可以让特定的程序在没有完全超级用户权限的情况下执行一些具有特权的操作。而不需要将整个程序或脚本设置为以超级用户身份运行。

通过 `getcap` 命令，你可以了解到哪些文件具有特殊权限，以及它们所具有的特权。这可以帮助你对系统中的文件和程序进行安全审计和权限管理。

需要注意的是，`getcap` 命令同样需要超级用户（root）权限才能查看特殊权限。可能并不是每个文件或目录都会设置特殊权限，所以返回结果中可能会有空白行。同时，应当只赋予可信任的程序特殊权限，并遵循安全最佳实践。

相关命令：[setcap](/linux-command/setcap)

**语法**：

```bash
getcap [-v] [-n] [-r] [-h] filename [ ... ]
```

**选项**：

- `-h`：打印命令的简明使用说明。
- `-n`：打印与文件功能关联的任何非零名称空间 rootid 值。
- `-r`：递归搜索文件。
- `-v`：显示所有搜索到的条目，即使它没有文件功能。

**参数**：

- `filename`：文件名称或目录路径。



## 示例

查看 /bin/ping 可执行文件的特殊权限（这将显示指定文件的特殊权限，如果有的话）：

```bash
$ getcap /bin/ping
/bin/ping = cap_net_raw+ep
```

列出系统 /bin 目录中所有具有特殊权限的文件：

```bash
$ getcap -r /bin/*
/bin/dumpcap = cap_net_admin,cap_net_raw+eip
/bin/gnome-keyring-daemon = cap_ipc_lock+ep
/bin/mtr-packet = cap_net_raw+ep
/bin/ping = cap_net_raw+ep
/bin/traceroute6.iputils = cap_net_raw+ep
```

将输出结果保存到文件：

```bash
getcap -r /bin/* > capabilities.txt
```

使用重定向操作符 `>`，可以将结果输出到指定的文件中，以便后续查阅或分析。

