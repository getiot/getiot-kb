---
sidebar_label: su 命令
sidebar_position: 35
slug: /su
---

# Linux su 命令 - 切换用户身份



## 介绍

在 Linux 系统中，**su**（英文全拼：substitute user）命令用于切换当前用户身份到指定用户，或者以指定用户的身份执行命令或程序。

普通用户切换到 root 用户，可以使用 `su --` 或 `su root`，但是必须输入 root 密码才能完成切换。root 用户切换到普通用户，可以使用 `su <username>`，不需要输入任何密码即可完成切换。

**语法**：

```bash
su [options] [-] [user [argument...]]
```

**选项**：

- `-c, --command`：执行完指定的指令后，即恢复原来的身份。
- `-f, --fast`：适用于 csh 与 tsch，使 shell 不用去读取启动文件。
- `-l, --login`：改变身份时，也同时变更工作目录，以及 HOME、SHELL、USER、logname，此外，也会变更 PATH 变量。
- `-m, -p, --preserve-environment`：变更身份时，不要变更环境变量。
- `-s, --shell`：指定要执行的 shell。
- `--help`：显示帮助信息。
- `--version`：显示版本信息。



## 示例

切换到 getiot 用户，但环境变量仍然是当前用户的：

```bash
su getiot
```

切换到 getiot 用户，并改变为 getiot 用户环境变量：

```bash
su - getiot
```

