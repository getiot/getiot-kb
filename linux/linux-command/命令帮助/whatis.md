---
sidebar_label: whatis 命令
sidebar_position: 3
slug: /whatis
---

# Linux whatis 命令 - 显示命令简要说明



## 介绍

**whatis** 命令是用于查询一个命令执行什么功能，并将查询结果打印到终端上。

whatis 命令在用 `catman` 命令创建的数据库中查找选项参数中指定的命令、系统调用、库函数或特殊文件名。实际上，whatis 命令显示手册部分的页眉行，等同于使用 `man -f` 命令。

简单来说，如果你想知道某个不熟悉命令是干什么用的，那么可以使用 whatis 命令来快速查看。

**语法**：

```bash
whatis [选项...] 关键词...
```

**选项**：

- `-d`, `--debug` ：输出调试信息。
- `-v`, `--verbose` ：输出详细的警告信息。
- `-r`, `--regex` ：把每个关键词都当作正则表达式解读。
- `-w`, `--wildcard` ：关键词里包含通配符。
- `-l`, `--long` ：不要把输出按终端宽度截断。
- `-C`, `--config-file=文件` ：使用该用户设置文件。
- `-L`, `--locale=区域` ：定义本次搜索所使用的区域设置。
- `-m`, `--systems=系统` ：使用来自其它系统的手册页。
- `-M`, `--manpath=路径` ：设置搜索手册页的路径为 PATH。
- `-s`, `--sections=列表`, `--section=列表` ：仅在这些分区中搜索（冒号分隔）。
- `-?`, `--help` ：显示帮助列表。
- `--usage` ：显示一份简洁的用法信息。
- `-V`, `--version` ：显示版本信息。



## 示例

查看 ls 命令的功能

```bash
$ whatis ls
ls (1)               - list directory contents
```

查看 cp 命令的功能

```bash
$ whatis cp
cp (1)               - copy files and directories
```

查看 chown 命令的功能

```bash
$ whatis chown
chown (1)            - change file owner and group
chown (2)            - change ownership of a file
```

查看 man 命令的功能

```bash
$ whatis man
man (1)              - an interface to the system reference manuals
man (7)              - macros to format man pages
```

