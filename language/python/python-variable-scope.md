---
sidebar_position: 17
---

# Python 变量作用域



在 Python 中，变量定义之后就有了一定的使用范围，即变量的作用域。实际上，作用域就是一个 Python 程序可以直接访问命名空间的正文区域。特别的，Python 的代码区域通过缩进来区分。



## 四种作用域

Python 的作用域一共有四种，分别是：

- **L（Local）**：最内层，包含局部变量，比如一个函数/方法内部。
- **E（Enclosing）**：包含了非局部也非全局的变量。比如两个嵌套函数，一个函数（或类） A 里面又包含了一个函数 B ，那么对于 B 中的名称来说 A 中的作用域就为 nonlocal。
- **G（Global）**：当前脚本的最外层，比如当前模块的全局变量。
- **B（Built-in）**： 包含了内建的变量/关键字等，最后被搜索。

四种作用域的搜索顺序为 **L –> E –> G –> B**。如果在局部找不到，则去局部外的局部找（例如闭包），再找不到就会去全局找，最后去内置中找。

![Python 的四种变量作用域](https://static.getiot.tech/python-variable-scope.png#center)



## 局部作用域

在函数内部创建的变量属于该函数的局部作用域，并且只能在该函数内部使用。例如：

```python showLineNumbers
def myfunc():
    x = 100
    print(x)

myfunc()  # 100
print(x)  # 出错
```



## 全局作用域

在 Python 代码主体中创建的变量是全局变量，属于全局作用域。

全局变量在任何范围（全局和局部）中可用，例如：

```python showLineNumbers
x = 100

def myfunc():
    print(x)

myfunc()  # 100
print(x)  # 100
```

如果在函数内部和外部操作同名变量，Python 会将它们视为两个单独的变量，一个在全局范围内可用（在函数外部），而一个在局部范围内可用（在函数内部）。

```python showLineNumbers
x = 100

def myfunc():
    x = 200
    print(x)

myfunc()  # 200
print(x)  # 100
```



## Global 关键字

如果你需要创建一个全局变量，但被卡在本地作用域内，则可以使用 global 关键字。

global 关键字使变量成为全局变量，例如：

```python showLineNumbers
def myfunc():
    global x
    x = 100
    print(x)

myfunc()  # 100
print(x)  # 100
```

