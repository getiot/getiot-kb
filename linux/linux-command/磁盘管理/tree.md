---
sidebar_label: tree 命令
sidebar_position: 16
slug: /tree
---

# tree 命令 - 以树形结构显示目录



## 介绍

**tree** 命令以树状图列出目录的内容。执行 tree 指令，会列出指定目录下的所有文件，包括子目录里的文件。

**语法**：

```bash
tree [选项] [参数]
```

详细语法格式：

```bash
tree [-acdfghilnpqrstuvxACDFQNSUX]  [-L level [-R]] [-H baseHREF] 
     [-T title] [-o filename] [--nolinks] [-P pattern] [-I pattern]
     [--inodes] [--device] [--noreport] [--dirsfirst] [--version] 
     [--help] [--filelimit #] [--si] [--prune] [--du] [--timefmt  format]
     [--matchdirs] [--fromfile] [--] [directory ...]
```

**选项**：

- `-a` 显示所有文件和目录。
- `-A` 使用 ASNI 绘图字符显示树状图而非以 ASCII 字符组合。
- `-C` 在文件和目录清单加上色彩，便于区分各种类型。
- `-d` 显示目录名称而非内容。
- `-D` 列出文件或目录的更改时间。
- `-f` 在每个文件或目录之前，显示完整的相对路径名称。
- `-F` 在执行文件，目录，Socket，符号连接，管道名称名称，各自加上 "`*`"、"`/`"、"`=`"、"`@`"、"`|`" 号。
- `-g` 列出文件或目录的所属群组名称，没有对应的名称时，则显示群组识别码。
- `-i` 不以阶梯状列出文件或目录名称。
- `-L level` 限制目录显示层级。
- `-l` 如遇到性质为符号连接的目录，直接列出该连接所指向的原始目录。
- `-n` 不在文件和目录清单加上色彩。
- `-N` 直接列出文件和目录名称，包括控制字符。
- `-p` 列出权限标示。
- `-P <范本样式>` 只显示符合范本样式的文件或目录名称。
- `-q` 用 "`?`" 号取代控制字符，列出文件和目录名称。
- `-s` 列出文件或目录大小。
- `-t` 用文件和目录的更改时间排序。
- `-u` 列出文件或目录的拥有者名称，没有对应的名称时，则显示用户识别码。
- `-x` 将范围局限在现行的文件系统中，若指定目录下的某些子目录，其存放于另一个文件系统上，则将该子目录予以排除在寻找范围外。

**参数**：目录（可以是绝对路径或相对路径）。



## 示例

以树状图列出当前目录结构

```bash
$ tree
.
├── file
├── subdir1
│   ├── hello.txt
│   └── world.txt
└── subdir2
    ├── hello.txt
    └── world.txt

2 directories, 5 files
```

只显示一级目录

```bash
$ tree -L 1
.
├── file
├── subdir1
└── subdir2

2 directories, 1 file
```

