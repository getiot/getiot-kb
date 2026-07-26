---
sidebar_position: 14
---

# 正则表达式

正则表达式（Regular Expression，常简称 regex / regexp）是一套描述文本模式的规则。在 Shell 编程里，它经常出现在 `grep`、`sed`、`awk`，以及 Bash 的 `=~` 匹配中。

先记住一件重要的事：**Shell 通配符不是正则表达式**。

| | 通配符（glob） | 正则表达式 |
| --- | --- | --- |
| 典型场景 | 匹配文件名：`*.txt` | 匹配文本内容 |
| `*` 含义 | 任意多个字符 | 修饰前面的原子，表示“重复 0 次或多次” |
| 常见工具 | `ls`、`cp`、Bash 路径展开 | `grep`、`sed`、`awk` |

通配符见上一章 [Shell 通配符](/linux-shell/shell-script-wildcards/)。本章只讲正则。



## 两种常见语法

在 Linux 上你会反复碰到两类正则：

1. **基本正则（BRE，Basic Regular Expression）**  
   传统 `grep`、默认 `sed` 使用。部分元字符需要写成 `\{`、`\(` 等转义形式才有特殊含义。

2. **扩展正则（ERE，Extended Regular Expression）**  
   `grep -E`、`egrep`、`sed -E`、`awk` 使用。`+`、`?`、`|`、`()` 等更直观。

还有 **PCRE**（Perl 兼容正则，如 `grep -P`），功能更强，但可移植性较差，本教程以 BRE / ERE 为主。

:::tip

初学时优先用扩展正则（`grep -E` / `sed -E`），书写更清晰。需要兼容老脚本时再对照 BRE。

:::



## 元字符速查

下面以扩展正则（ERE）为主说明。

### 匹配单个字符

| 模式 | 含义 | 示例 | 能匹配 |
| --- | --- | --- | --- |
| `.` | 任意单个字符（通常不含换行） | `a.c` | `abc`、`a-c` |
| `[abc]` | `a`、`b` 或 `c` 之一 | `[aeiou]` | 任一元音字母 |
| `[^abc]` | 除 `a`、`b`、`c` 外的字符 | `[^0-9]` | 非数字 |
| `[a-z]` | 范围内的字符 | `[0-9]` | 一位数字 |
| `\` | 转义，取消元字符特殊含义 | `\.` | 字面量点号 `.` |

### 位置锚定

| 模式 | 含义 |
| --- | --- |
| `^` | 行首 |
| `$` | 行尾 |
| `^$` | 空行 |

```bash
# 以 http 开头的行
grep -E '^http' urls.txt

# 以 .conf 结尾的行
grep -E '\.conf$' files.txt
```

### 数量（量词）

| 模式 | 含义 |
| --- | --- |
| `*` | 前面的原子重复 0 次或多次 |
| `+` | 重复 1 次或多次（ERE） |
| `?` | 重复 0 次或 1 次（ERE） |
| `{n}` | 恰好 n 次（ERE；BRE 写作 `\{n\}`） |
| `{n,}` | 至少 n 次 |
| `{n,m}` | n 到 m 次 |

```bash
# 一个或多个数字
grep -E '[0-9]+' data.txt

# 恰好 3 个字母 a
grep -E 'a{3}' data.txt
```

### 分组与选择

| 模式 | 含义 |
| --- | --- |
| `(...)` | 分组（ERE；BRE 写作 `\(...\)`） |
| `|` | 或者（ERE） |

```bash
grep -E '(error|warn|fatal)' app.log
grep -E 'colou?r' words.txt    # color 或 colour
```



## 常见字符类

为可读性，很多工具支持 POSIX 字符类（写在 `[]` 内）：

| 字符类 | 大致含义 |
| --- | --- |
| `[[:digit:]]` | 数字 |
| `[[:alpha:]]` | 字母 |
| `[[:alnum:]]` | 字母或数字 |
| `[[:space:]]` | 空白字符 |
| `[[:upper:]]` / `[[:lower:]]` | 大写 / 小写字母 |

```bash
grep -E '[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}' dates.txt
```



## 在 Bash 中直接使用正则

Bash 的 `[[ ... =~ ... ]]` 可用扩展正则做字符串匹配：

```bash showLineNumbers
#!/bin/bash

email="user@getiot.tech"

if [[ $email =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$ ]]; then
    echo "looks like an email"
else
    echo "invalid"
fi
```

匹配成功后，BASH 会把捕获组分到数组 `BASH_REMATCH`：

```bash
[[ $email =~ ^([^@]+)@(.+)$ ]]
echo "user=${BASH_REMATCH[1]}"
echo "domain=${BASH_REMATCH[2]}"
```



## 练习：从日志里抓 IP

假设 `access.log` 中有：

```bash
192.168.1.10 - GET /index.html
10.0.0.5 - GET /api
```

用扩展正则匹配 IPv4（简化版，未严格校验每段 0–255）：

```bash
grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' access.log
```

`-o` 只输出匹配到的部分，而不是整行。



## 小结

- 通配符管文件名，正则管文本内容，不要混用。
- 日常优先学 ERE：`.`、`[]`、`^$`、`*+?{}`、`()`、`|`。
- 真正干活时，正则几乎总是和 [grep](/linux-shell/grep-text-processing/)、[sed](/linux-shell/sed-text-processing/)、[awk](/linux-shell/awk-text-processing/) 一起出现。

下一章先从最常用的检索工具 `grep` 开始。
