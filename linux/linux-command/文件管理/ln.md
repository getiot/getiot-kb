---
sidebar_label: ln 命令
sidebar_position: 32
slug: /ln
---

# ln 命令 - 创建文件链接



## 介绍

**ln**（英文全拼：link）命令是 Linux 系统中非常重要的命令，它的作用是为某一个文件在另一个位置建立一个同步的链接。

Linux 文件系统中的链接（link）可分为两种 —— 硬链接（hard link）与软链接/符号链接（symbolic link）。软链接类似于 Windows 系统中的快捷方式。

**语法**：

```bash
ln [OPTION]... [-T] TARGET LINK_NAME
ln [OPTION]... TARGET
ln [OPTION]... TARGET... DIRECTORY
ln [OPTION]... -t DIRECTORY TARGET...
```

**选项**：

- `--backup[=CONTROL]` ：为每个已存在的目标文件创建备份文件。
- `-b` ：类似 --backup，但不接受任何参数。
- `-d`, `-F`, `--directory` ：允许超级用户尝试创建指向目录的硬链接（注意：此操作可能因系统限制而失败）。
- `-f`, `--force` ：强行删除任何已存在的目标文件。
- `-i`, `--interactive` ：删除目标文件前进行确认。
- `-L`, `--logical` ：如目标为符号链接，本次创建链接时将其解引用。
- `-n`, `--no-dereference` ：如果给定链接名是一个链接至某目录的符号链接，将其作为普通文件处理。
- `-P`, `--physical` ：创建直接指向符号链接文件的硬链接。
- `-r`, `--relative` ：创建相对于链接位置的符号链接。
- `-s`, `--symbolic` ：创建符号链接而非硬链接。
- `-S`, `--suffix=后缀` ：自行指定备份文件的后缀。
- `-t`, `--target-directory=目录` ：在指定目录中创建链接。
- `-T`, `--no-target-directory` ：总是将给定的链接名当作普通文件。
- `-v`, `--verbose` ：列出每个链接的文件名称。
- `--help` ：显示此帮助信息并退出。
- `--version` ：显示版本信息并退出。



## 示例

假设当前目录下有一个 libldal.so.1.0.0 共享库文件，可以通过如下命令创建软链接 libldal.so.1 和 libldal.so：

```bash
ln -s libldal.so.1.0.0 libldal.so.1
ln -s libldal.so.1 libldal.so
```

创建软链接后的文件情况：

```bash
lrwxrwxrwx 1 root root     12 Sep  2 16:15 libldal.so -> libldal.so.1
lrwxrwxrwx 1 root root     16 Sep  2 16:14 libldal.so.1 -> libldal.so.1.0.0
-rwxr-xr-x 1 root root 278416 Sep  2 16:12 libldal.so.1.0.0
```





