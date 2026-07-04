---
sidebar_position: 55
slug: /cpp-sizeof-classes
---

# C++ 类大小计算



## 概述

在 C++ 编程中，我们经常使用 Class 定义类，实现面向对象编程。和 C 语言中的 Struct 结构体一样，定义 Class 类也包括以下作用：

- 决定数据对象需要的内存数量；
- 决定如何解释内存中的位；
- 决定可使用数据对象执行的操作或方法。

但是，如果想要计算 Class 类的大小，就需要特别小心了！因为类的大小与它的构造函数、析构函数以及其他成员函数无关，只与它的数据成员相关。这和结构体的大小计算不一样！

Class 类大小的相关因素如下表所示：

| 类型     | 因素                                                         |
| -------- | ------------------------------------------------------------ |
| 有关因素 | **普通成员变量，虚函数、继承**（单一继承，多重继承，重复继承，虚拟继承） |
| 无关因素 | 静态成员变量、静态成员函数、普通成员函数                     |

下面通过一些简单的示例来加深理解，所有示例均运行在 64 位系统之上，相关代码位于 [GitHub](https://github.com/getiot/cpp-courses/tree/main/basic-syntax/class_size) 仓库。



## 示例

### 1. 空类的大小

示例代码：

```cpp showLineNumbers
#include <iostream>

class CBase
{
};

int main(void)
{
    std::cout << "sizeof(CBase) = " << sizeof(CBase)<< std::endl;
    return 0;
}
```

运行结果：

```bash
sizeof(CBase) = 1
```

为什么空的什么都没有是 1 呢？

先了解一个概念：类的实例化，所谓类的实例化就是在内存中分配一块地址，每个实例在内存中都有独一无二的地址。同样空类也会被实例化，所以编译器会给空类隐含的添加一个字节，这样空类实例化之后就有了独一无二的地址了。所以空类的 sizeof 为 1。



### 2. 一般非空类大小

示例代码：

```cpp showLineNumbers
#include <iostream>

class CBase
{
    int  a;
    char *p;
};

int main(void)
{
    std::cout << "sizeof(CBase) = " << sizeof(CBase)<< std::endl;
    return 0;
}
```

运行结果：

```bash
sizeof(CBase) = 16
```

在 64 位系统上运行的结果是 16，在 32 位系统上则为 8。因为在 64 位系统上指针的大小是 8 字节，而 32 位系统上指针大小是 4 字节。另外，由于字节对齐的问题，因此输出结果是 16 或者 8。



### 3. 普通成员函数

示例代码：

```cpp showLineNumbers
#include <iostream>

class CBase
{
    int  a;
    char *p;

    void FuncA();
};

int main(void)
{
    std::cout << "sizeof(CBase) = " << sizeof(CBase)<< std::endl;
    return 0;
}
```

运行结果：

```bash
sizeof(CBase) = 16
```

输出结果和上一个示例一样，这是因为类的大小与它的构造函数、析构函数和其他成员函数无关，只已它的数据成员有关。



### 4. 虚函数

示例代码：

```cpp showLineNumbers
#include <iostream>

class CBase
{
    int  a;
    char *p;

    virtual void FuncA();
};

int main(void)
{
    std::cout << "sizeof(CBase) = " << sizeof(CBase)<< std::endl;
    return 0;
}
```

运行结果：

```bash
sizeof(CBase) = 24
```

当 C++ 类中有虚函数的时候，会有一个指向虚函数表的指针（vptr），在 64 位系统分配指针大小为 8 字节，所以输出结果为 24。



### 5. 静态成员变量

示例代码：

```cpp showLineNumbers
#include <iostream>

class CBase
{
    int a;
    static int b;
};

int main(void)
{
    std::cout << "sizeof(CBase) = " << sizeof(CBase)<< std::endl;
    return 0;
}
```

运行结果：

```bash
sizeof(CBase) = 4
```

静态数据成员被编译器放在程序的一个 global data members 中，它是类的一个数据成员。但是它不影响类的大小，不管这个类实际产生了多少实例，还是派生了多少新的类，静态成员数据在类中永远只有一个实体存在。

而类的非静态数据成员只有被实例化的时候，它们才存在。但是类的静态数据成员一旦被声明，无论类是否被实例化，它都已存在。可以这么说，类的静态数据成员是一种特殊的全局变量。

所以在该示例中，CBase 类的大小就是 int a 变量的 4 字节。


