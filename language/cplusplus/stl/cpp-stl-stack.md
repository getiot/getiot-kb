---
sidebar_position: 15
slug: /cpp-stl-stack
---

# C++ STL 堆栈（Stack）



堆栈（Stack）是一种后进先出（LIFO）的数据结构，堆栈的元素插入称为“入栈”，元素的删除称为“出栈”。堆栈的两端分别称为栈顶（Stack Top）和栈底（Stack Bottom），入栈和出栈操作总在栈顶进行。

在 C++ STL 中，堆栈的泛化是直接通过现有的序列容器来实现的，默认使用双端队列 [deque](/cplusplus/cpp-stl-deque/) 的数据结构。当然，可以采用其他线性结构（[vector](/cplusplus/cpp-stl-vector/) 或 [list](/cplusplus/cpp-stl-list/) 等），只要提供堆栈的入栈、出栈、栈顶元素访问和判断是否为空的操作即可。由于堆栈的底层使用的是其他容器，因此，堆栈可看做是一种适配器，将一种容器转换为另一种容器（堆栈容器）。

为了严格遵循堆栈的数据后进先出原则，stack 不提供元素的任何迭代器操作。因此，stack 容器也就不会向外部提供可用的前向或反向迭代器类型。



## stack 语法

使用 stack 容器，必须先引入 `<stack>` 头文件。

```cpp showLineNumbers
#include <stack>
```

stack 容器适配器的模板有两个参数。第一个参数是存储对象的类型，第二个参数是底层容器的类型。通过指定第二个模板类型参数，可以使用任意类型的底层容器，只要它们支持 `back()`、`push_back()`、`pop_back()`、`empty()`、`size()` 这些操作。默认的底层容器是 `deque<T>` 容器。

因此，stack 容器适配器的模板定义如下：

```cpp showLineNumbers
template<class T, class Container = deque<T> > class stack;
stack<typename T, typename Container=deque<T>>
```



## stack 成员函数

借助函数，可以在编程领域中使用对象或变量。堆栈提供了大量可以在程序中使用或嵌入的函数。相同的列表如下:

| 函数            | 说明                                                         |
| --------------- | ------------------------------------------------------------ |
| `(constructor)` | 该函数用于构建堆栈集合。                                     |
| `empty`         | 该函数用于测试堆栈是否为空。如果堆栈为空，则函数返回 true，否则返回 false。 |
| `size`          | 该函数返回堆栈集合的大小，它是对堆栈中存储的元素数量的度量。 |
| `top`           | 该函数用于访问堆栈的顶部元素。该元素起着非常重要的作用，因为所有插入和删除操作都是在顶部元素执行的。 |
| `push`          | 该函数用于在堆栈顶部插入新元素。（写入）                     |
| `emplace`       | 该函数用于构造和插入新元素。                                 |
| `pop`           | 该函数用于从堆栈顶部移除元素。（读出）                       |
| `swap`          | 该函数用于交换元素。                                         |



## stack 示例

下面演示如何创建 stack 堆栈容器，以及入栈、出栈的用法。

```cpp showLineNumbers
#include <iostream>
#include <stack>

using namespace std;

void show_stack(stack <int> s)
{
    stack <int> sg = s;

    while (!sg.empty()) {
        cout << ' ' << sg.top();  // 打印数据
        sg.pop();                 // 出栈
    }
    cout << '\n';
}

int main(void)
{
    stack <int> s;
    
    // 入栈
    s.push(55);
    s.push(44);
    s.push(33);
    s.push(22);
    s.push(11);
    
    cout << "The stack s is : ";
    show_stack(s);

    cout << "\n s.size() : " << s.size();
    cout << "\n s.top()  : " << s.top();
    cout << "\n s.pop()  : ";

    // 出栈
    s.pop();
    s.pop();

    show_stack(s);

    return 0;
}
```

执行 `g++ main.cpp && ./a.out` 编译运行以上程序，输出结果如下：

```cpp showLineNumbers
The stack s is :  11 22 33 44 55

 s.size() : 5
 s.top()  : 11
 s.pop()  :  33 44 55
```


