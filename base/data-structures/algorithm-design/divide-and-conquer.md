---
sidebar_position: 2
slug: /divide-and-conquer
sidebar_label: 分治法
---

# 分治法

**分治法（Divide and Conquer）**把大问题拆成若干**规模更小、彼此独立（或近似独立）**的子问题，分别解决后再合并结果。

## 本文解决什么问题

- 分治的「分 / 治 / 合」三步如何落地
- 和递归、减治的关系
- 如何直觉估计 $O(n \log n)$ 这类复杂度

## 三步曲

1. **分（Divide）**：把问题划成子问题  
2. **治（Conquer）**：递归求解子问题（小到足够简单则直接算）  
3. **合（Combine）**：把子问题答案合并成总答案  

伪代码骨架：

```text
Solve(P):
    if P 足够小:
        return 直接求解(P)
    把 P 分成 P1, P2, ..., Pk
    for each Pi:
        Si = Solve(Pi)
    return Combine(S1, ..., Sk)
```

## 和递归的关系

分治几乎总用递归表达。归并排序、快速排序、最大子数组的分治写法、一些树算法都是分治典型。

若你还不熟递归，先读 [递归入门](/data-structures/recursion/)。

## 例子：归并排序中的「合」

归并排序：对半分 → 递归排序左右 → **归并**两个有序段。

```c showLineNumbers
void merge(int *a, int l, int m, int r, int *tmp) {
    int i = l, j = m + 1, k = l;
    while (i <= m && j <= r) {
        tmp[k++] = (a[i] <= a[j]) ? a[i++] : a[j++];
    }
    while (i <= m) tmp[k++] = a[i++];
    while (j <= r) tmp[k++] = a[j++];
    for (int t = l; t <= r; t++) {
        a[t] = tmp[t];
    }
}

void merge_sort(int *a, int l, int r, int *tmp) {
    if (l >= r) return;                 /* 规模足够小 */
    int m = l + (r - l) / 2;            /* 分 */
    merge_sort(a, l, m, tmp);           /* 治左 */
    merge_sort(a, m + 1, r, tmp);       /* 治右 */
    merge(a, l, m, r, tmp);             /* 合 */
}
```

完整讨论见 [归并排序](/data-structures/merge-sort/)。

## 复杂度直觉（主定理扫盲）

一类常见情形：每次分成 2 个规模为 $n/2$ 的子问题，合并要 $\Theta(n)$，则总时间：

$$
T(n) = 2T(n/2) + \Theta(n) = \Theta(n \log n)
$$

可以用递归树理解：每层总工作约 $cn$，共约 $\log n$ 层。

| 算法 | 分 | 合的代价 | 常见总时间 |
| --- | --- | --- | --- |
| 归并排序 | 两半 | $\Theta(n)$ | $\Theta(n \log n)$ |
| 快速排序（平均） | 按 pivot 分区 | 分区 $\Theta(n)$ | 平均 $\Theta(n \log n)$ |
| 二分查找 | 取一半 | 几乎无合并 | $\Theta(\log n)$（更偏减治） |

## 分治 vs 减治

| | 分治 | 减治 |
| --- | --- | --- |
| 子问题数量 | 通常多个 | 通常缩小后只继续一个（或明显更少） |
| 是否要合并 | 常常要 | 常常直接得到答案 |
| 例子 | 归并、快排 | 二分查找、减一递归 |

有的教材把减治看作分治的特例；本教程单列，是为了帮你分辨「合并多个子问题」和「缩小后继续一个问题」。详见 [减治法](/data-structures/decrease-and-conquer/)。

## 适用时要想清的三件事

1. **子问题是否真的更小？** 边界会不会死循环  
2. **子问题之间是否独立？** 若大量重叠，可能更适合 DP  
3. **合并是否正确且高效？** 合并若写成 $O(n^2)$，整体可能退化  

## 小结

分治适合「可拆、可并」的问题。先画清楚子问题边界和合并方式，再写递归，最后用复杂度验证是否值得。

下一篇：[减治法](/data-structures/decrease-and-conquer/)。
