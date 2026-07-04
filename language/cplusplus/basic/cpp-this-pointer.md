---
sidebar_position: 47
slug: /cpp-this-pointer
---

# C++ this 指针



## 概述

在 C++ 编程中，我们可以使用 this 关键字来表示引用类的当前实例对象的指针，通常有以下 3 种用法：

1. 可以用来将当前对象作为参数传递给另一个方法；
2. 可以用来引用当前类的实例变量（避免与其他同名变量混淆）；
3. 可以用来声明索引器（indexers）。



## 示例代码

下面通过一个简单的示例来加深对 C++ 中 this 关键字的理解，这里主要展示第 2 中用法。

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Human
{
public:
    string name;
    string gender;

    Human(string name, int gender)
    {
        this->name = name;
        this->gender = gender == 0 ? "female" : "male";
    }
};

class Employee: public Human
{
public:
    int id;      // data member (also instance variable)
    float salary;
    Employee(int id, string name, float salary): Human(name, 0)
    {
        this->id = id;
        this->salary = salary;
    }
    void display()
    {
        cout << id << "  " << name << "  " << gender << "  " << salary << endl;
    }
};

int main(void)
{
    Employee e1 = Employee(101, "Olalla", 89000);  // creating an object of Employee
    Employee e2 = Employee(102, "Maggie", 59000);  // creating an object of Employee
    e1.display();
    e2.display();
    return 0;
}
```

编译并运行程序，输出结果如下：

```bash
101  Olalla  female  89000
102  Maggie  female  59000
```



## this 本质

在 C++ 中，this 实际上是每个类成员函数隐式包含的一个形参，在调用成员函数时将对象的地址作为实参传递给 this。由于 this 是隐式的，因此不需要在代码中声明就可以使用，它会在编译阶段由编译器默默地将其添加到参数列表中。

this 作为隐式形参，本质上是成员函数的局部变量（private），所以只能在成员函数内部使用，并且只有在通过对象调用成员函数时才给 this 赋值。

实际上，C++ 的成员函数最终都会被编译成与对象无关的普通函数，除了成员变量，会丢失所有信息。所以编译时要在成员函数中添加一个额外的参数，把当前对象的首地址传入，以此来关联成员函数和成员变量。这个额外的参数，实际上就是 this，它是成员函数和成员变量关联的桥梁。



## 注意事项

- this 关键字是一个指向对象自己的指针，因此使用 `->` 而不是 `.` 符号；
- 只有当类实例化以后，this 才有意义；
- this 是 const 指针，它的值是不能被修改的；
- this 只能用于成员函数，不能用于静态函数（用 static 修饰的函数）；
- [友元函数](/cplusplus/cpp-friend-class/)没有 this 指针。

