---
sidebar_position: 54
slug: /cpp-keyword-using
---

# C++ using 关键字



本文介绍 C++ using 关键字的几种用法，包括声明、指示（引入命名空间）和类型重定义（取代 typedef）。



## using 声明

using 声明（using declaration）是将命名空间中单个名字注入到当前作用域的机制，使得在当前作用域下访问另一个作用域下的成员时无需使用限定符 `::`。

using 声明将其它 namespace 的成员引入本命名空间的 **当前作用域** (包括其嵌套作用域)  。一个 using 声明一次只引入一个命名空间成员，它使得无论程序中使用哪些名字，都非常准确。



## using 指示（引入命名空间）

using 指示（using directive）是使一个命名空间中的 **所有** 名字都在该作用域中可见的机制，这是最常用的方式。不过，需要注意命名冲突问题。

尽管 using 指示很方便，但在实际工作中应该尽量避免：它一下子将另一个 namespace 中的成员全部引入了，一不小心就会出现命名空间污染问题。



## 类型重定义，取代 typedef

这是 C++11 中的新用法，使用 using 比使用 typedef 更能表达别名的定义。语法格式如下：

```cpp showLineNumbers
using alias = typename
```

示例：

```cpp showLineNumbers
using fun = void (*)(int, int);
typedef void (*fun)(int, int); // 与上一句等价

using int16 = short;
typedef short int16;           // 与上一句等价
```


