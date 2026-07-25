---
sidebar_position: 7
slug: /heap
sidebar_label: 堆
---

# 堆

**堆（Heap）**这里特指用于优先队列的**二叉堆**，常用数组实现，逻辑上是一棵近似完全二叉树。

- **最大堆**：父结点 ≥ 孩子  
- **最小堆**：父结点 ≤ 孩子  

本篇以**最小堆**为例：堆顶永远是当前最小元素。

## 数组下标关系

下标从 0 开始时，对结点 `i`：

- 父结点：`(i - 1) / 2`
- 左孩子：`2 * i + 1`
- 右孩子：`2 * i + 2`

## 基本操作

| 操作 | 含义 | 复杂度 |
| --- | --- | --- |
| `push` | 插入元素并上浮 | $O(\log n)$ |
| `pop` | 删除堆顶并下沉 | $O(\log n)$ |
| `top` | 查看堆顶 | $O(1)$ |

适合：随时取「当前最大/最小」、Top-K、某些调度与最短路径算法中的优先队列。

## C：最小堆（简化版）

```c showLineNumbers
#include <stdio.h>
#include <stdbool.h>

#define MAXN 100

typedef struct {
    int data[MAXN];
    int size;
} MinHeap;

void swap(int *a, int *b) {
    int t = *a;
    *a = *b;
    *b = t;
}

void sift_up(MinHeap *h, int i) {
    while (i > 0) {
        int p = (i - 1) / 2;
        if (h->data[p] <= h->data[i]) break;
        swap(&h->data[p], &h->data[i]);
        i = p;
    }
}

void sift_down(MinHeap *h, int i) {
    while (1) {
        int l = 2 * i + 1;
        int r = 2 * i + 2;
        int smallest = i;
        if (l < h->size && h->data[l] < h->data[smallest]) smallest = l;
        if (r < h->size && h->data[r] < h->data[smallest]) smallest = r;
        if (smallest == i) break;
        swap(&h->data[i], &h->data[smallest]);
        i = smallest;
    }
}

bool push(MinHeap *h, int value) {
    if (h->size >= MAXN) return false;
    h->data[h->size] = value;
    sift_up(h, h->size);
    h->size++;
    return true;
}

bool pop(MinHeap *h, int *out) {
    if (h->size == 0) return false;
    *out = h->data[0];
    h->data[0] = h->data[--h->size];
    sift_down(h, 0);
    return true;
}

int main(void) {
    MinHeap h = {.size = 0};
    int x;
    push(&h, 5);
    push(&h, 1);
    push(&h, 3);

    while (pop(&h, &x)) {
        printf("%d ", x);  /* 1 3 5 */
    }
    printf("\n");
    return 0;
}
```

## C++：`std::priority_queue`

```cpp showLineNumbers
#include <iostream>
#include <queue>
#include <vector>

int main() {
    /* 默认是最大堆 */
    std::priority_queue<int> max_heap;
    max_heap.push(5);
    max_heap.push(1);
    max_heap.push(3);
    std::cout << max_heap.top() << '\n';  // 5

    /* 最小堆：比较器用 greater */
    std::priority_queue<int, std::vector<int>, std::greater<int>> min_heap;
    min_heap.push(5);
    min_heap.push(1);
    min_heap.push(3);
    std::cout << min_heap.top() << '\n';  // 1
    return 0;
}
```

## 堆 vs BST

| | 堆 | BST |
| --- | --- | --- |
| 主要目标 | 快速取最值 | 有序查找、范围查询 |
| 中序有序？ | 否 | 是 |
| 典型接口 | 优先队列 | 有序集合 / 映射 |

## 小结

堆用完全二叉树的数组布局，保证取最值很快。先掌握 `push`/`pop` 时的上浮下沉，再使用 `priority_queue` 会更踏实。

下一篇：[哈夫曼树](/data-structures/huffman-tree/)（构造时会反复取最小权值）。
