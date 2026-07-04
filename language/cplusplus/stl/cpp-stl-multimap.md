---
sidebar_position: 19
slug: /cpp-stl-multimap
---

# C++ STL 多重映射



多重映射（Multimap）是 C++ STL（标准模板库）的一部分。多重映射是类似的集合，例如映射，用于存储已排序的键/值对，但是与仅存储唯一键的映射不同，多重映射可以具有重复的键。



## multimap 语法

要使用 multimap 多重映射，必须先引入 `<map>` 头文件。

```cpp showLineNumbers
#include <map>
```

multimap 的类模板定义如下：

```cpp showLineNumbers
template < class Key,                                   // multimap::key_type  
           class T,                                     // multimap::mapped_type  
           class Compare = less<Key>,                   // multimap::key_compare  
           class Alloc = allocator<pair<const Key,T> >  // multimap::allocator_type  
         > class multimap;
```

multimap 参数说明：

| 参数      | 说明                                                         |
| --------- | ------------------------------------------------------------ |
| `key`     | 要存储在多重映射中的键数据类型。                             |
| `type`    | 要存储在多重映射中的值的数据类型。                           |
| `compare` | 一个比较类，该类使用两个bool类型相同的参数并返回一个值。此参数是可选的，二进制谓词less是默认值。 |
| `alloc`   | 分配器对象的类型。此参数是可选的，默认值为分配器。           |



## multimap 示例

```cpp showLineNumbers
#include <iostream>  
#include <map>  
#include <string>  
  
using namespace std;  
  
int main(void)  
{
    multimap<string, string> m = {
        {"China","Shanghai"},
        {"China", "Guangzhou"},
        {"Thailand", "Chiang Mai"},
        {"Netherlands", "Amsterdam"},
        {"United Kingdom", "London"},
        {"United States", "Los Angeles"}
    };

    cout << "Size of map m: " << m.size() << endl;
    cout << "Elements in m: " << endl;

    for (multimap<string, string>::iterator it = m.begin(); it != m.end(); ++it)
    {
        cout << "  [" << (*it).first << ", " << (*it).second << "]" << endl;
    }

    return 0;
}
```

执行 `g++ main.cpp && ./a.out` 编译运行以上程序，输出结果如下：

```bash
Size of map m: 6
Elements in m: 
  [China, Shanghai]
  [China, Guangzhou]
  [Netherlands, Amsterdam]
  [Thailand, Chiang Mai]
  [United Kingdom, London]
  [United States, Los Angeles]
```



## multimap 成员函数

下面是 multimap 的所有成员函数的列表。

### 构造器/解析器

| 函数            | 说明                                        |
| --------------- | ------------------------------------------- |
| `(constructor)` | 构造 multimaps。                            |
| `(destructor)`  | 析构函数。                                  |
| `operator =`    | 将 multimaps 的元素复制到另一个 multimaps。 |

### 迭代器

| 函数      | 说明                                            |
| --------- | ----------------------------------------------- |
| `begin`   | 返回指向多重映射中第一个元素的迭代器。          |
| `cbegin`  | 返回指向多重映射中第一个元素的 const_iterator。 |
| `end`     | 返回指向末尾的迭代器。                          |
| `cend`    | 返回一个指向末尾的常量迭代器。                  |
| `rbegin`  | 返回指向结尾的反向迭代器。                      |
| `rend`    | 返回指向起点的反向迭代器。                      |
| `crbegin` | 返回一个指向末尾的常量反向迭代器。              |
| `credit`  | 返回指向起点的常量反向迭代器。                  |

### 容量

| 函数       | 说明                               |
| ---------- | ---------------------------------- |
| `empty`    | 如果 multimaps 为空，则返回 true。 |
| `size`     | 返回 multimaps 中的元素数量。      |
| `max_size` | 返回 multimaps 的最大尺寸。        |

### 修饰符

| 函数           | 说明                                     |
| -------------- | ---------------------------------------- |
| `insert`       | 将元素插入 multimaps。                   |
| `erase`        | 从多重映射中擦除元素。                   |
| `swap`         | 交换 multimaps 的内容。                  |
| `clear`        | 删除 multimaps 的所有元素。              |
| `emplace`      | 构造新元素并将其插入 multimaps。         |
| `emplace_hint` | 通过提示构造新元素并将其插入 multimaps。 |

### 观察者

| 函数         | 说明                   |
| ------------ | ---------------------- |
| `key_comp`   | 返回键比较对象的副本。 |
| `value_comp` | 返回值比较对象的副本。 |

### 操作方式


| 函数            | 说明                                  |
| --------------- | ------------------------------------- |
| `find`          | 搜索具有给定键的元素。                |
| `count`         | 获取与给定键匹配的元素数。            |
| `lower_bound`   | 将迭代器返回到下限。                  |
| `upper_bound`   | 将迭代器返回上限。                    |
| `equal_range`   | 返回与给定键匹配的元素的参数。        |
| `get_allocator` | 返回用于构造 multimaps 的分配器对象。 |

### 非重载函数


| 函数         | 说明                                          |
| :----------- | :-------------------------------------------- |
| `operator==` | 检查两个 multimaps 是否相等。                 |
| `operator!=` | 检查两个 multimaps 是否相等。                 |
| `operator<`  | 检查第一个 multimaps 是否小于其他 multimaps。 |
| `operator<=` | 检查第一个 multimaps 是否小于或等于其他。     |
| `operator>`  | 检查第一个 multimaps 是否大于其他 multimaps。 |
| `operator>=` | 检查第一个 multimaps 是否大于其他。           |
| `swap()`     | 交换两个 multimaps 的元素。                   |


