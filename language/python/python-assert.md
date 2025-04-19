---
sidebar_position: 28
---

# Python 断言



在 Python 中，除了使用 [try 语句](/python/python-exceptions/)来处理程序运行中出现的异常，还可以使用断言（Assertions）也可以处理异常。



## assert 语句

断言使用 `assert` 关键字，它的语法格式为：

```python showLineNumbers
assert Expression[, Arguments] 
```

当它遇到一个断言语句，Python 解释器评估计算之后的表达式，希望是 True 值。如果表达式为 False，就会触发 AssertionError 异常。异常参数（Arguments）其实就是在断言表达式后添加字符串信息，用来解释断言并更好的知道是哪里出了问题。

理解断言的最简单的方法就是把它比作 **raise-if** 语句（更确切来说是 **raise-if-not**）。即对一个表达式进行测试，如果结果为 False，则触发异常。也就是说，assert expression 语句等价于：

```python showLineNumbers
if not expression:
    raise AssertionError
```

如果断言失败，Python 使用 Arguments 作为 AssertionError 异常的参数。同样可以用 **try-except** 语句来捕获并处理 AssertionError 异常，但是如果没有处理 AssertionError，Python 将终止该程序并产生一个回溯。

assert 判断的是表达式，如果需要同时判断多个表达式，可以这样：

```python showLineNumbers
assert (expression1 and expression2), "prompt..."
```



## 调试模式

实际上，断言是一种理智检查，通常用于开发阶段，在需要确保某个条件一定为真才能让程序正常工作的情况就很适合使用断言。比如，程序员常常放置断言来检查输入的有效，或在一个函数调用后检查有效的输出。当程序的测试完成，可以选择将断言打开或关闭。

关闭断言的方法是在执行 Python 程序的时候加上 `-O` 参数，如下：

```shell
python -O 源文件
```

assert 语句不应用于必须执行以确保程序正确的代码，因为如果 Python 运行在最优模式中（通过对解释器使用 -O 选项进入该模式），assert 语句将会被忽略。特别是不能用 assert 语句检查用户输入，相反，assert 语句用于检查应该始终为真的内容。如果 assert 引发异常，这意味着程序中存在 bug，而不是用户出现了错误。因此，对于诸如检查输入是否有效的操作，应该使用传统的 if 语句和相应的错误处理代码替换 assert 语句。

除了 assert 语句之外，Python 还提供内置的只读变量 `__debug__`， 除非解释器运行在最优模式中（通过使用 `-O` 选项指定），否则它的值为 True。在运行额外的错误检查过程时，程序可能在需要时检查这个变量。

`__debug__` 变量的底层实现在解释器中经过了优化，因为实际上没有包含 if 语句本身的额外控制流逻辑。如果 Python 运行在普通模式中，`if __debug__` 语句下的语句就会内联到没有 if 语句本身的程序中。而在最优模式中，`if __debug__` 语句以及所有相关语句都将从程序中完全删除。

使用 `assert` 和 `__debug__` 语句可以对程序进行高效的双模式开发。例如在调试模式中，可以随意地在代码中加入断言和调试检查，以便验证操作正确与否。在最优模式中，将省略所有这些额外的检查，以免造成额外的性能负担。

