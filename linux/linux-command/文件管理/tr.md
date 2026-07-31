---
sidebar_label: tr 命令
sidebar_position: 36
slug: /tr
description: "tr（translate）命令用于从标准输入读取数据，对字符进行转换、压缩或删除，然后输出到标准输出。常用于大小写转换、删除不可见字符、替换分隔符等文本处理任务，常与管道配合使用。"
---

# Linux tr 命令 - 转换或删除字符



## 介绍

**tr**（translate）命令用于从标准输入读取数据，对字符进行转换、压缩或删除，然后输出到标准输出。常用于大小写转换、删除不可见字符、替换分隔符等文本处理任务，常与管道配合使用。

tr 命令由 GNU coreutils 软件包提供，通常系统已预装。

**语法**：

```bash
tr [选项]... SET1 [SET2]
```

**选项**：

- `-c, -C, --complement`：使用 SET1 的补集
- `-d, --delete`：删除 SET1 中出现的字符，不做转换
- `-s, --squeeze-repeats`：将 SET1 中列出的连续重复字符压缩为一个
- `-t, --truncate-set1`：先将 SET1 截断为 SET2 的长度再转换
- `--help`：显示帮助
- `--version`：显示版本

**字符集（SET）说明**：

- `\n`、`\r`、`\t` 等：转义字符
- `字符1-字符2`：字符范围
- `[:alnum:]`：所有字母和数字
- `[:alpha:]`：所有字母
- `[:digit:]`：所有数字
- `[:lower:]`：所有小写字母
- `[:upper:]`：所有大写字母
- `[:blank:]`：水平空白字符
- `[:space:]`：所有空白字符

相关命令：[sed](/linux-command/sed/)、[awk](/linux-command/awk/)、[grep](/linux-command/grep/)



## 示例

1、将小写字母转换为大写：

```bash
echo "hello world" | tr '[:lower:]' '[:upper:]'
```

2、删除文件中的回车符（Windows 换行转 Unix）：

```bash
tr -d '\r' < file.txt > file_unix.txt
```

3、将空格替换为换行（单词逐行输出）：

```bash
echo "one two three" | tr ' ' '\n'
```

4、压缩连续的空格为一个：

```bash
echo "a    b   c" | tr -s ' '
```

5、删除所有数字：

```bash
echo "abc123def456" | tr -d '[:digit:]'
```

6、删除除字母和换行以外的字符：

```bash
tr -cd '[:alpha:]\n' < input.txt > output.txt
```

7、交换冒号和等号（解析特殊格式）：

```bash
echo "key:value" | tr ':' '='
```
