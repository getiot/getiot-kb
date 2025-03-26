---
sidebar_position: 5
---

# Python 快速上手



本文主要介绍运行 Python 程序的几种方式。通常来说，有 3 种方式可以运行 Python 程序，分别是直接使用 Python 交互式解释器、运行命令行脚本，以及在集成开发环境启动 Python 程序。



## 交互式解释器

可以通过命令行窗口（比如 Windows 的 CMD，Unix 的 shell）进入 python 并在交互式解释器中开始编写 Python 代码。在 Windows 中直接输入 python 即可，Unix 则要区分 python2 和 python3。

```shell
$ python3
Python 3.5.2 (default, Nov 12 2018, 13:43:14) 
[GCC 5.4.0 20160609] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> 
```

运行 python 解释器时还可以添加如下选项参数：

- `-d`：在解析时显示调试信息
- `-O`：生成优化代码（.pyo 文件）
- `-S`：启动时不引入查找 Python 路径的位置
- `-V`：输出 Python 版本号
- `-X`：从 1.6版本之后基于内建的异常（仅仅用于字符串）已过时。
- `-c cmd`：执行 Python 脚本，并将运行结果作为 cmd 字符串。
- `file`：在给定的python文件执行python脚本。



## 命令行脚本

在你的应用程序中通过引入解释器可以在命令行中执行 Python 脚本，比如：

```python showLineNumbers
#!/usr/bin/python3
```

下面是一个简单的 Python 脚本 hello.py：

```python showLineNumbers
#!/usr/bin/python3

print("Hello, World!")
```

在执行之前为其增加可执行权限：

```bash
chmod +x hello.py
```

现在，你可以在 Shell 终端运行该脚本啦！

```bash
$ ./hello.py 
Hello, World!
```



## 集成开发环境

有很多很好的 IDE 可以提高 Python 程序的开发效率，比如 [Sublime Text](http://www.sublimetext.com/) 和 [PyCharm](https://www.jetbrains.com/pycharm/download/)。

**Sublime Text：发烧友级**

现在已经发展到 Sublime Text3 了，它是非常流行的编辑器，基本上前端开发 HTML、CSS、JS 都用她。她是一个依赖于插件的、强大的、性感无比的、开源的编辑器！

ST3 具有代码高亮、语法提示、自动完成且反应快速的编辑器软件，不仅字体配色好看、具有华丽的界面，还支持插件扩展机制，用她来写代码，绝对是一种享受。相比于难于上手的 Vim，浮肿沉重的 Eclipse，VS，即便体积轻巧迅速启动的 Editplus、Notepad++，在 SublimeText 面前大略显失色，无疑这款性感无比的编辑器是 Coding 和 Writing 最佳的选择，没有之一。

当然，优点虽然很多，但也是有一些缺陷 —— 交互不是特别好，需要装一些插件来弥补。一般来说，Python 开发必装的有 Package Control、Emmet、PyV8、SublimeREPL（终端交互调试）、SublimeCodeIntel（代码提示）

**PyCharm：专业级**

如果说只能推荐一款 Python IDE，那么非 PyCharm 莫属，因为它的功能非常强大。

PyCharm 是由 JetBrains 打造的一款 Python IDE，支持 macOS、 Windows、 Linux 系统。PyCharm 具有很多实用的内置功能，比如：调试、语法高亮、Project管理、代码跳转、智能提示、自动完成、单元测试、版本控制…… 

而且这款神器结合了 Flask、Django、H5、AngularJS，对于 web 开发就不用再安装其他的 IDE 了。另外还有一个非常重要的功能就是支持代码重构，相信资深开发者都知道代码重构的重要性。

