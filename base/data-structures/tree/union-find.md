---
sidebar_position: 9
slug: /union-find
sidebar_label: 并查集
---

# 并查集

**并查集（Disjoint Set Union / Union-Find）**维护若干不相交集合，支持：

- **Find**：查询元素属于哪个集合（通常返回代表元 / 根）  
- **Union**：合并两个元素所在的集合  

适合动态维护「连通 / 等价」关系。

## 本文解决什么问题

- 用树（森林）如何表示集合
- 路径压缩与按秩合并是什么
- 完整可运行示例与应用场景

## 朴素想法

每个集合用一棵树表示，`parent[x]` 指向双亲；根满足 `parent[root] == root`，作为代表元。

- Find：沿 `parent` 走到根  
- Union：把一棵树的根挂到另一棵树的根下  

若树退化成链，Find 会变成 $O(n)$。优化：

1. **路径压缩**：Find 时把路径上结点直接挂到根下  
2. **按秩 / 按大小合并**：总是把矮树（或小树）挂到高树下，避免树过高  

二者结合后，均摊复杂度极接近常数（Ackermann 反函数量级，实践中可当 $O(1)$ 用）。

## C 实现（路径压缩 + 按秩）

```c showLineNumbers
#include <stdio.h>

#define N 100

int parent[N];
int rankk[N];   /* 树的上界秩，不是精确高度 */

void init_uf(int n) {
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rankk[i] = 0;
    }
}

int find_root(int x) {
    if (parent[x] != x) {
        parent[x] = find_root(parent[x]);  /* 路径压缩 */
    }
    return parent[x];
}

void unite(int a, int b) {
    a = find_root(a);
    b = find_root(b);
    if (a == b) return;
    if (rankk[a] < rankk[b]) {
        parent[a] = b;
    } else if (rankk[a] > rankk[b]) {
        parent[b] = a;
    } else {
        parent[b] = a;
        rankk[a]++;
    }
}

int connected(int a, int b) {
    return find_root(a) == find_root(b);
}

int main(void) {
    init_uf(5);
    unite(0, 1);
    unite(1, 2);
    unite(3, 4);
    printf("%d\n", connected(0, 2));  /* 1 */
    printf("%d\n", connected(0, 3));  /* 0 */
    return 0;
}
```

## 应用

| 场景 | 用法 |
| --- | --- |
| 连通分量 | 每条边 Union 两端；Find 判是否同分量 |
| Kruskal MST | 按边权排序，不形成环才 Union，见 [最小生成树](/data-structures/minimum-spanning-tree/) |
| 等价类 / 朋友圈 | 关系传递闭包的增量维护 |
| 网格连通 | 二维坐标映射到一维下标再并查 |

## 常见错误

- Union 前忘记先 Find 到根，只改了中间结点  
- 路径压缩写成迭代时漏了第二遍挂根  
- 下标越界（元素编号与数组大小不一致）  

## 小结

并查集是「动态维护连通性」的利器。先写对 `find` / `unite`，再理解路径压缩与按秩合并为何让它几乎 $O(1)$。

下一章进入 [图的基本概念](/data-structures/graph/)。
