---
sidebar_position: 35
slug: /cpp-virtual-function
---

# C++ 虚函数



在 C++ 中，面向对象的三大特征之一多态就是通过虚函数实现，虚函数使用关键字 `virtual` 声明。意思是，当派生类中重新定义基类中定义的虚函数时，告诉编译器不要静态链接到该函数。而是根据所调用的对象类型来选择调用的函数，这种操作也称为动态链接（或后期绑定）。



## 虚函数

虚函数就是使用关键字 `virtual` 声明的函数，例如：

```cpp showLineNumbers
virtual int area() {
   return width * height;
}
```

我们可以在基类中把一个函数定义为虚函数，然后在子类中重新实现，这样就实现了多态。

示例：

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Shape
{
protected:
    int width, height;
    
public:
    Shape( int a=0, int b=0) {
        width = a;
        height = b;
    }
    // 虚函数
    virtual int area() {
        return width * height;
    }
};

class Rect: public Shape
{
public:
    Rect(int a=0, int b=0): Shape(a, b) { }
    
    int area() {
        return width * height;
    }
};

int main(void)
{
    Rect r1(6, 8);
    
    cout << "Area of rect(6,8) is: " << r1.area() << endl;
    
    return 0;
}
```

使用 `g++ main.cpp && ./a.out` 命令编译和运行上面代码，输出结果如下：

```bash
Area of rect(6,8) is: 48
```



## 纯虚函数

有时候，我们需要在基类中定义虚函数，以便在派生类中重新定义该函数更好地适用于对象，但是在基类中又不能对虚函数给出有意义的实现，这个时候就会用到纯虚函数。

在 C++ 中定义纯虚函数，可以通过在虚函数后面跟 `=0;` 来实现。 例如：

```cpp showLineNumbers
virtual int area() = 0;
```

我们可以在基类中把一个函数定义为纯虚函数，然后在子类中实现逻辑。

示例：

```cpp showLineNumbers
#include <iostream>

class Shape
{
protected:
    int width, height;
    
public:
    Shape (int a=0, int b=0) {
        width = a;
        height = b;
    }
    // 纯虚函数
    virtual int area() = 0;
};

class Rect: public Shape 
{
public:
    Rect( int a=0, int b=0): Shape(a, b) { }
    
    int area() {
        return width * height;
    }
};

int main() 
{
    Rect r1(6, 8);
    
    std::cout << "Area of rect(6,8) is: ";
    std::cout << r1.area() << std::endl;
    return 0;
}
```

使用 `g++ main.cpp && ./a.out` 命令编译和运行上面代码，输出结果如下：

```bash
Area of rect(6,8) is: 48
```