---
sidebar_position: 4
sidebar_label: 文本搜索 grep
slug: /linux-grep-basics
---

# Linux 文本搜索：grep

你在 Linux 中经常需要从大量文本里找线索：日志里的错误、配置文件里的某个选项、代码里的某个函数名。这时最常用的命令就是 [grep](/linux-command/grep/)。

## grep 的基本用法

最简单的形式是：

```bash
grep 关键词 文件名
```

准备一个示例文件：

```bash
mkdir -p ~/linux-practice/grep-demo
cd ~/linux-practice/grep-demo
cat > app.log <<'EOF'
INFO server started
WARN disk space low
ERROR failed to connect database
INFO server stopped
EOF
```

搜索 `ERROR`：

```bash
grep ERROR app.log
```

输出：

```text
ERROR failed to connect database
```

## 显示行号

排查问题时，行号很有用：

```bash
grep -n ERROR app.log
```

输出类似：

```text
3:ERROR failed to connect database
```

## 忽略大小写

有些日志大小写不统一，可以加 `-i`：

```bash
grep -i error app.log
```

## 反向匹配

如果你想显示不包含某个关键词的行，使用 `-v`：

```bash
grep -v INFO app.log
```

这会排除包含 `INFO` 的行。

## 搜索多个文件

```bash
grep ERROR *.log
```

如果目录中有多个 `.log` 文件，`grep` 会显示匹配来自哪个文件。

递归搜索目录：

```bash
grep -R "database" .
```

`-R` 表示递归搜索当前目录及其子目录。

## 和管道配合

`grep` 最强的地方之一是可以处理其他命令的输出：

```bash
ps aux | grep nginx
```

这个命令会先列出进程，再从结果中筛选包含 `nginx` 的行。

查看最近日志里的错误：

```bash
tail -n 200 app.log | grep ERROR
```

## 使用简单正则表达式

默认情况下，`grep` 支持基础正则表达式。比如搜索以 `ERROR` 开头的行：

```bash
grep "^ERROR" app.log
```

搜索以 `stopped` 结尾的行：

```bash
grep "stopped$" app.log
```

使用扩展正则表达式可以加 `-E`：

```bash
grep -E "ERROR|WARN" app.log
```

这会搜索包含 `ERROR` 或 `WARN` 的行。

## 只显示匹配数量

```bash
grep -c INFO app.log
```

输出：

```text
2
```

这在统计日志类型、检查配置项出现次数时很方便。

## 常见组合

查看配置中未被注释的行：

```bash
grep -v "^#" config.conf
```

同时排除空行：

```bash
grep -v "^#" config.conf | grep -v "^$"
```

查找当前目录下包含 `TODO` 的文件：

```bash
grep -R -n "TODO" .
```

## grep 和 rg

很多开发者会安装 [rg](/linux-command/rg/)，也就是 ripgrep。它默认递归搜索目录，速度很快，并会自动忽略 `.gitignore` 中的文件。

但你仍然应该先学会 `grep`，因为它几乎在所有 Linux 系统上都可用。

## 小结

你需要掌握这些常用选项：

- `-n`：显示行号。
- `-i`：忽略大小写。
- `-v`：反向匹配。
- `-R`：递归搜索目录。
- `-E`：使用扩展正则表达式。
- `-c`：只显示匹配行数。

学会 `grep` 后，你排查日志和查找配置会快很多。
