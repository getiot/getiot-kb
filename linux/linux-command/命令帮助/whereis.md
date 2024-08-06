---
sidebar_position: 4
slug: /whereis
---

# whereis 命令



## 介绍

**whereis** 命令用来定位命令的二进制程序、源代码文件和 man 手册页等相关文件的路径。

whereis 命令查找速度非常快，因为它不是在磁盘中乱找，而是在一个数据库中查询；数据库是 linux 系统自动创建的，包含有本地所有文件的信息，并且每天通过自动执行 updatedb 命令更新一次。正因为这样，whereis 命令的搜索结果有时候会不准确，比如刚添加的文件可能搜不到， 原因就是该数据库文件没有被更新。

注意：该指令只能用于查找二进制文件、源代码文件和 man手册页，一般文件的定位需使用 [locate](/linux-command/locate) 命令。

**语法**：

```bash
whereis [options] [-BMS directory... -f] name...
```

**选项**：

- `-b` ：只查找二进制文件。
- `-B <目录>` ：只在设置的目录下查找二进制文件。
- `-f` ：不显示文件名前的路径名称。
- `-m` ：只查找说明文件。
- `-M <目录>` ：只在设置的目录下查找说明文件。
- `-s` ：只查找原始代码文件。
- `-S <目录>` ：只在设置的目录下查找原始代码文件。
- `-u` ：查找不包含指定类型的文件。



## 示例

查看 ssh 程序的位置

```bash
$ whereis ssh
ssh: /usr/bin/ssh /etc/ssh /usr/share/man/man1/ssh.1.gz
```

查看 ssh 的二进制程序的路径

```bash
$ whereis -b ssh
ssh: /usr/bin/ssh /etc/ssh
```

查看 ssh 命令的 man 手册页的路径

```bash
$ whereis -m ssh
ssh: /usr/share/man/man1/ssh.1.gz
```

