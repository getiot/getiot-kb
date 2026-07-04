---
sidebar_position: 18
slug: /cpp-stl-map
---

# C++ STL Map 容器



映射（map）是 C++ 标准模板库 STL 的一部分。映射是存储排序的键值对的关联集合，其中每个键都是唯一的，可以插入或删除但不能更改（与键关联的值可以更改）。

在 C++ STL 中，map 以模板（泛型）方式实现，可以存储任意类型的数据，包括使用者自定义的数据类型。Map 主要用于资料一对一映射（one-to-one）的情況，map 内部的实现是自建一颗红黑树，这颗树具有对数据自动排序的功能，所以在 map 内部所有的数据都是有序的。



## map 映射

Map 是 STL 中的一个关联容器，它提供一对一的数据处理能力。其中，第一个称为关键字（key），每个关键字只能在 map 中出现一次，第二个称为该关键字的值（value）。

C++ STL 的 map 底层数据结构是用红黑树实现的，具有对数据自动排序的功能，所以在 std::map 内部所有的数据都是有序的，查找时间复杂度是 `log(n)`。

下面举例说明什么是一对一的数据映射。比如一个班级中，每个学生的学号跟他的姓名就存在着一一映射的关系，这个模型可以用 map 轻易描述：学号用 int 描述，姓名用 string 描述。如下：

```cpp showLineNumbers
map<int, string> mapStudent;
```



## map 语法

使用 map 容器，必须先引入 `<map>` 头文件。

```cpp showLineNumbers
#include <map>
```

map 对象是模板类，需要关键字和存储对象两个模板参数。例如前面学生学号的例子：

```cpp showLineNumbers
std::map<int, string> mapStudent;
```

定义了一个用 int 作为索引，并拥有相关联的指向 string 的指针。



## map 示例

下面演示如何创建和操作 map 容器。

```cpp showLineNumbers
#include <map>
#include <string>
#include <iostream>

using namespace std;

int main(void)
{
    map<int, string> mapStudent;

    // 使用 insert 函数插入 pair 数据
    mapStudent.insert(pair<int, string>(1, "student_one"));
    mapStudent.insert(pair<int, string>(2, "student_two"));
    mapStudent.insert(pair<int, string>(3, "student_three"));

    // 用 insert 函数插入 value_type 数据
    mapStudent.insert(map<int, string>::value_type (1, "student_one"));
    mapStudent.insert(map<int, string>::value_type (2, "student_two"));
    mapStudent.insert(map<int, string>::value_type (3, "student_three"));

    // 用数组方式插入数据
    mapStudent[1] = "student_one";
    mapStudent[2] = "student_two";
    mapStudent[3] = "student_three";

    cout << "The size of map is: " << mapStudent.size() << endl;

    map<int, string>::iterator iter;
    for(iter = mapStudent.begin(); iter != mapStudent.end(); iter++)
    {
        cout << iter->first<< ": " << iter->second << endl;
    }

    return 0;
}
```

执行 `g++ main.cpp && ./a.out` 编译运行以上程序，输出结果如下：

```bash
The size of map is: 3
1: student_one
2: student_two
3: student_three
```

示例代码中提供了三种插入数据的方法，但是它们是有区别的。当然，第一种和第二种在效果上是完成一样的，用 `insert()` 函数插入数据，在数据的插入上涉及到集合的唯一性这个概念，即当 map 中有这个关键字时，insert 操作是不能插入数据的。但是用数组方式就不一样，它可以覆盖以前该关键字对应的值。



## map 函数列表

以下是 map 的所有成员函数的列表。

### 构造器/解析器

| 函数             | 说明                           |
| ---------------- | ------------------------------ |
| `(constructors)` | 构建映射                       |
| `(destructors)`  | 映射析构函数                   |
| `operator =`     | 将映射的元素复制到另一张映射。 |

### 迭代器

| 函数      | 说明                                    |
| --------- | --------------------------------------- |
| `begin`   | 返回指向映射中第一个元素的迭代器。      |
| `cbegin`  | 返回指向映射中第一个元素的const迭代器。 |
| `end`     | 返回指向末尾的迭代器。                  |
| `cend`    | 返回一个指向末尾的常量迭代器。          |
| `rbegin`  | 返回指向结尾的反向迭代器。              |
| `rend`    | 返回指向起点的反向迭代器。              |
| `crbegin` | 返回一个常量ant反向迭代器指向结束。     |
| `credit`  | 返回指向起点的常量反向迭代器。          |

### 容量

| 函数       | 说明                       |
| ---------- | -------------------------- |
| `empty`    | 如果映射为空，则返回true。 |
| `size`     | 返回映射中的元素数量。     |
| `max_size` | 返回映射的最大尺寸。       |

### 元素访问

| 函数          | 说明                   |
| ------------- | ---------------------- |
| `operator []` | 使用给定的键检索元素。 |
| `at`          | 使用给定的键检索元素。 |

### 修饰符

| 函数           | 说明                               |
| -------------- | ---------------------------------- |
| `insert`       | 在映射中插入元素。                 |
| `erase`        | 从映射上擦除元素。                 |
| `swap`         | 交换映射内容。                     |
| `clear`        | 删除映射的所有元素。               |
| `emplace`      | 构造新元素并将其插入映射。         |
| `emplace_hint` | 通过提示构造新元素并将其插入映射。 |

### 观察者

| 函数         | 说明                   |
| ------------ | ---------------------- |
| `key_comp`   | 返回键比较对象的副本。 |
| `value_comp` | 返回值比较对象的副本。 |

### 操作方式

| 函数            | 说明                           |
| --------------- | ------------------------------ |
| `find`          | 搜索具有给定键的元素。         |
| `count`         | 获取与给定键匹配的元素数。     |
| `lower_bound`   | 将迭代器返回到下限。           |
| `upper_bound`   | 将迭代器返回上限。             |
| `equal_range`   | 返回与给定键匹配的元素的参数。 |
| `get_allocator` | 返回用于构造映射的分配器对象。 |

### 非重载函数

| Functions    | Description                            |
| ------------ | -------------------------------------- |
| `operator==` | 检查两个映射是否相等。                 |
| `operator!=` | 检查两个映射是否相等。                 |
| `operator`   | 检查第一张映射是否小于其他映射。       |
| `operator`   | 检查第一张映射是否小于或等于其他映射。 |
| `operator>`  | 检查第一张映射是否大于其他映射。       |
| `operator>=` | 检查第一张映射是否大于其他映射。       |
| `swap()`     | 交换两个映射的元素。                   |


