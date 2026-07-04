---
sidebar_position: 59
slug: /cpp-standard-template-library
---

# C++ STL 标准模板库

STL 是 “Standard Template Library” 的缩写，中文译为 “标准模板库”。STL 是一些容器的集合，例如 `list`、`vector`、`set`、`map` 等。同时，STL 也是算法和其它一些组件的集合。STL 的目的是标准化组件，这样就可以使用现成的组件，不用重新开发。



## C++ STL 构成

C++ STL 包含三大部分：容器（Containers）、算法（Algorithms）、迭代器（iterators）。

| 组件   | 描述                                                         |
| ------ | ------------------------------------------------------------ |
| 容器   | 容器是用来管理某一类对象的集合。C++ 提供了各种不同类型的容器，比如 `deque`、`list`、`vector`、`map` 等。 |
| 算法   | 算法作用于容器，它们提供了执行各种操作的方式，包括对容器内容执行初始化、排序、搜索和转换等操作。 |
| 迭代器 | 迭代器用于遍历对象集合的元素。这些集合可能是容器，也可能是容器的子集。 |

这三大部分都预定了大量的内置函数，我们只需简单的几行代码就能完成复杂的任务。比如，我们之前学的 [C++ 数组](/cplusplus/cpp-arrays/) 不能自动扩容，如果容量不够，只能新建一个数组，然后拷贝元素，最后删除旧的数组。

但是 STL 中，使用 `vector`（向量）就可以解决这个问题！它跟数组类似，但是它可以自动扩容。



## vector 示例

下面示例是，我们使用 `vector` 容器存储数据。该容器一开始的容量是 0，但我们仍然可以不断地往里面添加元素。

```cpp showLineNumbers
#include <iostream>
#include <vector>
using namespace std;

int main(void)
{
    // 创建一个向量存储 int 类型数据
    vector<int> vec;
    
    // 显示 vec 的原始大小
    cout << "vector size = " << vec.size() << endl;
    
    // 推入 8 个值到向量中
    for (int i=0; i<8; i++) {
        vec.push_back(i);
    }
    
    // 显示 vec 扩展后的大小
    cout << "extended vector size = " << vec.size() << endl;
    
    // 访问向量中的 8 个值
    for (int i=0; i<8; i++) {
        cout << "value of vec [" << i << "] = " << vec[i] << endl;
    }
    
    // 使用迭代器 iterator 访问值
    vector<int>::iterator v = vec.begin();
    while (v != vec.end()) {
        cout << "value of v = " << *v << endl;
        v++;
    }
    
    return 0;
}
```

执行 `g++ main.cpp && ./a.out` 编译和运行以上示例代码，输出结果如下：

```bash
vector size = 0
extended vector size = 8
value of vec [0] = 0
value of vec [1] = 1
value of vec [2] = 2
value of vec [3] = 3
value of vec [4] = 4
value of vec [5] = 5
value of vec [6] = 6
value of vec [7] = 7
value of v = 0
value of v = 1
value of v = 2
value of v = 3
value of v = 4
value of v = 5
value of v = 6
value of v = 7
```

上述示例简单演示了如何使用 STL 的 `vector` 容器存储数据，关于 STL 以及容器的使用，将在 [C++ STL 教程](/cplusplus/cpp-stl-tutorial/) 中详细介绍。