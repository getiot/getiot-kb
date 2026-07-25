---
sidebar_position: 4
slug: /greedy
sidebar_label: 贪心法
---

# 贪心法

**贪心法（Greedy）**每一步都做**当前看起来最优**的选择，并期望由此得到全局最优（或足够好的近似解）。

## 本文解决什么问题

- 贪心在什么条件下可能正确
- 如何用反例判断「不能贪」
- 本教程后续哪些算法属于贪心族

## 适用直觉

能贪心的问题往往（需要证明）具有：

1. **贪心选择性质**：局部最优选择可以成为某全局最优解的一部分  
2. **最优子结构**：最优解包含子问题的最优解  

这两点不是口号——**不是所有问题都能贪心**。拿不准时：

- 先尝试构造反例  
- 反例存在 → 换 DP 或其他方法  
- 反例找不到 → 再查证明或权威结论  

## 例子：找零（经典币值可用贪心）

币值为 $25, 10, 5, 1$ 时，每次选不超过余额的最大面额：

```c showLineNumbers
int coin_change_greedy(int amount) {
    const int coins[] = {25, 10, 5, 1};
    int count = 0;
    for (int i = 0; i < 4; i++) {
        count += amount / coins[i];
        amount %= coins[i];
    }
    return count;
}
```

对「美元常见面额」这类集合，贪心是正确的。但若币值改成例如 $1, 3, 4$，要凑 $6$：

- 贪心：$4 + 1 + 1$ → 3 枚  
- 最优：$3 + 3$ → 2 枚  

贪心失败。任意币值的最少枚数通常用 [动态规划](/data-structures/dynamic-programming/)。

## 例子：活动选择（区间调度）

有一批活动，每个有开始与结束时间，同一时刻只能做一个。目标：选尽可能多的活动。

经典贪心：按**结束时间早**排序，依次选与已选活动不冲突的下一个。

```c showLineNumbers
/* intervals[i] = {start, end}，已按 end 升序排序 */
int activity_select(const int start[], const int end[], int n) {
    if (n <= 0) return 0;
    int count = 1;
    int last_end = end[0];
    for (int i = 1; i < n; i++) {
        if (start[i] >= last_end) {
            count++;
            last_end = end[i];
        }
    }
    return count;
}
```

这是教科书级「可证明正确」的贪心例子，用来对照「找零可能失败」很有帮助。

## 本教程中的贪心影子

| 主题 | 贪心味道 |
| --- | --- |
| [哈夫曼树](/data-structures/huffman-tree/) | 每次合并最小权值的两棵树 |
| [最小生成树](/data-structures/minimum-spanning-tree/) | Prim / Kruskal 每次加当前最安全的边 |
| Dijkstra（非负权） | 每次确定离源点最近的未定点 |

细节在树与图章节展开。

## 贪心 vs 动态规划

| | 贪心 | 动态规划 |
| --- | --- | --- |
| 每步 | 只做一个局部选择，不回退 | 保留多种子问题最优，再转移 |
| 正确性 | 依赖贪心选择性质 | 依赖最优子结构 + 重叠子问题处理 |
| 实现 | 常排序 + 一遍扫描 | 常定义状态、填表 |
| 失败时 | 出现反例 | 状态或转移写错 |

:::tip
很多题「看起来能贪」，实际要用 DP。养成习惯：先想反例，再写代码。
:::

## 小结

贪心好写、常很快，但必须确认「局部最优能导向全局最优」。拿不准就举反例；反例存在就换方法。

下一篇：[动态规划法](/data-structures/dynamic-programming/)。
