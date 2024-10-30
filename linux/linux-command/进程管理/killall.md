---
sidebar_label: killall 命令
sidebar_position: 6
slug: /killall
---

# Linux killall 命令 - 终止指定名称的所有进程



## 介绍

**killall** 命令用于杀死指定名字的所有进程。与 [kill](/linux-command/kill) 命令不同，killall 不需要事先查找进程 PID，直接对进程对名字进行操作，更加方便。

**语法**：

```bash
  killall [选项]  name
```

**选项**：

- `-e | --exact`：进程需要和名字完全相符
- `-I | --ignore-case`：忽略大小写
- `-g | --process-group`：结束进程组
- `-i | --interactive`：结束之前询问
- `-l | --list`：列出所有的信号名称
- `-q | --quite`：进程没有结束时，不输出任何信息
- `-r | --regexp`：将进程名模式解释为扩展的正则表达式。
- `-s | --signal`：发送指定信号
- `-u | --user`：结束指定用户的进程
- `-v | --verbose`：显示详细执行过程
- `-w | --wait`：等待所有的进程都结束
- `-V |--version`：显示版本信息
- `--help`：显示帮助信息

**参数**：进程名 name



## 示例

结束所有的 php-fpm 进程：

```bash
$ killall -9 php-fpm
```

