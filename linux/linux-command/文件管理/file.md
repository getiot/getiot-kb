---
sidebar_position: 19
slug: /file
---

# file 命令



## 介绍

**file** 命令用于探测 Linux 系统中指定文件的类型，也可用来辨别一些文件的编码格式。

与 Windows 系统通过扩展名来确定文件类型不同，file 命令通过查看文件的头部信息来获取文件类型。file 命令对文件的检查分为文件系统、魔法幻数检查和语言检查 3 个过程。

**语法**：

```bash
file [options] <file> ...
```

**选项**：

- `-b`, `--brief` ：列出辨识结果时，不显示文件名称。
- `-c`, `--checking-printout` ：详细显示指令执行过程，便于排错或分析程序执行的情形。
- `-f`, `--files-from <namefile>` ：指定名称文件，其内容有一个或多个文件名称时，让 file 依序辨识这些文件，格式为每列一个文件名称。
- `-L`, `--dereference` ：直接显示符号连接所指向的文件类别。
- `-m`, `--magic-file <magicfiles>` ：指定魔法数字文件。
- `-z`, `--uncompress` ：尝试去解读压缩文件的内容。
- `-v`, `--version` ：显示版本信息。
- `--help` ：显示帮助信息。



## 示例

查看当前目录下的 main.c 文件类型

```bash
$ file main.c 
main.c: C source, ASCII text
```

查看当前目录下的 README.md 文件类型

```bash
$ file README.md 
README.md: UTF-8 Unicode text
```

查看 /bin/sh 文件类型（软链接）

```bash
$ file /bin/sh
/bin/sh: symbolic link to dash
```

查看系统 /etc/profile 文件类型（不显示文件名称）

```bash
$ file -b /etc/profile
ASCII text
```

查看当前用户主目录的文件类型

```bash
$ file $HOME
/home/rudy: directory
```

