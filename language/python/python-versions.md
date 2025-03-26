---
sidebar_position: 2
---

# Python 版本



## Python 版本演进

- Python 1.0 - January 1994 增加了 lambda, map, filter and reduce.
- 1999年 Python的web框架之祖——Zope 1发布。
- Python 2.0 - 2000年10月16日发布，加入了内存回收机制，构成了现在 Python 语言框架的基础。
- Python 2.4 – 2004年11月30日发布，同年目前最流行的 Web 框架 Django 诞生。
- Python 2.5 - 2006年09月19日发布。
- Python 2.6 - 2008年10月01日发布。
- Python 2.7 - 2010年07月03日发布。
- Python 3.0 - 2008年12月03 日发布。
- Python 3.1 - 2009年06月27日发布。用 C 语言实现 io 模块，新增 OrderedDict 类。
- Python 3.2 - 2011年02月20日发布。新增 argparse、html 等模块，标准库进行了大量改进。
- Python 3.3 - 2012年09月29日发布，新增 yield from 语法。
- Python 3.4 - 2014年03月16日发布，集成 pip 工具，新增 enum、pathlib、statistics、selectors 等模块。
- Python 3.5 - 2015年09月13日发布，为协程新增 async 和 await 语句，增加 ”异步迭代器“，新增矩阵乘法运算符 @。
- Python 3.6 - 2016年12月23日发布，在 `f""` 修饰的字符串里直接使用变量，新增 ”异步生成式“，新增 Variable Annotations 用于静态分析代码，更简便地自定义类的创建。
- Python 3.7 - 2018年06月15日发布，新增内置函数 `breakpoint()`，新增 UTF-8 模式。



> 每一个版本都有大量的更新，更新详情请查看每个版本的 Python 文档中的 ”What's New In Python x.x“



## 选择 Python2 还是 Python3

Python2.7 是 2.x 系列的最后一个版本，已经停止开发，不再增加新功能。2020年终止支持。所有的最新的标准库的更新改进，只会在 3.x 的版本里出现。Guido 决定清理 Python2.x ，并且不再兼容旧版本。

Python3 最大的一个改变就是使用 Unicode 作为默认编码。Pyhton2.x 中直接写中文会报错，Python3 中可以直接写中文了。从开源项目看，支持 Python3 的比例已经大大提高，知名的项目一般都支持 py2.7 和 py3+。

简单来说，Python3 比 Python2 更规范统一、去掉了没必要的关键字 Python3.x 还在持续改进。所以，我们还是推荐大家使用 Python3.x。


