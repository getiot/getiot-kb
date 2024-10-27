---
sidebar_label: awk 命令
sidebar_position: 22
slug: /awk
---

# awk 命令



## 介绍

**awk** 是一种强大的文本处理工具，用于在 Unix 和 Linux 系统中处理和分析文本数据。它是一种基于模式匹配和动作执行的编程语言，通常用于从结构化文本中提取和操作数据。awk 常常用于处理行格式的文本数据，例如日志文件或表格数据。

awk 提供了丰富的功能，允许用户执行复杂的文本处理任务。它在脚本编程和数据分析中都非常有用。需要注意的是，awk 使用空格或制表符作为默认字段分隔符，但可以通过 `-F` 选项来指定其他分隔符。

**语法**：

```bash
awk '模式 { 动作 }' 文件
```

- **模式**：指定要匹配的条件，如果省略模式，则默认匹配所有行。
- **动作**：指定在匹配到模式时要执行的操作，可以是打印、计算、赋值等。



## 示例

打印文件中每行的第二列和第四列：

```bash
awk '{print $2, $4}' filename
```

将 `ls -l` 的结果作为输入，打印其中每行的第二列和第四列：

```bash
ls -l | awk '{print $2, $4}'
```

计算文件中第一列的总和，并在文件末尾输出总和值：

```bash
awk '{sum += $1} END {print "Sum =", sum}' filename
```

打印包含指定模式的所有行：

```bash
awk '/pattern/ {print}' filename
```

根据第三列的值打印相应的消息：

```bash
awk '{if ($3 > 50) print $1, "High"; else print $1, "Low"}' filename
```

使用冒号作为字段分隔符，打印 `/etc/passwd` 文件中的第一列和第三列：

```bash
awk -F':' '{print $1, $3}' /etc/passwd
```



