---
sidebar_label: sed 命令
sidebar_position: 23
slug: /sed
---

# Linux sed 命令 - 流编辑器



## 介绍

**sed**（流编辑器）是一个在 Linux 和 Unix 系统上广泛使用的文本处理工具。它允许用户通过脚本或命令行对文本进行基本的编辑和转换。sed 主要用于处理文本流，它可以从输入流中读取文本，对文本进行处理，并将处理后的文本送到输出流。sed 命令在文本处理和脚本编程中非常有用，可以通过组合多个命令来执行复杂的文本编辑任务。

**语法**：

```bash
sed [选项]... '动作' [输入文件]...
```

**选项**：

- `-n, --quiet, --silent`：禁止默认输出，只有经过处理的行才会输出。
- `--debug`：对程序运行进行标注。
- `-e 脚本, --expression=脚本`：允许多个编辑命令，添加“脚本”到程序的运行列表。
- `-f 脚本文件, --file=脚本文件`：添加“脚本文件”到程序的运行列表。
- `--follow-symlinks`：直接修改文件时跟随软链接。
- `-i[扩展名], --in-place[=扩展名]`：直接修改文件内容，而不是输出到标准输出（如果指定扩展名则备份文件）。
- `-l N, --line-length=N`：指定 `l` 命令的换行期望长度。
- `--posix`：关闭所有 GNU 扩展。
- `-E, -r, --regexp-extended`：在脚本中使用扩展正则表达式（为保证可移植性使用 `POSIX -E`）。
- `-s, --separate`：将输入文件视为各个独立的文件而不是单个长的连续输入流。
- `--sandbox`：在沙盒模式中进行操作（禁用 e/r/w 命令）。
- `-u, --unbuffered`：从输入文件读取最少的数据，更频繁的刷新输出。
- `-z, --null-data`：使用 NUL 字符分隔各行。
- `--help`：打印帮助并退出。
- `--version`：输出版本信息并退出。

动作通常以单引号括起来，其中包含一个或多个 `sed` 命令，如替换、删除、添加等。

- `a`：新增，a 的后面可以接字串，而这些字串会在新的一行出现（目前的下一行）。
- `c`：取代，c 的后面可以接字串，这些字串可以取代 `n1,n2` 之间的行。
- `d`：删除，后面通常不接任何字串。
- `i`：插入，i 的后面可以接字串，这些字串会在新的一行出现（目前的上一行）。
- `p`：打印，亦即将某个选择的数据印出。通常会与参数 `sed -n` 一起运行。
- `s`：取代，可以直接进行取代的工作，通常这个 s 的动作可以搭配正则表达式，例如 `1,20s/old/new/g`。



## 示例

在文件中查找 `old_text` 并将其替换为 `new_text`：

```bash
sed 's/old_text/new_text/' filename
```

删除包含指定模式（`pattern`）的行：

```bash
sed '/pattern/d' filename
```

只显示包含指定模式的行：

```bash
sed -n '/pattern/p' filename
```

分别在第 3 行之前和之后添加新行：

```bash
sed '3i\New line before the 3rd line' filename
sed '3a\New line after the 3rd line' filename
```

直接修改文件内容，而不是在标准输出中显示结果：

```bash
sed -i 's/old_text/new_text/' filename
```

需要注意的是，sed 不会修改原始文件，除非使用 `-i` 选项。

