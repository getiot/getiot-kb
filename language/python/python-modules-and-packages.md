---
sidebar_position: 38
---

# Python 模块和包

为了使 Python 代码逻辑更加清晰、更容易维护，通常我们会把不同功能的函数进行分组，分别存放在不同的源文件。这些不同功能的 .py 文件，就被称为**模块**（Module）。



## 模块定义

简单来说，Python 模块（Module）就是一个 Python 文件，它以 .py 结尾，其中包含了 Python 对象定义和功能实现。

实际上，Python 模块和包没啥区别，一样可以定义函数、类和变量，以及相关的功能执行代码。唯一的区别是，包的目录需要包含一个 `__init__.py` 文件，而且这个文件可以是空文件。

自定义模块

- 在导入一个包的时候，Python 会根据 sys.path 中的目录来寻找这个包中包含的子目录。
- 目录只有包含一个叫做 `__init__.py` 的文件才会被认作是一个包，主要是为了避免一些滥俗的名字（比如叫做 `string`）不小心的影响搜索路径中的有效模块。
- 最简单的情况，放一个空的 :`file:__init__.py`就可以了。当然这个文件中也可以包含一些初始化代码或者为（将在后面介绍的）`__all__`变量赋值。



## 模块导入

**import 语句**

想使用 Python 源文件，只需在另一个源文件里执行 import 语句，语法如下：

```python showLineNumbers
import module1[, module2[,... moduleN]
import random

random.choice([0,1,2,3,4,5])  #随机从列表中获取一个

random.randrange(1,10)  #1~9随机一个
import time

# 格式化成2016-03-20 11:45:39形式
print (time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()))
```

**from-import 语句**

Python的from语句让你从模块中导入一个指定的部分到当前命名空间中，语法如下：

```python showLineNumbers
from modname import name1[, name2[, ... nameN]]
from time import strftime,localtime

# 格式化成2016-03-20 11:45:39形式
print (strftime("%Y-%m-%d %H:%M:%S", localtime()))
```



## 模块安装

第三方模块可以使用 pip 安装。

- 使用 pip 命令安装
  - `pip install 模块名`
  - `pip uninstall 模块名`
  - `pip freeze` 查看都安装了哪些模块名
- whl 下载安装的方式
  - 网址： [https://www.lfd.uci.edu](https://www.lfd.uci.edu/~gohlke/pythonlibs/) 下载
  - 安装：`pip install 文件包名`
- 直接复制的方式
- anaconda

