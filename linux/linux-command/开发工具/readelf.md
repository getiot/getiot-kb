---
sidebar_label: readelf 命令
sidebar_position: 5
slug: /readelf
---

# Linux readelf 命令 - 显示 ELF 文件信息



## 介绍

**readelf** 命令用于显示一个或者多个 ELF 格式目标文件的信息。可以支持 32 位或 64 位的 elf 格式文件，也支持包含 elf 文件的文档（这里一般指的是使用 ar 命令将一些 elf 文件打包之后生成的例如 lib*.a 之类的静态库文件）。

readelf 和 [objdump](/linux-command/objdump) 提供的功能类似，但是它显示的信息更为具体，并且它不依赖 BFD 库（BFD 库是一个 GNU 项目，它的目标就是希望通过一种统一的接口来处理不同的目标文件），所以即使 BFD 库有什么 bug 存在的话也不会影响到 readelf 程序。

**语法**

```shell
readelf <options> elf-file ...
```

**选项**

- `-a`, `--all` ：显示全部信息，等价于 -h -l -S -s -r -d -V -A -I。
- `-h`, `--file-header` ：显示 ELF 文件开始的文件头信息。
- `-l`, `--program-headers` ：显示程序头（段头）信息（如果有的话）。
- `--segments` ：是 --program-headers 的别名。
- `-S`, `--section-headers` ：显示节头信息（如果有的话）。
- `--sections` ：是 --section-headers 的别名。
- `-g`, `--section-groups` ：显示节组信息（如果有的话）。
- `-t`, `--section-details` ：显示节的详细信息（-S 的）。
- `-e`, `--headers` ：显示全部头信息，等价于 -h -l -S。
- `-s`, `--syms` ：显示符号表段中的项（如果有的话）。
- `--symbols` ：是 --syms 的别名。
- `-n`, `--notes` ：显示 note 段（内核注释）的信息。
- `-r`, `--relocs` ：显示可重定位段的信息。
- `-u`, `--unwind` ：显示 unwind 段信息。当前只支持 IA64 ELF 的 unwind 段信息。
- `-d`, `--dynamic` ：显示动态段的信息。
- `-V`, `--version-info` ：显示版本段的信息。
- `-A`, `--arch-specific` ：显示 CPU 构架信息。
- `-D`, `--use-dynamic` ：使用动态段中的符号表显示符号，而不是使用符号段。
- `-x`, `--hex-dump=<number|name>` ：以十六进制方式显示指定段内内容。number 指定段表中段的索引，或字符串指定文件中的段名。
- `-p`, `--string-dump=<number|name>` ：以字符串方式显示指定段内内容。number 指定段表中段的索引，或字符串指定文件中的段名。
- `-R`, `--relocated-dump=<number|name>` ：以重定位字节方式显示指定段内内容。number 指定段表中段的索引，或字符串指定文件中的段名。
- `-w[lLiaprmfFsoRtUuTgAckK]` ：显示调试段中指定的内容。 
- `-I`, `--histogram` ：显示符号的时候，显示 bucket list 长度的柱状图。
- `-W`, `--wide` ：宽行输出。
- `-H`, `--help` ：显示帮助信息。
- `-v`, `--version` ：显示版本信息。



## 示例

读取可执行文件 a.out 的 ELF 文件头信息

```shell
$ readelf -h a.out
ELF 头：
  Magic：   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  类别:                              ELF64
  数据:                              2 补码，小端序 (little endian)
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI 版本:                          0
  类型:                              EXEC (可执行文件)
  系统架构:                          Advanced Micro Devices X86-64
  版本:                              0x1
  入口点地址：               0x401040
  程序头起点：          64 (bytes into file)
  Start of section headers:          15288 (bytes into file)
  标志：             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         11
  Size of section headers:           64 (bytes)
  Number of section headers:         29
  Section header string table index: 28
```

读取目标文件 ldal.o 的 ELF 文件头信息

```shell
$ readelf -h ldal.o
ELF 头：
  Magic：   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  类别:                              ELF64
  数据:                              2 补码，小端序 (little endian)
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI 版本:                          0
  类型:                              REL (可重定位文件)
  系统架构:                          Advanced Micro Devices X86-64
  版本:                              0x1
  入口点地址：               0x0
  程序头起点：          0 (bytes into file)
  Start of section headers:          25320 (bytes into file)
  标志：             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           0 (bytes)
  Number of program headers:         0
  Size of section headers:           64 (bytes)
  Number of section headers:         26
  Section header string table index: 25
```

读取共享库文件 libldal.so 的 ELF 文件头信息

```shell
$ readelf -h libldal.so
ELF 头：
  Magic：   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  类别:                              ELF64
  数据:                              2 补码，小端序 (little endian)
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI 版本:                          0
  类型:                              DYN (共享目标文件)
  系统架构:                          Advanced Micro Devices X86-64
  版本:                              0x1
  入口点地址：               0x6140
  程序头起点：          64 (bytes into file)
  Start of section headers:          226976 (bytes into file)
  标志：             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         11
  Size of section headers:           64 (bytes)
  Number of section headers:         36
  Section header string table index: 35
```

查看可执行文件 a.out 的 ELF 文件程序头表信息

```shell
$ readelf -l a.out

Elf 文件类型为 EXEC (可执行文件)
Entry point 0x401040
There are 11 program headers, starting at offset 64

程序头：
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  PHDR           0x0000000000000040 0x0000000000400040 0x0000000000400040
                 0x0000000000000268 0x0000000000000268  R      0x8
  INTERP         0x00000000000002a8 0x00000000004002a8 0x00000000004002a8
                 0x000000000000001c 0x000000000000001c  R      0x1
      [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]
  LOAD           0x0000000000000000 0x0000000000400000 0x0000000000400000
                 0x0000000000000438 0x0000000000000438  R      0x1000
  LOAD           0x0000000000001000 0x0000000000401000 0x0000000000401000
                 0x00000000000004a5 0x00000000000004a5  R E    0x1000
  LOAD           0x0000000000002000 0x0000000000402000 0x0000000000402000
                 0x0000000000000258 0x0000000000000258  R      0x1000
  LOAD           0x0000000000002e10 0x0000000000403e10 0x0000000000403e10
                 0x0000000000000420 0x0000000000000428  RW     0x1000
  DYNAMIC        0x0000000000002e20 0x0000000000403e20 0x0000000000403e20
                 0x00000000000001d0 0x00000000000001d0  RW     0x8
  NOTE           0x00000000000002c4 0x00000000004002c4 0x00000000004002c4
                 0x0000000000000044 0x0000000000000044  R      0x4
  GNU_EH_FRAME   0x00000000000020e0 0x00000000004020e0 0x00000000004020e0
                 0x000000000000004c 0x000000000000004c  R      0x4
  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000  RW     0x10
  GNU_RELRO      0x0000000000002e10 0x0000000000403e10 0x0000000000403e10
                 0x00000000000001f0 0x00000000000001f0  R      0x1

 Section to Segment mapping:
  段节...
   00
   01     .interp
   02     .interp .note.gnu.build-id .note.ABI-tag .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt
   03     .init .plt .text .fini
   04     .rodata .eh_frame_hdr .eh_frame
   05     .init_array .fini_array .dynamic .got .got.plt .data .bss
   06     .dynamic
   07     .note.gnu.build-id .note.ABI-tag
   08     .eh_frame_hdr
   09
   10     .init_array .fini_array .dynamic .got
```

显示 a.out 文件中的所有段，即查看段表

```shell
$ readelf -S a.out
There are 29 section headers, starting at offset 0x3bb8:

节头：
  [号] 名称              类型             地址              偏移量
       大小              全体大小          旗标   链接   信息   对齐
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .interp           PROGBITS         00000000004002a8  000002a8
       000000000000001c  0000000000000000   A       0     0     1
  [ 2] .note.gnu.build-i NOTE             00000000004002c4  000002c4
       0000000000000024  0000000000000000   A       0     0     4
  [ 3] .note.ABI-tag     NOTE             00000000004002e8  000002e8
       0000000000000020  0000000000000000   A       0     0     4
  [ 4] .gnu.hash         GNU_HASH         0000000000400308  00000308
       000000000000001c  0000000000000000   A       5     0     8
  [ 5] .dynsym           DYNSYM           0000000000400328  00000328
       0000000000000060  0000000000000018   A       6     1     8
  [ 6] .dynstr           STRTAB           0000000000400388  00000388
       000000000000003f  0000000000000000   A       0     0     1
  ......
```

