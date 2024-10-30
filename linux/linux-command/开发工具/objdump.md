---
sidebar_label: objdump 命令
sidebar_position: 4
slug: /objdump
---

# objdump 命令 - 显示目标文件信息



## 介绍

**objdump** 命令用于显示二进制目标文件的信息，也就是以一种可阅读的格式让开发者更多地了解二进制文件可能带有的附加信息。它是 GNU Binutils 工具集中的一个命令。

**语法**：

```bash
objdump <options> <file>
```

**选项**：

- `-a`, `--archive-headers` ：显示档案库的成员信息，类似 `ls -l` 将 lib*.a 的信息列出。 
- `-b`, `--target=BFDNAME` ：指定目标码格式。这不是必须的，objdump 能自动识别许多格式。
- `-C`, `--demangle[=STYLE]` ：将底层的符号名解码成用户级名字，除了去掉所开头的下划线之外，还使得 C++ 函数名以可理解的方式显示出来。 
- `-d`, `--disassemble` ：反汇编可执行的 section 内容。
- `-D`, `--disassemble-all` ：反汇编所有 section 内容。
- `-e`, `--debugging-tags` ：类似 -g 选项，但是生成的信息是和 ctags 工具相兼容的格式。
- `-f`, `--file-headers` ：显示文件头信息。
- `-g`, `--debugging` ：显示调试信息。企图解析保存在文件中的调试信息并以 C 语言的语法显示出来。仅仅支持某些类型的调试信息。有些其他的格式被 `readelf -w` 支持。 
- `-h`, `--[section-]headers` ：显示目标文件各个 section 的头部摘要信息。
- `-i`, `--info` ：显示对于 -b 或者 -m 选项可用的架构和目标格式列表。
- `-j`, `--section=NAME` ：仅仅显示指定名称为 name 的 section 的信息。
- `-m`, `--architecture=MACHINE` ：指定反汇编目标文件时使用的架构，当待反汇编文件本身没描述架构信息的时候（比如 S-records），这个选项很有用。可以用 -i 选项列出这里能够指定的架构。
- `-r`, `--reloc` ：显示文件的重定位入口。如果和 -d 或者 -D 一起使用，重定位部分以反汇编后的格式显示出来。
- `-R`, `--dynamic-reloc` ：显示文件的动态重定位入口，仅仅对于动态目标文件有意义，比如某些共享库。
- `-s`, `--full-contents` ：显示指定 section 的完整内容。默认所有的非空 section 都会被显示。 
- `-S`, `--source` ：尽可能反汇编出源代码，尤其当编译的时候指定了-g 这种调试参数时，效果比较明显。隐含了-d 参数。
- `--start-address=ADDR` ：从指定地址开始显示数据，该选项影响 -d、-r 和 -s 选项的输出。
- `--stop-address=ADDR` ：显示数据直到指定地址为止，该项影响 -d、-r 和 -s 选项的输出。
- `-t`, `--syms` ：显示文件的符号表入口。类似于 `nm -s` 提供的信息。
- `-T`, `--dynamic-syms` ：显示文件的动态符号表入口，仅仅对动态目标文件意义，比如某些共享库。它显示的信息类似于 `nm -D|--dynamic` 显示的信息。 
- `-x`, `--all-headers` ：显示所有可用的头信息，包括符号表、重定位入口。-x 等价于 -a -f -h -r -t 同时指定。
- `-z`, `--disassemble-zeroes` ：一般反汇编输出将省略大块的零，该选项使得这些零块也被反汇编。 
- `-H`, `--help` ：显示帮助信息。
- `-v`, `--version` ：显示版本信息。



## 示例

查看本机目标结构（使用大端还是小端存储）

```bash
objdump -i
```

查看所有的符号以及它们所在段（显示符号表入口）

```bash
objdump -t main.o
```

打印主要段的信息

```bash
objdump -h main.o
```

打印更多的详细信息

```bash
objdump -x main.o
```

将所有段的内容以十六进制方式打印出来

```bash
objdump -s main.o
```

显示 main.o 文件中的 text 段的内容

```bash
objdump --section=.text -s main.o
```

将所有包含指令的段反汇编

```bash
objdump -d main.o
```





