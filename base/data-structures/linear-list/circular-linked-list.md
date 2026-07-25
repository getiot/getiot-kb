---
sidebar_position: 5
slug: /circular-linked-list
sidebar_label: 循环链表
---

# 循环链表

**循环链表（Circular Linked List）**让表尾结点的 `next` 指向头结点（或某个固定入口），形成一个环。可以是单向循环，也可以是双向循环。

```text
头 → A → B → C ─┐
↑               │
└───────────────┘
```

## 本文解决什么问题

- 循环链表和普通链表的终止条件有何不同
- 空表、单结点环如何处理
- 常见应用直觉（轮转、约瑟夫环）

## 有什么用

- 从任意结点出发都能遍历整表（注意终止条件）  
- 「轮转调度」、约瑟夫环类问题更自然  
- 某些缓冲区、操作系统结构里能看到环形思想  

双向循环链表则让尾结点的 `next` 指头、头结点的 `prev` 指尾，头尾操作都可以 $O(1)$（再配头尾指针或只保留尾指针等技巧）。

## 遍历：不要找 NULL

终止条件不是 `p == NULL`，而是「再次回到起点」：

```c showLineNumbers
#include <stdio.h>

typedef struct Node {
    int data;
    struct Node *next;
} Node;

void print_circular(Node *head) {
    if (!head) return;
    Node *p = head;
    do {
        printf("%d ", p->data);
        p = p->next;
    } while (p != head);
    printf("\n");
}
```

用 `do-while` 可以自然覆盖「至少有一个结点」的情况。空表必须先特判。

## 单结点环

只有一个结点时：`p->next == p`。插入第二个结点、删除到只剩一个结点时，都要单独想清楚，否则容易变成「假装循环、其实断了」或死循环。

## 约瑟夫环（示意）

$n$ 个人围成圈，数到 $m$ 出局，问最后剩下谁。循环链表能直接模拟：

```c showLineNumbers
/* 假设已构造含 n 个结点的循环表，head 指向编号 1 的结点。
 * 每次数 m 个，删除该结点，直到剩 1 个。返回幸存者编号。
 * 此处仅示意逻辑，完整造表/释放略。 */
int josephus(Node *head, int m) {
    Node *p = head;
    while (p->next != p) {
        for (int i = 1; i < m - 1; i++) {
            p = p->next;
        }
        /* p->next 出局 */
        Node *victim = p->next;
        p->next = victim->next;
        /* free(victim); 视实现而定 */
        p = p->next;
    }
    return p->data;
}
```

:::note
约瑟夫问题也有 $O(n)$ 递推公式解法；链表模拟更利于理解「环上删除」。
:::

## 常见错误

| 错误 | 后果 |
| --- | --- |
| 仍用 `p != NULL` 遍历 | 死循环 |
| 空表未判 | 解引用崩溃 |
| 造环时尾 `next` 忘改 | 变成普通链表 |
| 释放时无终止条件 | 死循环或漏释 |

## 小结

循环链表是「首尾相接」的链表。实现时把终止条件从 `NULL` 改成「回到起点」，并单独验证空表与单结点环。

下一篇：[静态链表](/data-structures/static-linked-list/)。
