---
sidebar_position: 11
slug: /cpp-stl-vector
---

# C++ STL 向量（Vector）



vector 容器是 STL 中最常用的容器之一，它和 array 容器非常类似，都可以看做是对 C++ 普通数组的 “升级版”。不同之处在于，array 实现的是静态数组（容量固定的数组），而 vector 实现的是一个动态数组，即可以进行元素的插入和删除，在此过程中，vector 会动态调整所占用的内存空间，整个过程无需人工干预。

vector 常被称为向量容器，因为该容器擅长在尾部插入或删除元素，在常量时间内就可以完成，时间复杂度为 O(1)；而对于在容器头部或者中部插入或删除元素，则花费时间要长一些（移动元素需要耗费时间），时间复杂度为线性阶 O(n)。



## vector 语法

使用 vector 容器，必须先引入 `<vector>` 头文件。

```cpp showLineNumbers
#include <vector>

std::vector<type> values;
```

下面代码演示了如何创建并使用 vector 容器：

```cpp showLineNumbers
#include<iostream>
#include<vector>

using namespace std;

int main(void)
{
    vector<string> v1;
    
    v1.push_back("GetIoT.tech ");
    v1.push_back("C++ STL");
    
    for (vector<string>::iterator itr=v1.begin(); itr!=v1.end(); ++itr)
        cout<< *itr;
    
    return 0; 
}
```

执行 `g++ main.cpp && ./a.out` 编译运行以上程序，输出结果如下：

```bash
GetIoT.tech C++ STL
```



## vector 成员函数

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
| `max_size()`       | 返回元素个数的最大值。这通常是一个很大的值，一般是 232-1，所以我们很少会用到这个函数。 |
| `resize()`         | 改变实际元素的个数。                                         |
| `capacity()`       | 返回当前容量。                                               |
| `empty()`          | 判断容器中是否有元素，若无元素，则返回 true；反之，返回 false。 |
| `reserve()`        | 增加容器的容量。                                             |
| `shrink _to_fit()` | 将内存减少到等于当前元素实际所使用的大小。                   |
| `operator[ ]`      | 重载了 `[ ]` 运算符，可以向访问数组中元素那样，通过下标即可访问甚至修改 vector 容器中的元素。 |
| `at()`             | 使用经过边界检查的索引访问元素。                             |
| `front()`          | 返回第一个元素的引用。                                       |
| `back()`           | 返回最后一个元素的引用。                                     |
| `data()`           | 返回指向容器中第一个元素的指针。                             |
| `assign()`         | 用新元素替换原有内容。                                       |
| `push_back()`      | 在序列的尾部添加一个元素。                                   |
| `pop_back()`       | 移出序列尾部的元素。                                         |
| `insert()`         | 在指定的位置插入一个或多个元素。                             |
| `erase()`          | 移出一个元素或一段元素。                                     |
| `clear()`          | 移出所有的元素，容器大小变为 0。                             |
| `swap()`           | 交换两个容器的所有元素。                                     |
| `emplace()`        | 在指定的位置直接生成一个元素。                               |
| `emplace_back()`   | 在序列尾部生成一个元素。                                     |



