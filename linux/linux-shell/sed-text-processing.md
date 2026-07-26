---
sidebar_position: 16
---

# sed 文本处理

`sed`（stream editor）是流编辑器：按行读入文本，按脚本规则处理，再输出结果。它特别擅长**批量查找替换、删行、插行**，常与管道一起使用。

本章以 GNU sed 为例，推荐在需要扩展正则时使用 `sed -E`。



## 基本用法

```bash
sed [选项] '脚本' [文件...]
```

常见选项：

| 选项 | 作用 |
| --- | --- |
| `-n` | 取消默认的“每行自动打印”，只打印你明确要求输出的内容 |
| `-i` | 直接改文件（in-place）；危险，改前请备份 |
| `-i.bak` | 改文件并保留 `.bak` 备份（GNU sed） |
| `-E` | 使用扩展正则（ERE） |
| `-e` | 指定一条脚本；可多次使用以组合多条命令 |

默认情况下，`sed` **不会改原文件**，只把结果打到标准输出。要写回文件，请重定向到新文件，或谨慎使用 `-i`。

```bash
sed 's/foo/bar/' input.txt > output.txt
```



## 最常用：替换 s///

格式：

```bash
sed 's/模式/替换/标志'
```

常用标志：

| 标志 | 含义 |
| --- | --- |
| （无） | 每行只替换**第一次**匹配 |
| `g` | 替换行内所有匹配 |
| `p` | 打印该行（常配合 `-n`） |
| `i` | 忽略大小写（GNU sed） |
| `数字` | 只替换第 N 次匹配 |

```bash
# 把每行第一个 apple 换成 orange
sed 's/apple/orange/' fruits.txt

# 替换一行中全部匹配
sed 's/apple/orange/g' fruits.txt

# 扩展正则：把一个或多个空格压成单个空格
sed -E 's/[[:space:]]+/ /g' messy.txt
```

分隔符不一定是 `/`。路径里很多斜杠时，可换用 `#` 或 `|`：

```bash
sed 's#/usr/local/bin#/opt/bin#' paths.txt
```



## 按地址选择行

可以在命令前加“地址”，只处理部分行：

| 地址 | 含义 |
| --- | --- |
| `10` | 第 10 行 |
| `1,5` | 第 1 到 5 行 |
| `$` | 最后一行 |
| `/模式/` | 匹配该模式的行 |
| `10,~2` | （GNU）从第 10 行起，步长相关用法请查 man；入门可先掌握逗号范围 |

```bash
# 删除空行
sed '/^$/d' file.txt

# 只打印包含 error 的行（等价于简易 grep）
sed -n '/error/p' app.log

# 删除第 1 到 3 行
sed '1,3d' file.txt
```



## 常用编辑命令

| 命令 | 作用 |
| --- | --- |
| `s` | 替换 |
| `d` | 删除行 |
| `p` | 打印行 |
| `a\` | 在匹配行**后**追加 |
| `i\` | 在匹配行**前**插入 |
| `c\` | 替换整行内容 |
| `q` | 处理后退出 |

追加示例：

```bash
sed '/listen/a\    # added by script' nginx.conf.sample
```



## 多个命令

可以写在一条脚本里，用分号分隔：

```bash
sed -E 's/\r$//; /^#/d' file.txt
```

也可以多次 `-e`：

```bash
sed -e 's/foo/bar/g' -e '/^$/d' file.txt
```

或把脚本放到文件中：

```bash
sed -f rules.sed input.txt
```



## 捕获组与反向引用

扩展正则分组后，可用 `\1`、`\2` 引用：

```bash
# 把 "last, first" 调成 "first last"
sed -E 's/^([^,]+),[[:space:]]*(.+)$/\2 \1/' names.txt
```

```bash
$ echo 'Doe, Jane' | sed -E 's/^([^,]+),[[:space:]]*(.+)$/\2 \1/'
Jane Doe
```



## 在脚本中的典型用法

### 修改配置值

```bash showLineNumbers
#!/bin/bash
# 将 listen 端口改为 8080（演示用，真实配置请先备份）

conf="app.conf"
cp "$conf" "$conf.bak"
sed -E -i 's/^(listen[[:space:]]*=[[:space:]]*)[0-9]+/\18080/' "$conf"
```

:::warning

`sed -i` 会直接改文件。量产脚本里务必先备份，或先写到临时文件再 `mv`。

:::

### 管道处理命令输出

```bash
ip -br addr | sed -E 's/[[:space:]]+/ /g'
```



## 与 grep 如何选型

| 需求 | 更合适的工具 |
| --- | --- |
| 只想找出匹配行 | `grep` |
| 要改写、删行、插行 | `sed` |
| 按字段做计算或重组 | 下一章的 `awk` |

正则细节见 [正则表达式](/linux-shell/regexp-syntax/)。下一章介绍更擅长“按列思考”的 [awk](/linux-shell/awk-text-processing/)。
