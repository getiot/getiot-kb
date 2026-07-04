---
sidebar_position: 1
slug: /cpp-stl-tutorial
---

# C++ STL 教程



**STL** 是 “Standard Template Library” 的缩写，中文译为 “标准模板库”。STL 是 C++ 标准库的一部分，不用单独安装。

STL 是一个具有工业强度的、高效的 C++ 程序库。它被容纳于 C++ 标准程序库（C++ Standard Library）中，是 ANSI/ISO C++ 标准中最新的也是极具革命性的一部分。该库包含了诸多在计算机科学领域里所常用的基本数据结构和基本算法。为广大 C++ 程序员们提供了一个可扩展的应用框架，高度体现了软件的可复用性。

C++ 对模板（Template）支持得很好，STL 就是借助模板把常用的数据结构及其算法都实现了一遍，并且做到了数据结构和算法的分离。例如，vector 的底层为顺序表（数组），list 的底层为双向链表，deque 的底层为循环队列，set 的底层为红黑树，hash_set 的底层为哈希表。

STL 的代码从广义上讲分为三类：algorithm（算法）、container（容器）和 iterator（迭代器），几乎所有的代码都采用了模板类和模版函数的方式，这相比于传统的由函数和类组成的库来说提供了更好的代码重用机会。

在 C++ 标准中，STL 被组织为下面的 13 个头文件：

```cpp showLineNumbers
<algorithm>
<deque>
<functional>
<iterator>
<vector>
<list>
<map>
<memory>
<numeric>
<queue>
<set>
<stack>
<utility>
```

有关 C++ STL 的内容，本教程将逐一展开介绍。


