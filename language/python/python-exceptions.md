---
sidebar_position: 27
---

# Python 异常处理



在 Python 中，“异常”是指在程序运行期间出现的错误，通常语法是正确的，但是运行时出错，比如除零操作、使用没有初始化的变量等等。而运行前发生的则称为“错误”，比如语法错误。



## try 语句

如果异常对象未被处理或捕获，程序就会出现回溯（traceback）并终止执行。所以要想写出高可靠性的 Python 代码，必须在可能出现异常的地方捕获并处理异常。Python 提供了 `try ... except` 语句来捕获异常，举个例子：

```python showLineNumbers
def div(dividend, divisor):
    try:
        quotient = dividend/divisor
        return quotient
    except ZeroDivisionError:
        print("除数不能为零啊，哥！")

print("div(4,2) => %d" %(div(4,2)))
print("div(4,0) => %d" %(div(4,0)))
```

执行结果如下：

```python showLineNumbers
div(4,2) => 2
除数不能为零啊，哥！
Traceback (most recent call last):
  File "except_error.py", line 9, in <module>
    print("div(4,0) => %d" %(div(4,0)))
TypeError: %d format: a number is required, not NoneType
```

在这个例子中，函数 `div()` 中的除零异常已经被捕获了，后面的 traceback 其实是格式化输出的异常，以为当除数为零时 `div()` 函数没有返回一个数字，所以 `div(4,0)` 得到的结果是 `None`。

Python 中异常处理的结构如下：

```python showLineNumbers
try:
    # 尝试执行的语句
except [ErrorType [as err] ]:
    # 捕获异常时执行的语句
else:
    # 没有异常时执行的语句
finally:
    # 无论如何最后都要执行的语句
```

在这个结构中，**`try`** 子句是必须的，**`except`** 子句、**`else`** 子句和 **`finally`** 子句都是可选的。也就是说，可以是 `try-except` 结构，或者 `try-except-else` 结构，或者 `try-finally` 结构，或者是完整的 `try-except-else-finally` 结构。

值得一提的是，异常的类型很多，所以 `except` 子句可以是一条或者多条；另外，当存在 `except` 子句时，`else` 子句才有意义，否则就相当于所有所有执行内容写在 `try` 子句中了。

`try` 语句的工作方式如下：

- 首先，执行 `try` 子句（在关键字 `try` 和关键字 `except` 之间的语句）；如果没有异常发生，忽略 `except` 子句，接着执行有 `else` 子句（如果有）；最后执行 `finally` 子句；
- 如果在执行 `try` 子句的过程中发生异常，那么 `try` 子句余下部分都会被忽略，转而执行 `except` 子句；
- 如果异常的类型和 `except` 后面的名称相符，那么对应 `except` 子句将被执行；
- `try` 语句可以嵌套使用，如果一个异常没有任何的 `except` 匹配，那么这个异常将会传递给上层的 `try` 中；
- 一个 `try` 语句可能包含多个 `except` 子句，分别来处理不同的（特定的）异常，最多只有一个分支会被执行；
- 一个 `except` 子句可以同时处理多个异常，这些异常将被放在一个括号里成为一个元组。

另外，还需要注意以下特性：

- 无论 `try` 里执行什么，即使是 `return`，也会调用 `finally` 的（无论是否有异常，最后都要做的一些事情）；
- `try` 子句的返回值会被 `finally` 的返回值覆盖；
- 如果 `try` 中没有异常，那么 `except` 部分将跳过，执行 `else` 中的语句；
- 但是如果 `try` 里面执行了 `return` 语句，就会跳过 `else` 子句，从而阻挡了 `else` 的执行，但是不会影响 `finally` 的执行。

因此，我们编写 Python 代码过程中应注意：如非必须，不要在 `try` 和 `else` 子句中写 `return` 语句，`return` 语句应该写在 `finally` 中（如果没有 `finally`，就写在最后）。

简单来说，就是 `try`、`except`、`else` 里都是 do something 的，Return 的工作就交给 `finally` 吧。



## 异常类型

在 Python 中，我们通过 `dir(__builtins__)` 可以看到内建的一些异常类型，各种异常及其说明如下：

| 异常名称                    | 描述                                                 |
| :-------------------------- | :--------------------------------------------------- |
| `BaseException`             | 所有异常的基类                                       |
| `SystemExit`                | 解释器请求退出                                       |
| `KeyboardInterrupt`         | 用户中断执行（通常是输入 Ctrl+C）                    |
| `Exception`                 | 常规错误的基类                                       |
| `StopIteration`             | 迭代器没有更多的值                                   |
| `GeneratorExit`             | 生成器（generator）发生异常来通知退出                |
| `StandardError`             | 所有的内建标准异常的基类                             |
| `ArithmeticError`           | 所有数值计算错误的基类                               |
| `FloatingPointError`        | 浮点计算错误                                         |
| `OverflowError`             | 数值运算超出最大限制                                 |
| `ZeroDivisionError`         | 除（或取模）零 （所有数据类型）                      |
| `AssertionError`            | 断言语句失败                                         |
| `AttributeError`            | 对象没有这个属性                                     |
| `EOFError`                  | 没有内建输入，到达 EOF 标记                          |
| `EnvironmentError`          | 操作系统错误的基类                                   |
| `IOError`                   | 输入/输出操作失败                                    |
| `OSError`                   | 操作系统错误                                         |
| `WindowsError`              | 系统调用失败                                         |
| `ImportError`               | 导入模块/对象失败                                    |
| `LookupError`               | 无效数据查询的基类                                   |
| `IndexError`                | 序列中没有此索引（index）                            |
| `KeyError`                  | 映射中没有这个键                                     |
| `MemoryError`               | 内存溢出错误（对于Python 解释器不是致命的）          |
| `NameError`                 | 未声明/初始化对象（没有属性）                        |
| `UnboundLocalError`         | 访问未初始化的本地变量                               |
| `ReferenceError`            | 弱引用（Weak reference）试图访问已经垃圾回收了的对象 |
| `RuntimeError`              | 一般的运行时错误                                     |
| `NotImplementedError`       | 尚未实现的方法                                       |
| `SyntaxError`               | Python 语法错误                                      |
| `IndentationError`          | 缩进错误                                             |
| `TabError`                  | Tab 和空格混用                                       |
| `SystemError`               | 一般的解释器系统错误                                 |
| `TypeError`                 | 对类型无效的操作                                     |
| `ValueError`                | 传入无效的参数                                       |
| `UnicodeError`              | Unicode 相关的错误                                   |
| `UnicodeDecodeError`        | Unicode 解码时的错误                                 |
| `UnicodeEncodeError`        | Unicode 编码时错误                                   |
| `UnicodeTranslateError`     | Unicode 转换时错误                                   |
| `Warning`                   | 警告的基类                                           |
| `DeprecationWarning`        | 关于被弃用的特征的警告                               |
| `FutureWarning`             | 关于构造将来语义会有改变的警告                       |
| `OverflowWarning`           | 旧的关于自动提升为长整型（long）的警告               |
| `PendingDeprecationWarning` | 关于特性将会被废弃的警告                             |
| `RuntimeWarning`            | 可疑的运行时行为（runtime behavior）的警告           |
| `SyntaxWarning`             | 可疑的语法的警告                                     |
| `UserWarning`               | 用户代码生成的警告                                   |



## 自定义异常

除了 Python 定义的异常之外，我们还可以自定义异常。自定义异常实际上就是定义一个类，让这个类继承 Exception 类（或其派生类）。但通常我们并不会使用自定义异常，所以了解即可。

举个栗子：

```python showLineNumbers
class NetworkError(RuntimeError):
    def __init__(self, arg):
        self.arg = arg

def connect():
    raise NetworkError("Bad hostname")

try:
    connect()
except NetworkError as err:
    print(err)
```

执行后输出：

```python showLineNumbers
Bad hostname
```



## 抛出异常

除了捕获异常，我们在 Python 中还可以抛出异常，或者称为触发异常。`raise` 语句的格式如下：

```python showLineNumbers
raise [Exception [, args [, traceback]]]
```

语句中 Exception 是异常的类型（例如 NameError）参数标准异常中任一种，args 是自已提供的异常参数。最后一个 traceback 参数是可选的（很少使用），如果存在，是跟踪异常对象。

举个栗子：

```python showLineNumbers
def func(num):
    if num < 1:
        raise Exception("Invalid level!", num)

try:
    func(0)
except Exception as err:
    print("No: %s" %(err))
```

执行后输出：

```python showLineNumbers
No: ('Invalid level!', 0)
```

