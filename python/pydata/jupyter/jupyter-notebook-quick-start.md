---
sidebar_position: 3
slug: /jupyter-notebook-quick-start
---

# Jupyter Notebook 使用方法

本节主要介绍 Jupyter Notebook 的基本使用方法，让你对 Jupyter Notebook 的使用有一个大致的认识。

## 快捷键

- `Ctrl` + `Enter` ：只运行单元格，后面不增加新的单元格
- `Shift` + `Enter` ：运行单元格，运行介绍后跳到下一个单元格，如果没有则增加一个单元格
- `Alt` + `Enter` ：运行单元格，不管后面有没有单元格，都会在后面增加一个单元格
- `Esc` ：进入 Vim 模式



## Jupyter 魔法命令

Jupyter 为我们提供了很多特殊的高级用法，我们把这些命令称为魔法命令。掌握这些魔法命令，会使我们更好地使用 Jupyter Notebook。



**%load**

作用：导入文件内容，并不会执行

示例：

```python showLineNumbers
%load my/hello.py
```

**%run**

作用：直接运行 Python 文件

示例：

```python showLineNumbers
%run my/hello.py
```

**%timeit**

作用：循环测试，获取执行时间，后面只能跟一句代码

示例：

```python showLineNumbers
%timeit li = [i**2 for i in range(1000)]
```

多行模式：

```python showLineNumbers
%%timeit
li = []
for i in range(1000):
	li.append(i**2)
```

**%time**

作业：只测量一次，获取执行时间

示例：

```python showLineNumbers
import random
li = [random.random() for i in range(100000)]
#%timeit li.sort()
%time li.sort()
```

多行模式：

```python showLineNumbers
%%time
```

**%%html**

作用：执行前端代码

示例：

```html showLineNumbers
%%html
<div class='mytest' style='color:red'>
    html test
</div>
```

**%%js**

作用：执行JavaScript代码

示例：

```javascript showLineNumbers
%%js
document.querySelector(".mytest").innerHTML = 'new content';
```

**%%writefile**

作用：将单元格中的内容写入文件

示例：

```python showLineNumbers
%%writefile "test.py"
import random
li = [random.random() for i in range(100000)]
%time li.sort()
```



## 总结

| 魔法命令      | 作用                                                         |
| ------------- | ------------------------------------------------------------ |
| `%load`       | 导入文件内容，并不会执行                                     |
| `%run`        | 直接运行 Python 文件                                         |
| `%timeit`     | 获取执行时间，后面只能跟一句代码，如果测试多行语句则用 `%%timeit` |
| `%time`       | 获取执行时间（执行1次），如果测试多行语句则用 `%%time`       |
| `%%html`      | 执行前端代码                                                 |
| `%%js`        | 执行JavaScript代码                                           |
| `%%writefile` | 将单元格中的内容写入文件                                     |



在 Jupyter 中，由于 `import` 导入一次后就不会重新导入，即便相应的 python 模块被修改了。这时候，使用 `%run` 就比较灵活。



此外还可以**执行系统命令**，并返回结果。只需在系统命令前面加一个感叹号即可

```
!ls -l
```

