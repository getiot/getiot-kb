---
sidebar_position: 7
---

# Python 基础语法

本文主要介绍 Python 编程所需的一些基本概念、背景知识和基础语法。




## 背景知识

### 编码

Python 3.x 相比于 Python 2.7 最大的一个改变就是使用 Unicode 作为默认编码。Pyhton 2.x 中直接写中文会报错，而 Python 3.x 中可以直接写中文了，并且允许使用中文作为变量名（但不推荐）。 

因此，如果你看 Python 2.x 的代码，可能经常会遇到文件头有如下声明，用于指定 UTF-8 编码。

```python showLineNumbers
# -*- coding:utf-8 -*-
```

从开源项目看，支持 Python 3.x 的比例已经大大提高，通常知名的项目都会支持 Python 2.7 和 Python 3.x。



### 标识符和关键字

在 Python 中，标识符由**字母**、**数字**和**下划线**组成，但不能以数字开头，并且字母是区分大小写的。

值得注意的是，下划线在 Python 标识符中有特殊的意义：

- 以单下划线开头 `_foo` 的代表不能直接访问的类属性，需要通过类提供的接口进行访问，不能用 `from xxx import *` 而导入；
- 以双下划线开头的 `__foo` 代表类的私有成员；
- 以双下划线开头和结尾的 `__foo__` 代表 Python 里特殊方法专用的标识，如 `__init__()` 代表类的构造函数。

Python 的关键字也称为保留字，我们不能用关键字作为标识符名称。那我们怎么知道 Python 里面有哪些关键字呢？  

使用 keyword 模块来查看：

```python showLineNumbers
>>> import keyword
>>> keyword.kwlist
['False','None','True','and','as','assert',
 'break','class','continue','def','del',
 'elif','else','except','finally','for','from',
 'global','if','import','in','is','lambda',
 'nonlocal','not','or','pass','raise','return',
 'try','while','with','yield']
```



### 模块导入机制

关于 “模块导入”，Python 官方给出的解释是这样的：Python code in one module gains access to the code in another module by the process of importing it.

意思就是说：Python 的模块太多啦，总不能把代码都写一块去吧？所以为了便于相互协作和后期维护，我们要把功能封装成模块，然后通过导入模块来复用代码。于是，我们就可以像上面的例子中 `import keyword` 来导入 keyword 模块，然后就可以访问模块中的函数和变量啦。 

通常，模块有以下几种导入方式：

```python showLineNumbers
# 导入一个模块
import module_name

# 导入多个模块
import module_name1, module_name2

# 导入模块中的指定的属性、方法（不加括号）、类
from moudule_name import moudule_element [as new_name]
```

`import` 某一模块，相当于在当前环境中把某块内的代码执行一遍，使得该模块定义的变量、方法可见。为防止名称冲突，引用时通过 **模块名.变量名**（`module.variable`）的方式访问。如果在当前环境中还有同样名字的变量 variable，它们俩之间是没有任何关系的，引用时要区分开。 

“`import module_name`” 的本质是将 ”module_name.py” 中的全部代码加载到内存并**赋值给与模块同名的变量**写在当前文件中，这个变量的类型是 module。 

如果代码中有多个地方需要重复调用同一个模块的同一个方法或变量，每次调用时， Python 都需要重复查找模块。所以可以使用 ”`from module_name import module_element`“ 进行优化，减少了查找的过程。 

另外，import 是具有层次性质的，即在当前模块中 `import module_name` 模块，那么，当前模块是不能访问 module_name 模块中 import 其他模块的对象的！

那么问题来了，模块从哪里导入？又能导入哪些模块呢？ 

Python 在模块导入的时候，默认先在当前目录下查找，然后再到系统中查找。系统查找的范围是 sys.path 下的所有路径，并且按顺序查找。

```python showLineNumbers
>>> import sys
>>> sys.path
['',
 '/usr/lib/python35.zip',
 '/usr/lib/python3.5',
 '/usr/lib/python3.5/plat-x86_64-linux-gnu',
 '/usr/lib/python3.5/lib-dynload',
 '/usr/local/lib/python3.5/dist-packages',
 '/usr/lib/python3/dist-packages']
```

执行 `sys.modules` 可以列出 Python 启动时导入的模块，当某个模块第一次导入时，sys.modules 会自动记录该模块，后面再次导入该模块时，则直接查询 sys.modules，从而加快程序运行速度。实际上，sys.modules 是一个全局字典，因此可以使用字典所拥有的一切方法，比如 `sys.modules.keys()`。



### 模块和包的区别

**模块（module）**：用来从逻辑（实现一个功能）上组织 Python 代码（变量、函数、类），本质就是 *.py 文件。文件是物理上组织方式 ”module_name.py“，模块是逻辑上组织方式 ”module_name“。如果需要引用其他模块内的变量、方法或对象，在模块内还可以 import 进其他模块。

**包（package）**：定义了一个由模块和子包组成的 Python 应用程序执行环境，本质就是一个有层次的文件目录结构（必须带有一个 `__init__.py` 文件）。

我们可以通过 `pip3 freeze` 命令可以查看当前 Python 环境中已安装的包。



### 内建函数和库函数

内建模块（built-in modules）是 Python 解释器实现的模块（C 语言编写），它为 Python 程序直接提供操作接口，包括数据类型、文件 I/O 等常用的函数。如果没有这些 built-in 模块，Python 也将失去意义。实际上，内建函数也属于 Python 标准库的一部分。 

内建函数都在 `__builtins__` 模块里面，在 Python 程序中，我们可以直接（global）使用它们，通过 “`dir(__builtins__)`” 可以查看 Python 中的内建函数。

标准库（Standard Library）提供了很多 Python 编写的模块和函数，它们通常都是针对某一个特定的功能而设计的，比如 os、sys、time、datetime、math、urllib 模块等等。如果你使用的是 Windows 平台的 Python 环境，通常已经安装了完整的标准库和很多额外的软件包。不幸的是，如果你和我一样使用类 Unix 系统，那么通常只会安装 Python 解释器珍藏的那部分库，所以你还需要根据实际情况安装更多的软件包。 

好消息是，有一个 PyPI（Python Package index）的网站收集了成千上万来自全球各地的 Python 模块。所以，我们推荐使用 pip 工具来安装相应的模块。比如使用如下命令安装 paho-mqtt 包：

```shell
pip3 install paho-mqtt
```

除了内建函数，其他函数（包括标准库和第三方模块）都需要 import 关键字导入模块才能使用。第三方模块一般安装在 dist-packages 或 site-packages 目录下。




## 编码风格

Python 的编程风格和其他语言不太一样，最明显的区别是 Python 使用缩进来区分代码区块和变量作用域，而其他语言通常使用花括号（`{...}`）来区分。

关于 Python 的风格规范，可以参考《[Google 开源项目风格指南](https://zh-google-styleguide.readthedocs.io/en/latest/google-python-styleguide/python_style_rules/)》。

### 分号

不同于 C/C++ 和 Java，Python 的每一行（语句）不需要在行尾加分号。因此，不要用分号将两条命令放在同一行。

```python showLineNumbers
a = 1; b = 2;  # 不建议

a = 1          # 建议
b = 2
```



### 缩进

Python 是一门用空格缩进来区分代码层次的语言。但是 Python 并没有强制要求用 Tab 缩进还是用空格缩进，甚至连空格按几个都没有强制要求。不过，[PEP8](https://www.python.org/dev/peps/pep-0008/) 规范建议四个空格为语句的缩进块。

```python showLineNumbers
if True:
    print("Hello girl!")
else:
    print("Hello boy!")
```

用缩进来控制不同的语句块是 Python 的一大特色，缩进也让 Python 的代码更优美，简洁。



### 注释

Python 支持单行注释和多行注释，单行注释以 `#` 开头，例如：

```python showLineNumbers
# 这是一个注释
print("Hello, World!")
```

多行注释用三个单引号（`'''`）或者三个双引号（`"""`）将注释括起来，例如：

```python showLineNumbers
#!/usr/bin/python3 
'''
这是多行注释，用三个单引号
这是多行注释，用三个单引号 
这是多行注释，用三个单引号
'''
print("Hello, World!")
```

或者

```python showLineNumbers
#!/usr/bin/python3 
"""
这是多行注释，用三个单引号
这是多行注释，用三个单引号 
这是多行注释，用三个单引号
"""
print("Hello, World!")
```

注意：开头的 `#!/usr/bin/python3 ` 并不是注释，而是引入解释器。

