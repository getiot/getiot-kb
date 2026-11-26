---
sidebar_position: 7
sidebar_label: 通配符与快捷键
slug: /linux-wildcards-shortcuts
---

# Linux 通配符与常用快捷键

你在命令行中经常需要一次处理多个文件。通配符可以帮你用一个模式匹配一批文件；快捷键则能让你少敲很多字。

## 通配符不是正则表达式

Shell 通配符也叫 glob。它由 Shell 展开，然后再把展开后的文件名交给命令。

正则表达式通常由 `grep`、`sed`、`awk` 等程序解释。二者相似，但不是同一套规则。

举个例子：

```bash
ls *.txt
```

这里的 `*.txt` 会先被 Shell 展开成当前目录下所有以 `.txt` 结尾的文件，再交给 `ls`。

## 常用通配符

| 写法 | 含义 |
| --- | --- |
| `*` | 匹配任意长度的任意字符 |
| `?` | 匹配一个任意字符 |
| `[abc]` | 匹配 `a`、`b`、`c` 中的一个 |
| `[0-9]` | 匹配一个数字 |
| `{a,b}` | 展开成 `a` 和 `b`，这是 Bash 常用的 brace expansion |

准备练习文件：

```bash
mkdir -p ~/linux-practice/glob-demo
cd ~/linux-practice/glob-demo
touch a.txt b.txt c.log app.log image01.png image02.png
```

匹配所有文本文件：

```bash
ls *.txt
```

匹配所有日志文件：

```bash
ls *.log
```

匹配 `image01.png` 和 `image02.png`：

```bash
ls image0?.png
```

## 使用引号控制展开

如果你想让 `*` 保持原样，不被 Shell 展开，需要加引号：

```bash
echo "*.txt"
```

不加引号：

```bash
echo *.txt
```

会输出匹配到的文件名。

这也是为什么包含空格的路径要加引号：

```bash
cd "my notes"
```

## 常用快捷键

| 快捷键 | 作用 |
| --- | --- |
| Tab | 自动补全命令或路径 |
| Ctrl+A | 光标移动到行首 |
| Ctrl+E | 光标移动到行尾 |
| Ctrl+U | 删除光标前的内容 |
| Ctrl+K | 删除光标后的内容 |
| Ctrl+W | 删除光标前的一个词 |
| Ctrl+C | 中断当前命令 |
| Ctrl+D | 退出当前 Shell 或结束输入 |
| Ctrl+L | 清屏 |
| Ctrl+R | 搜索历史命令 |

这些快捷键一开始不用全背。先掌握 Tab、Ctrl+C、Ctrl+R，就已经能明显提升效率。

## Tab 补全

假设当前目录有文件：

```text
linux-notes.txt
linux-commands.txt
```

你输入：

```bash
cat lin
```

然后按 Tab，Shell 会尝试补全。如果有多个候选项，再按一次 Tab 通常会显示候选列表。

Tab 补全不仅减少输入，也能帮你避免路径拼错。

## Ctrl+R 搜索历史

按 Ctrl+R 后输入关键词，Shell 会从历史命令中搜索。比如你以前运行过：

```bash
ssh user@example.com
```

按 Ctrl+R 后输入 `ssh`，就能快速找回来。

如果找到了目标命令：

- 按 Enter：直接执行。
- 按方向键或右方向键：把命令放到当前输入行，继续编辑。
- 按 Ctrl+C：取消搜索。

## 小结

你需要记住：

- `*` 匹配任意字符。
- `?` 匹配一个字符。
- `[]` 匹配一组字符中的一个。
- 引号可以阻止 Shell 展开通配符。
- Tab 补全、Ctrl+C、Ctrl+R 是最值得优先掌握的快捷键。

通配符和快捷键不是“高级技巧”，而是日常使用 Linux 的省力工具。
