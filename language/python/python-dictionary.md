---
sidebar_position: 15
---

# Python 字典 Dict



Python 的字典（Dictionary）是由一对一对的键（key）和值（value）组成的无序集合，是一种映射类型，通常又称为“**哈希表**”。字典是 Python 中另一种可变容器模型，可以存储任意类型对象。和集合（set）最大的区别是，字典中的元素可通过键（key）来存取。



## 创建与删除

在 Python 中，字典使用花括号（`{}`）表示，字典的每个键值对用冒号（`:`）分割，每个对之间用逗号（`,`）分隔。例如：

```python showLineNumbers
d = { "key1" : "value1", "key2" : "value2" }
```

注意：键必须是唯一的，且不可变，可以是字符串、数字或元组。而值则不必唯一，可以取任何数据类型。

下面是一些简单的的字典：

```python showLineNumbers
dict1 = { 'Alice': 1024, 'Beth': '9102', 'Cecil': '3258' }
dict2 = { 1: 'abc', 2: 'def' };
dict3 = { (1,2): 'abc', (3,4): 'def' };
```

字典中的键必须符合以下规则：

1. 不允许同一个键出现两次，创建时如果同一个键被赋值两次，后一个值会被记住；

2. 键必须不可变，可以用数字、字符串或元组充当，但不能使用列表。

当我们不需要某个字典对象时，可以使用 `del` 语句删除其引用。例如：

```python showLineNumbers
del dict1, dict2, dict3
```



## 访问字典元素

把相应的键放入熟悉的方括弧，就能取得相应键的值了。例如：

```python showLineNumbers
dict1 =	{
    "firstName": "Rudy",
    "lastName": "Lo"
}
print(dict1["firstName"])
print(dict1["lastName"])
```

如果用字典里没有的键访问的数据，会抛出 KeyError 异常

```python showLineNumbers
print(dict1["age"])
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
KeyError: 'age'
```



## 修改字典元素

向字典添加新内容的方法是增加新的键/值对，例如：

```python showLineNumbers
dict1 =	{
    "firstName": "Rudy",
    "lastName": "Lo"
}

dict1['age'] = 18
print(dict1)
```

如果要修改字典，直接对存在的键赋值即可。

```python showLineNumbers
dict1 =	{
    "firstName": "Rudy",
    "lastName": "Lo",
    "age": 18
}

dict1['age'] = 22
print(dict1)
```



## 删除字典元素

使用 `pop()` 方法可以删除具有指定键名的项，例如：

```python showLineNumbers
dict1 =	{
    "firstName": "Rudy",
    "lastName": "Lo",
    "age": 18
}
dict1.pop("age")
print(dict1)
```

`popitem()` 方法删除最后插入的项目（在 3.7 之前的版本中，删除随机项目）：

```python showLineNumbers
dict1 =	{
    "firstName": "Rudy",
    "lastName": "Lo",
    "age": 18
}
dict1.popitem()
print(dict1)
```

除此之外，使用 `del` 关键字也可以删除具有指定键名的项目，例如：

```python showLineNumbers
dict1 =	{
    "firstName": "Rudy",
    "lastName": "Lo",
    "age": 18
}
del dict1["age"]
print(dict1)
```

如果想清空字典，可以使用 `dict.clear()` 函数，例如：

```python showLineNumbers
dict1 =	{
    "firstName": "Rudy",
    "lastName": "Lo",
    "age": 18
}
dict1.clear()
print(dict1)
```



## 字典内置函数

下表列出了 Python 字典内置的函数。

| 函数                | 描述                                               |
| ------------------- | -------------------------------------------------- |
| `cmp(dict1, dict2)` | 比较两个字典元素。                                 |
| `len(dict)`         | 计算字典元素个数，即键的总数。                     |
| `str(dict)`         | 输出字典可打印的字符串表示。                       |
| `type(variable)`    | 返回输入的变量类型，如果变量是字典就返回字典类型。 |



## 字典成员方法

下表列出了 Python 内置的方法。

| 函数                                 | 描述                                                         |
| ------------------------------------ | ------------------------------------------------------------ |
| `dict.clear()`                       | 删除字典内所有元素。                                         |
| `dict.copy()`                        | 返回一个字典的浅复制。                                       |
| `dict.fromkeys(seq[, val])`          | 创建一个新字典，以序列 seq 中元素做字典的键，val 为字典所有键对应的初始值。 |
| `dict.get(key, default=None)`        | 返回指定键的值，如果值不在字典中返回 default 值。            |
| `dict.items()`                       | 以列表返回可遍历的 `(键, 值)` 元组数组。                     |
| `dict.keys()`                        | 以列表返回一个字典所有的键。                                 |
| `dict.setdefault(key, default=None)` | 和 `get()` 类似，但如果键不存在于字典中，将会添加键并将值设为 default。 |
| `dict.update(dict2)`                 | 把字典 dict2 的键/值对更新到 dict 里。                       |
| `dict.values()`                      | 以列表返回字典中的所有值。                                   |
| `pop(key[,default])`                 | 删除字典给定键 key 所对应的值，返回值为被删除的值。key 值必须给出。否则，返回 default 值。 |
| `popitem()`                          | 随机返回并删除字典中的一对键和值。                           |

