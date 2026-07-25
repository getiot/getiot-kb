---
sidebar_position: 3
slug: /binary-search
sidebar_label: 二分查找
---

# 二分查找

**二分查找**要求序列**有序**且支持随机访问。每次与中间元素比较，把问题规模减半，属于 [减治法](/data-structures/decrease-and-conquer/)。

## 本文解决什么问题

- 标准二分模板与溢出细节
- 复杂度与前提条件
- 常见变体（了解）

## 核心模板

```c showLineNumbers
int binary_search(const int a[], int n, int key) {
    int lo = 0, hi = n - 1;
    while (lo <= hi) {
        int mid = lo + (hi - lo) / 2;  /* 避免 (lo+hi) 溢出 */
        if (a[mid] == key) return mid;
        if (a[mid] < key) lo = mid + 1;
        else hi = mid - 1;
    }
    return -1;
}
```

```cpp showLineNumbers
#include <algorithm>
#include <vector>

// 库函数：存在则指向该元素，否则指向插入点
auto it = std::lower_bound(a.begin(), a.end(), key);
```

## 复杂度与前提

- 时间 $O(\log n)$  
- 额外空间：迭代 $O(1)$，递归 $O(\log n)$  
- **前提**：有序 + 随机访问（数组 / `vector`，不是链表）  

动态频繁插入时，维护有序数组成本高，可改用 BST / 哈希。

## 常见变体（了解）

| 变体 | 目标 |
| --- | --- |
| `lower_bound` | 第一个 $\ge key$ 的位置 |
| `upper_bound` | 第一个 $> key$ 的位置 |
| 找第一个 / 最后一个等于 key | 在相等时继续向左或向右收窄 |

写变体时最容易错的是 `while` 条件与 `mid±1` 是否前进，建议用小组数据手测。

## 常见错误

| 错误 | 说明 |
| --- | --- |
| `(lo+hi)/2` | 大下标可能溢出 |
| 无序仍二分 | 结果错误 |
| `lo < hi` 与更新方式不配 | 死循环或漏解 |

## 小结

二分快，但前提是有序。先写对「存在性」模板，再练 bound 类变体。

下一篇：[哈希表](/data-structures/hash-table/)。
