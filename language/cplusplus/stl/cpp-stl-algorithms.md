---
sidebar_position: 6
slug: /cpp-stl-algorithms
---

# C++ STL 算法



## STL 算法

STL 采用泛化（Generic）的方式实现各种算法，实现了数据结构和算法分离的目的。正是这种分离设计，使得 STL 变得非常通用。包括排序、查找、排列组合算法以及用于数据移动、复制、删除、比较、组合、运算等的算法。例如，我们可以将 STL 的 `sort()` 函数用在几乎所有数据集合的排序上，包括链表，容器和数组等等。

函数库对数据类型的选择对其可重用性起着至关重要的作用。而 C++ 通过模板的机制允许推迟对某些类型的选择，直到真正想使用模板或者说对模板进行特化的时候，STL 就利用了这一点提供了相当多的有用算法。

STL 提供了大约 100 个实现算法的模版函数，比如算法 for_each 将为指定序列中的每一个元素调用指定的函数，stable_sort 以你所指定的规则对序列进行稳定性排序等等。这样一来，只要我们熟悉了 STL 之后，许多代码可以被大大的化简，只需要通过调用一两个算法模板，就可以完成所需要的功能并大大地提升效率。

STL 算法部分的头文件包括三个：`<algorithm>`、`<numeric>` 和 `<functional>`。

- 要使用 STL 中的算法函数必须包含头文件 `<algorithm>`，它是所有 STL 头文件中最大的一个，包含一堆模板函数，功能涉及比较、交换、查找、遍历操作、复制、修改、移除、反转、排序、合并等算法；
- 而 `<numeric>` 提供了数学运算的模板函数，比如加法和乘法在序列上的一些操作。
- `<functional>` 中则定义了一些模板类，用来声明函数对象。

在 C++ STL 中，所有泛型算法的前两个参数都是一对迭代器（iterators），通常称为 `first` 和 `last`，用以标示算法的操作区间。STL 习惯采用前闭后开区间表示法，写成 `[first, last)`。不过有一个必要条件就是，必须能够累加操作符从 `first` 到达 `last`。编译器本身无法强求这一点，因此需要程序员去保证，否则将导致不可预期的结果。

每一个 STL 算法的声明，都必须说明它所需要的最低程度的迭代器类型，例如 `find()` 需要一个 InputIterator ，这是它的最低要求，但是它也可以接受更高类型的迭代器，如 ForwardIterator、BidirectionalIterator 或者 RandomAccessIterator。但是如果给 `find()` 传递一个 OutputIterator，将会出错。此外，将无效的迭代器传递给某个算法，虽然是一种错误，但是不保证编译器就会被捕捉出来。



## 常用 STL 算法

STL 涵盖了许多非常有用的算法，比如排序、查找、排列组合、数据移动、复制、删除、比较、组合、运算等等。这里介绍其中比较常用的一些。

### sort

sort 将范围 `[first,last)` 中的元素按升序排序。第一个版本使用 `operator<` 比较元素，第二个版本使用 `comp` 进行比较。sort 是我们用的最多的一个算法，它接受两个 RandomAccessIterators（随机存取迭代器），然后将区间内所有元素以递增方式由大到小重新排列。它的仿函数版本，允许自定义排序标准。

关联式容器自动排序，序列式容器中 stack、queue、priority-queue 都是有特定的出入口，因此也不需要 sort。list 的迭代器属于 BidirectionalIterators，因此不能用 sort，剩下的 vector 和 deque 比较适合用 sort。

```cpp showLineNumbers
template <class RandomAccessIterator>
void sort (RandomAccessIterator first, RandomAccessIterator last);

template <class RandomAccessIterator, class Compare>
void sort (RandomAccessIterator first, RandomAccessIterator last, Compare comp);
```

一定要注意第二个参数是一个仿函数对象，直接用仿函数类是不可以的。下面是一个简单的示例：

```cpp showLineNumbers
int myints[] = {32, 71, 12, 45, 26, 80, 53, 33};
std::vector<int> myvector (myints, myints+8);               // 32 71 12 45 26 80 53 33

// using default comparison (operator <):
std::sort (myvector.begin(), myvector.begin()+4);           //(12 32 45 71)26 80 53 33
// using function as comp
std::sort (myvector.begin()+4, myvector.end(), myfunction); // 12 32 45 71(26 33 53 80)
// print out content:
// using object as comp
std::sort (myvector.begin(), myvector.end(), myobject);     //(12 26 32 33 45 53 71 80)
```

参考手册：[sort](http://www.cplusplus.com/reference/algorithm/sort/)



### lower_bound

这是二分查找的一种版本，试图在已经排序的 `[first, last)` 中寻找元素 value。它返回一个迭代器，指向第一个 “不小于 value” 的元素。如果 value 大于 `[first, last)` 内的任何一个元素，则返回 last。该函数接受两个版本，版本一采用 `operator <` 进行比较，版本二采用仿函数 `comp`，完整的声明如下。

```cpp showLineNumbers
template <class ForwardIterator, class T>
ForwardIterator lower_bound (ForwardIterator first, ForwardIterator last,
                            const T& val);

template <class ForwardIterator, class T, class Compare>
ForwardIterator lower_bound (ForwardIterator first, ForwardIterator last,
                            const T& val, Compare comp);
```

此外，还有一个和 `lower_bound` 函数十分类似的 `upper_bound`，返回的迭代器指向区间内第一个大于 value 的元素。

下面是一个简单的示例：

```cpp showLineNumbers
#include <iostream>     // std::cout
#include <algorithm>    // std::lower_bound, std::upper_bound, std::sort
#include <vector>       // std::vector

int main(void)
{
    int myints[] = {10, 20, 30, 30, 20, 10, 10, 20};
    std::vector<int> v(myints,myints+8);           // 10 20 30 30 20 10 10 20
    std::sort(v.begin(), v.end());                 // 10 10 10 20 20 20 30 30

    std::vector<int>::iterator low,up;
    low=std::lower_bound (v.begin(), v.end(), 20); //          ^
    up= std::upper_bound (v.begin(), v.end(), 20); //                   ^

    std::cout << "lower_bound at position " << (low- v.begin()) << '\n';
    std::cout << "upper_bound at position " << (up - v.begin()) << '\n';

    return 0;
}
// lower_bound at position 3
// upper_bound at position 6
```

此外，还有一些用到二分查找的其他算法，比如 `binary_search` 用来检查指定值是否存在于排序后的序列中，`equal_range` 返回排序后的序列中值等于 value 的下标范围。

参考手册：[lower_bound](http://www.cplusplus.com/reference/algorithm/lower_bound/)



### 其他算法

* `reverse`：反转范围 `[first,last)` 中元素的顺序。
* `swap`：交换 a 和 b 的值。
* `binary_search`：如果范围 `[first,last)` 中的任何元素等效于 val，则返回 true，否则返回 false。
* `find`：返回指向范围 `[first,last)` 中比较等于 val 的第一个元素的迭代器。如果没有找到比较相等的元素，函数返回 last。
* `find_first_of`：返回一个指向范围 `[first1,last1)` 中与 `[first2,last2)` 中的元素匹配的第一个元素的迭代器。如果没有找到这样的元素，函数返回 last1。

参考手册：[**STL: Algorithms**](https://www.cplusplus.com/reference/algorithm/)

