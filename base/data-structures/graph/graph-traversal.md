---
sidebar_position: 3
slug: /graph-traversal
sidebar_label: 图的遍历
---

# 图的遍历

图的遍历从某顶点出发，访问所有**可达**顶点。两大基础是 **DFS** 与 **BFS**。

存储见 [图的存储结构](/data-structures/graph-storage/)；队列见 [队列](/data-structures/queue/)。

## 本文解决什么问题

- DFS / BFS 怎么写、差在哪里
- 为何必须标记 `visited`
- 不连通图如何遍历全图
- 与树遍历、最短路的关系

## 深度优先（DFS）

沿一条路走到底，再回溯。可用递归或显式栈。

```cpp showLineNumbers
#include <iostream>
#include <vector>

void dfs(int u, const std::vector<std::vector<int>> &g, std::vector<bool> &vis) {
    vis[u] = true;
    std::cout << u << ' ';
    for (int v : g[u]) {
        if (!vis[v]) {
            dfs(v, g, vis);
        }
    }
}
```

- 时间：$O(n + m)$（邻接表，每个点/边处理常数次）  
- 空间：递归栈最坏 $O(n)$  

## 广度优先（BFS）

用队列一层层扩展，类似树的层序。

```c showLineNumbers
#include <stdio.h>
#include <stdbool.h>

#define N 5
#define MAXE 32

typedef struct { int to, next; } Edge;
Edge edges[MAXE];
int head[N], ecnt;

void add_edge(int u, int v) {
    edges[ecnt] = (Edge){v, head[u]};
    head[u] = ecnt++;
}

void bfs(int start) {
    int q[N];
    int front = 0, back = 0;
    bool visited[N] = {false};

    visited[start] = true;
    q[back++] = start;

    while (front < back) {
        int u = q[front++];
        printf("%d ", u);
        for (int e = head[u]; e != -1; e = edges[e].next) {
            int v = edges[e].to;
            if (!visited[v]) {
                visited[v] = true;
                q[back++] = v;
            }
        }
    }
    printf("\n");
}

int main(void) {
    for (int i = 0; i < N; i++) head[i] = -1;
    ecnt = 0;
    add_edge(0, 1); add_edge(1, 0);
    add_edge(0, 2); add_edge(2, 0);
    add_edge(1, 3); add_edge(3, 1);
    add_edge(2, 4); add_edge(4, 2);
    bfs(0);
    return 0;
}
```

- **无权图**中，BFS 得到的层数就是最短边数距离  
- 必须先标记再入队，避免同一顶点多次入队  

## DFS vs BFS

| | DFS | BFS |
| --- | --- | --- |
| 结构 | 栈 / 递归 | 队列 |
| 直觉 | 钻深 | 铺开 |
| 无权最短路 | 不直接给 | 可以 |
| 拓扑 / 连通分量等 | 常用 | 也可用 |

## 不连通图

一次遍历只能覆盖一个连通分量。要访问全部顶点：

```text
for u in 0..n-1:
    if not visited[u]:
        DFS(u) 或 BFS(u)
```

有向图则按可达性谈「从谁出发能走到谁」。

## 常见错误

| 错误 | 后果 |
| --- | --- |
| 不标记 visited | 有环时死循环 |
| 出队后再标记 | BFS 可能重复入队，队列爆炸 |
| 无向边只加一次 | 图不完整 |
| 递归过深 | 栈溢出，改显式栈 |

## 小结

DFS 像「钻深」，BFS 像「铺开」。二者是最短路、连通分量、拓扑排序等算法的底座。

下一篇：[最短路径](/data-structures/shortest-path/)。
