---
sidebar_position: 40
slug: /unit-testing-frameworks
---

# 单元测试框架

C/C++

- Google Test
- Boost.Test
- CTest
- MiniUnit

Python

- unittest（PyUnit）
- nose
- pytest

https://zhuanlan.zhihu.com/p/68088736



Java

- JUnit



## CppUnit



## GoogleTest

https://groups.google.com/g/pongba/c/B1hvRcq41zo

googletest 与 CppUnit 相比，有两个特点：

\1. 使用简单，写 test case 不用分成声明和定义两部分，也不用自己注册 test suite。

CppUnit 是从jUnit移植而来，而 C++ 没有 Java 那样的反射机制（和annotation，也没有C#那样的代码元数据 attribute，所以一般需要自己注册各个 test case。虽然 CppUnit 提供了一些宏，但是按照 C++ 成员函数 定义/声明 分离的原则，加一个test case还是得两头改。
而googletest采用了类似CppUnitLite的宏，让写test case就像写一个函数那样简单。

\2. ASSERT 种类与信息更丰富。

googletest 中，你写ASSERT_LE(orderAmount, allowedAmount);表明 orderAmount 不大于 allowedAmount。如果这条assert没通过，那么出错信息里不仅有 orderAmount 和 allowedAmount 的值，还会有 "orderAmount" 和 "allowedAmount" 这两个字符串。这是用反射没法做到的，只能用宏实现。

当然，googletest还可以做"死亡测试"，即测试那些让程序退出的代码段。googletest 能 fork() 出一个新进程，然后检查新进程的exit status或新进程的死亡原因（kill by signal等）。

另外：Google C++ Coding Standards: http://code.google.com/p/google-styleguide/
