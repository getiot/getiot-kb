---
sidebar_position: 21
slug: /wc
---

# wc 命令



## 介绍

**wc**（英文全拼：word counts）命令统计指定文件中的字节数、字数、行数，并将统计结果显示输出。

**语法**：

```bash
wc [OPTION]... [FILE]...
```

**选项**：

- `-c`, `--bytes` ：只显示字节数。
- `-m`, `--chars` ：只显示字符数。
- `-l`, `--lines` ：显示行数。
- `-w`, `--words` ：只显示字数。
- `--help` ：在线帮助。
- `--version` ：显示版本信息。



## 示例

统计文件字数：

```bash
wc -w test.txt 
```

统计文件字节数：

```bash
wc -c test.txt 
```

统计文件字符数：

```bash
wc -m test.txt 
```

统计文件行数：

```bash
wc -l test.txt 
```

打印最长行的长度：

```bash
wc -L test.txt
```

统计当前目录下的文件和目录总数：

```bash
ls | wc -w
```

