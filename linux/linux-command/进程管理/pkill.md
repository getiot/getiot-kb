---
sidebar_label: pkill 命令
sidebar_position: 5
slug: /pkill
---

# pkill 命令



## 介绍

**pkill** 用于杀死一个进程，类似于 [killall](/linux-command/killall) 命令。

**语法**：

```bash
  pkill [选项]  name
```

**选项**：

- `-o` 仅向找到的最小（起始）进程号发送信号
- `-n` 仅向找到的最大（结束）进程号发送信号
- `-P` 指定父进程号发送信号
- `-g` 指定进程组
- `-t` 指定开启进程的终端

**参数**：进程名 name



## 示例

结束 php-fpm 进程：

```bash
$ pkill -9 php-fpm
```

