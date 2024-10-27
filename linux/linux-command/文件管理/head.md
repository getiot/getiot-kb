---
sidebar_label: head 命令
sidebar_position: 24
slug: /head
---

# head 命令



## 介绍

**head** 命令可用于查看文件的开头部分的内容，默认显示前 10 行的内容。

**语法**：

```bash
head [OPTION]... [FILE]...
```

**选项**：

- `-q` ：隐藏文件名。
- `-v` ：显示文件名。
- `-c`, `--bytes=[-]NUM` ：显示的字节数。
- `-n`, `--lines=[-]NUM` ：显示的行数。



## 示例

显示 getiot.log 文件的开头 10 行：

```bash
head getiot.log
```

显示 getiot.log 文件的开头 5 行：

```bash
head -n 5 getiot.log
```

显示 getiot.log 文件除最后 5 行外的其他所有内容：

```bash
head -n -5 getiot.log
```

显示 getiot.log 文件前 233 个字节：

```bash
head -c 233 getiot.log
```

