---
sidebar_label: stat 命令
sidebar_position: 15
slug: /stat
---

# stat 命令 - 显示文件或文件系统状态



## 介绍

**stat**（英文全拼：status）命令用于显示文件或文件系统的状态，以文字的格式来显示 inode 的内容。

**语法**：

```bash
stat [OPTION]... FILE...
```

**选项**：

- `-L`：支持符号连接
- `-f`：显示文件系统状态而非文件状态
- `-t`：以简洁方式输出信息
- `--help`：显示指令的帮助信息
- `--version`：显示指令的版本信息

**参数**：文件或目录



## 示例

假设当前目录下由 dir 目录及软链接 dir_link

```bash
$ ls -ld dir*
drwxr-xr-x 2 root root 4096 Apr 13 10:33 dir
lrwxrwxrwx 1 root root    3 Apr 13 13:55 dir_link -> dir
```

查看 dir 目录的 inode 内容

```bash
$ stat dir
  File: dir
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: b302h/45826d    Inode: 2752621     Links: 2
Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2021-04-13 10:33:54.796081184 +0000
Modify: 2021-04-13 10:33:47.508153771 +0000
Change: 2021-04-13 10:33:47.508153771 +0000
 Birth: 2021-04-13 10:33:08.968537620 +0000
```

查看 dir_link 目录的 inode 内容

```bash
stat dir_link
  File: dir_link -> dir
  Size: 3               Blocks: 0          IO Block: 4096   symbolic link
Device: b302h/45826d    Inode: 2752631     Links: 1
Access: (0777/lrwxrwxrwx)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2021-04-13 13:55:59.591319842 +0000
Modify: 2021-04-13 13:55:54.755368008 +0000
Change: 2021-04-13 13:55:54.755368008 +0000
 Birth: 2021-04-13 13:55:54.755368008 +0000
```

查看 file 文件的 inode 内容

```bash
$ stat file
  File: file
  Size: 8360846         Blocks: 16336      IO Block: 4096   regular file
Device: b302h/45826d    Inode: 2752632     Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2021-04-13 13:59:07.161451669 +0000
Modify: 2021-04-13 13:59:07.197451310 +0000
Change: 2021-04-13 13:59:07.197451310 +0000
 Birth: 2021-04-13 13:59:07.161451669 +0000
```

