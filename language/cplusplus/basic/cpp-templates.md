---
sidebar_position: 45
slug: /cpp-templates
---

# C++ 模板



模板是 C++ 支持参数化多态的工具，使用模板可以使用户为类或者函数声明一种一般模式，使得类中的某些数据成员或者成员函数的参数、返回值取得任意类型。

- 模板是一种对类型进行参数化的工具；
- 通常有两种形式：函数模板和类模板；
- 函数模板针对仅参数类型不同的函数；
- 类模板针对仅数据成员和成员函数类型不同的类。

使用模板的目的就是能够让程序员编写与类型无关的代码。

**注意**：模板的声明或定义只能在全局，命名空间或类范围内进行。即不能在局部范围，函数内进行，比如不能在 `main()` 函数中声明或定义一个模板。



## 函数模板

定义模板函数的语法格式如下：

```cpp showLineNumbers
template <class type> ret-type func-name(parameter list)
{
    // 函数的主体
}
```

其中，`type` 是函数所使用的数据类型的占位符名称。这个名称可以在函数定义中使用。

**示例**：定义一个函数模板，返回两个数种的最大值

```cpp showLineNumbers
#include <iostream>
#include <string>

using namespace std;

template <typename T>
inline T const& Max (T const& a, T const& b) 
{
    return a < b ? b : a;
}

int main(void)
{
    int i = 39;
    int j = 67;
    cout << "Max(i, j): " << Max(i, j) << endl;

    double f1 = 3.15;
    double f2 = 20.87;
    cout << "Max(f1, f2): " << Max(f1, f2) << endl;

    string s1 = "Hello"; 
    string s2 = "GetIoT";
    cout << "Max(s1, s2): " << Max(s1, s2) << endl;

   return 0;
}
```

执行 `g++ main.cpp && ./a.out` 编译运行以上示例，输出结果如下：

```bash
Max(i, j): 67
Max(f1, f2): 20.87
Max(s1, s2): Hello
```



## 类模板

不仅可以定义函数模板，C++ 还允许定义类模板。类模板又称**泛型类**（Generic class）。

泛型类声明的一般语法格式如下：

```cpp showLineNumbers
template <class type> class class-name {
    // ...
}
```

其中，`type` 是占位符类型名称，可以在类被范例化的时候进行指定。可以使用一个逗号分隔的列表来定义多个泛型数据类型。

示例：定义一个类 `Stack<>`，并实现了泛型方法来对元素进行入栈出栈操作

```cpp showLineNumbers
#include <iostream>
#include <vector>
#include <cstdlib>
#include <string>
#include <stdexcept>

using namespace std;

template <class T>
class Stack {
private:
    vector<T> elems;          // 向量，用来保存元素

public:
    void push(T const&);      // 入栈
    void pop();               // 出栈
    T top() const;            // 返回栈顶元素
    bool empty() const{       // 如果为空则返回真
        return elems.empty();
    }
};

template <class T>
void Stack<T>::push (T const& elem)
{
    // 追加传入元素的副本
    elems.push_back(elem);
}

template <class T>
void Stack<T>::pop ()
{ 
    if (elems.empty()) {
        throw out_of_range("Stack<>::pop(): empty stack");
    }
    // 删除最后一个元素
    elems.pop_back();         
}

template <class T>
T Stack<T>::top () const
{
    if (elems.empty()) {
        throw out_of_range("Stack<>::top(): empty stack"); 
    }
    // 返回最后一个元素的副本 
    return elems.back();      
} 

int main() 
{ 
    try { 
        Stack<int>         intStack;  // int 类型的栈
        Stack<string> stringStack;    // string 类型的栈

        // 操作 int 类型的栈
        intStack.push(17);
        cout << intStack.top() <<endl;

        // 操作 string 类型的栈
        stringStack.push("Hello GetIoT");
        cout << stringStack.top() << std::endl;
        stringStack.pop();
        stringStack.pop();
    } 
    catch (exception const& ex) {
        cerr << "Exception: " << ex.what() <<endl;
        return -1;
    }
}
```

编译运行以上程序，输出结果如下：

```bash
17
Hello GetIoT
Exception: Stack<>::pop(): empty stack
```