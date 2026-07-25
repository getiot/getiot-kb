---
sidebar_position: 4
slug: /shortest-path
sidebar_label: 最短路径
---

# 最短路径

**最短路径**求两顶点间（或单源到全体）边权之和最小的路径。前提是边权含义明确，且算法假设与权值符号匹配。

## 本文解决什么问题

- 按场景如何选题（BFS / Dijkstra / Bellman-Ford / Floyd）
- Dijkstra 的核心直觉与注意点
- 负权与负环意味着什么

## 常见算法对照

| 算法 | 适用 | 思路一句话 | 常见复杂度 |
| --- | --- | --- | --- |
| BFS | 边权全为 1（或等权） | 层数即距离 | $O(n + m)$ |
| Dijkstra | **非负权** 单源 | 每次扩展当前最近未确定点 | $O((n+m)\log n)$（堆优） |
| Bellman-Ford | 可有负权（无负环）单源 | 松弛 $|V|-1$ 轮 | $O(nm)$ |
| Floyd-Warshall | 全源 | DP 枚举中间点 | $O(n^3)$ |

## 松弛（Relax）

几乎所有最短路都会用到：

```text
如果 dist[v] > dist[u] + w(u,v):
    dist[v] = dist[u] + w(u,v)
```

含义：经 `u` 走边到 `v` 更优，则更新。

## Dijkstra 直觉

1. `dist[s]=0`，其余为 $\infty$  
2. 重复：在未确定顶点中取 `dist` 最小者 `u`，标记确定  
3. 用 `u` 的出边松弛邻居  
4. 直到全部确定或堆空  

非负权保证：一旦取出 `u`，`dist[u]` 不会再变小。

```cpp showLineNumbers
#include <queue>
#include <vector>
#include <limits>

using P = std::pair<int, int>;  // {dist, vertex}

std::vector<int> dijkstra(int n, int s,
                          const std::vector<std::vector<P>> &g) {
    const int INF = std::numeric_limits<int>::max() / 4;
    std::vector<int> dist(n, INF);
    std::priority_queue<P, std::vector<P>, std::greater<P>> pq;
    dist[s] = 0;
    pq.push({0, s});

    while (!pq.empty()) {
        auto [d, u] = pq.top();
        pq.pop();
        if (d != dist[u]) continue;   // 过期堆项
        for (auto [v, w] : g[u]) {
            if (dist[v] > dist[u] + w) {
                dist[v] = dist[u] + w;
                pq.push({dist[v], v});
            }
        }
    }
    return dist;
}
```

:::warning
边权有负数时，不要直接套朴素 Dijkstra。存在**负环**（环上权值和为负）时，「最短」可能无下界。
:::

## 选题清单

1. 边权是否全相同？→ BFS  
2. 是否有负权？→ Bellman-Ford / SPFA（注意卡）/ Floyd  
3. 只要单源且非负？→ Dijkstra  
4. 全源且 $n$ 不大？→ Floyd  

## 小结

最短路是图算法核心应用之一。先分清单源/全源与权值约束，再选题；Dijkstra 是非负权单源的默认选择。

下一篇：[最小生成树](/data-structures/minimum-spanning-tree/)。
