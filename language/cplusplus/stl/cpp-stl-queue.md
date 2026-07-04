---
sidebar_position: 16
slug: /cpp-stl-queue
---

# C++ STL 队列（Queue）



队列（Queue）是一种先进先出（FIFO）的数据结构，即元素从容器的一端插入并从另一端提取。在 C++ STL 中，队列被实现为容器适配器。这些类使用特定容器类的封装对象作为其底层容器，提供一组特定的成员函数来访问其元素。元素被推入特定容器的“后部”并从其“前部”弹出。



## queue 语法

使用 queue 容器，必须先引入 `<queue>` 头文件。

```cpp showLineNumbers
#include <queue>
```

与 [stack](/cplusplus/cpp-stl-stack/) 模板类很相似，queue 模板类也需要两个模板参数。第一个参数是存储对象的类型，第二个参数是底层容器的类型。其中，元素类型是必要的，而容器类型是可选的，默认为 deque 类型。底层容器只需要支持 `empty()`、`size()`、`push_back()`、`pop_front()`、`front()` 和 `back()` 等操作即可。

queue 容器适配器的模板定义如下：

```cpp showLineNumbers
template<class T, class Container = deque<T> > class queue;
```



## queue 成员函数

借助函数，可以在编程领域中使用对象或变量。队列提供了大量可以在程序中使用或嵌入的函数。相同的列表如下:

| 函数            | 说明                                                         |
| --------------- | ------------------------------------------------------------ |
| `(constructor)` | 该函数用于构造队列集合。                                     |
| `empty`         | 该函数用于测试队列是否为空。如果队列为空，则该函数返回 true，否则返回 false。 |
| `size`          | 该函数返回队列集合的大小，该大小是对队列中存储的元素数量的度量。 |
| `front`         | 该函数用于访问队列的前部元素。该元素起着非常重要的作用，因为所有删除操作都是在最前面的元素上进行的。 |
| `back`          | 该函数用于访问队列的后部元素。元素扮演一个角色成员函数将分配器用于队列。 |



## queue 示例

下面演示如何创建 queue 队列容器，以及数据插入和提取的用法。

```cpp showLineNumbers
#include <iostream>
#include <queue>

using namespace std;

void show_queue(queue <int> q)
{
    queue <int> qu = q;
    
    while (!qu.empty()) {
        cout << ' ' << qu.front();
        qu.pop();
    }
    cout << '\n';
}

int main(void)
{
    queue <int> q;
    
    q.push(55);
    q.push(44);
    q.push(33);
    q.push(22);
    q.push(11);
    
    cout << "The queue q is : ";
    show_queue(q);
    
    cout << "\n q.size()  : " << q.size();
    cout << "\n q.front() : " << q.front();
    cout << "\n q.back()  : " << q.back();

    cout << "\n q.pop() : ";
    q.pop();
    q.pop();
    show_queue(q);
    
    return 0;
}
```

执行 `g++ main.cpp && ./a.out` 编译运行以上程序，输出结果如下：

```cpp showLineNumbers
The queue q is :  55 44 33 22 11

 q.size()  : 5
 q.front() : 55
 q.back()  : 11
 q.pop() :  33 22 11
```

