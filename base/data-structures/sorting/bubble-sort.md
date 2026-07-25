---
sidebar_position: 4
slug: /bubble-sort
sidebar_label: 冒泡排序
---

# 冒泡排序

**冒泡排序**反复比较相邻元素，逆序则交换，使较大（或较小）元素逐渐「冒」到一端。

## 本文解决什么问题

- 标准写法与提前结束优化
- 复杂度与稳定性
- 教学价值 vs 工程价值

## 实现

```c showLineNumbers
void bubble_sort(int a[], int n) {
    for (int i = 0; i < n - 1; i++) {
        int swapped = 0;
        for (int j = 0; j < n - 1 - i; j++) {
            if (a[j] > a[j + 1]) {
                int t = a[j]; a[j] = a[j + 1]; a[j + 1] = t;
                swapped = 1;
            }
        }
        if (!swapped) break; /* 已有序可提前结束 */
    }
}
```

## 复杂度

| | |
| --- | --- |
| 最好 | $O(n)$（加 swapped 优化且已有序） |
| 平均 / 最坏 | $O(n^2)$ |
| 空间 | $O(1)$ |
| 稳定 | 是（相等不交换） |

## 小结

冒泡帮助理解交换类排序；真正常用的交换思想代表是 [快速排序](/data-structures/quick-sort/)。大数组工程中少用冒泡。
