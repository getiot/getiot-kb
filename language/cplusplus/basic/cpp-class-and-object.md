---
sidebar_position: 28
slug: /cpp-class-and-object
---

# C++ 类和对象



C++ 是面向对象的编程语言，对象就是面向对象程序设计的核心。所谓对象就是真实世界中的实体，对象与实体是一一对应的，也就是说现实世界中每一个实体都是一个对象，它是一种具体的概念。本文主要介绍 C++ 类和对象。

面向对象编程（Object Oriented Programming，简称 OOP）是 C++ 与 C 语言的最大区别，而类和对象就是 C++ 面向对象的基础，对类和对象具有深刻的理解，对于编写 C++ 程序来说有很大帮助。



## 什么是类

具有相同特性（数据元素）和行为（功能）的对象的抽象就是类。因为类本身只是一个抽象，因此并不能直接拿来用，我们必须先定义类，然后根据类创建对象，然后才可以使用对象里面的属性和方法。

类（class）是 C++ 的核心特性，通常被称为用户定义的类型，目的是将一组数据打包成一个结构，这一点和[结构体](/cplusplus/cpp-struct/)（struct）的概念类似。不过，C++ 中的类比结构体有更多特性。



## 定义 C++ 类

定义一个类，本质上是定义一个数据类型的蓝图，也就是说，它定义了类的对象包括了什么，以及可以在这个对象上执行哪些操作。

语法：

```cpp showLineNumbers
class ClassName      // 类名
{
PropertyModifier:    // 修饰符
    propertoys   // 属性列表
    functions    // 函数列表
};
```

C++ 类定义的细节：

1. 类定义是以关键字 `class` 开头，后跟类的名称；
2. 类的主体是包含在一对花括号（`{ }`）中；
3. 类定义后必须跟着一个分号（`;`）或一个声明列表；
4. 修饰符用于修饰属性和函数，有 public、protected、private 三种。

下面的代码使用关键字 `class` 定义 Box 数据类型：

```cpp showLineNumbers
class Box
{
public:
    double length;   // 盒子的长度
    double width;    // 盒子的宽度
    double height;   // 盒子的高度
};
```

关键字 `public` 确定了类成员的访问属性。在类对象作用域内，公共成员在类的外部是可访问的。

除了 `public`，还可以使用 `private` 或 `protected`，这个我们稍后会进行讲解。



## 创建对象

类提供了对象的蓝图，所以根据类来创建的对象（Object），对象也称为实例（Instance）。创建对象的语法如下：

```cpp showLineNumbers
Classname classVar(param);
```

其中，Classname 是预先定义好的类，classVar 是对象名称，括号中的 param 是这个类的构造函数的参数列表。这个过程也称为“实例化”。

如果构造函数没有任何参数，那么我们在对象后面就不可以加小括号，这种情况就跟创建基本数据类型或结构体的变量一样。

例如，下面示例声明了类 Box 的两个对象：

```cpp showLineNumbers
Box box1;          // 声明 box1，类型为 Box
Box box2;          // 声明 box2，类型为 Box
```

对象 box1 和 box2 都有它们各自的数据成员。



## 访问数据成员

类的对象的公共数据成员可以使用直接成员访问运算符（`.`）来访问，例如：

```cpp showLineNumbers
double len = box.length;  // 获取盒子的长度
```

注意，私有的成员（private）和受保护的成员（protected）是不能使用直接成员访问运算符（`.`）来直接访问。



## 构造函数

在 C++ 中，当我们创建一个类时，编译器会自动为其添加一个跟类名一样的函数，该函数没有任何的返回值，且该函数不做任何操作，这个函数就是默认的构造方法（或构造函数）。构造方法用于创建对象时使用，每当创建一个类的实例对象时，C++ 解释器都会自动调用它。

默认的构造函数是没有任何参数的，但是 C++ 允许我们重写该函数，为其设置任意多个和任意类型的参数。如果我们在构造函数里设置了参数，那么在实例化类对象的时候，必须要传入相对应的参数。

类构造函数的定义：

```cpp showLineNumbers
class Classname
{
public:
    Classname(){}	
};
```

C++ 构造方法的名字与类名完全一致，该函数默认没有任何参数，并且是自动调用，不需要我们手动调用。

示例：创建构造函数参数为空的类对象

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Box
{
public:
    Box()
    {
        cout << "Create a Box" << endl;
    }
    double length;   // 盒子的长度
    double width;    // 盒子的宽度
    double height;   // 盒子的高度
};

int main(void)
{
    Box box;
    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
Create a Box
```

下面示例将演示如何使用带参数的构造函数，实例化时需要传入对应的参数。

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Box
{
public:
    Box()
    {
        cout << "Create a Box" << endl;
    }

    Box(double length, double width, double height)
    {
        this->length = length;
        this->width  = width;
        this->height = height;
    }

    double length;   // 盒子的长度
    double width;    // 盒子的宽度
    double height;   // 盒子的高度
};

int main(void)
{
    Box box(30, 20, 10);

    cout << "Length = " << box.length << ", ";
    cout << "Width = " << box.width << ", ";
    cout << "Height = " << box.height << endl;

    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
Length = 30, Width = 20, Height = 10
```



## 析构函数

在 C++ 中，构造函数用来做一些类的初始化工作，而且是系统自动调用。同样，在类被销毁时，系统还提供了一个析构函数，用来做一些清理工作，比如释放分配的内存、关闭打开的文件等。和构造函数一样，析构函数也是系统自动调用。

析构函数（Destructor）也是一种特殊的成员函数，没有返回值，不需要程序员显式调用（程序员也没法显式调用），而是在销毁对象时自动执行。构造函数的名字和类名相同，而析构函数的名字是在类名前面加一个 `~` 符号。

析构函数没有参数，不能被重载，因此一个类只能有一个析构函数。如果用户没有定义，编译器会自动生成一个默认的析构函数。

示例：给 Box 类添加析构函数

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Box
{
public:
    Box()
    {
        cout << "Create a Box" << endl;
    }

    Box(double length, double width, double height)
    {
        this->length = length;
        this->width  = width;
        this->height = height;
    }

    ~Box()
    {
        cout << "Delete a Box" << endl;
    }

    double length;   // 盒子的长度
    double width;    // 盒子的宽度
    double height;   // 盒子的高度
};

int main(void)
{
    Box box(30, 20, 10);

    cout << "Length = " << box.length << ", ";
    cout << "Width = " << box.width << ", ";
    cout << "Height = " << box.height << endl;

    return 0;
}
```

编译和运行以上示例，输出结果如下：

```bash
Length = 30, Width = 20, Height = 10
Delete a Box
```

