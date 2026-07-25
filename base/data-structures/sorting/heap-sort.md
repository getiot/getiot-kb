---
sidebar_position: 7
slug: /heap-sort
sidebar_label: 堆排序
---

# 堆排序

**堆排序**利用堆（优先队列）反复取出极值来排序。结构细节见 [堆](/data-structures/heap/)。

## 本文解决什么问题

- 建堆 + 反复取顶的步骤
- 复杂度与稳定性
- 和快排的对比直觉

## 步骤（升序用大顶堆）

1. 把数组建成大顶堆  
2. 堆顶与末尾交换，堆大小减 1，再向下调整  
3. 重复直到堆空  

```c showLineNumbers
void sift_down(int a[], int start, int end) {
    int root = start;
    while (1) {
        int child = root * 2 + 1;
        if (child > end) break;
        if (child + 1 <= end && a[child] < a[child + 1]) child++;
        if (a[root] >= a[child]) break;
        int t = a[root]; a[root] = a[child]; a[child] = t;
        root = child;
    }
}

void heap_sort(int a[], int n) {
    for (int i = n / 2 - 1; i >= 0; i--) sift_down(a, i, n - 1);
    for (int end = n - 1; end > 0; end--) {
        int t = a[0]; a[0] = a[end]; a[end] = t;
        sift_down(a, 0, end - 1);
    }
}
```

## 复杂度与性质

| | |
| --- | --- |
| 时间 | $O(n \log n)$（最坏也是） |
| 空间 | $O(1)$ 额外（原地） |
| 稳定 | 否 |

相对快排：最坏有保证，但常数与缓存表现常不如精心实现的快排。

## 小结

堆排序保证最坏 $O(n \log n)$。下一篇：[归并排序](/data-structures/merge-sort/)。
