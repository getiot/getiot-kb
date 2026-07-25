---
sidebar_position: 2
slug: /sequential-search
sidebar_label: 顺序查找
---

# 顺序查找

**顺序查找（线性查找）**从表的一端起，逐个将关键字与给定值比较，直到命中或扫完。

## 本文解决什么问题

- 适用场景与复杂度
- 哨兵优化在做什么
- 和二分、哈希的边界

## 适用场景

- 表无序  
- 链表等不便随机访问的结构  
- 数据量很小，实现成本优先  

时间约为 $O(n)$。

```c showLineNumbers
int sequential_search(const int a[], int n, int key) {
    for (int i = 0; i < n; i++) {
        if (a[i] == key) return i;
    }
    return -1;
}
```

## 哨兵技巧

把 `key` 放在表尾（或下标 0）当哨兵，循环里可少做「下标越界」判断：

```c showLineNumbers
/* a[0] 作哨兵，有效数据在 a[1..n] */
int sequential_search_sentinel(int a[], int n, int key) {
    a[0] = key;
    int i = n;
    while (a[i] != key) i--;
    return i;  /* 0 表示没找到 */
}
```

教材常用；工程里可读性有时更重要，不一定要哨兵。

## 平均查找长度（直觉）

若每个元素等概率命中，成功 ASL 约为 $\frac{n+1}{2}$；失败则常要比较到表尾。

## 小结

顺序查找最简单，也是理解 ASL 的起点。有序且可随机访问时，优先考虑 [二分查找](/data-structures/binary-search/)。
