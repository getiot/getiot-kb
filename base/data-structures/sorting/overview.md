---
sidebar_position: 1
slug: /sorting-overview
sidebar_label: 排序概述
---

# 排序概述

**排序**将序列按关键字递增或递减重新排列。它是算法课的核心训练场，也直接出现在系统、数据库、竞赛与工程中。

## 本文解决什么问题

- 排序如何分类
- 用哪些维度评价算法
- 本章各篇地图

## 本部分学什么

| 类别 | 文章 |
| --- | --- |
| 插入类 | [直接插入](/data-structures/insertion-sort/)、[希尔](/data-structures/shell-sort/) |
| 交换类 | [冒泡](/data-structures/bubble-sort/)、[快速](/data-structures/quick-sort/) |
| 选择类 | [简单选择](/data-structures/selection-sort/)、[堆排序](/data-structures/heap-sort/) |
| 归并类 | [归并排序](/data-structures/merge-sort/) |
| 分配类 | [基数排序](/data-structures/radix-sort/) |
| 对比 | [排序算法比较](/data-structures/sorting-comparison/) |

## 评价维度

| 维度 | 含义 |
| --- | --- |
| 时间 | 最好 / 平均 / 最坏 |
| 空间 | 是否原地（额外 $O(1)$） |
| 稳定性 | 相等关键字是否保持相对次序 |
| 适应性 | 对基本有序数据是否更快 |

:::tip 稳定性为何重要
多关键字排序时，先按次关键字排、再按主关键字用**稳定**排序，可保留次关键字次序。
:::

## 学习建议

1. 每个算法先跑通一个小数组手算  
2. 再默写代码，核对边界（`n=0/1`、已有序、逆序、含重复）  
3. 最后看 [比较篇](/data-structures/sorting-comparison/) 做选型  

工程中优先 `std::sort` / `std::stable_sort`；本教程手写是为了理解代价与思想。

## 小结

先建立「分类 + 评价指标」，再逐个算法动手。下一篇：[直接插入排序](/data-structures/insertion-sort/)。
