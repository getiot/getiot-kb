---
sidebar_position: 22
---

# Python 循环语句



在计算机中，我们通常将流程控制分为三类，即顺序结构、分支结构（选择结构）、循环结构。本文主要介绍 Python 循环结构的语法，对应的是循环语句（for 和 while 语句）。



## while 循环

```python showLineNumbers
while <条件表达式>:
    循环的内容
    [变量的变化]
    ...
```

while 循环语句也可以搭配 else 语句，else 中的代码在 while 条件为假的情况下执行，一般用于当条件不满足后所要执行的操作。

```python showLineNumbers
while <条件表达式>:
    循环的内容
    [变量的变化]
    ...
else:
    当 <条件表达式> 为假时执行的语句
```

另外，我们还经常会用到死循环，也就是循环不会终止的循环类型，除非使用 `break` 或 `exit()` 语句。通常我们用 `while True:` 来实现死循环。



## for…in 循环

`for...in` 循环语句用于遍历容器类的数据（字符串，列表，元组，集合，字典）。格式如下：

```python showLineNumbers
for <变量> in <容器>：
    循环的内容（可以在此使用 <变量>）
    ...
```

也可以在一次解析多个变量，格式如下：

```python showLineNumbers
for 变量1, 变量2 in <容器>：
    循环的内容（可以在此使用变量1和变量2）
    ...
```

但是，这种用法依赖于容器的结构，比如包含元组的列表 `[(),(),()]`、包含列表的列表 `[[],[],[]]`、包含元组的元组 `((),(),())`、包含元组的集合 `{(),(),()}`、包含字典的列表 `[{},{},{}]` 等等。这种方法是直接解析子项中的数据，举个栗子：

```python showLineNumbers
info = [1, 2]
for i,j in info:
    print(i, j)
```

上面这段代码，执行出错（TypeError）

```python showLineNumbers
info = [(1, 2)]
for i,j in info:
    print(i, j)
```

这段代码执行成功，打印“1 2”。

有时候，我们希望从某个值循环到另一个值，也就是遍历一个数字序列。我们可以使用 Python 的内建函数 `range()` 来实现，或者通过 `len()` 函数计算容器长度来实现。例如打印 0~9：

```python showLineNumbers
for i in range(0, 10):
    print(i)
```



## 跳出循环

在循环语句中，我们可以通过关键字 `break` 和 `continue` 来影响执行流程。

- **break** 语句可以跳出 for 和 while 的循环体。break 会直接终止循环，使得对应的 else 语句也不会执行（包括 while…else 语句中的 else 块）。
- **continue** 语句用于跳过当前循环（不执行后面的语句），然后进入下一轮循环。

值得一提的是，关键字 pass 并不会影响执行流程。在 Python 中，pass 表示空语句，用于保持程序结构的完整性。也就是说，pass 语句只用于占位，不做任何事情，这么做可以让解释器舒服一点（因为它有强迫症）。

