---
sidebar_position: 3
slug: /shell-sort
sidebar_label: 希尔排序
---

# 希尔排序

**希尔排序（Shell Sort）**按增量序列把元素分成若干子序列，分别做插入排序；增量逐步缩小，最后增量为 1 时做一次直接插入。

## 本文解决什么问题

- 希尔相对直接插入改进了什么
- 如何写一版固定增量的实现
- 复杂度如何理解

## 直觉

远距离元素先大致归位，减少后期插入时的移动次数。增量序列的选择影响性能。

```c showLineNumbers
void shell_sort(int a[], int n) {
    for (int gap = n / 2; gap > 0; gap /= 2) {
        for (int i = gap; i < n; i++) {
            int key = a[i], j = i;
            while (j >= gap && a[j - gap] > key) {
                a[j] = a[j - gap];
                j -= gap;
            }
            a[j] = key;
        }
    }
}
```

上例增量取 `n/2, n/4, ..., 1`，实现简单；还有 Hibbard、Sedgewick 等序列，实践中可能更快。

## 复杂度与性质

- 时间依赖增量，常见实现大致介于 $O(n^{1.3})$～$O(n^2)$ 量级（**需结合具体序列验证**）  
- 额外空间 $O(1)$  
- 一般**不稳定**  

## 小结

希尔 = 分组插入 + 缩小增量。先会写「gap 折半」一版，再查阅更优增量。

下一篇：[冒泡排序](/data-structures/bubble-sort/)。
