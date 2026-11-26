---
sidebar_position: 3
sidebar_label: 查看文本文件
slug: /linux-view-text-files
---

# Linux 文本文件查看：cat、less、head、tail

Linux 系统里有大量配置和日志是文本文件。你需要学会快速查看它们，而不是每次都打开图形编辑器。

本文介绍 [cat](/linux-command/cat/)、[less](/linux-command/less/)、[head](/linux-command/head/) 和 [tail](/linux-command/tail/)。

## 准备示例文件

进入练习目录：

```bash
mkdir -p ~/linux-practice/text-demo
cd ~/linux-practice/text-demo
```

创建一个简单文件：

```bash
printf "line 1\nline 2\nline 3\nline 4\nline 5\n" > notes.txt
```

查看文件：

```bash
cat notes.txt
```

预期输出：

```text
line 1
line 2
line 3
line 4
line 5
```

## cat：直接输出全部内容

`cat` 适合查看较短文件：

```bash
cat notes.txt
```

也可以显示行号：

```bash
cat -n notes.txt
```

如果文件很长，`cat` 会一口气输出全部内容，不方便阅读。这时应该使用 `less`。

## less：分页查看

`less` 适合查看长文件：

```bash
less notes.txt
```

常用按键：

| 按键 | 作用 |
| --- | --- |
| 空格 | 下一页 |
| `b` | 上一页 |
| `g` | 跳到开头 |
| `G` | 跳到结尾 |
| `/word` | 搜索 `word` |
| `n` | 下一个搜索结果 |
| `q` | 退出 |

阅读日志、配置文件、命令输出时，`less` 非常有用。

## head：查看开头

`head` 默认查看文件前 10 行：

```bash
head notes.txt
```

指定前 3 行：

```bash
head -n 3 notes.txt
```

它适合快速确认文件格式，比如 CSV 文件头、日志起始内容。

## tail：查看结尾

`tail` 默认查看文件最后 10 行：

```bash
tail notes.txt
```

指定最后 3 行：

```bash
tail -n 3 notes.txt
```

查看日志时，最常用的是 `-f`：

```bash
tail -f app.log
```

`-f` 表示 follow，会持续等待文件新增内容。你可以按 Ctrl+C 停止。

## 和管道配合

很多命令输出也可以交给 `less`：

```bash
ls -la /etc | less
```

查看系统日志结尾并搜索关键字：

```bash
tail -n 100 /var/log/syslog | grep error
```

有些发行版没有 `/var/log/syslog`，可能使用 systemd journal。后面会介绍 [journalctl 日志查看](../process-service/linux-journalctl.md)。

## 什么时候用哪个

| 需求 | 推荐命令 |
| --- | --- |
| 文件很短，直接看完 | `cat` |
| 文件很长，需要翻页 | `less` |
| 只看开头几行 | `head` |
| 只看结尾几行 | `tail` |
| 持续跟踪日志 | `tail -f` |

## 常见错误

### 显示乱码

如果文本编码不是 UTF-8，终端可能显示乱码。你可以先用 [file](/linux-command/file/) 看文件类型：

```bash
file notes.txt
```

### 文件太大

不要用 `cat` 直接输出超大日志文件。优先使用：

```bash
less large.log
tail -n 200 large.log
```

## 小结

查看文本文件是 Linux 日常操作的基本功。遇到配置和日志时，先问自己：

- 我需要看全部，还是只看一部分？
- 文件是短文件还是长文件？
- 我是否需要持续观察新增日志？

然后选择 `cat`、`less`、`head` 或 `tail`。
