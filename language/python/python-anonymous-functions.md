---
sidebar_position: 24
---

# Python 匿名函数



## lambda 表达式

在 Python 中，匿名函数使用关键字 `lambda` 来定义，而不再使用 `def` 语句这样标准的形式定义一个函数。

举个栗子：

```python showLineNumbers
def add(v1, v2):
    return v1+v2

sum = lambda v1,v2:v1+v2

print("type(add)", type(add))
print(add(10, 20))
print("type(sum)", type(sum))
print(sum(10, 20))
```

输出结果如下：

```python showLineNumbers
type(add) <class 'function'>
30
type(sum) <class 'function'>
30
```

可以看到，lambda 只是一个表达式，函数体比 def 简单得多。



## 匿名函数的限制

匿名函数的定义简单，有如下一些特性与限制：

- 语法：lambda 函数的语法只包含一个语句，如：

  ```python showLineNumbers
  lambda [arg1 [,arg2, …, argn]]:expression
  ```

- lambda 主体是一个表达式，而不是代码块。仅仅能在 lambda 表达式中封装有限的逻辑进去；

- lambda 函数拥有自己的命名空间，且不能访问自己参数列表之外或全局命名空间里的参数；

- 虽然 lambda 函数看起来只能写一行，却不等同于 C 或 C++ 的内联函数，后者的目的是调用小函数时不占用栈内存从而增加运行效率；

