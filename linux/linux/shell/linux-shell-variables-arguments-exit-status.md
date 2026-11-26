---
sidebar_position: 3
sidebar_label: 变量、参数与退出状态
slug: /linux-shell-variables-arguments-exit-status
---

# Linux Shell 变量、参数与退出状态概览

Shell 脚本最基本的三件事是：保存值、接收参数、判断命令是否成功。对应到概念就是变量、位置参数和退出状态。

## 变量

变量赋值：

```bash
name="Linux"
```

使用变量：

```bash
echo "$name"
```

推荐给变量加双引号：

```bash
echo "$name"
```

这样可以减少空格、特殊字符带来的意外。

## 环境变量

普通变量只在当前 Shell 中使用。如果你希望子进程也能看到它，需要 `export`：

```bash
export APP_ENV=development
```

查看环境变量：

```bash
printenv APP_ENV
```

更多环境变量内容可以阅读 [Linux 环境变量](../environment/linux-environment-variables.md)。

## 位置参数

脚本可以接收命令行参数。

创建 `args.sh`：

```bash
#!/usr/bin/env bash

echo "script: $0"
echo "first: $1"
echo "second: $2"
echo "all: $@"
echo "count: $#"
```

运行：

```bash
bash args.sh apple banana
```

输出类似：

```text
script: args.sh
first: apple
second: banana
all: apple banana
count: 2
```

常见参数变量：

| 写法 | 含义 |
| --- | --- |
| `$0` | 脚本名 |
| `$1` | 第一个参数 |
| `$2` | 第二个参数 |
| `$@` | 所有参数 |
| `$#` | 参数个数 |

## 退出状态

每个命令执行后都会返回一个退出状态。通常：

- `0` 表示成功。
- 非 `0` 表示失败。

查看上一条命令的退出状态：

```bash
ls /tmp
echo $?
```

再试一个失败命令：

```bash
ls /not-exist
echo $?
```

你会看到第二次通常不是 `0`。

## 使用退出状态判断

可以这样写：

```bash
if grep -q "ERROR" app.log; then
    echo "found error"
else
    echo "no error"
fi
```

`grep -q` 不输出匹配内容，只用退出状态表示是否找到。

## 主动退出

脚本中可以使用 `exit` 指定退出状态：

```bash
#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "usage: $0 name"
    exit 1
fi

echo "Hello, $1"
exit 0
```

这里 `[ -z "$1" ]` 表示第一个参数为空。

## set -e 要谨慎

你可能会在脚本开头看到：

```bash
set -e
```

它表示命令失败时退出脚本。这个选项很有用，但也有细节。入门阶段可以先知道它的存在，不要把它当成所有脚本的万能开关。

## 小结

你需要记住：

- 变量赋值时等号两边不要加空格。
- 使用变量时优先写成 `"$name"`。
- `$1`、`$2` 表示脚本参数。
- `$@` 表示所有参数，`$#` 表示参数个数。
- `$?` 是上一条命令的退出状态。
- `0` 通常表示成功，非 `0` 通常表示失败。

更完整的 Shell 变量和参数内容，可以继续阅读 [Shell 教材](/linux-shell/)。
