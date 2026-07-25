---
sidebar_position: 2
slug: /graph-storage
sidebar_label: 图的存储结构
---

# 图的存储结构

图常用两种存储：**邻接矩阵**与**邻接表**。选择取决于边密度与要支持的操作。

## 本文解决什么问题

- 两种存储的时空权衡
- C / C++ 如何落地邻接表
- 带权边怎么存

## 邻接矩阵

$n$ 个顶点用 $n \times n$ 矩阵；`A[i][j] = 1`（或权值）表示边，无边常记 `0` 或 `INF`。

| | 说明 |
| --- | --- |
| 查边 | $O(1)$ |
| 枚举邻居 | 扫一整行，$O(n)$ |
| 空间 | $O(n^2)$，稠密图合适 |

```c showLineNumbers
#define N 4
int A[N][N] = {
    {0, 1, 1, 0},
    {1, 0, 0, 1},
    {1, 0, 0, 1},
    {0, 1, 1, 0}
};
```

无向图矩阵对称；有向图不一定。

## 邻接表

每个顶点挂一条边表，存相邻顶点（及权值）。

| | 说明 |
| --- | --- |
| 空间 | 约 $O(n + m)$ |
| 枚举邻居 | 与度数成正比，稀疏图高效 |
| 查「是否有边」 | 可能要扫链表，$O(\mathrm{deg})$ |

### C：链式前向星 / 邻接表头插

```c showLineNumbers
#include <stdio.h>

#define N 5
#define MAXE 32

typedef struct {
    int to;
    int next;
} Edge;

Edge edges[MAXE];
int head[N];
int ecnt;

void init_graph(void) {
    for (int i = 0; i < N; i++) head[i] = -1;
    ecnt = 0;
}

void add_edge(int u, int v) {
    edges[ecnt].to = v;
    edges[ecnt].next = head[u];
    head[u] = ecnt++;
}

/* 无向边加两次 */
void add_undirected(int u, int v) {
    add_edge(u, v);
    add_edge(v, u);
}
```

带权时在 `Edge` 中增加 `int w` 字段即可。

### C++：`vector` 邻接表

```cpp showLineNumbers
#include <vector>

int n = 5;
std::vector<std::vector<int>> g(n);

void add_undirected(int u, int v) {
    g[u].push_back(v);
    g[v].push_back(u);
}

/* 带权 */
struct E { int to, w; };
std::vector<std::vector<E>> gw(n);
```

工程与竞赛里，`vector` 邻接表最常用。

## 如何选型

| 场景 | 更合适 |
| --- | --- |
| $m \approx n^2$，常查边 | 邻接矩阵 |
| $m = O(n)$ 稀疏 | 邻接表 |
| 要跑 DFS/BFS/多数图算法 | 邻接表 |

## 其他形式（了解）

十字链表、邻接多重表等，面向有向图或无向图的特殊操作；入门可先跳过。

## 小结

先掌握矩阵与邻接表的时空权衡，再学 [图的遍历](/data-structures/graph-traversal/)。稀疏图默认邻接表即可。
