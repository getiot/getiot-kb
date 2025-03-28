---
sidebar_position: 25
---

# Python 内置函数



Python 作为一门高级语言，提供了许多内置函数。本文就来简单介绍一下 Python 的内置函数及其使用方法。



| 函数             | 描述                                                         |
| ---------------- | ------------------------------------------------------------ |
| `abs()`          | 返回数字的绝对值。                                           |
| `all()`          | 用于判断给定的可迭代参数 iterable 中的所有元素是否不为 0、False 或空对象。 |
| `any()`          | 用于判断给定的可迭代参数 iterable 是否全部为 0、False 或空对象。 |
| `ascii()`        | 返回一个表示对象的字符串，对于字符串中的非 ASCII 字符则返回通过 repr() 函数使用 `\x`、`\u` 或 `\U` 编码的字符。 |
| `bin()`          | 返回一个整数 int 或者长整数 long int 的二进制表示。          |
| `bool()`         | 用于将给定参数转换为布尔类型，如果没有参数，返回 False。     |
| `bytearray()`    | 返回一个新字节数组，这个数组里的元素是可变的，并且每个元素的值范围 `0 <= x < 256`。 |
| `bytes()`        | 返回一个新的 bytes 对象，该对象是一个 `0 <= x < 256` 区间内的整数不可变序列。 |
| `callable()`     | 用于检查一个对象是否是可调用的。                             |
| `chr()`          | 返回一个 ASCII 范围内的整数对应的 ASCII 字符，参数的必须是 0-255 的整数。 |
| `classmethod()`  | 将一个方法设置为类的方法。                                   |
| `compile()`      | 将一个字符串编译为字节代码。                                 |
| `complex()`      | 用于创建一个值为 `real + imag * j` 的复数，或者转化一个字符串或数为复数。 |
| `delattr()`      | 用于删除一个对象的属性。                                     |
| `dict()`         | 用于创建一个字典。                                           |
| `dir()`          | 不带参数时，返回当前范围内的变量、方法和定义的类型列表；带参数时，返回参数的属性、方法列表。 |
| `divmod()`       | 把除数和余数运算结果结合起来，返回一个包含商和余数的元组 `(a // b, a % b)`。 |
| `enumerate()`    | 用于将一个可遍历的数据对象（如列表、元组或字符串）组合为一个索引序列，返回下标（索引）和数据组成的元组列表。 |
| `eval()`         | 用于执行一个字符串表达式，并返回表达式的值。                 |
| `exec()`         | 用于执行储存在字符串或文件中的 Python 语句，与 eval 不同的是，exec 可以执行更复杂的 Python 代码。 |
| `filter()`       | 用于过滤序列，过滤掉不符合条件的元素，返回由符合条件元素组成的新列表。 |
| `float()`        | 用于将整数和字符串转换成浮点数。                             |
| `format()`       | 用于格式化字符串，参考 [Python 字符串](python-string)、[Python 输入输出](python-input-output)。 |
| `frozenset()`    | 返回一个冻结的集合，冻结后集合不能再添加或删除任何元素。     |
| `getattr()`      | 用于返回一个对象属性值。                                     |
| `globals()`      | 以字典类型返回当前位置的全部全局变量。                       |
| `hasattr()`      | 用于判断对象是否包含对应的属性。                             |
| `hash()`         | 用于获取取一个对象（字符串或者数值等）的哈希值。             |
| `help()`         | 用于查看函数或模块用途的详细说明。                           |
| `hex()`          | 用于将 10 进制整数转换成 16 进制整数。                       |
| `id()`           | 用于获取对象的内存地址。                                     |
| `input()`        | 用于获取控制台的输入，参考 [Python 输入输出](python-input-output)。 |
| `int()`          | 用于将一个字符串会数字转换为整型。                           |
| `isinstance()`   | 可以判断一个对象是否是一个已知的类型，类似于 type() 函数。   |
| `issubclass()`   | 用于判断参数 class 是否是类型参数 classinfo 的子类。         |
| `iter()`         | 用于生成迭代器。                                             |
| `len()`          | 返回对象（字符、列表、元组等）长度或项目个数。               |
| `list()`         | 用于将序列（可迭代的对象）转换为列表。                       |
| `locals()`       | 以字典类型返回当前位置的全部局部变量。                       |
| `map()`          | 可以根据提供的函数对指定序列做计算（映射）。                 |
| `max()`          | 返回给定参数的最大值，参数可以为序列。                       |
| `memoryview()`   | 返回给定参数的内存查看对象（Momory view）。                  |
| `min()`          | 返回给定参数的最小值，参数可以为序列。                       |
| `next()`         | 返回迭代器的下一个项目。                                     |
| `object()`       | 返回一个空对象。                                             |
| `oct()`          | 将一个整数转换成 8 进制字符串。                              |
| `open()`         | 用于打开一个文件，创建一个 file 对象。                       |
| `ord()`          | 该函数是 chrI() 函数或 unichr() 函数的配对函数，以一个字符作为参数，返回对应的 ASCII 数值，或者 Unicode 数值。 |
| `pow()`          | 返回 x 的 y 次方的值。                                       |
| `print()`        | 用于打印输出，参考 [Python 输入输出](python-input-output)。 |
| `property()`     | 用于在新式类中返回属性值。                                   |
| `range()`        | 用于创建一个整数列表，一般用在 for 循环中。                  |
| `repr()`         | 将对象转化为供解释器读取的形式。                             |
| `reversed()`     | 用于反转列表，该方法会修改原来的列表。                       |
| `round()`        | 用于返回浮点数 x 的四舍五入值。                              |
| `set()`          | 用于创建一个无序不重复元素集合。                             |
| `setattr()`      | 用于设置一个对象的属性值，前提是该属性必须存在。             |
| `slice()`        | 用于实现切片对象，主要用在切片操作函数里的参数传递。         |
| `sorted()`       | 对所有可迭代的对象进行排序操作。                             |
| `staticmethod()` | 返回函数的静态方法。                                         |
| `str()`          | 将对象转化为适于人阅读的形式。                               |
| `sum()`          | 用于对序列（可迭代的对象）进行求和计算。                     |
| `super()`        | 用于调用下一个父类（超类）并返回该父类实例的方法。           |
| `tuple()`        | 用于将序列（可迭代的对象，如列表和生成器）转换为元组。       |
| `type()`         | 返回对象的类型。                                             |
| `vars()`         | 返回对象 object 的属性和属性值的字典对象。                   |
| `zip()`          | 将可迭代的对象作为参数，将对象中对应的元素打包成一个个元组，然后返回由这些元组组成的列表。 |
| `__import__()`   | 用于动态加载类和函数。                                       |

