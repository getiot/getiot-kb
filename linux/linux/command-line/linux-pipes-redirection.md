---
sidebar_position: 6
sidebar_label: 管道与重定向
slug: /linux-pipes-redirection
---

# Linux 管道与重定向

Linux 命令行真正好用的地方，不只是每个命令本身，而是命令之间可以组合。管道和重定向就是组合命令的基础。

你可以把它们理解成：

- 重定向：把输入或输出换一个地方。
- 管道：把前一个命令的输出交给后一个命令继续处理。

## 标准输入、标准输出和标准错误

一个命令通常有三条默认通道：

| 名称 | 编号 | 含义 |
| --- | --- | --- |
| 标准输入 stdin | 0 | 命令从哪里读数据 |
| 标准输出 stdout | 1 | 正常结果输出到哪里 |
| 标准错误 stderr | 2 | 错误信息输出到哪里 |

默认情况下，标准输入来自键盘，标准输出和标准错误都显示在终端。

## 输出重定向

把命令输出写入文件：

```bash
echo "hello linux" > hello.txt
cat hello.txt
```

`>` 会覆盖文件内容。如果文件不存在，会创建文件。

追加到文件末尾：

```bash
echo "second line" >> hello.txt
cat hello.txt
```

`>>` 不会覆盖旧内容，而是追加。

:::warning
使用 `>` 时要小心。如果目标文件已经存在，内容会被覆盖。
:::

## 错误重定向

错误信息属于标准错误，可以用 `2>` 重定向：

```bash
ls /not-exist 2> error.log
cat error.log
```

如果你想忽略错误信息，可以重定向到 `/dev/null`：

```bash
find /etc -name "*.conf" 2>/dev/null
```

`/dev/null` 是一个特殊设备，写进去的内容会被丢弃。

## 同时重定向标准输出和错误

把正常输出和错误都写入同一个文件：

```bash
command > output.log 2>&1
```

在 Bash 中也常写成：

```bash
command &> output.log
```

第一种写法更通用，第二种更简洁。

## 输入重定向

有些命令可以从标准输入读取内容。比如：

```bash
wc -l < hello.txt
```

这会统计 `hello.txt` 的行数。

输入重定向不如输出重定向常见，但理解它有助于你看懂脚本。

## 管道

管道符号是 `|`。它会把左边命令的标准输出，交给右边命令作为标准输入。

例如：

```bash
ls -la /etc | less
```

这会把 `ls -la /etc` 的输出交给 `less` 分页查看。

再看一个例子：

```bash
ps aux | grep ssh
```

这会先列出所有进程，再筛选包含 `ssh` 的行。

## tee：一边显示一边保存

有时你既想在终端看到输出，又想保存到文件，可以使用 [tee](/linux-command/tee/)：

```bash
ls -la | tee files.txt
```

追加写入：

```bash
ls -la | tee -a files.txt
```

`tee` 在调试脚本、保存日志时很实用。

## 常见组合

查看当前目录文件数量：

```bash
ls | wc -l
```

查找日志中的错误并保存：

```bash
grep -i error app.log | tee errors.txt
```

查看大目录并分页：

```bash
du -h /var 2>/dev/null | sort -h | tail
```

这个命令已经稍微复杂了。你可以拆开看：

- [du](/linux-command/du/) 统计目录大小。
- `2>/dev/null` 忽略权限错误。
- `sort -h` 按人类可读大小排序。
- [tail](/linux-command/tail/) 显示最后几行。

## 小结

管道和重定向是 Linux 命令行的核心能力：

- `>` 覆盖写入文件。
- `>>` 追加写入文件。
- `2>` 重定向错误信息。
- `|` 把一个命令的输出交给下一个命令。
- `tee` 可以同时显示和保存输出。

学会组合命令后，你就不只是“使用命令”，而是在搭建小型的数据处理流水线。
