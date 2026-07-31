---
sidebar_position: 2
sidebar_label: Shell 基础语法
title: Linux Shell 基础语法：shebang、注释与程序块
description: 讲解 Bash / Shell 脚本基础语法，包括 shebang 解释器标识、缩进与分界符、注释写法，帮你写出结构清晰的脚本。
---

# Linux Shell 基础语法：shebang、注释与程序块



## 解释器标识

规范的 Shell 脚本第一行会指出使用哪个程序（解释器）来执行脚本中的内容。在 Linux bash 编程中一般为：

```bash
#!/bin/bash
```

其中开头的 `#!`（读作 shebang）又称为幻数，在执行 shell 脚本时，内核会根据其后的解释器来确定由哪个解释器来执行脚本中的内容。

注意：解释器标识这一行必须在每个脚本顶端的第一行，如果不是第一行则会被认为是脚本注释行。

实际上我们不仅可以使用 bash 解释器，还可以使用其他一些解释器，甚至是以命令开头，后面紧跟其参数。例如：

```bash showLineNumbers
#!/bin/sh
#!/bin/bash
#!/usr/bin/awk
#!/bin/sed
#!/usr/bin/tcl
#!/usr/bin/expect
#!/usr/bin/perl
#!/usr/bin/env python
```

如果脚本开头没有指定解释器，那么系统会尝试用对应的解释器执行脚本。例如 `bash test.sh` 和 `python test.py`，为避免不必要的错误，建议养成一个好习惯 —— 在脚本开头加上相应的解释器标识。



## 程序块

### 缩进

Shell 的程序块采用缩进风格编写。函数或过程的开始、结构的定义及循环、判断等语句中的代码都要采用缩进风格。

与 Python 不同，Shell 脚本中对缩进没有强制要求和标准，常见的缩进有 2 个空格、4 个空格或 1 个制表符。建议采用 2 个或 4 个空格，并保证程序构造的缩进与逻辑嵌套深度一致，便于阅读即可。



### 分界符

与 C/C++ 一样，Shell 程序使用花括号（`{` 和 `}`）作为程序块的分界符，左右花括号应各自独占一行并且位于同一列。

分界符常见于函数定义。

```bash showLineNumbers
function_name()
{
    commands
}
```



### 结束符

与 C/C++ 一样，Shell 程序使用分号（`;`）作为语句的结束符。不同的是，Shell 程序中的结束符不是必须的。

- 如果单行只有一个独立语句，加或不加结束符都可以；

  ```bash
  a=1
  ```

- 如果单行包含多个语句，则需要添加结束符以分割各个语句。

  ```bash
  a=1; b=2; c=3
  ```



## 注释

在 Shell 脚本中，以 `#` 开头的行就是注释，会被解释器忽略。

```bash showLineNumbers
# This is a single-line comment；
```

注释的作用是对程序进行补充描述，通常只需要对函数和关键代码进行言简意赅的注释即可。

- 函数注释：描述函数的具体功能，放在函数上一行；
- 代码注释：对关键或复杂代码进行注释，注释放在代码上一行或代码后。

Shell 中没有多行注释，如果需要多行注释，只能在每一行的开头加一个 `#` 号。例如，包含作者、开发时间、脚本功能描述等信息的脚本头部注释。

```bash showLineNumbers
#!/bin/bash
#####################################
# Script: XXXX
# Author: XXXX
# Date: XX-XX-XX
# Description: XXXXXX
# Usage: XXXX
#####################################
```

注意：所有注释都必须放在第一行 `#!/bin/bash` 解释器标识之后。



## 第一个 Shell 脚本

本节最后，我们来看一个完整的 shell 脚本，它的作用是询问你的名字并等待输入，接着打印一句 “Hello + 你的名字”。其中，`echo` 命令用于打印字符串到终端，`read` 命令用于从键盘读取用户输入的字符串。

```bash showLineNumbers
#!/bin/bash
################################################
# Script: first.sh
# Author: GetIoT
# Date: 2021-05-20
# Description: This is your first shell script
#              which says Hello to you.
# Usage: ./first.sh
################################################

echo "What is your name?"
read NAME
echo "Hello, $NAME!"
```

为 first.sh 脚本增加可执行权限。

```bash
$ chmod +x first.sh
```

执行该脚本，并输入你的名字。

```bash
$ ./first.sh
What is your name?
GetIoT
Hello, GetIoT!
```





