---
sidebar_position: 17
slug: /cpp-stl-priority-queue
---

# C++ STL 优先级队列



## STL 优先队列

C++ 中的优先级队列（priority_queue）是 STL 中的派生集合，它仅考虑最高优先级元素。队列遵循 FIFO 策略（先进先出），而优先级队列根据优先级弹出元素，即优先级最高的元素首先弹出。

它在某些方面类似于普通队列，但在以下方面有所不同：

- 在优先级队列中，队列中的每个元素都与某个优先级相关联，但是优先级在队列数据结构中不存在。
- 当队列遵循 FIFO 策略时，优先级队列中优先级最高的元素将被首先删除，这意味着首先插入的元素将被首先删除。
- 如果存在多个具有相同优先级的元素，则将考虑该元素在队列中的顺序。

提示：优先级队列是普通队列的扩展版本，但优先级最高的元素将首先从优先级队列中删除。

优先队列的语法如下：

```cpp showLineNumbers
priority_queue<int> variable_name;
```



## 优先队列的成员函数

| 函数        | 说明                                                       |
| ----------- | ---------------------------------------------------------- |
| `push()`    | 它将在优先级队列中插入新元素。                             |
| `pop()`     | 它从队列中删除优先级最高的元素。                           |
| `top()`     | 此函数用于处理优先级队列的最上层元素。                     |
| `size()`    | 它确定优先级队列的大小。                                   |
| `empty()`   | 它验证队列是否为空。基于验证，它返回状态。                 |
| `swap()`    | 它将优先级队列的元素与另一个具有相同类型和大小的队列交换。 |
| `emplace()` | 它将在优先级队列的顶部插入一个新元素。                     |



## 示例 1

让我们创建一个简单的优先级队列程序。

```cpp showLineNumbers
#include <iostream>
#include <queue>

using namespace std;

int main(void)
{
    priority_queue<int> p; // variable declaration.
    p.push(10);            // inserting 10 in a queue, top=10
    p.push(30);            // inserting 30 in a queue, top=30
    p.push(20);            // inserting 20 in a queue, top=20
    
    cout << "Number of elements available in 'p' : " << p.size() << endl;
    
    while (!p.empty()) {
        cout << p.top() << endl;
        p.pop();
    }
    
    return 0;
}
```

执行 `g++ main.cpp && ./a.out` 编译运行以上程序，输出结果如下：

```bash
Number of elements available in 'p' : 3
30
20
10
```

上面代码创建了一个优先级队列，然后在其中插入了三个元素（10、30、20），接着使用 while 循环显示优先级队列所有元素。



## 示例 2

让我们看看优先级队列的另一个示例。

```cpp showLineNumbers
#include <iostream>
#include<queue>

using namespace std;

int main(void)
{
    priority_queue<int> p; // priority queue declaration
    priority_queue<int> q; // priority queue declaration
    
    p.push(1); // inserting element '1' in p.
    p.push(2); // inserting element '2' in p.
    p.push(3); // inserting element '3' in p.
    p.push(4); // inserting element '4' in p.
    
    q.push(5); // inserting element '5' in q.
    q.push(6); // inserting element '6' in q.
    q.push(7); // inserting element '7' in q.
    q.push(8); // inserting element '8' in q.
    
    p.swap(q);
    
    cout << "Elements of p are : " << endl;
    while (!p.empty()) {
        cout << p.top() << endl;
        p.pop();
    }
    
    cout << "Elements of q are :" << endl;
    while (!q.empty()) {
        cout << q.top() << endl;
        q.pop();
    }
    
    return 0;
}
```

执行 `g++ main.cpp && ./a.out` 编译运行以上程序，输出结果如下：

```bash
Elements of p are : 
8
7
6
5
Elements of q are :
4
3
2
1
```

在该示例代码中，创建了两个优先级队列（p 和 q），然后分别在 p 和 q 优先级队列中插入四个元素，接着使用 `swap()` 函数将 p 队列的元素与 q 队列交换。

