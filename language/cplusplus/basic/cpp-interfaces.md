---
sidebar_position: 40
slug: /cpp-interfaces
---

# C++ 接口

接口是一种规范，用于描述类的行为和功能，但不需要完成类的具体实现。按照接口规范进行方法调用，就能获得所期望的功能，按照接口规范实现接口的的方法，就能提供所期望的功能。

C++ 使用**抽象类**来实现接口。抽象类与[数据抽象](/cplusplus/cpp-data-abstraction/)互不混淆，数据抽象是一个把实现细节与相关的数据分离开的概念。



## 抽象类

如果类中至少有一个函数被声明为纯虚函数，则这个类就是抽象类。纯虚函数是通过在声明中使用 `= 0` 来指定的，如下所示：

```cpp showLineNumbers
class Box
{
public:
    // 纯虚函数
    virtual double getVolume() = 0;

private:
    double length;      // 长度
    double width;       // 宽度
    double height;      // 高度
};
```

设计**抽象类**（Abstract Class，通常称为 ABC）的目的，是为了给其他类提供一个可以继承的适当的基类。抽象类不能被用于实例化对象，它只能作为**接口**使用。如果试图实例化一个抽象类的对象，会导致编译错误。

因此，如果一个 ABC 的子类需要被实例化，则必须实现每个虚函数，这也意味着 C++ 支持使用 ABC 声明接口。如果在派生类中没有重载纯虚函数，就尝试实例化该类的对象，将会导致编译错误。

相对应的，可用于实例化对象的类被称为**具体类**。



## 示例

下面示例中，基类 Shape 提供了一个接口 `getArea()` ，然后在两个派生类 `Rectangle` 和 `Triangle` 分别实现 `getArea()`。

```cpp showLineNumbers
#include <iostream>
using namespace std;

// 基类
class Shape 
{
public:
    // 构造函数
    Shape(int w=0, int h=0) {
        width = w;
        height = h;
    }
    // 提供接口框架的纯虚函数
    virtual int getArea() = 0;
    
    void setWidth(int w) {
        width = w;
    }
    
    void setHeight(int h) {
        height = h;
    }
protected:
    int width;
    int height;
};

// 派生类
class Rectangle: public Shape
{
public:
    Rectangle(int w, int h): Shape(w, h) {}

    int getArea() {
        return (width * height);
    }
};

class Triangle: public Shape
{
public:
    Triangle(int w, int h): Shape(w, h) {}

    int getArea() {
        return (width * height)/2;
    }
};

int main(void)
{
    Rectangle rect(6, 8);
    Triangle  tri(6, 8);
    
    // 输出对象的面积
    cout << "Total Rectangle area is : " << rect.getArea() << endl;
    cout << "Total Triangle area is  : " << tri.getArea() << endl;
    
    return 0;
}
```

执行 `g++ main.cpp && ./a.out` 编译运行示例，输出结果如下：

```cpp showLineNumbers
Total Rectangle area is : 48
Total Triangle area is  : 24
```

在这个示例中，`Shape` 就是抽象类，而 `Rectangle` 和 `Triangle` 则是具体类，它们根据不同的面积计算方法各自实现了 `Shape` 中的纯虚函数 `getArea()`。



## 总结

- 设计面向对象的系统时可以使用一个抽象基类为所有的外部应用程序提供一个适当的、通用的、标准化的接口。然后，派生类通过继承抽象基类，就把所有类似的操作都继承下来。
- 外部应用程序提供的功能（即公有函数）在抽象基类中是以纯虚函数的形式存在的。这些纯虚函数在相应的派生类中被实现。
- 这种构架使得新的应用程序可以很容易地被添加到系统中，即使是在系统被定义之后依然可以如此。