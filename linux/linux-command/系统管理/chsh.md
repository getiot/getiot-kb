---
sidebar_label: chsh 命令
sidebar_position: 42
slug: /chsh
---

# Linux chsh 命令 - 更改登录 Shell



## 介绍

**chsh**（英文全拼：change shell）命令用于更改用户登录 shell。

**语法**：

```bash
chsh [选项] [登录]
```

**选项**：

- `-R`, `--root CHROOT_DIR` ：在 `CHROOT_DIR` 目录中应用更改并使用 `CHROOT_DIR` 目录中的配置文件。
- `-s`, `--shell SHELL` ：用户的新登录 shell 的名称（将此字段设置为空会让系统选择默认的登录 shell）。
- `-h`, `--help` ：显示帮助信息并退出。



## 示例

查看系统支持的 shell

```bash
$ cat /etc/shells 
# /etc/shells: valid login shells
/bin/sh
/bin/bash
/usr/bin/bash
/bin/rbash
/usr/bin/rbash
/bin/dash
/usr/bin/dash
```

查看当前登录的 shell

```bash
$ echo $SHELL
/bin/bash
```

查看当前用户设置的默认 shell

```bash
$ cat /etc/passwd | grep sh
rudy:x:1000:1000:rudy,,,:/home/rudy:/bin/bash
```

将当前用户的默认 shell 由 bash 修改为 dash

```bash
$ chsh -s /bin/dash
```

再次查看当前用户设置的默认 shell

```bash
$ cat /etc/passwd | grep sh
rudy:x:1000:1000:rudy,,,:/home/rudy:/bin/dash
```

将当前用户的默认 shell 设置回 bash

```bash
$ chsh -s /bin/bash
```

