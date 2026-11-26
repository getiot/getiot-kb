---
sidebar_position: 14
---

# Linux 查看二进制文件



本文介绍在 Linux 系统中查看或编辑二进制文件的几种方法，包括使用 vim 编辑器，使用 hexdump、xxd、od 命令等。



## 使用 Vim 编辑器

以二进制模式打开文件：

```bash
vim -b <your_binary_file>
```

按 `:` 进入 vim 尾行模式，输入如下命令：

```bash
%!xdd -g 1
```

这样就会以十六进制形式显示该二进制文件的内容。



## 使用 hexdump 命令

`hexdump` 是一个用于查看二进制文件的命令行工具，它可以将二进制文件转换成十六进制的格式并打印出来。

```bash
hexdump <your_binary_file>
```

此外，`hexdump` 还提供了各种选项实现数据格式的转换，例如以 `ASCII` 格式显示：

```bash
hexdump -C <your_binary_file>
```

`-b`选项会将所有数据以单字节为单位转换为八进制的格式显示：

```bash
hexdump -b <your_binary_file>
```



## 使用 xxd 命令

`xxd` 命令的效果与 `hexdump -C` 输出的格式类似，打印的结果包含地址，十六进制格式和字符格式（单字节为单位）。

```bash
xxd <your_binary_file>
```



## 使用 od 命令

`od` 命令与 `xxd` 和 `hexdump` 命令有所区别，它的显示格式与前两者不同，通过 `od` 命令可以打印出二进制文件的十六进制格式和十进制的格式。

```bash
od -tx1 -tc -Ax <your_binary_file>
```

选项参数说明：

- `-tx1` 表示将文件中的字节以十六进制的形式列出来，每组一个字节（类似 `hexdump` 的 `-c` 选项）。
- `-tc` 表示将文件中的 ASCII 码以字符形式列出来（和 `hexdump` 类似，输出结果最左边的一列是文件中的地址，默认以八进制显示）。
- `-Ax` 表示以十六进制显示文件中的地址。

