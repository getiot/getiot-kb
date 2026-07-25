---
sidebar_position: 5
slug: /dynamic-programming
sidebar_label: 动态规划法
---

# 动态规划法

**动态规划（Dynamic Programming，DP）**用于同时具备：

1. **最优子结构**：大问题的最优解由子问题最优解构成  
2. **重叠子问题**：同样的子问题被反复算到  

做法是：把子问题答案存下来（记忆化或填表），避免重复计算。

## 本文解决什么问题

- DP 和分治、贪心差在哪里
- 如何从递归定义走到递推填表
- 做题时的四步思考顺序

## 和分治 / 贪心的差别

| | 分治 | 贪心 | 动态规划 |
| --- | --- | --- | --- |
| 子问题 | 常互不重叠 | 每步做一个选择 | 子问题重叠，需复用 |
| 目标 | 分而治之再合并 | 每步局部最优 | 填表 / 记忆化得到全局最优 |
| 典型 | 归并 | 活动选择、MST | 背包、LCS、最短路 DP 版 |

分治若子问题重叠严重，朴素递归会爆；DP 正是为「重叠」准备的。

## 从递归到 DP：斐波那契

朴素递归：

```c showLineNumbers
long long fib(int n) {
    if (n <= 1) return n;
    return fib(n - 1) + fib(n - 2);   /* 大量重复 */
}
```

### 办法一：记忆化（自顶向下）

```c showLineNumbers
long long memo[128];

long long fib_memo(int n) {
    if (n <= 1) return n;
    if (memo[n] != -1) return memo[n];
    memo[n] = fib_memo(n - 1) + fib_memo(n - 2);
    return memo[n];
}

/* 使用前：for (int i = 0; i < 128; i++) memo[i] = -1; */
```

### 办法二：递推填表（自底向上）

```c showLineNumbers
long long fib_dp(int n) {
    if (n <= 1) return n;
    long long dp0 = 0, dp1 = 1;   /* 滚动变量，空间 O(1) */
    for (int i = 2; i <= n; i++) {
        long long cur = dp0 + dp1;
        dp0 = dp1;
        dp1 = cur;
    }
    return dp1;
}
```

时间 $O(n)$。斐波那契是「最小 DP 味道」的例子；更典型的还有背包、最长公共子序列等。

## 例子：爬楼梯（入门状态转移）

一次可走 1 或 2 级，问爬到第 $n$ 级有多少种走法。

- 状态：`dp[i]` = 到达第 $i$ 级的方案数  
- 转移：`dp[i] = dp[i-1] + dp[i-2]`  
- 初始：`dp[1]=1, dp[2]=2`（按你的题面约定）  

```c showLineNumbers
int climb_stairs(int n) {
    if (n <= 2) return n;
    int a = 1, b = 2;
    for (int i = 3; i <= n; i++) {
        int c = a + b;
        a = b;
        b = c;
    }
    return b;
}
```

你会发现它和斐波那契几乎同构——**DP 的关键往往是状态定义，而不是会不会写循环**。

## 做题时的思考顺序

1. **状态**：`dp[...]` 的含义是什么？（用一句话说清）  
2. **转移**：当前状态如何由更小状态得到？  
3. **初始值与边界**：空、长度为 1、全 0 等  
4. **计算顺序**：保证用到的子问题已经算完；能否压缩空间？  

:::tip
先写会超时的递归 + 记忆化，往往比一上来填多维表更不容易错。正确后再改成纯循环、再压空间。
:::

## 常见坑

| 坑 | 说明 |
| --- | --- |
| 状态含义不清 | 转移很难写对，调也调不明白 |
| 漏边界 | `n=0`、全负数、容量为 0 |
| 顺序错误 | 用到了尚未计算的状态 |
| 误当贪心 | 局部最优 ≠ 全局最优时硬贪 |

## 和本教程的衔接

- [递归入门](/data-structures/recursion/) 中的重复计算，正是 DP 要消灭的对象  
- 最短路中的 Floyd、部分 DP on DAG，会在图章节再次出现  
- 本篇建立方法论；大型题（背包模板、区间 DP）可在掌握基本结构后专项练习  

## 小结

DP 的关键是**状态定义 + 转移 + 复用**。先保证递归定义正确，再记忆化或填表，最后考虑空间优化。

下一章进入具体数据结构：从 [线性表概述](/data-structures/linear-list/) 开始。
