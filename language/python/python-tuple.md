---
sidebar_position: 13
---

# Python 元组 Tuple



Python 中的元组（tuple）和列表（list）同属序列类型，它们的区别是，列表中的元素可以进行任意修改，而元组中的元素无法修改，除非将元组整体替换掉。在表达方式上，元组使用小括号，列表使用方括号。



## 创建与删除

创建一个元组很简单，只要在 **括号** 中添加元素，并使用逗号隔开即可。

```python showLineNumbers
>>> tup1 = ('Python', 'getiot.tech', 123)
>>> tup2 = (1, 2, 3, 4, 5 )
>>> tup3 = "a", "b", "c", "d"
>>> tup1
('Python', 'getiot.tech', 2.7)
>>> tup2
(1, 2, 3, 4, 5)
>>> tup3
('a', 'b', 'c', 'd')
```

实际上，在 Python 中任何使用逗号分隔的表达式，除了赋值运算外，都是元组。这种表达方式称为“无关闭分隔符”。

```python showLineNumbers
>>> 'abc', -4.24e93, 18+6.6j, 'xyz'
('abc', -4.24e+93, (18+6.6j), 'xyz')
>>> x, y = 1, 2
>>> x,y
(1, 2)
>>> 1+2,3+3
(3, 6)
```

可以直接使用一对小括号创建一个空元祖

```python showLineNumbers
>>> tup1 = ()
>>> tup1
()
```

注意：当元组中只包含一个元素时，需要在元素后面添加逗号，不然就被认为是运算符 `()`。

在运算符中，小括号用于改变运算符的优先级。

```python showLineNumbers
>>> tup1 = (50,) # 有逗号，是元组
>>> tup1
(50,)
>>> tup1 = (50) # 没逗号
>>> tup1
50
```

当我们不需要某个元组对象时，可以使用 `del` 语句删除其引用。例如：

```python showLineNumbers
del tup1
```



## 访问元组元素

元组与字符串类似，可以使用下标访问元组中的元素。下标索引从 0 开始，可以进行截取，组合等。例如：

```python showLineNumbers
>>> tuple1 = ('PEK', 28, 'Li Bai')
>>> tuple1[0]
'PEK'
>>> tuple1[1:]
(28, 'Li Bai')
```

元组中的元素是不可变的，如果修改元组的元素，会抛出 `TypeError` 异常。

```python showLineNumbers
>>> tuple1 = ('PEK', 28, 'Li Bai')
>>> tuple1[1] = 88

Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'tuple' object does not support item assignment
```

不过，虽然元组中的元素值是不允许修改的，但我们可以对元组进行连接组合或重新赋值。

```python showLineNumbers
>>> tuple1 = ('PEK', 28, 'Li Bai')
>>> tuple2 = ('Tsinghua',)
>>> tuple3 = tuple1 + tuple2
>>> tuple3
('PEK', 28, 'Li Bai', 'Tsinghua')
```

注意：元组中的元素值是不允许删除的，但可以使用 del 语句来删除整个元组。



## 元组运算符

虽然元组的元素不可变更，但元组之间可以使用 `+` 号和 `*` 号进行运算，经过运算之后会生成一个新的元组。

| Python 表达式                   | 结果                       | 描述         |
| ------------------------------- | -------------------------- | ------------ |
| `len((1, 3, 5))`                | `3`                        | 计算元素个数 |
| `(1, 3, 5) + (2, 4, 6)`         | `(1, 2, 3, 4, 5, 6)`       | 连接         |
| `('Ys',) * 4`                   | `('Ys', 'Ys', 'Ys', 'Ys')` | 复制         |
| `3 in (1, 3, 5)`                | `True`                     | 元素是否存在 |
| `for x in (1, 3, 5): print (x)` | `1 3 5`                    | 迭代         |



## 元组截取

因为元组是一个序列，所以我们可以使用索引访问元组中的指定位置的元素，也可以截取索引中的一段元素。

假设元组 p 定义如下：

```python showLineNumbers
p = ('PEK', 28, 'Li Bai', 'Tsinghua')
```

那么使用索引截取元组元素情况如下：

| Python 表达式 | 结果                         | 描述                         |
| ------------- | ---------------------------- | ---------------------------- |
| `p[2]`        | `'Li Bai'`                   | 读取第三个元素               |
| `p[-2]`       | `'Li Bai'`                   | 反向读取；读取倒数第二个元素 |
| `p[1:]`       | `(28, 'Li Bai', 'Tsinghua')` | 截取元素                     |



## 元组内置函数

下表列出了 Python 中可以应用于元组的函数。

| 函数                  | 描述                 |
| --------------------- | -------------------- |
| `cmp(tuple1, tuple2)` | 比较两个元组元素     |
| `len(tuple)`          | 计算元组元素个数     |
| `max(tuple)`          | 返回元组中元素最大值 |
| `min(tuple)`          | 返回元组中元素最小值 |
| `tuple(seq)`          | 将列表转换为元组     |

从某些方面说，元组除了创建元组的方法 `tuple()` 和下标索引外，没有内置的元组对象的方法。认识这一点很重要，因为它体现了 Python 内建通用方法的思想。

