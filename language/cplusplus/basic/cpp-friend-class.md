---
sidebar_position: 36
slug: /cpp-friend-class
---

# C++ 友元函数



在 C++ 中，使用 `friend` 修饰的函数，称为友元函数。类的私有成员（private）和只能在本类中访问，类的保护成员（protected）只能在本类或者子类中访问，但类的友元函数可以访问类的私有成员和保护成员。

记住：类的友元函数是定义在类外部，但有权访问类的所有私有成员和保护成员。另外，尽管友元函数的原型有在类的定义中出现过，但是友元函数并不是成员函数。



## 声明友元函数

在 C++ 中，友元函数使用 `friend` 关键字修饰。例如，下面示例中的 `func()` 函数就是一个友元函数。

```cpp showLineNumbers
class ClassName
{
public:
    friend void func();
};

void func()
{
    // do something
}
```



## 友元函数示例

请看下面示例：

```cpp showLineNumbers
#include <iostream>
using namespace std;

class Student
{
public:
    Student(string name, int age)
    {
        this->name = name;
        this->age = age;
    }
    
    void sayHello() const
    {
        cout << "I am " << this->name << " and i am " << this->age << " years old!" << endl;
    }

private:
    string name;
    int age;
};

// 非成员函数
void show(Student stu)
{
    cout << "Call Show, Name = " << stu.name << ", Age = " << stu.age << endl;
}

int main(void)
{
    Student stu("GetIoT.tech", 3);
    show(stu);
    return 0;
}
```

使用 `g++ main.cpp` 命令编译该示例，出现如下错误：

```cpp showLineNumbers
main.cpp: In function ‘void show(Student)’:
main.cpp:26:40: error: ‘std::string Student::name’ is private within this context
   26 |     cout << "Call Show, Name =" << stu.name << " Age = " << stu.age << endl;
      |                                        ^~~~
main.cpp:19:12: note: declared private here
   19 |     string name;
      |            ^~~~
main.cpp:26:65: error: ‘int Student::age’ is private within this context
   26 |     cout << "Call Show, Name =" << stu.name << " Age = " << stu.age << endl;
      |                                                                 ^~~
main.cpp:20:9: note: declared private here
   20 |     int age;
      |         ^~~
```

这是因为我们在类的外面调用 `show()` 函数访问类的私有成员，程序当然会报错。

现在，我们在 Student 类中将 `show()` 函数声明为友元函数，修改程序如下：

```cpp showLineNumbers
class Student
{
public:
    Student(string name, int age)
    {
        this->name = name;
        this->age = age;
    }
    
    void sayHello() const
    {
        cout << "I am " << this->name << " and i am " << this->age << " years old!" << endl;
    }

    friend void show(Student stu);
    
private:
    string name;
    int age;
};
```

使用 `g++ main.cpp && ./a.out` 命令编译运行以上示例，输出结果如下：

```bash
Call Show, Name = GetIoT.tech, Age = 3
```



