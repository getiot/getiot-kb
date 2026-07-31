---
sidebar_position: 3
sidebar_label: Shell 数据类型
title: Linux Shell 数据类型：字符串、整数与特殊变量
description: 说明 Shell 中常见的数据类型与取值方式，理解字符串、整数运算以及脚本里特殊变量的基本含义与使用场景。
---

# Linux Shell 数据类型：字符串、整数与特殊变量



Shell 脚本语言是一门弱类型语言，实际上，它并没有数据类型的概念。无论你输入的是字符串还是数字，在 shell 中都按照字符串类型来存储。至于具体是什么类型，Shell 会根据上下文去确定。

例如，当你尝试对一个字符串进行加一操作时，Shell 解释执行时便会报错。

```bash showLineNumbers
#!/bin/bash
NUM="Hello"
echo $NUM+1            # 输出结果：Hello+1
echo `expr $NUM + 1`   # 执行出错：expr: 非整数参数
NUM=1
echo `expr $NUM + 1`   # 输出结果：2
```

又例如，字符串 "true" 和 "false" 可以作为普通字符串使用，但在比较语句中，Shell 会将其当成布尔型的值进行比较。

```bash showLineNumbers
#!/bin/bash
RESULT="false"
if $RESULT; then
    echo "Is true."
else
    echo "Is false."
fi
```

因此，我们需要理解 shell 在数据类型上的特殊性，虽然 shell 脚本语言是弱类型语言，但其在解释执行时会进行语法检查，确认具体类型。



## 字符串

字符串是 shell 脚本语言最常用的数据类型。字符串的定义可以使用单引号，也可以使用双引号，甚至可以不用引号。

例如，下面 3 种定义方式是等效的：

```bash showLineNumbers
str=getiot.tech
str='getiot.tech'
str="getiot.tech"
```

但三者的使用还是有差别的，具体来说：

- 如果文本中不包含空白符，则可以不用引号包裹，但如果文本中包含空白符，则必须用单引号或双引号包裹；
- 单引号包裹的任何字符都会按原样输出，单引号字符串中的变量是无效的；
- 单引号包裹的字符中可以出现双引号（不需要转义），但不能出现单引号（使用转义符也不行）；
- 双引号包裹的内容可以包含变量；
- 双引号包裹的内容可以使用转义字符。

Bash 提供了一种获取字符串长度的方法：

```bash showLineNumbers
#!/bin/bash
str="getiot.tech"
echo ${#str}       # 输出结果：11
```



## 布尔型

布尔型变量的定义与字符串一样，只是它的值只能是 true 和 false 两者之一。

```bash showLineNumbers
flag=true
flag=false
```



## 数值型

Shell 脚本能够处理数值型数据，但并没有像 C 语言那样区分字符型、整型、浮点型，而是统统存储为字符串。

不过，shell 依然能够处理数值型数据，例如使用 `$` 和 `[]` 包含待运算的数学公式。

```bash showLineNumbers
#!/bin/bash
a=1; b=2
echo $a+$b       # 输出结果：1+2
echo $[$a+$b]    # 输出结果：3
```

另外，shell 还提供了一个数学运算命令 expr（evaluate expression），例如：

```bash showLineNumbers
#!/bin/bash
a=1; b=2
c=`expr $a + $b`
echo $c          # 输出结果：3
```

可惜的是，上述两种运算方式并不支持浮点运算。好在，我们还可以在 shell 中使用 bc 计算器进行数值运算。

```bash showLineNumbers
#!/bin/bash
var=`echo "scale=4;10/3"|bc`
echo $var         # 输出结果：3.3333
```

将数学表达式通过管道传递给 bc 计算器，其中 `scale=4` 表示保留四位小数。



## 数组

Shell 支持一维数组（不支持多维数组），并且没有限定数组的大小。数组元素的下标由 0 开始编号，利用下标可以获取数组中的元素，下标可以是整数或算术表达式，其值应大于或等于 0。

定义数组的一般形式为：

```bash
array_name=(value1 ... valueN)
```

例如：

```bash showLineNumbers
array=(10 20 30 40 50)
echo ${array[3]}    # 输出结果：40
```

可以单独给数组元素重新赋值，例如：

```bash showLineNumbers
array[3]=100
echo ${array[3]}    # 输出结果：100
```

Shell 的数组非常灵活，允许使用不连续的下标，而且下标的范围没有限制。例如：

```bash showLineNumbers
array[6]="apple"
echo ${array[6]}    # 输出结果：apple
```

另外，使用 `@` 或 `*` 可以获取数组中的所有元素。例如：

```bash showLineNumbers
len=${#array[@]}
echo $len           # 输出结果：6
len=${#array[*]}
echo $len           # 输出结果：6
len=${#array[6]}
echo $len           # 输出结果：5（字符串 apple 的长度）
```





