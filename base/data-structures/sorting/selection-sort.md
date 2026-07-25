---
sidebar_position: 6
slug: /selection-sort
sidebar_label: 简单选择排序
---

# 简单选择排序

**简单选择排序**第 $i$ 趟在未排序后缀中选最小（或最大）元素，与后缀首位交换。

## 实现

```c showLineNumbers
void selection_sort(int a[], int n) {
    for (int i = 0; i < n - 1; i++) {
        int min_i = i;
        for (int j = i + 1; j < n; j++) {
            if (a[j] < a[min_i]) min_i = j;
        }
        if (min_i != i) {
            int t = a[i]; a[i] = a[min_i]; a[min_i] = t;
        }
    }
}
```

## 复杂度与性质

| | |
| --- | --- |
| 时间 | 总是 $\Theta(n^2)$（比较次数固定） |
| 空间 | $O(1)$ |
| 稳定 | 否（交换可能跨过相等元素） |
| 特点 | 交换次数少（最多 $n-1$ 次） |

## 小结

选择排序好写、好分析，但渐进性能一般。用堆做选择就得到 [堆排序](/data-structures/heap-sort/)。
