---
sidebar_position: 30
slug: /cpp-encapsulation
---

# C++ 封装

C++ 是面向对象的编程语言，对象就是面向对象程序设计的核心。所谓对象就是真实世界中的实体，对象与实体是一一对应的，也就是说，现实世界中每一个实体都是一个对象，它是一种具体的概念。

C++ 面向对象编程有三大特性，它们是封装、继承和多态。本文主要介绍 C++ 面向对象封装。



## 什么是封装

在计算机程序设计中，封装可以隐藏实现的细节，让使用者只能通过实现写好的访问方法来访问这些字段。这样一来，我们只需要在这些方法中增加逻辑控制，限制对数据的不合理访问，同时方便数据检查，有利于于保护对象信息的完整性。便于修改，提高代码的可维护性。[C++ 的类](/cplusplus/cpp-class-and-object/) 就是一种常用的封装方法。

实现良好的封装，需要从两个方面考虑：

- 把字段（成员变量）和实现细节隐藏起来，不允许外部直接访问；
- 把方法暴露出来，让方法控制这些成员变量进行安全的访问和操作。

所以，封装的含义是确保对用户隐藏敏感数据。为此，必须：

- 将类变量/属性声明为`private`；
- 提供公共的 get 和 set 方法来访问和更新 `private` 变量的值；



## get 和 set 函数方法

在 C++ 中，`private` 变量只能在同一类中访问（外部类无法访问它）。但是，如果我们提供公共的 get 和 set 方法，则可以间接地访问它们。

通常来说，get 方法返回变量值，而 set 方法设置该值。例如：

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Employee
{
private:
    // 私有成员变量
    int salary;
public:
    // set 方法
    void setSalary(int s) {
        salary = s;
    }
    // get 方法
    int getSalary() {
        return salary;
    }
};

int main(void)
{
    Employee john;
    
    john.setSalary(50000);
    cout << john.getSalary() << endl;
    
    return 0;
}
```



## 封装的好处

总的来说，封装具有以下好处：

- 更好地控制类的属性和方法；
- 可以将类属性设置为只读（如果仅使用 get 方法），也可以设置为只写（如果仅使用 set 方法）；
- 更加灵活，程序员可以更改代码的一部分而不影响其他部分；
- 增强数据安全性。