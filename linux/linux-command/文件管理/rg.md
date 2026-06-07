---
sidebar_label: rg 命令
sidebar_position: 35
slug: /rg
---

# Linux rg 命令 - 快速递归搜索文本



## 介绍

**rg**（ripgrep）是一个高性能的文本搜索工具，用于在目录中递归搜索匹配正则表达式的行。相比传统 [grep](/linux-command/grep/)，`rg` 默认自动跳过隐藏文件、二进制文件，并尊重 `.gitignore` 规则，搜索速度更快，适合在大型代码库中日常使用。

rg 命令由 ripgrep 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install ripgrep
```

**语法**：

```bash
rg [OPTIONS] PATTERN [PATH ...]
rg [OPTIONS] -e PATTERN ... [PATH ...]
rg [OPTIONS] -f PATTERNFILE ... [PATH ...]
rg [OPTIONS] --files [PATH ...]
```

**常用选项**：

- `-e, --regexp=PATTERN`：指定搜索模式（可多次使用）
- `-f, --file=PATTERNFILE`：从文件读取搜索模式，每行一个
- `-i, --ignore-case`：忽略大小写
- `-w, --word-regexp`：只匹配完整单词
- `-v, --invert-match`：反向匹配，显示不包含模式的行
- `-c, --count`：只显示每个文件的匹配行数
- `-l, --files-with-matches`：只显示包含匹配的文件名
- `-L, --files-without-match`：只显示不包含匹配的文件名
- `-n, --line-number`：显示行号
- `-o, --only-matching`：只输出匹配的部分
- `-A, --after-context=NUM`：显示匹配行之后的 NUM 行
- `-B, --before-context=NUM`：显示匹配行之前的 NUM 行
- `-C, --context=NUM`：显示匹配行前后各 NUM 行
- `-t, --type=TYPE`：只搜索指定类型的文件（如 `py`、`rust`、`md`）
- `-g, --glob=GLOB`：按 glob 模式过滤文件
- `-F, --fixed-strings`：将模式视为固定字符串，而非正则
- `-r, --replace=TEXT`：将匹配内容替换为 TEXT 后输出
- `--files`：列出将要搜索的文件，不执行搜索
- `-h, --help`：显示帮助
- `-V, --version`：显示版本

相关命令：[grep](/linux-command/grep/)、[awk](/linux-command/awk/)、[sed](/linux-command/sed/)



## 示例

1、在当前目录递归搜索包含 `TODO` 的行：

```bash
rg TODO
```

2、在指定目录搜索，忽略大小写：

```bash
rg -i error /var/log/
```

3、只搜索 Python 文件中的函数定义：

```bash
rg -t py "^def "
```

4、显示匹配行号及前后 3 行上下文：

```bash
rg -n -C 3 "main\(" src/
```

5、只列出包含匹配的文件名：

```bash
rg -l "import numpy" .
```

6、搜索以 `-` 开头的字面字符串：

```bash
rg -- -foo
```

7、统计每个文件的匹配次数：

```bash
rg -c "printf" *.c
```

8、排除特定目录：

```bash
rg "pattern" -g '!node_modules' -g '!build'
```
