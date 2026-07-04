---
sidebar_position: 6
---

# R 语言数据类型



在计算机编程中，数据类型（data type）是一个重要的概念。变量能够存储不同类型的数据，不同的数据类型可以做不同的事情。

在 R 中，变量不需要声明为任何特定类型，甚至可以在设置后更改类型，例如：

```R showLineNumbers
my_var <- 30 # my_var is type of numeric
my_var <- "Sally" # my_var is now of type character (aka string)
```

R 有多种数据类型和对象类，下面我们将逐一介绍。



## 基本数据类型

R 中的基本数据类型可以分为以下几种：

| 数据类型    | 描述   | 示例                                                         |
| ----------- | ------ | ------------------------------------------------------------ |
| `numeric`   | 浮点数 | 直接输入单个数字，被视为浮点数，如 10.5, 55, 787             |
| `integer`   | 整数   | 如需要其必须为整数型，需要在整数后加大写 `L`，如 1L, 55L, 100L |
| `complex`   | 复数   | 虚数符号用 `i`，不能用 `j`，如 9 + 3i                        |
| `character` | 字符串 | 被单引号或双引号括起来的内容为字符串，如 "k", "R is exciting", "FALSE", "11.5" |
| `logical`   | 逻辑值 | 逻辑值包括 `TRUE` 和 `FALSE` 两种，所有字母必须大写，可简写为 `T` 和 `F` |

我们可以使用 `class()` 函数来检查变量的数据类型，例如：

```R showLineNumbers
# numeric
x <- 10.5
class(x)

# integer
x <- 1000L
class(x)

# complex
x <- 9i + 3
class(x)

# character/string
x <- "R is exciting"
class(x)

# logical/boolean
x <- TRUE
class(x)
```

在接下来的章节中，你将学到更多关于各种数据类型的知识。

