---
sidebar_position: 4
sidebar_label: 条件、循环与函数概览
slug: /linux-shell-control-flow-overview
---

# Linux Shell 条件、循环与函数概览

Shell 脚本除了顺序执行命令，还可以判断条件、重复执行、封装函数。这一篇只做入门概览，让你能看懂常见脚本结构。

## if 条件判断

基本结构：

```bash
if 条件; then
    命令
else
    命令
fi
```

例如判断文件是否存在：

```bash
if [ -f "app.log" ]; then
    echo "log exists"
else
    echo "log not found"
fi
```

常见测试：

| 写法 | 含义 |
| --- | --- |
| `[ -f file ]` | 是否是普通文件 |
| `[ -d dir ]` | 是否是目录 |
| `[ -z "$var" ]` | 字符串是否为空 |
| `[ "$a" = "$b" ]` | 字符串是否相等 |
| `[ "$n" -gt 10 ]` | 数字是否大于 10 |

注意 `[` 和 `]` 内侧需要空格。

## case 多分支

当你要根据一个值匹配多个分支时，`case` 更清晰：

```bash
case "$1" in
    start)
        echo "starting"
        ;;
    stop)
        echo "stopping"
        ;;
    *)
        echo "usage: $0 start|stop"
        exit 1
        ;;
esac
```

命令行工具脚本常用这种结构处理子命令。

## for 循环

遍历一组文件：

```bash
for file in *.log; do
    echo "processing $file"
done
```

遍历参数：

```bash
for arg in "$@"; do
    echo "$arg"
done
```

这里 `"$@"` 能更好地保留参数中的空格。

## while 循环

逐行读取文件：

```bash
while IFS= read -r line; do
    echo "line: $line"
done < app.log
```

这是 Shell 脚本中读取文本文件的常见写法。

## 函数

函数用于封装重复逻辑：

```bash
log_info() {
    echo "[INFO] $*"
}

log_info "server started"
```

函数参数使用 `$1`、`$2`、`$@`，和脚本参数类似，只是在函数内部代表函数参数。

## 一个小脚本示例

```bash
#!/usr/bin/env bash

set -u

usage() {
    echo "usage: $0 file"
}

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

file="$1"

if [ ! -f "$file" ]; then
    echo "not a file: $file"
    exit 1
fi

echo "first 5 lines of $file:"
head -n 5 "$file"
```

这个脚本展示了：

- 函数。
- 参数数量判断。
- 文件存在性判断。
- 使用变量保存参数。
- 调用外部命令。

## 小结

你现在只需要能看懂这些结构：

- `if ... then ... else ... fi`
- `case ... in ... esac`
- `for ... do ... done`
- `while ... do ... done`
- `name() { ... }`

Shell 脚本有很多细节，本教程只讲到能读懂和写简单脚本的程度。深入学习请继续阅读 [Shell 教材](/linux-shell/)。
