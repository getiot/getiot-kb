---
sidebar_position: 12
sidebar_label: Shell 函数调用
title: Linux Shell 函数教程：定义、参数、local 与返回值
description: 学习 Bash 函数的定义与调用、local 局部变量，以及用 return 返回状态码、用 echo 返回文本结果的写法。
---

# Linux Shell 函数教程：定义、参数、local 与返回值

函数用来把一段可复用的逻辑封装起来。学会函数后，脚本会更容易读、更容易测，也更不容易把主流程写成长长的一坨。

本章以 Bash 为例。如果你的脚本要以 `/bin/sh`（在 Ubuntu 上常为 dash）运行，请注意部分写法的可移植性差异。



## 函数定义与调用

推荐使用不带 `function` 关键字的可移植写法：

```bash showLineNumbers
#!/bin/bash

say_hello()
{
    echo "Hello, $1"
}

say_hello "GetIoT"
```

要点：

- 函数必须**先定义，后调用**。
- 定义时圆括号里不写形参列表；调用时像普通命令一样传参。
- 函数体内用 `$1`、`$2`、`$#`、`$@` 等接收参数，含义与脚本位置参数类似，但作用域是**当前这次函数调用**。
- 函数内的 `$0` 通常仍是脚本名，不是函数名（Bash 行为如此）。



也可以写成单行：

```bash
say_hello() { echo "Hello, $1"; }
```

多语句时仍建议使用花括号分块，并保持缩进一致。



## 函数规范

### 函数结构

- 每一个小功能都封装到独立函数里，一个函数只完成一件事；在脚本尾部按顺序调用函数，把整段逻辑串起来。
- 控制函数体大小，尽量控制在大约一百行以内；过大的函数应拆成多个。

### 函数复用

- 多次出现的相同逻辑要抽成函数，降低维护成本。
- 对常用能力（写日志、计算日期、发邮件等）可封装成独立脚本，再由其他脚本 `source` 引入。



## 局部变量

默认情况下，函数里赋值的变量是**全局**的，会污染脚本其余部分。需要局部作用域时，用 `local`：

```bash showLineNumbers
#!/bin/bash

counter=0

inc()
{
    local step=$1
    counter=$((counter + step))
    echo "inside: counter=$counter, step=$step"
}

inc 3
echo "outside: counter=$counter"
# echo "$step"   # 空：step 是 local，函数外不可见
```

:::tip

配置类、脚本级变量可以放在脚本头部；函数内部的临时变量优先使用 `local`。

:::



## 函数返回

Shell 函数的“返回”通常有两种用途：

1. 告诉调用方**成功或失败**（退出状态）。
2. 把**文本结果**交回给调用方。

### 用 return 返回状态码

`return` 返回的是整数状态码（一般为 0–255），约定与命令退出码相同：`0` 表示成功，非 `0` 表示失败。

```bash showLineNumbers
#!/bin/bash

is_positive()
{
    if [ "$1" -gt 0 ] 2>/dev/null; then
        return 0
    else
        return 1
    fi
}

if is_positive 10; then
    echo "ok"
else
    echo "not positive"
fi
```

在函数外检查上一次状态码，可以用 `$?`：

```bash
is_positive -1
echo $?    # 1
```

:::note

`return` 只能用在函数里。在脚本顶层请用 `exit`。不要指望用 `return` 传回字符串。

:::

### 用 echo / printf 返回文本

需要把计算结果交给调用方时，通常把结果打印到标准输出，再用命令替换捕获：

```bash showLineNumbers
#!/bin/bash

add()
{
    local a=$1
    local b=$2
    echo $((a + b))
}

sum=$(add 3 5)
echo "sum=$sum"
```

如果函数既要打印调试信息，又要返回结果，调试信息应写到 stderr，避免污染捕获结果：

```bash showLineNumbers
add()
{
    local a=$1
    local b=$2
    echo "debug: a=$a b=$b" >&2
    echo $((a + b))
}
```



## 综合示例

下面这个小脚本演示参数检查、局部变量、状态码与文本返回：

```bash showLineNumbers title="greet.sh"
#!/bin/bash

usage()
{
    echo "Usage: $0 <name>" >&2
}

greet()
{
    local name=$1
    if [ -z "$name" ]; then
        return 1
    fi
    echo "Hello, ${name}!"
}

if [ $# -lt 1 ]; then
    usage
    exit 1
fi

msg=$(greet "$1") || {
    echo "invalid name" >&2
    exit 1
}

echo "$msg"
```

运行：

```bash
$ chmod +x greet.sh
$ ./greet.sh GetIoT
Hello, GetIoT!
```



## 常见错误

| 现象 | 常见原因 |
| --- | --- |
| `command not found` | 调用写在定义之前 |
| 变量“莫名其妙”被改掉 | 函数内未使用 `local` |
| `$(func)` 结果里多出调试文字 | 调试信息打到了 stdout，应改用 stderr |
| `return` 后拿到奇怪数字 | 把字符串或大于 255 的值当状态码使用了 |

下一章会介绍 Shell [通配符](/linux-shell/shell-script-wildcards/)，它和后面的正则表达式容易混淆，建议对照阅读。
