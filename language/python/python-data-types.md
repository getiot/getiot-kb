---
sidebar_position: 9
---

# Python 数据类型



Python 作为一门高级编程语言，有它自身独有的一些数据类型。在 Python3 中有六个标准的数据类型。



## Number 数字

在 Python 程序中表示数字的方法与数学上的写法几乎一样，Python3 支持以下四种数字类型：

- `int`（长整型）
- `float`（浮点型）
- `bool`（布尔值）
- `complex`（复数）

注意：在 Python3 中，只有一种整数类型 `int`，表示为长整型，没有 Python2 中的 `Long`。布尔值只有 `True` 和 `False` 两种。

Python 数值类型的赋值和计算都是很直观的，下面演示四种数字类型的定义：

```python showLineNumbers
a = 20
b = 5.5
c = True
d = 4+3j
```

可以使用多重赋值同时定义多个变量，使用内置的 `type()` 函数可以用来查询变量所指的对象类型。例如：

```python showLineNumbers
>>> a, b, c, d = 20, 5.5, True, 4+3j

>>> print(type(a), type(b), type(c), type(d))
<class 'int'> <class 'float'> <class 'bool'> <class 'complex'>
```

也可以使用 `isinstance()` 函数来判断。

```python showLineNumbers
>>> isinstance(a, int)
True

>>> isinstance(a, float)
False
```

`isinstance` 和 `type` 的区别在于：

- `type()` 不会认为子类是一种父类类型；
- `isinstance()` 会认为子类是一种父类类型。

```python showLineNumbers
class A:
    pass

class B(A):
    pass

>>> isinstance(A(), A)
True

>>> type(A()) == A
True

>>> isinstance(B(), A)
True

>>> type(B()) == A
False
```

关于 Python 类的内容，我们将在后面详细介绍。



## Strings 字符串

Python 的字符串是以单引号（`''`）或双引号（`""`）包裹的任意文本。如果单引号本身也是文本的一部分，那么可以使用双引号包裹；反之如果双引号也是文本的一部分，那么可以使用单引号包裹。例如：

```python showLineNumbers
str1 = "I'm an engineer"
str2 = 'He say:"Life is short, you need Python"'

print(str1)  # I'm an engineer
print(str2)  # He say:"Life is short, you need Python"
```

如果字符串内部既包含单引号，又包含双引号，那么可以使用反斜杠（`\`）进行转义。例如：

```python showLineNumbers
str3 = "He say:\"I'm a doctor\""
print(str3)  # He say:"I'm a doctor"
```

如果想输出转义符，则可以在字符串前面添加一个 `r` 表示原始字符串。例如：

```python showLineNumbers
str4 = r'\n is an escape character'
print(str4)  # \n is an escape character
```



## List 列表

Python 列表是任意对象的有序集合，可通过索引访问指定元素，第一个元素索引为 0，依次递增，-1 表示最后一个元素。列表使用方括号（`[]`）表示，使用逗号分隔各元素，例如：

```python showLineNumbers
list1 = [1, 2, 3, 4, 5, 6]
```

列表是 Python 中非常常用的一种数据类型，但和其他语言的数组不同，Python 列表中的元素类型可以不同。比如，同一个列表中可以包含数字、字符串等多种数据类型。

```python showLineNumbers
list2 = ['Python', 123, 7.25]
```



## Tuple 元组

Python 元组使用小括号（`()`）表示，使用逗号分隔各元素。例如：

```python showLineNumbers
tup = (12, 13, 14)
```

和列表一样，元组中的元素类型也可以不同，例如：

```python showLineNumbers
tup = (12, 13, 14, "Python")
```

定义一个空元组的方法如下：

```python showLineNumbers
tup = ()
```

元组和列表同属序列类型，它们的区别是，列表中的元素可以进行任意修改，而元组中的元素无法修改，除非将元组整体替换掉。

例如，下面的赋值操作会报错：

```python showLineNumbers
tup = (12, 13, 14, "Python")
tup[3] = 15;

# 报错
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'tuple' object does not support item assignment
```



## Set 集合

集合（set）是一个无序的不重复元素序列，基本功能包括关系测试和消除重复元素。与列表、元组的不同在于，集合的元素是无序的，无法通过数字编号进行索引；并且集合中的元素不能重复。

Python 集合使用花括号（`{}`）表示，使用逗号分隔各元素。例如：

```python showLineNumbers
set1 = {'one', 'two', 'three'}
```

另外，也可以使用 `set()` 函数创建集合。如果需要创建一个空的集合，则必须使用 `set()` 函数创建。例如：

```python showLineNumbers
set2 = set()
```



## Dictionary 字典

字典是由一对一对的键（key）和值（value）组成的无序集合，是一种映射类型。字典中的元素可通过键（key）来存取。在 Python 中，字典使用花括号（`{}`）表示，例如：

```python showLineNumbers
dict1 = {'name': 'rudy', 'age': 18}
```

字典中的键必须是不可变类型，可以使用数字、字符串或者元组充当，但不能使用列表。并且在同一个字典中，键必须是唯一的。

