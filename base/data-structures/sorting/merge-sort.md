---
sidebar_position: 8
slug: /merge-sort
sidebar_label: 归并排序
---

# 归并排序

**归并排序**把序列对半切开，递归排序左右，再把两个有序表**归并**成一个，典型 [分治法](/data-structures/divide-and-conquer/)。

## 实现骨架

```c showLineNumbers
void merge(int a[], int l, int m, int r, int tmp[]) {
    int i = l, j = m + 1, k = l;
    while (i <= m && j <= r) {
        tmp[k++] = (a[i] <= a[j]) ? a[i++] : a[j++]; /* <= 保稳定 */
    }
    while (i <= m) tmp[k++] = a[i++];
    while (j <= r) tmp[k++] = a[j++];
    for (int t = l; t <= r; t++) a[t] = tmp[t];
}

void merge_sort(int a[], int l, int r, int tmp[]) {
    if (l >= r) return;
    int m = l + (r - l) / 2;
    merge_sort(a, l, m, tmp);
    merge_sort(a, m + 1, r, tmp);
    merge(a, l, m, r, tmp);
}
```

## 复杂度与性质

| | |
| --- | --- |
| 时间 | 总是 $O(n \log n)$ |
| 空间 | 常见实现 $O(n)$ 辅助数组 |
| 稳定 | 是 |

还适合链表归并、外排序（多路归并）思想。C++ 中 `std::stable_sort` 保证稳定。

## 小结

归并是「分治 + 合并有序表」。需要稳定性或保证最坏时间时，它是重要选项。

下一篇：[基数排序](/data-structures/radix-sort/)。
