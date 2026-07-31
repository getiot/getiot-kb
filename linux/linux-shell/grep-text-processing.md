---
sidebar_position: 15
sidebar_label: grep 文本处理
title: Linux grep 文本处理：查找、过滤与正则匹配
description: 用 grep 在文件和管道中查找文本，掌握 -i、-n、-E、-o 等常用选项，以及在 Shell 脚本中用退出码做判断。
---

# Linux grep 文本处理：查找、过滤与正则匹配

`grep` 用来在文本中按模式查找行。名字来自编辑器里的 `g/re/p`（global / regular expression / print）。写脚本、查日志、过滤命令输出时，它几乎是第一选择。

本章默认使用 GNU grep（常见于 Ubuntu / Debian）。命令手册也可参考 [grep 命令](/linux-command/grep/)。



## 基本用法

```bash
grep [选项] 模式 [文件...]
```

从文件查找：

```bash
$ grep error app.log
2026-07-27 10:01:02 ERROR connection timeout
```

从管道查找：

```bash
$ dmesg | grep -i usb
```

模式里若含空格或 Shell 特殊字符，请加引号：

```bash
grep "connection refused" app.log
```



## 常用选项

| 选项 | 作用 |
| --- | --- |
| `-i` | 忽略大小写 |
| `-n` | 显示行号 |
| `-v` | 反向匹配（打印不匹配的行） |
| `-c` | 只输出匹配行数 |
| `-l` | 只输出包含匹配的文件名 |
| `-r` / `-R` | 递归搜索目录 |
| `-w` | 按“整词”匹配 |
| `-x` | 整行完全匹配 |
| `-o` | 只输出匹配到的片段 |
| `-E` | 使用扩展正则（ERE） |
| `-F` | 把模式当固定字符串，不做正则解释 |
| `-A N` / `-B N` / `-C N` | 显示匹配行后/前/前后各 N 行上下文 |

```bash
# 忽略大小写，带行号
grep -in error app.log

# 递归查找 .sh 中的 TODO
grep -rn --include='*.sh' 'TODO' .

# 固定字符串，避免 . 被当成“任意字符”
grep -F '192.168.1.1' hosts.txt
```



## 与正则配合

默认 `grep` 使用基本正则（BRE）。需要 `+`、`?`、`|`、`()` 时，加上 `-E`：

```bash
# 匹配 error 或 warn
grep -E 'error|warn' app.log

# 提取 IPv4（简化）
grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' access.log
```

正则基础见 [正则表达式](/linux-shell/regexp-syntax/)。



## 在脚本中判断是否匹配

`grep` 找到匹配时退出码为 `0`，找不到为 `1`，出错为 `2`。因此可以直接用于 `if`：

```bash showLineNumbers
#!/bin/bash

if grep -q 'ERROR' app.log; then
    echo "found errors"
else
    echo "no error keyword"
fi
```

`-q` 表示安静模式：不打印匹配行，只返回状态码，适合脚本判断。



## 实用组合

### 统计匹配次数

```bash
grep -c 'ERROR' app.log
```

### 多文件中定位

```bash
grep -nH 'FIXME' *.sh
```

`-H` 强制打印文件名（多文件时默认就会打印）。

### 排除某些行

```bash
grep -E 'ERROR|WARN' app.log | grep -v 'known-issue'
```

### 配合 `find`

```bash
find . -name '*.conf' -print0 | xargs -0 grep -n 'Listen'
```



## 示例：过滤系统用户

`/etc/passwd` 中 shell 为 `/usr/sbin/nologin` 或 `/bin/false` 的行常表示系统/服务账号：

```bash
grep -E '/(nologin|false)$' /etc/passwd
```



## 常见错误

| 现象 | 原因与处理 |
| --- | --- |
| 模式里的 `.` 匹配了太多内容 | 用 `grep -F`，或写成 `\.` |
| `*` 不符合预期 | 你可能在用通配符思维；正则里 `*` 修饰前一个原子 |
| 脚本里明明有匹配却走进 `else` | 检查是否忘了引号，或工作目录不对 |
| 二进制文件被当成文本扫 | 加 `-I` 忽略二进制，或限制 `--include` |

下一章介绍专门做“查找并改写”的流编辑器 [sed](/linux-shell/sed-text-processing/)。
