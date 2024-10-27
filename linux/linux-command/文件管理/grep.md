---
sidebar_label: grep 命令
sidebar_position: 11
slug: /grep
---

# grep 命令



## 介绍

**grep**（英文全拼：Global Regular Expression Print）命令是一个强大的文本搜索工具，它能使用正则表达式搜索文本，并把匹配的行打印出来。

grep 的工作方式是在一个或多个文件中搜索字符串模板，如果模板包括空格，则必须被引用，模板后的所有字符串被看作文件名。搜索的结果被送到标准输出，不影响原文件内容。在 shell 脚本中常常使用 grep 命令进行一些自动化的文本处理工作。

相关命令：egrep、fgrep、rgrep

**语法**：

```bash
grep [OPTION...] PATTERNS [FILE...]
grep [OPTION...] -e PATTERNS ... [FILE...]
grep [OPTION...] -f PATTERN_FILE ... [FILE...]
```

**选项**：

- `-a`, `--text` ：不要忽略二进制的数据。
- `-b`, `--byte-offset` ：在显示符合样式的那一行之前，标示出该行第一个字符的编号。
- `-c`, `--count` ：计算符合样式的列数。
- `-A`, `--after-context=NUM` ：除了显示符合范本样式的那一列之外，并显示该行之后的内容。
- `-B`, `--before-context=NUM` ：除了显示符合样式的那一行之外，并显示该行之前的内容。
- `-C`, `--context=NUM` ：除了显示符合样式的那一行之外，并显示该行之前后的内容。
- `-d`, `--directories=ACTION` ：当指定要查找的是目录而非文件时，必须使用这项参数，否则 grep 指令将回报信息并停止动作。
- `-e`, `--regexp=PATTERNS` ：指定字符串做为查找文件内容的样式。
- `-f`, `--file=FILE` ：指定规则文件，其内容含有一个或多个规则样式，让 grep 查找符合规则条件的文件内容，格式为每行一个规则样式。
- `-E`, `--extended-regexp` ：将样式为延伸的正则表达式来使用。
- `-F`, `--fixed-regexp` ：将样式视为固定字符串的列表。
- `-G`, `--basic-regexp` ：将样式视为普通的表示法来使用。
- `-h`, `--no-filename` ：在显示符合样式的那一行之前，不标示该行所属的文件名称。
- `-H`, `--with-filename` ：在显示符合样式的那一行之前，表示该行所属的文件名称。
- `-i`, `--ignore-case` ：忽略字符大小写的差别。
- `-l`, `--file-with-matches` ：列出文件内容符合指定的样式的文件名称。
- `-L`, `--files-without-match` ：列出文件内容不符合指定的样式的文件名称。
- `-n`, `--line-number` ：在显示符合样式的那一行之前，标示出该行的列数编号。
- `-o`, `--only-matching` ：只显示匹配 PATTERN 部分。
- `-q`, `--quiet`, `--silent` ：不显示任何信息。
- `-r`, `--recursive` ：递归查找指定目录下的所有文件。
- `-s`, `--no-messages` : 不显示错误信息。
- `-v`, `--invert-match` ：显示不包含匹配文本的所有行。
- `-w`, `--word-regexp` ：只显示全字符合的列。
- `-x`, `--line-regexp` ：只显示全列符合的列。
- `-V`, `--version` ：显示版本信息。



## 示例

### 查找进程

查找指定进程（init 进程）

```bash
ps -ef | grep init
```

查找指定进程个数

```bash
ps -ef | grep init -c
```

查找指定进程，但不显示 grep 查找进程本身

```bash
ps -ef | grep init | grep -v "grep"
```

### 查找文件内容

假设文件 dialogue.txt 内容如下：

```bash
Rudy: Hello, Welcome to getiot.tech website.
Tina: Hello, Rudy. That is so cool.
Rudy: Thanks, I'm so glad you like it.
Tina: Of courses, I've subscribed it.
```

keywords.txt 文件保存关键字：

```bash
getiot
hello
```

从文件中读取关键词进行搜索

```bash
cat dialogue.txt | grep -f keywords.txt
```

从文件中读取关键词进行搜索，并显示行号

```bash
cat dialogue.txt | grep -nf keywords.txt
```

从文件中查找关键词 getiot

```bash
grep "getiot" dialogue.txt
```

从文件中查找关键词 hello（不区分大小写）

```bash
grep -i "hello" dialogue.txt
```

从当前目录中递归查找关键词，并显示行号

```bash
grep -rn "getiot" ./*
```

找出以 R 开头的行内容

```bash
cat dialogue.txt | grep ^R
```

输出非 R 开头的行内容

```bash
cat dialogue.txt | grep ^[^R]
```

输出以 it. 结尾的行内容

```bash
cat dialogue.txt | grep it.$
```

显示包含 so 或者 to 字符的内容行

```bash
cat dialogue.txt | grep -E "so|to"
```

