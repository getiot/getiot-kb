---
sidebar_position: 5
slug: /minimum-spanning-tree
sidebar_label: 最小生成树
---

# 最小生成树

连通无向带权图中，**最小生成树（MST）**是一棵包含全部顶点、边权之和最小的生成树（$n$ 个顶点、$n-1$ 条边、无环）。

典型应用：铺设代价最小的管网 / 线路，使所有站点连通。

## 本文解决什么问题

- Prim 与 Kruskal 各自怎么做
- 为何是贪心且正确（直觉）
- 和并查集的关系

## 两种经典算法

### Prim（加点法）

从某点生长：每次加入连接「树内—树外」的最小权边，把新顶点并入树，直到包含全部顶点。

- 实现可用优先队列，类似 Dijkstra 的生长方式  
- 适合边较稠密或从邻接表扩展  

### Kruskal（加边法）

1. 所有边按权**升序**排序  
2. 从小到大尝试加入；若两端尚不连通则加入（不会成环）  
3. 已选满 $n-1$ 条边结束  

判断连通用 [并查集](/data-structures/union-find/)：

```cpp showLineNumbers
#include <algorithm>
#include <vector>

struct Edge {
    int u, v, w;
};

int find_root(std::vector<int> &p, int x) {
    return p[x] == x ? x : (p[x] = find_root(p, p[x]));
}

int kruskal(int n, std::vector<Edge> edges) {
    std::sort(edges.begin(), edges.end(),
              [](const Edge &a, const Edge &b) { return a.w < b.w; });
    std::vector<int> p(n);
    for (int i = 0; i < n; i++) p[i] = i;

    int taken = 0, total = 0;
    for (const auto &e : edges) {
        int a = find_root(p, e.u);
        int b = find_root(p, e.v);
        if (a == b) continue;          // 成环，跳过
        p[b] = a;
        total += e.w;
        if (++taken == n - 1) break;
    }
    return taken == n - 1 ? total : -1;  // -1 表示原图不连通
}
```

## 贪心本质

两者都是 [贪心法](/data-structures/greedy/)：局部选当前「安全」的最小边，最终得到全局最优 MST（在连通无向带权图的经典条件下可证明）。

直觉：成环的边一定不是某棵 MST 的必需边；不连通的两端之间最小边可以被扩展进某棵 MST（割性质）。

## Prim vs Kruskal

| | Prim | Kruskal |
| --- | --- | --- |
| 过程 | 从点生长 | 按边排序加边 |
| 数据结构 | 堆 + 邻接表 | 排序 + 并查集 |
| 常见擅长 | 稠密图 | 稀疏图 |

## 小结

Prim 偏「加点」，Kruskal 偏「加边 + 并查集」。会手算小图并说明为何跳过成环边，即达到入门目标。

下一篇：[拓扑排序](/data-structures/topological-sort/)。
