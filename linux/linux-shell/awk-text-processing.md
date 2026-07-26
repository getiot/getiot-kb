---
sidebar_position: 17
---

# awk 文本处理

`awk` 是一门面向文本的小型编程语言，也是一条命令。它的强项是：**按行扫描，按字段拆分，再打印或计算**。处理日志、CSV、命令输出时，比一层层管道嵌套往往更清晰。

Linux 上常见实现是 `gawk`（GNU Awk）。许多发行版里的 `awk` 就是 `gawk` 的链接。



## 基本模型

`awk` 的核心循环可以概括成：

```bash
对每一行 {
    按分隔符拆成字段 $1, $2, ...
    若模式匹配，则执行对应动作
}
```

命令形式：

```bash
awk [选项] '程序' [文件...]
```

最简单的程序只有动作：

```bash
$ echo 'a b c' | awk '{print $2}'
b
```

带模式的程序：

```bash
awk '/ERROR/ {print $0}' app.log
```

`$0` 表示整行，`$1` 起为各字段，`NF` 为当前行字段数，`NR` 为已读行号。



## 字段与分隔符

默认按**空白**（空格/制表符等）拆分字段。

| 内置量 | 含义 |
| --- | --- |
| `$0` | 整行 |
| `$1` ... `$n` | 第 1 到第 n 个字段 |
| `NF` | 字段个数 |
| `NR` | 当前行号（跨文件累加） |
| `FNR` | 当前文件内的行号 |
| `FS` | 输入字段分隔符 |
| `OFS` | 输出字段分隔符 |
| `RS` / `ORS` | 记录（行）分隔符 / 输出记录分隔符 |

指定输入分隔符：

```bash
# 冒号分隔，类似 /etc/passwd
awk -F: '{print $1, $7}' /etc/passwd

# 与上面等价
awk 'BEGIN {FS=":"} {print $1, $7}' /etc/passwd
```

输出时用逗号分隔字段，会插入 `OFS`（默认空格）：

```bash
awk -F: -v OFS='\t' '{print $1, $3, $7}' /etc/passwd
```



## BEGIN 与 END

- `BEGIN { ... }`：读入任何行**之前**执行一次，适合初始化。
- `END { ... }`：读完所有输入**之后**执行一次，适合汇总。

```bash
$ printf '10\n20\n30\n' | awk '{s+=$1} END {print "sum=", s}'
sum= 60
```



## 模式与动作

常见模式：

| 模式 | 含义 |
| --- | --- |
| `/正则/` | 行匹配正则 |
| `表达式` | 表达式为真时执行，如 `NR==1`、`$3>100` |
| `P1, P2` | 从匹配 P1 的行开始，到匹配 P2 的行结束（范围） |

```bash
# 打印第 2 到第 5 行
awk 'NR>=2 && NR<=5 {print}' file.txt

# 第三列大于 100 的行
awk -F, '$3 > 100 {print $1, $3}' data.csv

# 只处理包含 timeout 的行，并打印第 1、5 字段
awk '/timeout/ {print $1, $5}' app.log
```



## 常用内置函数

| 函数 | 作用 |
| --- | --- |
| `length(s)` | 字符串长度 |
| `substr(s, m, n)` | 从位置 m 起取 n 个字符 |
| `index(s, t)` | 子串位置 |
| `split(s, a, fs)` | 按 `fs` 拆分到数组 `a` |
| `tolower(s)` / `toupper(s)` | 大小写转换 |
| `sprintf("fmt", ...)` | 格式化字符串 |

```bash
awk '{print toupper($1)}' names.txt
```



## 示例

### 1. 打印指定列

```bash
# 磁盘用量：打印文件系统与使用率
df -h | awk 'NR==1 || $5+0 >= 80 {print $1, $5}'
```

### 2. 统计单词出现次数

```bash showLineNumbers
awk '{
  for (i = 1; i <= NF; i++)
    count[$i]++
}
END {
  for (w in count)
    print count[w], w
}' words.txt | sort -nr
```

### 3. 处理 CSV 第一列求和

```bash
awk -F, 'NR>1 {sum += $2} END {print sum}' sales.csv
```

:::note

简单 CSV 可以用 `awk -F,`。字段里若含逗号、引号，需要更严格的 CSV 解析器；不要对复杂表格硬用 `awk`。

:::

### 4. 在脚本中调用

```bash showLineNumbers
#!/bin/bash

logfile=${1:-app.log}

awk '
/ERROR/ { err++ }
/WARN/  { warn++ }
END {
  printf "ERROR=%d WARN=%d\n", err+0, warn+0
}
' "$logfile"
```



## grep / sed / awk 怎么选

| 需求 | 优先工具 |
| --- | --- |
| 找出包含某模式的行 | `grep` |
| 行内替换、删行、插行 | `sed` |
| 按列提取、过滤、汇总、格式化 | `awk` |

三者常组合使用，例如：

```bash
grep -E 'ERROR|WARN' app.log | awk '{print $1, $2, $5}'
```

更系统的模式语法见 [正则表达式](/linux-shell/regexp-syntax/)。学完三件套后，可以到 [shell 脚本示例](/linux-shell/shell-script-templates/) 看完整脚本模板。
