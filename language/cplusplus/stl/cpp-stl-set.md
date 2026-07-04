---
sidebar_position: 14
slug: /cpp-stl-set
---

# C++ STL 集合（Set）



集（Set）是 C++ STL（标准模板库）的一部分。集合是存储排序键（key）的关联集合，其中每个键都是唯一的，可以插入或删除但不能更改。

Set 是由节点组成的红黑树，每个节点都包含着一个元素，节点之间以某种作用于元素对的谓词排列，没有两个不同的元素能够拥有相同的次序。



## set 语法

使用 set 容器，必须先引入 `<set>` 头文件。

```cpp showLineNumbers
#include <set>
```

set 的模板定义：

```cpp showLineNumbers
template < class T,                       // set::key_type/value_type
           class Compare = less<T>,       // set::key_compare/value_compare
           class Alloc = allocator<T>     // set::allocator_type
           > class set;
```

参数说明

| 参数      | 说明                                                         |
| --------- | ------------------------------------------------------------ |
| `T`       | 存储在集合集中的元素类型。                                   |
| `Compare` | 一个比较类，它接受两个具有相同 bool 类型的参数并返回一个值。此参数是可选的，二进制谓词 `less <T>` 是默认值。 |
| `Alloc`   | 用于定义存储分配模型的分配器对象的类型。                     |

示例：创建 set 容器

```cpp showLineNumbers
#include <iostream>
#include <set>
#include <string>

using namespace std;

int main(void) 
{
    // 初始化字符串集合
    set<string> fruit {
        "orange", "apple", "mango", "peach", "grape"
    };
    
    // 查看 set 容器大小
    cout << "Size of set container fruit is : " << fruit.size() << endl;
    return 0;
}
```

执行 `g++ main.cpp && ./a.out` 编译运行以上程序，输出结果如下：

```bash
Size of set container fruit is : 5
```



## set 成员函数

### 构造函数/解析函数

| 函数            | 说明                           |
| --------------- | ------------------------------ |
| `(constructor)` | 构造函数                       |
| `(destructor)`  | 解析函数                       |
| `operator=`     | 将集合的元素复制到另一个集合。 |



### 迭代器

| 函数      | 说明                                      |
| --------- | ----------------------------------------- |
| `begin`   | 返回指向集合中第一个元素的迭代器。        |
| `cbegin`  | 返回指向集合中第一个元素的 const 迭代器。 |
| `end`     | 返回指向末尾的迭代器。                    |
| `Cend`    | 返回一个指向末尾的常量迭代器。            |
| `rbegin`  | 返回指向结尾的反向迭代器。                |
| `rend`    | 返回指向起点的反向迭代器。                |
| `crbegin` | 返回一个常数指向最后的反向迭代器。        |
| `crend`   | 返回指向起点的常量反向迭代器。            |



### 容量

| 函数       | 说明                      |
| ---------- | ------------------------- |
| `empty`    | 如果set为空，则返回true。 |
| `size`     | 返回集合中的元素数量。    |
| `max_size` | 返回集合的最大大小。      |



### 修饰符

| 函数           | 说明                                 |
| -------------- | ------------------------------------ |
| `insert`       | 将元素插入集合中。                   |
| `erase`        | 从集合中擦除元素。                   |
| `swap`         | 交换集合的内容。                     |
| `clear`        | 删除集合中的所有元素。               |
| `emplace`      | 构造并将新元素插入到集合中。         |
| `emplace_hint` | 通过提示构造并将新元素插入到集合中。 |



### 观察者

| 函数         | 说明                   |
| ------------ | ---------------------- |
| `key_comp`   | 返回键比较对象的副本。 |
| `value_comp` | 返回值比较对象的副本。 |



### 操作方式

| 函数          | 说明                           |
| ------------- | ------------------------------ |
| `find`        | 搜索具有给定键的元素。         |
| `count`       | 获取与给定键匹配的元素数。     |
| `lower_bound` | 将迭代器返回到下限。           |
| `upper_bound` | 将迭代器返回上限。             |
| `equal_range` | 返回与给定键匹配的元素的范围。 |



### 分配者

| 函数            | 说明                           |
| --------------- | ------------------------------ |
| `get_allocator` | 返回用于构造集合的分配器对象。 |



## Set 非重载函数

| 函数         | 说明                             |
| :----------- | :------------------------------- |
| `operator==` | 检查两组是否相等。               |
| `operator!=` | 检查两组是否相等。               |
| `operator<`  | 检查第一组是否小于其他组。       |
| `operator<=` | 检查第一组是否小于或等于其他。   |
| `operator>`  | 检查第一个集合是否大于其他集合。 |
| `operator>=` | 检查第一个集合是否大于其他集合。 |
| `swap()`     | 交换两组元素。                   |



