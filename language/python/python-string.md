---
sidebar_position: 11
---

# Python 字符串 String



和许多高级编程语言一样，字符串也是 Python 中最常用的数据类型。本文将介绍 Python 字符串的创建方法、字符串元素的访问、更新，以及字符串运算和格式化等内容。最后还列出了 Python 内置的字符串对象操作函数。



## 创建与删除

在 Python 中有多种创建字符串的方法。

1、使用单引号引起来

```python showLineNumbers
>>> s1 = 'Hello \n World'
>>> print (s1)
Hello 
 World
```

2、使用双引号引起来的字符串

```python showLineNumbers
>>> s1 = "Hello \n World"
>>> print (s1)
Hello 
 World
```

3、在字符串前添加 `r` 表示原始字符串

```python showLineNumbers
>>> s1 = r"Hello \n World"
>>> print (s1)
Hello \n World
```

4、使用三个单引号引起来的字符串

```python showLineNumbers
>>> s1 = '''Hello
World

Nice to see you
'''
>>> print (s1)
Hello
World

Nice to see you

>>>
```

5、使用三个单引号引起来的字符串

```python showLineNumbers
>>> s1 = """Hello
World

Nice to see you
"""
>>> print (s1)
Hello
World

Nice to see you

>>>
```

当我们不需要某字符串对象时，可以使用 `del` 语句删除其引用。例如：

```python showLineNumbers
del s1
```



## 访问字符串

Python 可以使用下标索引访问字符串中单个字符。下标索引是一种特殊的访问方法，类似于 C 语言的数组，在变量后跟一对中括号，中括号里填入整形数字就能访问对应的元素。

- 索引从 0 开始，第一个元素是 0，第二个元素是 1 ... 以此类推
- 最后一个元素是 -1，倒数第二个元素是 -2 ... 以此类推

```python showLineNumbers
>>> s1 = 'Hello Python'
>>> s1[1]
'e'
>>> s1[-2]
'o'
```

我们还可以使用下标索引来截取一段字符串，例如：

```python showLineNumbers
>>> s1 = 'Hello Python'
>>> s1[1:4]
'ell'
>>> s1[1:-1]
'ello Pytho'
```



## 字符串更新

字符串本身是不能更改的，但可以使用下标索引将字符串中的一部分赋值给另一个字符串。

```python showLineNumbers
>>> s1 = 'Hello Python'
>>> s1[3] = 'w'

Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'str' object does not support item assignment
>>> s2 = s1[1:6]
>>> s2
'ello '
```



## 转义字符

如果要在字符串中使用下表列出的特殊字符，就要使用反斜杠（`\`）转义字符。下表列出了常见的一些转义字符。

| 转义字符        | 描述                                             |
| --------------- | ------------------------------------------------ |
| `\`（在行尾时） | 续行符                                           |
| `\\`            | 反斜杠符号                                       |
| `\'`            | 单引号                                           |
| `\"`            | 双引号                                           |
| `\a`            | 响铃                                             |
| `\b`            | 退格（Backspace）                                |
| `\e`            | 转义                                             |
| `\000`          | 空                                               |
| `\n`            | 换行                                             |
| `\v`            | 纵向制表符                                       |
| `\t`            | 横向制表符                                       |
| `\r`            | 回车                                             |
| `\f`            | 换页                                             |
| `\oyy`          | 八进制数，yy 代表的字符，例如：`\o12` 代表换行   |
| `\xyy`          | 十六进制数，yy 代表的字符，例如：`\x0a` 代表换行 |
| `\other`        | 其它的字符以普通格式输出                         |



## 字符串运算符

下表列出了 Python 支持的字符串操作符（示例中假设 `a= "Hello"`，`b = "Python"`）

| 操作符   | 描述                                                 | 示例            | 输出          |
| -------- | ---------------------------------------------------- | --------------- | ------------- |
| `+`      | 字符串连接                                           | `a+b`           | `HelloPython` |
| `*`      | 重复输出字符串                                       | `a*2`           | `HelloHello`  |
| `[]`     | 通过索引获取字符串中字符                             | `a[1]`          | `e`           |
| `[ : ]`  | 截取字符串中的一部分                                 | `a[1:4]`        | `ell`         |
| `in`     | 成员运算符 如果字符串中包含给定的字符返回 True       | `"H" in a`      | True          |
| `not in` | 成员运算符 如果字符串中不包含给定的字符返回 True     | `"M" not in a`  | `True`        |
| `r/R`    | 原始字符串：所有的字符串都是直接按照字面的意思来使用 | `print (r'\n')` | `\n`          |
| `%`      | 格式字符串                                           | 后面介绍        |               |



## 字符串格式化

Python 支持格式化字符串的输出，尽管这样可能会用到非常复杂的表达式，但最基本的用法是将一个值插入到一个有字符串格式符 `%s` 的字符串中。例如：

```python showLineNumbers
>>> 'Hello %s, My age is %d' % ('Python', 18)
'Hello Python, My age is 18'
```

下表列出了 Python 支持的字符串格式化符号。

| 格式化符 | 描述                                  |
| -------- | ------------------------------------- |
| `%c`     | 格式化字符及其 ASCII 码               |
| `%s`     | 格式化字符串                          |
| `%d`     | 格式化整数                            |
| `%u`     | 格式化无符号整型                      |
| `%o`     | 格式化无符号八进制数                  |
| `%x`     | 格式化无符号十六进制数                |
| `%X`     | 格式化无符号十六进制数（大写）        |
| `%f`     | 格式化浮点数字，可指定小数点后的精度  |
| `%e`     | 用科学计数法格式化浮点数              |
| `%E`     | 作用同 `%e`，用科学计数法格式化浮点数 |
| `%g`     | `%f` 和 `%e` 的简写                   |
| `%G`     | `%f` 和 `%E` 的简写                   |
| `%p`     | 用十六进制数格式化变量的地址          |

另外，格式化操作符还有一些辅助指令，用于实现占位、对齐等功能。

| 符号      | 功能                                                        |
| --------- | ----------------------------------------------------------- |
| `*`       | 定义宽度或者小数点精度                                      |
| `-`       | 用做左对齐                                                  |
| `+`       | 在正数前面显示加号 `+`                                      |
| `<sp>`    | 在正数前面显示空格                                          |
| `#`       | 在八进制数前面显示零 `0`，在十六进制前面显示 `0x` 或者 `0X` |
| `0`       | 显示的数字前面填充 `0`，而不是默认的空格                    |
| `%`       | `%%` 输出一个单一的百分号 `%`                               |
| `( var )` | 映射变量（字典参数）                                        |
| `m.n.`    | m 是显示的最小总宽度，n 是小数点后的位数（如果可用的话）    |



## format 函数

除此之外，Python 的字符串还可以使用内置函数 `str.format()` 格式化字符串。基本语法是通过 `{}` 和 `:` 来代替以前的 `%`，例如：

```python showLineNumbers
>>> "{} {}".format("hello", "world")
'hello world'
```

format 函数可以接受不限个参数，位置可以不按顺序。

```python showLineNumbers
>>> "{0} {1}".format("hello", "world")
'hello world'

>>> "{1} {0} {1}".format("hello", "world")
'world hello world'
```

还可以通过字典设置参数输出参数，例如：

```python showLineNumbers
>>> site = {"title": "人人都懂物联网", "url": "getiot.tech"}
>>> print("标题: {title}, 地址: {url}".format(**site))
标题: 人人都懂物联网, 地址: getiot.tech
```



## 三引号

前面介绍过了 Python 可以使用三引号（triple quotes）来创建字符串。Python 三引号允许一个字符串跨多行，字符串中可以包含换行符、制表符以及其它的特殊字符。

三引号的语法是一对连续的单引号或者双引号，例如：

```python showLineNumbers
>>> s = '''Hello
World'''
>>> s              # repr()
'Hello\nWorld'
>>> print (s)      # str()
Hello
World
```

三引号让程序员从引号和特殊字符串的泥潭里面解脱出来，自始至终保持一小块字符串的格式是所谓的 **WYSIWYG**（所见即所得）格式。

比如，当我们需要在 Python 程序中引用一大块 HTML 或者 SQL 语句时，三引号就非常好用！

```python showLineNumbers
errHTML = '''<!DOCTYPE html>
<meta charset="utf-8">
<title>Demo</title><
<h3>ERROR</h3>
<b>%s</b>
<form><input type="button" value="Back" 
onclick="window.history.back()"></form>
'''
cursor.execute('''
CREATE TABLE users (  
login VARCHAR(8), 
uid INTEGER,
prid INTEGER)
''')
```



## 字符串内建函数

Python 为字符串对象提供了许多内建函数，包括：

- 把字符串的第一个字符大写。

  ```python showLineNumbers
  string.capitalize()
  ```

- 返回一个原字符串居中，并使用空格填充至长度 width 的新字符串。

  ```python showLineNumbers
  string.center(width)
  ```

- 返回 str 在 string 里面出现的次数，如果 beg 或者 end 指定则返回指定范围内 str 出现的次数。

  ```python showLineNumbers
  string.count(str, beg=0, end=len(string))
  ```

- 以 encoding 指定的编码格式解码 string，如果出错默认报一个 ValueError 的异常，除非 errors 指定的是 'ignore' 或者 'replace'。

  ```python showLineNumbers
  string.decode(encoding='UTF-8', errors='strict')
  ```

- 以 encoding 指定的编码格式编码 string，如果出错默认报一个 ValueError 的异常，除非 errors 指定的是 'ignore' 或者 'replace'。

  ```python showLineNumbers
  string.encode(encoding='UTF-8', errors='strict')
  ```

- 检查字符串是否以 obj 结束，如果 beg 或者 end 指定则检查指定的范围内是否以 obj 结束，如果是，返回 True，否则返回 False。

  ```python showLineNumbers
  string.endswith(obj, beg=0, end=len(string))
  ```

- 把字符串 string 中的 tab 符号转为空格，tab 符号默认的空格数是 8。

  ```python showLineNumbers
  string.expandtabs(tabsize=8)
  ```

- 检测 str 是否包含在 string 中，如果 beg 和 end 指定范围，则检查是否包含在指定范围内，如果是返回开始的索引值，否则返回 -1。

  ```python showLineNumbers
  string.find(str, beg=0, end=len(string))
  ```

- 格式化字符串

  ```python showLineNumbers
  string.format()
  ```

- 跟 `find()`方法一样，只不过如果 str 不在 string 中会报一个异常。

  ```python showLineNumbers
  string.index(str, beg=0, end=len(string))
  ```

- 如果 string 至少有一个字符并且所有字符都是字母或数字则返回 True，否则返回 False。

  ```python showLineNumbers
  string.isalnum()
  ```

- 如果 string 至少有一个字符并且所有字符都是字母则返回 True，否则返回 False。

  ```python showLineNumbers
  string.isalpha()
  ```

- 如果 string 只包含十进制数字则返回 True，否则返回 False。

  ```python showLineNumbers
  string.isdecimal()
  ```

- 如果 string 只包含数字则返回 True，否则返回 False。

  ```python showLineNumbers
  string.isdigit()
  ```

- 如果 string 中包含至少一个区分大小写的字符，并且所有这些（区分大小写的）字符都是小写，则返回 True，否则返回 False。

  ```python showLineNumbers
  string.islower()
  ```

- 如果 string 中只包含数字字符，则返回 True，否则返回 False。

  ```python showLineNumbers
  string.isnumeric()
  ```

- 如果 string 中只包含空格，则返回 True，否则返回 False。

  ```python showLineNumbers
  string.isspace()
  ```

- 如果 string 是标题化的（参见 `title()`）则返回 True，否则返回 False。

  ```python showLineNumbers
  string.istitle()
  ```

- 如果 string 中包含至少一个区分大小写的字符，并且所有这些（区分大小写的）字符都是大写，则返回 True，否则返回 False。

  ```python showLineNumbers
  string.isupper()
  ```

- 以 string 作为分隔符，将 seq 中所有的元素（的字符串表示）合并为一个新的字符串。

  ```python showLineNumbers
  string.join(seq)
  ```

- 返回一个原字符串左对齐，并使用空格填充至长度 width 的新字符串。

  ```python showLineNumbers
  string.ljust(width)
  ```

- 转换 string 中所有大写字符为小写。

  ```python showLineNumbers
  string.lower()
  ```

- 截掉 string 左边的空格。

  ```python showLineNumbers
  string.lstrip()
  ```

- 创建字符映射的转换表，对于接受两个参数的最简单的调用方式，第一个参数 frm 表示需要转换的字符，第二个参数 to 表示转换的目标。

  ```python showLineNumbers
  string.maketrans(frm, to)
  ```

- 返回字符串 str 中最大的字母

  ```python showLineNumbers
  max(str)
  ```

- 返回字符串 str 中最小的字母。

  ```python showLineNumbers
  min(str)
  ```

- `partition()` 有点像 `find()` 和 `split()` 的结合体，从 str 出现的第一个位置起，把字符串 string 分成一个 3 元素的元组。

  ```python showLineNumbers
  string.partition(str)
  ```

- 把 string 中的 str1 替换成 str2，如果 num 指定，则替换不超过 num 次。

  ```python showLineNumbers
  string.replace(str1, str2, num=string.count(str1))
  ```

- 类似于 `find()` 函数，不过是从右边开始查找。

  ```python showLineNumbers
  string.rfind(str, beg=0,end=len(string))
  ```

- 类似于 `index()`，不过是从右边开始。

  ```python showLineNumbers
  string.rindex( str, beg=0,end=len(string))
  ```

- 返回一个原字符串右对齐，并使用空格填充至长度 width 的新字符串。

  ```python showLineNumbers
  string.rjust(width)
  ```

- 类似于 `partition()` 函数，不过是从右边开始查找。

  ```python showLineNumbers
  string.rpartition(str)
  ```

- 删除 string 字符串末尾的空格。

  ```python showLineNumbers
  string.rstrip()
  ```

- 以 str 为分隔符切片 string，如果 num有指定值，则仅分隔 num 个子字符串。

  ```python showLineNumbers
  string.split(str="", num=string.count(str))
  ```

- 按照行（`\r`、`\r\n`、`\n`）分隔，返回一个包含各行作为元素的列表，如果参数 keepends 为 False，不包含换行符，如果为 True，则保留换行符。

  ```python showLineNumbers
  string.splitlines(keepends)
  ```

- 检查字符串是否是以 obj 开头，是则返回 True，否则返回 False。如果 beg 和 end 指定值，则在指定范围内检查。

  ```python showLineNumbers
  string.startswith(obj, beg=0,end=len(string))
  ```

- 在 string 上执行 `lstrip()` 和 `rstrip()`。

  ```python showLineNumbers
  string.strip(obj)
  ```

- 翻转 string 中的大小写。

  ```python showLineNumbers
  string.swapcase()
  ```

- 返回"标题化"的 string，就是说所有单词都是以大写开始，其余字母均为小写。

  ```python showLineNumbers
  string.title()
  ```

- 根据 str 给出的表（包含 256 个字符）转换 string 的字符，要过滤掉的字符放到 del 参数中。

  ```python showLineNumbers
  string.translate(str, del="")
  ```

- 转换 string 中的小写字母为大写。

  ```python showLineNumbers
  string.upper()
  ```

- 返回长度为 width 的字符串，原字符串 string 右对齐，前面填充 0。

  ```python showLineNumbers
  string.zfill(width)
  ```

- isdecimal() 方法检查字符串是否只包含十进制字符，这种方法只存在于 unicode 对象。

  ```python showLineNumbers
  string.isdecimal()
  ```



