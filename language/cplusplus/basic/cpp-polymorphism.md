---
sidebar_position: 32
slug: /cpp-polymorphism
---

# C++ 多态



多态是 C++ 面向对象编程中的重要概念，按字面意思理解，“多态”就是多种形态。当类之间存在层次结构，并且类之间是通过继承关联时，就会用到多态。在 C++ 中，多态意味着调用成员函数时，会根据调用函数的对象的类型来执行不同的函数。

具体来讲，就是指程序中定义的引用变量所指向的具体类型和通过该引用变量发出的方法调用在编程时并不确定，而是在程序运行期间才确定，即一个引用变量到底会指向哪个类的实例对象，该引用变量发出的方法调用到底是哪个类中实现的方法，必须在由程序运行期间才能决定。



## 多态示例

首先，我们通过下面的示例来理解多态，在这个示例中，基类 Shape 被派生为两个类（Rectangle 和 Triangle），派生类各自实现了 area 方法。

代码如下：

```cpp showLineNumbers
#include <iostream> 
using namespace std;

class Shape
{
protected:
    int width, height;
public:
    Shape(int w=0, int h=0)
    {
        width = w;
        height = h;
    }
    int area()
    {
        cout << "Parent class area : ";
        return 0;
    }
};

class Rectangle: public Shape
{
public:
    Rectangle(int w=0, int h=0):Shape(w, h) { }
    int area()
    {
        cout << "Rectangle class area : ";
        return (width * height);
    }
};

class Triangle: public Shape
{
public:
    Triangle(int w=0, int h=0):Shape(w, h) { }
    int area()
    {
        cout << "Triangle class area : ";
        return (width * height / 2);
    }
};

int main(void)
{
    Shape *shape;
    Rectangle rec(10, 5);  // 创建矩形实例
    Triangle  tri(10, 5);  // 创建三角形实例
    
    shape = &rec;                   // 存储矩形的地址
    cout << shape->area() << endl;  // 调用矩形的求面积函数 area
    
    shape = &tri;                   // 存储三角形的地址
    cout << shape->area() << endl;  // 调用三角形的求面积函数 area
    
    return 0;
}
```

当上面的代码被编译和执行时，它会产生下列结果：

```bash
Parent class area : 0
Parent class area : 0
```

导致错误输出的原因是，调用函数 `area()` 被编译器设置为基类中的版本，这就是所谓的**静态多态**，或**静态链接**，意思是函数调用在程序执行前就准备好了。有时候这也被称为**早绑定**，因为 `area()` 函数在程序编译期间就已经设置好了。

但现在，让我们对程序稍作修改，在 Shape 类中，`area()` 的声明前放置关键字 **virtual**，如下所示：

```cpp showLineNumbers
class Shape
{
protected:
    int width, height;
public:
    Shape(int w=0, int h=0)
    {
        width = w;
        height = h;
    }
    virtual int area()
    {
        cout << "Parent class area : ";
        return 0;
    }
};
```

修改后，当编译和执行前面的实例代码时，它会产生以下结果：

```bash
Rectangle class area : 50
Triangle class area : 25
```

此时，编译器看的是指针的内容，而不是它的类型。因此，由于 `tri` 和 `rec` 类的对象的地址存储在 `*shape` 中，所以会调用各自的 `area()` 函数。

从这个例子中可以看到，每个子类都有一个函数 `area()` 的独立实现，这就是多态的一般使用方式。有了多态，就可以有多个不同的类，都带有同一个名称却具有不同实现的函数，函数的参数甚至可以是相同的。这给 C++ 程序设计带来极大的灵活性。



## 虚函数

实际上，**C++ 就是使用虚函数实现多态的**。虚函数就是在基类中使用关键字 `virtual` 声明的函数。在派生类中重新定义基类中定义的虚函数时，会告诉编译器不要静态链接到该函数。

我们想要的是在程序中任意点可以根据所调用的对象类型来选择调用的函数，这种操作被称为**动态链接**，或**后期绑定**。



## 纯虚函数

有时候，我们需要在基类中定义虚函数，以便在派生类中重新定义该函数更好地适用于对象，但是在基类中又不能对虚函数给出有意义的实现，这个时候就会用到纯虚函数。

我们可以把基类中的虚函数 `area()` 改写如下：

```cpp showLineNumbers
class Shape
{
protected:
    int width, height;
public:
    Shape(int a=0, int b=0)
    {
        width = a;
        height = b;
    }
    // pure virtual function
    virtual int area() = 0;
};
```

`= 0` 告诉 C++ 编译器，这个虚函数没有主体，也就是**纯虚函数**。

