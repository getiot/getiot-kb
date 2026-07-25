---
sidebar_position: 4
slug: /doubly-linked-list
sidebar_label: 双向链表
---

# 双向链表

**双向链表（Doubly Linked List）**每个结点除了 `next`，还有 `prev` 指向前驱，因此可以双向遍历；在**已知结点指针**时删除，通常不必再从头找前驱。

```text
NULL <- [prev|data|next] <-> [prev|data|next] <-> ... -> NULL
```

## 本文解决什么问题

- 双向链表相对单向多了什么能力
- 插入、删除时如何同时维护 `prev` / `next`
- 和 `std::list` 的对应关系

## 相对单向链表

| | 单向 | 双向 |
| --- | --- | --- |
| 指针域 | 仅 `next` | `prev` + `next` |
| 向前遍历 | 不方便 | 方便 |
| 删除已知结点 | 常需前驱 | 改指针即可，$O(1)$ |
| 空间 | 更省 | 每结点多一个指针 |

## C：结点与删除

```c showLineNumbers
#include <stdlib.h>

typedef struct DNode {
    int data;
    struct DNode *prev;
    struct DNode *next;
} DNode;

/* 删除已知结点 p（非空）。调用方负责维护 head/tail。 */
void unlink_node(DNode *p) {
    if (!p) return;
    if (p->prev) {
        p->prev->next = p->next;
    }
    if (p->next) {
        p->next->prev = p->prev;
    }
    free(p);
}
```

若还有独立的 `head` / `tail` 指针，删除头或尾时必须同步更新它们：

```c showLineNumbers
DNode *delete_node(DNode *head, DNode *p) {
    if (!head || !p) return head;
    if (p->prev) p->prev->next = p->next;
    else head = p->next;           /* 删的是头 */
    if (p->next) p->next->prev = p->prev;
    free(p);
    return head;
}
```

## C：在已知结点后插入

```c showLineNumbers
/* 在 p 之后插入值为 e 的结点；p 非空 */
DNode *insert_after(DNode *p, int e) {
    DNode *node = (DNode *)malloc(sizeof(DNode));
    if (!node) return NULL;
    node->data = e;
    node->prev = p;
    node->next = p->next;
    if (p->next) {
        p->next->prev = node;
    }
    p->next = node;
    return node;
}
```

建议固定一种指针更新顺序并画图验证，避免漏改 `prev` 造成「半截双向」。

## C++

标准库 `std::list` 是双向链表；只要单向可用 `std::forward_list`。

```cpp showLineNumbers
#include <iostream>
#include <list>

int main() {
    std::list<int> lst = {1, 3};
    auto it = lst.begin();
    ++it;
    lst.insert(it, 2);   // 1, 2, 3
    for (int x : lst) std::cout << x << ' ';
    std::cout << '\n';
    return 0;
}
```

`std::list` 的迭代器在插入删除（指向被删元素以外）时更稳定，这是相对 `vector` 的一个工程差异。

## 何时用双向

- 需要从当前位置向前走  
- 频繁删除「已经拿到的结点指针」  
- LRU 缓存等结构里，常用双向链表 + 哈希表  

代价是每个结点多占一个指针，以及插入删除时代码更易写错——用画图或断言检查 `p->next->prev == p` 这类不变量很有帮助。

## 小结

需要频繁前向移动或 $O(1)$ 删除已知结点时，双向链表更合适。写代码时把 `prev`/`next` 当成一对不变量一起维护。

下一篇：[循环链表](/data-structures/circular-linked-list/)。
