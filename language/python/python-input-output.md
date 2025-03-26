---
sidebar_position: 18
---

# Python 输入输出



本文主要介绍 Python 输入和输出的函数接口使用方法。在程序调试过程中，我们通常需要将信息输出到终端控制台，或者从键盘输入数据到程序中。为此，Python 为我们提供了 `input()` 和 `print()` 函数。



## input() 输入

`input()` 是 Python 的内建函数，括号内存放的参数用作提示信息。

```python showLineNumbers
what = input("请输入：")
print ("你输入的内容是: ", what)
```

执行该语句后，Python 会等待用户输入数据，当从键盘获取数据后，将其返回给 what 变量。

与 Python 2.7 不同的是，Python 3.x 没有 `raw_input()` 函数，只有 `input()` 函数，因此会把用户输入的任何值都当作字符串来对待。



## print() 输出

`print()` 函数同样是内建函数，与 Python 2.7 不同的是，Python 3.x 的 `print()` 函数一定要加上括号。 

`print()` 函数默认是输出换行的，如果不需要换行，需要指定 `end` 参数，比如：

```python showLineNumbers
print("Hello, World!", end="")
```

`print()` 函数支持字符串运算，比如打印 10 个等号，可以这样：

```python showLineNumbers
print("="*10)
```

`print()` 函数也可以接收多个参数，此时需要用逗号隔开，比如：

```python showLineNumbers
num = 1
print("我要买：", num, "盒", "牛奶")
```



## 格式化输出

Python 中支持两种格式化输出语法。一种是类似于 C 语言 `printf()` 的方式，称为 **Formatting Expression**；另一种是类似于 C# 的方式，称为 **String Formatting Method Calls**。



### C 语言风格

基本是前文格式控制，`%(,,)` 中分别表示输出内容。 如果只有一个需要格式化输出的变量，则该变量紧跟在百分号 `%`（percent）后面即可；如果有多个需要格式化输出的变量，那么需要将变量放到圆括号 `()`（parenthesis）中，并且变量之间用逗号 `,`（comma）隔开。 

例如：

```python showLineNumbers
# 单个变量
>>> a = 12
>>> print("a = %d" % a)
a = 12

# 多个变量
>>> name = "GetIoT"
>>> print("a = %d, name = %s" % (a, name))
a = 12, name = GetIoT
```

格式化指示符包括：

- `b` 二进制。将数字以 2 为基数进行输出。
- `c` 字符。在打印之前将整数转换成对应的 Unicode 字符串。
- `d` 十进制整数。将数字以 10 为基数进行输出。
- `o` 八进制。将数字以 8 为基数进行输出。
- `x` 十六进制。将数字以 16 为基数进行输出，9 以上的位数用小写字母。
- `e` 幂符号。用科学计数法打印数字。用 `e` 表示幂。
- `g` 一般格式。将数值以 fixed-point 格式输出。当数值特别大的时候，用幂形式打印。
- `n` 数字。当值为整数时和 `d` 相同，值为浮点数时和 `g` 相同。不同的是它会根据区域设置插入数字分隔符。
- `%` 百分数。将数值乘以 100 然后以 `fixed-point('f')` 格式打印，值后面会有一个百分号。

如果需要左右对齐或截取内容，可以通过 `%` 后加数字，以及 `-` 和 `.` 符号控制。例如：

```python showLineNumbers
# 字符串输出
>>> print('%s' % 'Hello GetIoT')
Hello GetIoT

# 右对齐，取20位，不够则补位
>>> print('%20s' % 'Hello GetIoT')
        Hello GetIoT

# 左对齐，取20位，不够则补位
>>> print('%-20s' % 'Hello GetIoT')
Hello GetIoT

# 取2位
>>> print('%.2s' % 'Hello GetIoT')
He

# 右对齐，取2位
>>> print('%10.2s' % 'Hello GetIoT')
        He

# 左对齐，取2位
>>> print('%-10.2s' % 'Hello GetIoT')
He
```



### format 方法

格式化字符串的函数 `str.format()`，它增强了字符串格式化的功能。基本是前文格式控制，`.format(,,)` 中分别表示输出内容。数字 (0, 1, ...) 即代表 `format()` 里面的元素，所以可以使用 `.` 调用元素的方法。

字符串的参数使用 `{NUM}` 进行表示占位，`{0}` 表示第一个参数，`{1}` 表示第二个参数，以后顺次递加。使用 : 指定代表元素需要的操作，如 `{0:.3f}` 表示保留小数点后三位，`{0:<8}` 表示占 8 个字符空间并且左对齐等。

可以指定所需长度的字符串的对齐方式：

- `<` 左对齐 （默认）
- `>` 右对齐 
- `^` 中间对齐 
- `=` 在小数点后进行补齐（只用于数字）

对比两种格式化输出的方式，我们可以认为 `format()` 函数通过 `{}` 和 `:` 来代替前者的 `%`。

使用示例：

```python showLineNumbers
>>> "{} {}".format("hello", "world")    # 不指定位置，按默认顺序
'hello world'
>>> "{0} {1}".format("hello", "world")  # 指定位置
'hello world'
>>> "{1} {0}".format("hello", "world")  # 指定位置
'world hello'

# 指定参数名
>>> print("网站：{website}, 地址：{url}".format(website="GetIoT", url="https://getiot.tech"))
网站：GetIoT, 地址：https://getiot.tech

# 通过字典设置参数
>>> site = {"website":"GetIoT", "url":"https://getiot.tech"}
>>> print("网站：{website}, 地址：{url}".format(**site))
网站：GetIoT, 地址：https://getiot.tech

# 通过列表索引设置参数，"0"是必须的
>>> web_list = ["GetIoT", "https://getiot.tech"]
>>> print("网站：{0[0]}, 地址：{0[1]}".format(web_list))
网站：GetIoT, 地址：https://getiot.tech
```

数字格式化示例：

| 数字       | 格式                                                         | 输出                                 | 描述                         |
| :--------- | :----------------------------------------------------------- | :----------------------------------- | :--------------------------- |
| 3.1415926  | `{:.2f}`                                                     | 3.14                                 | 保留小数点后两位             |
| 3.1415926  | `{:+.2f}`                                                    | +3.14                                | 带符号保留小数点后两位       |
| -1         | `{:+.2f}`                                                    | -1.00                                | 带符号保留小数点后两位       |
| 2.71828    | `{:.0f}`                                                     | 3                                    | 不带小数                     |
| 5          | `{:0>2d}`                                                    | 05                                   | 数字补零 (填充左边, 宽度为2) |
| 5          | `{:x<4d}`                                                    | 5xxx                                 | 数字补x (填充右边, 宽度为4)  |
| 10         | `{:x<4d}`                                                    | 10xx                                 | 数字补x (填充右边, 宽度为4)  |
| 1000000    | `{:,}`                                                       | 1,000,000                            | 以逗号分隔的数字格式         |
| 0.25       | `{:.2%}`                                                     | 25.00%                               | 百分比格式                   |
| 1000000000 | `{:.2e}`                                                     | 1.00e+09                             | 指数记法                     |
| 13         | `{:10d}`                                                     | 13                                   | 右对齐 (默认, 宽度为10)      |
| 13         | `{:<10d}`                                                    | 13                                   | 左对齐 (宽度为10)            |
| 13         | `{:^10d}`                                                    | 13                                   | 中间对齐 (宽度为10)          |
| 11         | `'{:b}'.format(11)`<br/>`'{:d}'.format(11)`<br/>`'{:o}'.format(11)`<br/>`'{:x}'.format(11)`<br/>`'{:#x}'.format(11)`<br/>`'{:#X}'.format(11)` | 1011<br/>11<br/>13<br/>b <br/>0xb<br/>0XB | 进制                         |

一个常见的用法是将浮点数按右对齐的方式输出，同时需要控制小数点后的数字长度，这时候可以组合起来使用。例如：

```python showLineNumbers
# 右对齐（位宽8）且保留小数点后两位
>>> print("{:>8.2f}".format(3.14159))
    3.14

# 一个左对齐，一个右对齐
>>> print("{0:<8.2f}|{1:>8.2f}".format(-3.14159, 3.14159))
-3.14   |    3.14
```

