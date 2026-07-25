---
sidebar_position: 6
slug: /topological-sort
sidebar_label: 拓扑排序
---

# 拓扑排序

**拓扑排序**针对**有向无环图（DAG）**：给出顶点的一个线性次序，使得每条有向边 $u \rightarrow v$ 都满足 $u$ 在 $v$ 之前。

有环则不存在拓扑序。

## 本文解决什么问题

- 拓扑排序解决什么业务问题
- Kahn（入度法）如何实现
- 如何检测环
- DFS 法的直觉

## 典型应用

- 课程先修：先修课必须排在前面  
- 编译依赖 / 任务调度：A 依赖 B 则 B 在 A 前  
- 某些 DP on DAG 的计算顺序  

## Kahn 算法（入度法）

1. 计算每个点入度  
2. 入度为 0 的点入队  
3. 出队一个点并输出；删掉它的出边（邻居入度 -1）；若变为 0 则入队  
4. 若最终输出点数 $< n$，则存在环，无拓扑序  

```cpp showLineNumbers
#include <queue>
#include <vector>

std::vector<int> topo_kahn(int n, const std::vector<std::vector<int>> &g) {
    std::vector<int> indeg(n, 0);
    for (int u = 0; u < n; u++) {
        for (int v : g[u]) indeg[v]++;
    }

    std::queue<int> q;
    for (int i = 0; i < n; i++) {
        if (indeg[i] == 0) q.push(i);
    }

    std::vector<int> order;
    while (!q.empty()) {
        int u = q.front();
        q.pop();
        order.push_back(u);
        for (int v : g[u]) {
            if (--indeg[v] == 0) q.push(v);
        }
    }
    if ((int)order.size() != n) return {};  // 有环
    return order;
}
```

时间 $O(n + m)$。同一图可能有多种合法拓扑序（入队顺序不同即可导致不同结果）。

## DFS 法（了解）

对图做 DFS，在回溯时把顶点压入结果；最后反转结果，也可得到拓扑序。实现时需区分「访问中」与「已完成」，才能正确报环（回到「访问中」的点说明有环）。

## 常见错误

- 把无向图拿来做拓扑（概念不对）  
- 有环仍强行输出部分序列当成功  
- 建边方向反了（依赖方向画反）  

## 小结

拓扑排序 = DAG 上的合法线性序。Kahn 算法直观，并自然检测环。图章到此告一段落，下一章进入 [查找概述](/data-structures/searching-overview/)。
