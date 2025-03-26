---
sidebar_position: 16
---

# Python 类型转换

类型转换是一种常见任务，Python 提供了很多简化这种工作的内置函数。



## 显式转换

**将整数转换为浮点数**

```python showLineNumbers
>>> float(3)
3.0
```

**将字符串转换为浮点数**

```python showLineNumbers
>>> float('3.2')
3.2
```

**将整数转换为字符串**

```python showLineNumbers
>>> str(85)
'85'
```

**将浮点数转换为字符串**

```python showLineNumbers
>>> str(-9.78)
'-9.78'
```

**将浮点数转换为整数**

这种转换稍微有点麻烦，因为你必须决定如何处理浮点数的小数部分。函数 `int(x)` 将小数部分删除，而 `round(x)` 采用标准圆整方式。

```python showLineNumbers
>>> int(8.54)
8
>>> round(8.54)
9
>>> round(8.5)
8
```

:::tip

圆整策略：四舍六入五成双，这是计算机上圆整数字的标准方式。更多细节请参考 [Rounding](http://en.wikipedia.org/wiki/Rounding)。

:::

对于大多数应用程序，使用 `int(x)`、`float(x)` 和 `round(x)` 就能满足数值转换需求。然而，为处理更具体的转换，Python 模块 math 提供了更多小数部分删除的函数：`math.trunc(x)`、`math.ceil(x)` 和 `math.floor(x)`。

**将字符串转换为数字**

这很容易，只需使用函数 `int(s)` 或 `float(s)` 即可。

```python showLineNumbers
>>> int('5')
5
>>> float('6')
6.0
```

注意：使用 `int(s)` 和 `float(s)` 将字符串转换为整数和浮点数时，是假定字符串看起来像 Python 整数或浮点数，如果不是这样，将出现一条错误消息，指出不能执行转换。比如：

```python showLineNumbers
>>> int('10.2')
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ValueError: invalid literal for int() with base 10: '10.2'
>>> float('6s')
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ValueError: could not convert string to float: '6s'
```

如果用科学记数法表示浮点数的字符串则可以转换：

```python showLineNumbers
>>> float('6e-02')
0.06
```



## 隐式转换

有时候 Python 会自动在数值类型之间转换，而不要求显式地调用转换函数。比如：

```python showLineNumbers
>>> 89 * 1.2
106.8
```

这里自动将 89 转换为 89.0，再将其与 1.2 相乘。一般而言，表达式同时包含整数和浮点数时，Python 会自动将整数转换为浮点数。

