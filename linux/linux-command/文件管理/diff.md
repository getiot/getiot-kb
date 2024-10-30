---
sidebar_label: diff 命令
sidebar_position: 8
slug: /diff
---

# Linux diff 命令 - 比较文件差异



## 介绍

**diff**（英文全拼：different）命令用于在 Linux 系统中比较文件的差异。

diff 以逐行的方式，比较文本文件的异同处。如果指定要比较目录，则 diff 会比较目录中相同文件名的文件，但不会比较其中子目录。

**语法**：

```bash
diff [OPTION]... FILES
```

**选项**：

- `-a` ：diff 预设只会逐行比较文本文件。
- `-b` ：不检查空格字符的不同。
- `-W` ： 在使用 `-y` 参数时，指定栏宽。
- `-x` ： 不比较选项中所指定的文件或目录。
- `-X=<FILE>` ：您可以将文件或目录类型存成文本文件，指定此文本文件。
- `-y` ：以并列的方式显示文件的异同之处。
- `--help` ：查看帮助信息。
- `--left-column` ：在使用 `-y` 参数时，若两个文件某一行内容相同，则仅在左侧的栏位显示该行内容。
- `--suppress-common-lines` ：在使用 `-y` 参数时，仅显示不同之处。



## 示例

比较两个文件

```bash
diff testfile1 testfile2
```

比较两个文件，且以并排格式输出

```bash
diff testfile1 testfile2 -y -W 50
```

比较两个文件，将差异保存到另一个文件

```bash
diff testfile1 testfile2 > testfile.patch
```

