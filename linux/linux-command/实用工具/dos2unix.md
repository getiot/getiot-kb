---
sidebar_label: dos2unix 命令
sidebar_position: 4
slug: /dos2unix
---

# Linux dos2unix 命令 - 转换文本文件格式



## 介绍

**dos2unix** 是一个 DOS/Mac - Unix 文件格式转换器。

Windows 格式文件的换行符是 `\r\n`，而 Linux 使用的换行符是 `\n`。dos2unix 命令其实就是将文件中的 `\r\n` 转换为 `\n`。

Dos2unix 软件包包括两个工具 —— dos2unix 和 unix2dos，用于将纯文本文件在 DOS 或 Mac 格式与 Unix 格式之间相互转换。在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install dos2unix
```

**语法**：

```bash
dos2unix [options] [file ...] [-n infile outfile ...]
```

**选项**：

- `--allow-chown` ：允许修改文件所有者。
- `-ascii` ：只转换换行符（默认）。
- `-iso` ：在 DOS 和 ISO-8859-1 字符集之间转换。
- `-7` ：转换 8 位字符到 7 位空间。
- `-b`, `--keep-bom` ：保留 UTF-8 BOM 头。
- `-c`, `--convmode <convmode>` ：转换模式 convmode 包括 ascii、7bit、iso 或 mac，默认为 ascii。
- `-f`, `--force` ：强制转换二进制文件。
- `-h`, `--help` ：显示本说明文字
- `-i`, `--info[=FLAGS] <file>` ：显示文件信息，file 是需要分析的文件。
- `-k`, `--keepdate` ：保留输出文件时间。
- `-L`, `--license` ：显示软件协议。
- `-l`, `--newline` ：加入额外的换行符。
- `-m`, `--add-bom` ：添加 UTF-8 BOM头（默认为UTF-8）。
- `-n`, `--newfile <infile> <outfile>` ：写入新文件，infile 为新文件模式中的原始文件，outfile 为新文件模式中的输出文件。
- `--no-allow-chown` ：不允许修改文件所有者（默认选项）。
- `-o`, `--oldfile <file>` ：写入原文件（默认），file 为旧文件模式中要转换的文件。
- `-q`, `--quiet` ：安静模式，不显示所有警告。
- `-r`, `--remove-bom` ：移除 UTF-8 BOM 头（默认）。
- `-s`, `--safe` ：跳过二进制文件（默认）。
- `-u`,  `--keep-utf16` ：保留 UTF-16 编码。
- `-ul`, `--assume-utf16le` ：假定输入文件格式为 UTF-16LE。
- `-ub`, `--assume-utf16be` ：假定输入文件格式为 UTF-16BE。
- `-v`,  `--verbose` ：显示更多信息。
- `-F`, `--follow-symlink` ：根据符号链接转换其目标文件。
- `-R`, `--replace-symlink` ：取代符号链接为转换后的文件（原链接目标文件保持不变）。
- `-S`, `--skip-symlink` ：保持符号链接及其目标不变（默认）。
- `-V`, `--version` ：显示版本号。



## 示例

在源文件基础上将此文件从 dos 格式转换为 unix 格式

```bash
dos2unix book.csv
```

保留源文件

```bash
dos2unix -n book.csv newbook.csv
```

不改变转换后文件的时间戳

```bash
dos2unix -k book.csv
```

静默转换

```bash
dos2unix -q book.csv
```

