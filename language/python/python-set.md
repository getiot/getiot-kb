---
sidebar_position: 14
---

# Python 集合 Set



集合（set）是一个无序的不重复元素序列，基本功能包括关系测试和消除重复元素。与列表、元组的不同在于，集合的元素是无序的，无法通过数字编号进行索引；并且集合中的元素不能重复。



## 创建与删除

Python 集合使用花括号（`{}`）表示，使用逗号分隔各元素。例如：

```python showLineNumbers
set1 = {"apple", "banana", "cherry"}
```

也可以使用 `set()` 函数创建集合，例如：

```python showLineNumbers
set1 = set(("apple", "banana", "cherry")) # 请留意这个双括号
```

如果需要创建一个空的集合，则必须使用 `set()` 函数创建。例如：

```python showLineNumbers
set2 = set()
```

当我们不需要某个集合对象时，可以使用 `del` 语句删除其引用。例如：

```python showLineNumbers
del set1 set2
```



## 访问集合元素

由于集合是无序的，元素没有索引，因此无法通过引用索引来访问 set 中的项目。但是可以使用 for 循环遍历集合中的元素，或者使用 in 关键字查询集合中是否存在指定值。

示例：使用 for 循环遍历集合

```python showLineNumbers
set1 = {"apple", "banana", "cherry"}

for item in set1:
  print(item)
```

示例：使用 in 关键字查询

```python showLineNumbers
set1 = {"apple", "banana", "cherry"}

print("banana" in set1)
```



## 添加集合元素

集合一旦创建，就无法修改元素，但是允许为集合添加新元素。

使用 `add()` 方法可以将一个元素添加到集合，例如：

```python showLineNumbers
set1 = {"apple", "banana", "cherry"}
set1.add("orange")
print(set1)
# {'apple', 'orange', 'banana', 'cherry'}
```

集合中的元素不能重复，例如：

```python showLineNumbers
set1 = {"apple", "banana", "cherry"}
set1.add("banana")
print(set1)
# {'apple', 'banana', 'cherry'}
```

使用 `update()` 方法可以向集合中添加多个元素，例如：

```python showLineNumbers
set1 = {"apple", "banana", "cherry"}
set1.update(["orange", "mango", "grapes"])
print(set1)
# {'apple', 'orange', 'banana', 'grapes', 'mango', 'cherry'}
```



## 删除集合元素

要删除集合中的元素，请使用 `remove()` 或 `discard()` 方法。

示例：使用 `remove()` 方法来删除 “banana” 元素

```python showLineNumbers
set1 = {"apple", "banana", "cherry"}
set1.remove("banana")
print(set1)
```

示例：使用 `discard()` 方法来删除 “banana” 元素

```python showLineNumbers
set1 = {"apple", "banana", "cherry"}
set1.discard("banana")
print(set1)
```

`remove()` 和 `discard()` 方法的区别是，如果要删除的元素不存在，`remove()` 将引发错误，而 `discard()` 不会引发错误。

另外，你还可以使用 `pop()` 方法删除集合的最后一项，`pop()` 方法的返回值是被删除的项目。但由于 set 是无序的，因此你不会知道被删除的是哪一个。

```python showLineNumbers
set1 = {"apple", "banana", "cherry"}
set2 = set1.pop()
print(set2)
print(set1)
```

如果要清空集合，可以使用 `clear()` 方法，例如：

```python showLineNumbers
set1 = {"apple", "banana", "cherry"}
set1.clear()
print(set1)
```



## 集合内置函数

Python 拥有一套能够在集合（set）上使用的内建方法。

| 方法                            | 描述                                         |
| :------------------------------ | :------------------------------------------- |
| `add()`                         | 向集合添加元素。                             |
| `clear()`                       | 删除集合中的所有元素。                       |
| `copy()`                        | 返回集合的副本。                             |
| `difference()`                  | 返回包含两个或更多集合之间差异的集合。       |
| `difference_update()`           | 删除此集合中也包含在另一个指定集合中的项目。 |
| `discard()`                     | 删除指定项目。                               |
| `intersection()`                | 返回为两个其他集合的交集的集合。             |
| `intersection_update()`         | 删除此集合中不存在于其他指定集合中的项目。   |
| `isdisjoint()`                  | 返回两个集合是否有交集。                     |
| `issubset()`                    | 返回另一个集合是否包含此集合。               |
| `issuperset()`                  | 返回此集合是否包含另一个集合。               |
| `pop()`                         | 从集合中删除一个元素。                       |
| `remove()`                      | 删除指定元素。                               |
| `symmetric_difference()`        | 返回具有两组集合的对称差集的集合。           |
| `symmetric_difference_update()` | 插入此集合和另一个集合的对称差集。           |
| `union()`                       | 返回包含集合并集的集合。                     |
| `update()`                      | 用此集合和其他集合的并集来更新集合。         |

