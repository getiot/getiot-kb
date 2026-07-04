---
sidebar_position: 12
slug: /cpp-stl-deque
---

# C++ STL 双端队列（Deque）



STL 中的 deque 是双端队列容器，deque 容器和 vector 容器有很多相似之处，deque 容器也擅长在序列尾部添加或删除元素（时间复杂度为 `O(1)`），而不擅长在序列中间添加或删除元素。deque 容器也可以根据需要修改自身的容量和大小。

和 vector 不同的是，deque 还擅长在序列头部添加或删除元素，所耗费的时间复杂度也为常数阶 `O(1)`。并且更重要的一点是，deque 容器中存储元素并不能保证所有元素都存储到连续的内存空间中。

当需要向序列两端频繁的添加或删除元素时，应首选 deque 容器。



## deque 语法

使用 deque 容器，必须先引入 `<deque>` 头文件。

```cpp showLineNumbers
#include <deque>

std::deque<type> values;
```

下面代码演示了如何创建并使用 deque 容器：

```cpp showLineNumbers
#include <iostream>
#include <deque>

using namespace std;

int main(void)
{
	deque<string> d;
    
    d.push_back("GetIoT.tech ");
    d.push_back("C++ STL");
    
	for (auto i=d.begin(); i<d.end(); i++) {
        cout  << *i << endl;
    }
    return 0; 
}
```

执行 `g++ main.cpp && ./a.out` 编译运行以上程序，输出结果如下：

```bash
GetIoT.tech 
C++ STL
```

这个示例创建了一个 deque 双端队列，并使用 `push_back()` 存放了元素，最后使用迭代器遍历了所有元素。



## deque 成员函数

| 函数成员           | 函数功能                                                     |
| ------------------ | ------------------------------------------------------------ |
| `begin()`          | 返回指向容器中第一个元素的迭代器。                           |
| `end()`            | 返回指向容器最后一个元素所在位置后一个位置的迭代器，通常和 `begin()` 结合使用。 |
| `rbegin()`         | 返回指向最后一个元素的迭代器。                               |
| `rend()`           | 返回指向第一个元素所在位置前一个位置的迭代器。               |
| `cbegin()`         | 和 `begin()` 功能相同，只不过在其基础上，增加了 const 属性，不能用于修改元素。 |
| `cend()`           | 和 `end()` 功能相同，只不过在其基础上，增加了 const 属性，不能用于修改元素。 |
| `crbegin()`        | 和 `rbegin()` 功能相同，只不过在其基础上，增加了 const 属性，不能用于修改元素。 |
| `crend()`          | 和 `rend()` 功能相同，只不过在其基础上，增加了 const 属性，不能用于修改元素。 |
| `size()`           | 返回实际元素个数。                                           |
| `max_size()`       | 返回容器所能容纳元素个数的最大值。这通常是一个很大的值，一般是 232-1，我们很少会用到这个函数。 |
| `resize()`         | 改变实际元素的个数。                                         |
| `empty()`          | 判断容器中是否有元素，若无元素，则返回 true；反之，返回 false。 |
| `shrink _to_fit()` | 将内存减少到等于当前元素实际所使用的大小。                   |
| `at()`             | 使用经过边界检查的索引访问元素。                             |
| `front()`          | 返回第一个元素的引用。                                       |
| `back()`           | 返回最后一个元素的引用。                                     |
| `assign()`         | 用新元素替换原有内容。                                       |
| `push_back()`      | 在序列的尾部添加一个元素。                                   |
| `push_front()`     | 在序列的头部添加一个元素。                                   |
| `pop_back()`       | 移除容器尾部的元素。                                         |
| `pop_front()`      | 移除容器头部的元素。                                         |
| `insert()`         | 在指定的位置插入一个或多个元素。                             |
| `erase()`          | 移除一个元素或一段元素。                                     |
| `clear()`          | 移出所有的元素，容器大小变为 0。                             |
| `swap()`           | 交换两个容器的所有元素。                                     |
| `emplace()`        | 在指定的位置直接生成一个元素。                               |
| `emplace_front()`  | 在容器头部生成一个元素。和 `push_front()` 的区别是，该函数直接在容器头部构造元素，省去了复制移动元素的过程。 |
| `emplace_back()`   | 在容器尾部生成一个元素。和 `push_back()` 的区别是，该函数直接在容器尾部构造元素，省去了复制移动元素的过程。 |