---
sidebar_position: 7
sidebar_label: 获取帮助
slug: /linux-getting-help
---

# 获取帮助：man、--help 与 info

Linux 命令太多，不可能全靠记忆。真正熟练的用户并不是把所有参数背下来，而是知道如何快速找到可靠帮助。

这一篇会教你使用 `--help`、[man](/linux-command/man/)、[info](/linux-command/info/)、[whatis](/linux-command/whatis/)、[which](/linux-command/which/) 和 [type](/linux-command/type/)。

## 先用 --help

很多命令都支持 `--help`：

```bash
ls --help
```

它通常会显示：

- 命令用途
- 常用选项
- 参数格式
- 退出状态

`--help` 适合快速查选项。比如你忘了 `ls` 如何显示隐藏文件，可以运行：

```bash
ls --help | grep hidden
```

这里用到了管道和 [grep](/linux-command/grep/)，后面的命令行章节会详细讲。

## 使用 man 手册

`man` 是 manual 的缩写，也就是手册页。你可以这样查看 `ls` 的手册：

```bash
man ls
```

进入手册后，常用按键是：

| 按键 | 作用 |
| --- | --- |
| 空格 | 向下翻一页 |
| `b` | 向上翻一页 |
| `/word` | 搜索 `word` |
| `n` | 跳到下一个搜索结果 |
| `q` | 退出 |

手册页通常比较完整，但一开始看会觉得密。你可以先重点读这些部分：

- NAME：命令名称和一句话说明。
- SYNOPSIS：命令格式。
- DESCRIPTION：详细说明。
- OPTIONS：选项列表。
- EXAMPLES：示例，有些手册页会提供。

## 看懂命令格式

手册中的命令格式经常长这样：

```text
ls [OPTION]... [FILE]...
```

你可以这样读：

- `ls` 是命令本身。
- 方括号表示可选内容。
- `OPTION` 表示选项。
- `FILE` 表示文件或目录参数。
- `...` 表示可以出现多次。

所以 `ls` 可以不带参数，也可以带一个或多个文件目录：

```bash
ls
ls /etc
ls /etc /var/log
```

## man 的章节

有些名字可能既是命令，也是函数或配置文件。`man` 用章节区分它们：

| 章节 | 内容 |
| --- | --- |
| 1 | 用户命令 |
| 2 | 系统调用 |
| 3 | 库函数 |
| 5 | 文件格式和配置文件 |
| 8 | 系统管理命令 |

例如：

```bash
man 1 printf
man 3 printf
```

第一条看命令，第二条看 C 标准库函数。

## 使用 whatis 快速确认

如果你只想知道一个命令大概是什么，可以用 [whatis](/linux-command/whatis/)：

```bash
whatis ls
```

输出通常类似：

```text
ls (1) - list directory contents
```

这能帮助你判断自己找的是不是目标命令。

## 使用 which、type 和 whereis

如果你想知道命令来自哪里，可以用：

```bash
which ls
type cd
whereis ls
```

它们关注点不同：

- [which](/linux-command/which/)：查找可执行文件路径。
- [type](/linux-command/type/)：判断命令是外部程序、Shell 内建命令还是别名。
- [whereis](/linux-command/whereis/)：查找程序、源码和手册页位置。

比如 `cd` 通常是 Shell 内建命令，所以 `type cd` 比 `which cd` 更有解释力。

## 使用 info

[info](/linux-command/info/) 是 GNU 项目常用的文档系统。部分 GNU 工具的 `info` 文档比 `man` 更详细：

```bash
info coreutils
```

如果你只是查一个命令选项，`--help` 和 `man` 通常更快；如果你想系统阅读某个工具集，`info` 更适合。

## 从错误信息开始

很多初学者一看到报错就慌，其实报错是线索。比如：

```text
Permission denied
```

说明权限不足，可能需要检查文件权限、执行权限、目录权限或是否需要 `sudo`。

再比如：

```text
No such file or directory
```

通常是路径写错、当前目录不对，或目标文件尚未创建。

遇到错误时，你可以按这个顺序处理：

1. 复制错误信息的关键句。
2. 看命令是否拼错。
3. 用 `pwd` 和 `ls` 检查路径。
4. 用 `命令 --help` 或 `man 命令` 查参数。
5. 再去搜索资料。

## 小结

你不需要背下所有命令参数，但需要学会查：

- `命令 --help`：最快速。
- `man 命令`：最常用。
- `info 命令`：适合 GNU 工具的系统文档。
- `whatis 命令`：快速了解命令用途。
- `type 命令`：判断命令类型。
- `which 命令`：查看外部命令路径。

下一章开始，你会真正进入命令行操作。
