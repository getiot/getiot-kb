---
sidebar_position: 5
slug: /quick-sort
sidebar_label: 快速排序
---

# 快速排序

**快速排序**选一个基准（pivot），把序列分成「小于基准」与「大于基准」两部分，再递归排序两侧，属于 [分治法](/data-structures/divide-and-conquer/)。

## 本文解决什么问题

- 分区（partition）在做什么
- 平均与最坏复杂度
- 常见工程优化方向

## 分区直觉

一次 partition 后，基准落在最终位置；左右子问题规模通常显著减小。

```c showLineNumbers
/* Lomuto 分区：以 a[hi] 为 pivot */
int partition(int a[], int lo, int hi) {
    int pivot = a[hi];
    int i = lo;
    for (int j = lo; j < hi; j++) {
        if (a[j] < pivot) {
            int t = a[i]; a[i] = a[j]; a[j] = t;
            i++;
        }
    }
    int t = a[i]; a[i] = a[hi]; a[hi] = t;
    return i;
}

void quick_sort(int a[], int lo, int hi) {
    if (lo >= hi) return;
    int p = partition(a, lo, hi);
    quick_sort(a, lo, p - 1);
    quick_sort(a, p + 1, hi);
}
```

## 复杂度与性质

| | |
| --- | --- |
| 平均 | $O(n \log n)$ |
| 最坏 | $O(n^2)$（已有序且 pivot 总选端点等） |
| 空间 | 平均递归栈 $O(\log n)$，最坏 $O(n)$ |
| 稳定 | 否（一般实现） |

## 工程优化（了解）

- 随机 pivot / 三数取中，降低最坏概率  
- 小区间改插入排序  
- 尾递归优化、三路快排（大量重复键）  

C++ `std::sort` 通常是内省排序（快排 + 堆排兜底等），实践中优先用库。

## 小结

快排是实践中最重要的排序之一。先写对一种分区，再理解最坏情况与优化。

下一篇：[简单选择排序](/data-structures/selection-sort/)。
