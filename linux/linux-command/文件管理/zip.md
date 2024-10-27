---
sidebar_label: zip 命令
sidebar_position: 29
slug: /zip
---

# zip 命令



## 介绍

**zip** 命令用于打包和压缩文件，压缩后的文件后缀名为 .zip。

zip 命令可以将一个或多个压缩文件与有关文件的信息（名称、路径、日期、上次修改的时间、保护和检查信息以验证文件完整性）一起放入一个压缩存档中。

**语法**：

```bash
zip [-options] [-b path] [-t mmddyyyy] [-n suffixes] [zipfile list] [-xi list]
```

**选项**：

- `-q` ：不显示指令执行过程。
- `-r` ：递归处理，将指定目录下的所有文件和子目录一并处理。
- `-z`, `--archive-comment` ：替压缩文件加上注释。
- `-v`, `--verbose` ：显示指令执行过程。
- `-n`, `--suffixes <suffixes>` ：不压缩具有特定字尾字符串的文件。
- `-sf`, `--show-files` ：显示压缩包中的文件。



## 示例

假设当前目录下有一个 test 目录，里面有两个文件：

```bash
test/
├── hello.c
└── world.c
```

将 test 目录下所有文件（和文件夹）打包为当前目录下的 test.zip：

```bash
$ zip -q -r test.zip test
```

不解压直接查看压缩包中的内容：

```bash
$ zip -sf test.zip 
Archive contains:
  test/
  test/world.c
  test/hello.c
Total 3 entries (12 bytes)
```

