---
sidebar_position: 21
---

# Python 条件语句



在计算机中，我们通常将流程控制分为三类，即顺序结构、分支结构（选择结构）、循环结构。本文主要介绍 Python 分支结构的语法，对应的是条件判断语句（if 语句）。

Python 程序的分支结构有以下几种形式：

**单向分支结构**

```python showLineNumbers
if <条件表达式>:
    执行语句
    ...
```

**双向分支结构**

```python showLineNumbers
if <条件表达式>:
    执行语句
    ...
else:
    执行语句
    ...
```

**多分支结构**

```python showLineNumbers
if <条件表达式>:
    执行语句
    ...
elif <条件表达式>:
    执行语句
    ...
else:
    执行语句
    ...
```

**嵌套分支结构**

```python showLineNumbers
if <条件表达式>:
    if <条件表达式>:
        执行语句
        ...
    else:
        执行语句
        ...
else:
    if <条件表达式>:
        执行语句
        ...
    else:
        执行语句
        ...
```

注意：每一层的缩进格式要统一，否则可能会导致意想不到的情况。
