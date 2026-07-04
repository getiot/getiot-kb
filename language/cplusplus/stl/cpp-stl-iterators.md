---
sidebar_position: 5
slug: /cpp-stl-iterators
---

# C++ STL 迭代器

软件设计有一个基本原则 —— 所有的问题都可以通过引进一个间接层来简化。这种简化在 STL 中就是用迭代器来完成的。



## STL 迭代器

迭代器（iterator）是一种抽象的设计概念，《Design Patterns》中对迭代器的定义如下：

*“提供一种方法，使之能够依序巡访某个聚合物（容器）所含的各个元素，而又无需暴露该聚合物的内部表示方式。”*

概括来说，迭代器在 STL 中的作用是将算法和容器联系起来，起着一种黏和剂的作用。几乎 STL 提供的所有算法都是通过迭代器存取元素序列进行工作的，每一个容器都定义了其本身所专有的迭代器，用以存取容器中的元素。

![STL 迭代器是算法操作容器的桥梁，与容器一一对应](https://static.getiot.tech/cpp-stl-algorithm-container-iterator.png#center)

在 C++ 中，STL 迭代器部分主要由头文件 `<utility>`, `<iterator>` 和 `<memory>` 组成。

| 头文件       | 描述                                                         |
| ------------ | ------------------------------------------------------------ |
| `<utility>`  | 一个很小的头文件，它包括了贯穿使用在 STL 中的几个模板的声明。 |
| `<iterator>` | 提供了迭代器使用的许多方法，而对于 `<memory>` 的描述则十分的困难，它以不同寻常的方式为容器中的元素分配存储空间，同时也为某些算法执行期间产生的临时对象提供机制。 |
| `<memory>`   | 主要部分是模板类 allocator，它负责产生所有容器中的默认分配器。 |

和指针不同，迭代器提供了许多更强大的功能。它们不仅能操作任何类型的容器，还能执行范围检查并分析容器的使用。当然，迭代器的最大优势就是极大地增加了代码重用性：基于迭代器写的算法在大部分的容器上都能使用，而且自己写的容器要是提供了迭代器，就能作为参数传给各种各样的标准函数。



## 迭代器类型

根据移动特性与可以施行的操作，可以将迭代器分为五类：

* **输入迭代器**（Input iterators）：提供对数据的只读访问。
* **输出迭代器**（Output iterators）：提供对数据的只写访问。
* **前推迭代器**（Forward iterators）：提供读写操作。
* **双向迭代器**（Bidirectional iterators）：提供读写操作，并能向前和向后操作。
* **随机访问迭代器**（Random access iterators）：提供读写操作，并能在数据中随机移动，包括 `p+n, p-n, p[n], p1-p2, p1<p2` 等。

尽管各种不同的 STL 在实现细节方面有所不同，但还是可以将上面的迭代器想象为一种类继承关系。从某种程度上看，下图中下面的迭代器继承自上面的迭代器。由于这种继承关系，可以将一个 Forward 迭代器作为一个 Output 或 Input 迭代器使用。同样，如果一个算法要求一个 Bidirectional 迭代器，那么只能使用该种类型和随机访问迭代器。

![](https://static.getiot.tech/cpp-stl-iterator-1.png#center)

### 输入迭代器

输入迭代器是可用于顺序输入操作的迭代器，其中迭代器指向的每个值只读取一次，然后迭代器递增。

正如其名字所说的，输入迭代器就像输入流一样。每个容器都需要根据自己的内部实现来提供相应的迭代器类型，不过所有的输入迭代器必须支持下面的操作。

- 支持拷贝构造和拷贝赋值，可以正常地析构。

  ```cpp showLineNumbers
  b(a); b = a;
  ```

- 支持用 `==` 和 `!=` 操作符对两个迭代器进行比较。

  ```cpp showLineNumbers
  a == b; a != b;
  ```

- 如果处于可取消引用状态的话，可以解引用为一个右值（rvalue）。

  ```cpp showLineNumbers
  *a; a->m;
  ```

- 有效的话可以进行递增运算，递增后继续有效或者为一个 `past-the-end` 迭代器。递增后前一个迭代器不用处于有效状态。

  ```cpp showLineNumbers
  ++a; (void)a++; *a++
  ```

- 迭代器是左值，并且可以交换。

  ```cpp showLineNumbers
  swap(a,b)
  ```



**注意：使用 Input Iterators 的算法每次执行只能对容器遍历一次。**

下面看一下 `find()` 模板函数的定义（在 find 算法中，如果 first 和 last 指向不同的容器，该算法可能陷入死循环）。

```cpp showLineNumbers
template<class InputIterator, class T>  
InputIterator find (InputIterator first, InputIterator last, const T& val)
{
    while (first != last) {
        if (*first == val) return first;
        ++first;
    }
    return last;
}
```

参考手册：[Input iterators](http://www.cplusplus.com/reference/iterator/InputIterator/)



### 输出迭代器

输出迭代器和输入迭代器的区别在于解引用后得到的是一个左值，并且只能被解引用到赋值表达式的左边，一旦解引用一次，就不能再次进行解引用。

```cpp showLineNumbers
*a = t
*a++ = t
```

输出迭代器默认是只写的，通常用于将数据从一个位置拷贝到另一个位置。由于输出迭代器无法读取对象，因此不能在任何搜索和其他算法中使用它。下面看一下 `copy()` 模板函数的定义。

```cpp showLineNumbers
template<class InputIterator, class OutputIterator>
OutputIterator copy (InputIterator first, InputIterator last, OutputIterator result)
{
  while (first!=last) {
    *result = *first;
    ++result; ++first;
  }
  return result;
}
```

参考手册：[Output iterators](http://www.cplusplus.com/reference/iterator/OutputIterator/)



### 前推迭代器

前推迭代器有点像输入迭代器和输出迭代器的结合，既可以读取值，又可以对其赋值。解引用一个迭代器后，该迭代器不会失效，因此算法中可以多次读取迭代器或者对迭代器进行赋值。

```cpp showLineNumbers
*a
a->m
*a = t
```

下面看下 `replace()` 模版函数的定义（replace 将 `[first, last)` 范围内的所有值为 old_value 的对象替换为 new_value）。

```cpp showLineNumbers
template <class ForwardIterator, class T>
void replace (ForwardIterator first, ForwardIterator last,
                const T& old_value, const T& new_value)
{
    while (first != last) {
        // 既可以解引用读取值，又可以给其赋值。
        if (*first == old_value) *first = new_value;
        ++first;
    }
}
```

参考手册：[Forward iterators](http://www.cplusplus.com/reference/iterator/ForwardIterator/)



### 双向迭代器

双向迭代器在前推迭代器的基础上，增加了迭代器的后退功能。

```cpp showLineNumbers
--a
a--
*a--
```

下面看下 `reverse()` 对容器进行逆向排序，该算法要求两个双向迭代器作为参数。

```cpp showLineNumbers
template <class BidirectionalIterator>
void reverse (BidirectionalIterator first, BidirectionalIterator last)
{
    while ( (first != last) && (first != --last) ) {
        std::iter_swap (first,last);
        ++first;
    }
}
```

参考手册：[Bidirectional iterators](http://www.cplusplus.com/reference/iterator/BidirectionalIterator/)



### 随机访问迭代器

随机访问迭代器是在双向迭代器的基础上，允许以任意顺序访问数据，并且可以使用关系操作符进行比较，支持下面的迭代器操作（其中 n 为相应容器的 difference 类型）。

```cpp showLineNumbers
a + n
n + a
a - n
a - b
a < b
a > b
a <= b
a >= b
a += n
a -= n
a[n]
```

下面看下 `random_shuffle()` 函数（该随机打乱原先的顺序，要求两个随机迭代器作为参数）。

```cpp showLineNumbers
template <class RandomAccessIterator, class RandomNumberGenerator>
void random_shuffle (RandomAccessIterator first, RandomAccessIterator last,
                       RandomNumberGenerator& gen)
{
  iterator_traits<RandomAccessIterator>::difference_type i, n;
  n = (last-first);
  for (i=n-1; i>0; --i) {
    swap (first[i],first[gen(i+1)]);
  }
}
```

参考手册：[Random-access iterators](http://www.cplusplus.com/reference/iterator/RandomAccessIterator/)



## 迭代器失效分析

向容器中添加元素和从容器中删除元素的操作可能会使指向容器元素的迭代器失效，一个**失效的迭代器将不再表示任何元素**，使用失效的迭代器是一种严重的程序设计错误，很可能引起与使用未初始化指针一样的问题。



### 插入操作

对于序列式容器：

* `vector`：如果存储空间没有重新分配（扩大存储空间），则指向插入位置之前的元素的迭代器仍有效，但指向插入位置之后元素的迭代器将会失效。如果存储空间被重新分配，则指向容器的迭代器全部失效。
* `deque`：插入到除首尾位置之外的任何位置都会导致迭代器失效。如果在首尾位置添加元素，指向存在的元素的迭代器不会失效。
* `list`：指向容器的迭代器（包括尾后迭代器和首前迭代器）仍有效。
* `forward_list`：指向容器的迭代器（包括尾后迭代器和首前迭代器）仍有效。

对于关联容器：

* `[multi]{set,map}`：迭代器不受影响，因为底层实现是红黑树。
* `unordered_[multi]{set,map}`：如果插入操作不导致扩大存储空间，进而重新 hash，那么迭代器不受影响，否则所有的迭代器失效。



### 删除操作

当我们从一个容器中删除元素后，指向被删除元素的迭代器会失效，毕竟这个元素已经被销毁了，对于指向其它元素的迭代器来说，具体如下。

对于序列式容器：

* `vector`：指向被删元素之前元素的迭代器仍然有效。
* `deque`：如果在首尾之外的任何位置删除元素，那么指向被删除元素外的其它元素的迭代器也会失效。如果删除 deque 的尾元素，则尾后迭代器也会失效，但其它迭代器不受影响，如果删除首元素，都不受影响。
* `list`：指向容器其他位置的迭代器（包括尾后迭代器和首前迭代器）仍有效。
* `forward_list`：指向容器其他位置的迭代器（包括尾后迭代器和首前迭代器）仍有效。

对于关联容器：

* `[multi]{set,map}`：迭代器不受影响，因为底层实现是红黑树。
* `unordered_[multi]{set,map}`：不受影响。

对于容器适配器 stack、queue、priority_queue 来说，它们的迭代器取决于底层实现的容器。

由于向迭代器添加元素和从迭代器删除元素的代码可能会使迭代器失效，因此必须保证每次改变容器的操作之后都正确地**重新定位迭代器**。



### 循环中改变

添加/删除容器中元素的循环程序必须考虑迭代器可能失效的问题，程序必须保证每个循环步都更新迭代器。insert 和 erase 操作返回的都是迭代器，可以方便我们更新。下面是一个简单的例子：

```cpp showLineNumbers
// 删除偶数元素, 复制每个奇数元素
vector<int> vi = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
auto iter = vi.begin();
while (iter != vi.end()) {
    if (*iter % 2) {
        iter = vi.insert(iter, *iter);
        iter += 2;              // 跳过当前元素和插入到它前面的元素
    }
    else {
        iter = vi.erase(iter);  // 删除偶数元素
    }
}
```

这里 erase 返回的迭代器指向序列中下一个元素，insert 在给定位置之前插入新的元素，然后返回指向新插入元素的迭代器。

**注意：不要保存 end 返回的迭代器。**

每当添加删除 vector 的元素后，或者在 deque 中首元素之外任何位置添加/删除元素后，原来 end 返回的迭代器总是会失效。因此添加或删除元素的循环程序必须反复调用 end（通常 C++ 标准库的实现中 end() 操作都很快，部分就是因为这个原因）。

