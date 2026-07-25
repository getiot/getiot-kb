---
sidebar_position: 2
slug: /queue
sidebar_label: 队列
---

# 队列

**队列（Queue）**是「先进先出」（FIFO，First In First Out）：从**队尾**入队，从**队头**出队，像排队买票。

## 本文解决什么问题

- 队列 ADT 与典型应用
- 链表实现如何写
- 为何数组队列通常要做成循环队列
- 和栈、双端队列的对比

## 基本操作

| 操作 | 含义 | 典型复杂度 |
| --- | --- | --- |
| `enqueue` / `push` | 入队（尾） | $O(1)$ |
| `dequeue` / `pop` | 出队（头） | $O(1)$ |
| `front` | 看队头 | $O(1)$ |
| `empty` | 是否为空 | $O(1)$ |

## 典型用途

- 广度优先遍历（BFS）  
- 任务缓冲、消息排队、打印队列  
- 生产者-消费者之间的有序缓冲  

## C：链表实现

用「头尾指针」可以让入队、出队都是 $O(1)$：

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct QNode {
    int data;
    struct QNode *next;
} QNode;

typedef struct {
    QNode *head;  /* 队头，出队端 */
    QNode *tail;  /* 队尾，入队端 */
} LinkQueue;

void init(LinkQueue *q) {
    q->head = q->tail = NULL;
}

bool enqueue(LinkQueue *q, int value) {
    QNode *node = (QNode *)malloc(sizeof(QNode));
    if (!node) return false;
    node->data = value;
    node->next = NULL;
    if (!q->tail) {
        q->head = q->tail = node;
    } else {
        q->tail->next = node;
        q->tail = node;
    }
    return true;
}

bool dequeue(LinkQueue *q, int *out) {
    if (!q->head) return false;
    QNode *node = q->head;
    *out = node->data;
    q->head = node->next;
    if (!q->head) q->tail = NULL;  /* 删空 */
    free(node);
    return true;
}
```

:::tip
出队后若表空，必须把 `tail` 一并置空，否则悬空指针会导致下次入队写坏内存。
:::

## 数组实现的问题 → 循环队列

若用数组且队头下标只增不减，前面空出来的槽会浪费，最终「逻辑上人不多，物理上却判满」。解决办法是 [循环队列](/data-structures/circular-queue/)：下标取模，把数组当成环。

本篇用链表把 FIFO 语义讲清；数组环的空满判定放到下一篇专讲。

## C++：`std::queue`

```cpp showLineNumbers
#include <iostream>
#include <queue>

int main() {
    std::queue<int> q;
    q.push(1);
    q.push(2);
    q.push(3);

    while (!q.empty()) {
        std::cout << q.front() << ' ';
        q.pop();
    }
    std::cout << '\n';
    return 0;
}
```

默认底层常是 `deque`。若两端都要进出，直接用 [双端队列](/data-structures/deque/) 或 `std::deque`。

## 栈 vs 队列

| | 栈 | 队列 |
| --- | --- | --- |
| 顺序 | 后进先出 | 先进先出 |
| 典型 | 回溯、递归展开 | 分层扩展、缓冲 |
| 接口端 | 同一端 | 两端各司其职 |

## 小结

队列维护「先来先服务」。链表实现语义直观；数组实现请用循环队列，并先固定空 / 满策略。

下一篇：[循环队列](/data-structures/circular-queue/)。
