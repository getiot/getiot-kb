---
sidebar_position: 39
slug: /cpp-data-encapsulation
---

# C++ 数据封装



**封装**是面向对象四大特性之一（封装、抽象、继承和多态），是面向对象编程中把数据和操作数据的函数绑定在一起的一个概念，这样能避免数据受到外界的干扰和误用，从而确保了安全。

数据封装引申出了另一个重要的 OOP 概念，即**数据隐藏**。



## 数据抽象

所有的 C++ 程序都有以下两个基本要素：

- **函数**：这是程序中执行动作的部分。
- **程序数据**：数据是程序的信息，会受到程序函数的影响。

**数据封装**是一种把数据和操作数据的函数捆绑在一起的机制。**数据抽象**是一种仅向用户暴露接口而把具体的实现细节隐藏起来的机制。



## 数据隐藏

C++ 通过创建类来支持封装和数据隐藏（public、protected、private）。

我们[之前](/cplusplus/cpp-class-and-object/)学到，类包含私有成员（private）、保护成员（protected）和公有成员（public）成员。默认情况下，在类中定义的所有项目都是私有的（private）。

例如：

```cpp showLineNumbers
class Box
{
public:
    double getVolume(void)
    {
        return length * width * height;
    }
private:
    double length;      // 长度
    double width;       // 宽度
    double height;      // 高度
};
```

变量 `length`、`width` 和 `height` 都是私有的（private）。这意味着它们只能被 `Box` 类中的其他成员访问，而不能被程序中其他部分访问。这就是 C++ 通过类实现实现数据封装的一种方式。

为了使类中的成员变成公有的，使程序中的其他部分也能访问，必须在这些成员前使用 `public` 关键字进行声明。所有定义在 `public` 标识符后边的变量或函数可以被程序中所有其他的函数访问。

**注意**：把一个类定义为另一个类的友元类，会暴露实现细节，从而降低了封装性。在设计程序时，应尽可能地对外隐藏每个类的实现细节。



## 示例

C++ 程序中，任何带有公有和私有成员的类都可以作为数据封装和数据抽象的示例。

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Adder
{
public:
    // 构造函数
    Adder(int i = 0) {
        total = i;
    }
    
    // 对外的接口
    void addNum(int number) {
        total += number;
    }
    
    // 对外的接口
    int getTotal() {
        return total;
    };
    
private:
    // 对外隐藏的数据
    int total;
};

int main(void)
{
    Adder a;
    
    a.addNum(13);
    a.addNum(17);
    a.addNum(29);
    
    cout << "Total " << a.getTotal() << endl;
    return 0;
}
```

执行 `g++ main.cpp && ./a.out` 编译运行以上示例，输出结果如下：

```bash
Total 59
```

该示例中，`Adder` 类的公有成员 `addNum()` 和 `getTotal()` 是对外的接口，用户需要知道它们以便使用类。而私有成员 `total` 是对外隐藏的，用户不需要了解它，但它又是类能正常工作所必需的。



## 总结

- 为了保证数据的良好封装，通常会将类成员状态设置为私有（private）。
- 如果确实需要在外部访问，则应该设计一些成员方法来访问这些数据，避免直接将其暴露。
- 数据封装的规则应用于数据成员，但它同样适用于所有成员，包括虚函数。