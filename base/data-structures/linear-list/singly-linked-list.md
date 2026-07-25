---
sidebar_position: 3
slug: /singly-linked-list
sidebar_label: 单向链表
---

# 单向链表

**单向链表（Singly Linked List）**是最基础的链表形态：每个结点只有一个 `next` 指针，指向后继；最后一个结点的 `next` 为 `NULL`。

结点不必连续存放；在**已知位置**处插入、删除往往不必像数组那样搬移大量元素。

## 本文解决什么问题

- 结点结构与头指针的含义
- 头插、尾插、按位插入 / 删除怎么写
- 常见指针错误如何避免
- 和顺序表、C++ 标准库如何对照

## 结点长什么样

```text
[ data | next ] -> [ data | next ] -> [ data | next ] -> NULL
```

```c showLineNumbers
typedef struct Node {
    int data;
    struct Node *next;
} Node;
```

通常用 `Node *head` 指向第一个结点；空表时 `head == NULL`。有的实现会加**头结点**（哨兵），让空表与非空表的插入删除更统一——本篇先用「无头结点」写法，更直观。

## 特点

| 操作 | 平均时间 | 说明 |
| --- | --- | --- |
| 头插 / 头删 | $O(1)$ | 改几个指针 |
| 访问第 $k$ 个 | $O(k)$ | 不能随机访问 |
| 按值查找 | $O(n)$ | 需要遍历 |
| 在已知结点**后**插入 | $O(1)$ | 关键是先找到位置 |
| 删除已知结点 | $O(n)$ 找前驱，或 $O(1)$ 若已有前驱 | 单向链表删当前结点通常要前驱 |

优点：指针到手时插入删除灵活。  
缺点：不能 $O(1)$ 按下标跳转；额外指针占空间；缓存不友好。

## C：头插、遍历与释放

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int data;
    struct Node *next;
} Node;

Node *push_front(Node *head, int value) {
    Node *node = (Node *)malloc(sizeof(Node));
    if (!node) {
        return head;
    }
    node->data = value;
    node->next = head;
    return node;
}

void print_list(const Node *head) {
    for (const Node *p = head; p != NULL; p = p->next) {
        printf("%d ", p->data);
    }
    printf("\n");
}

void free_list(Node *head) {
    while (head) {
        Node *tmp = head->next;
        free(head);
        head = tmp;
    }
}

int main(void) {
    Node *head = NULL;
    head = push_front(head, 30);
    head = push_front(head, 20);
    head = push_front(head, 10);  /* 10 -> 20 -> 30 */

    print_list(head);
    free_list(head);
    return 0;
}
```

:::warning
`malloc` 的结点必须 `free`。链表里最常见的 bug：丢指针、断链、对 `NULL` 解引用、重复释放、释放后仍使用。
:::

## 在第 i 个结点后插入（位序从 1 起看「第 i 个已有结点」）

更常见的教材接口是「在位序 $i$ 处插入」，需要先找到第 $i-1$ 个结点：

```c showLineNumbers
/* 在位序 i（1..length+1）插入 e；成功返回新 head */
Node *insert_at(Node *head, int i, int e) {
    if (i < 1) return head;

    Node *node = (Node *)malloc(sizeof(Node));
    if (!node) return head;
    node->data = e;

    if (i == 1) {
        node->next = head;
        return node;
    }

    Node *prev = head;
    for (int k = 1; k < i - 1 && prev; k++) {
        prev = prev->next;
    }
    if (!prev) {           /* i 过大 */
        free(node);
        return head;
    }
    node->next = prev->next;
    prev->next = node;
    return head;
}
```

插入时指针赋值顺序很重要：先让 `node->next` 接上后继，再让前驱指向 `node`，否则容易丢链。

## 删除位序 i

```c showLineNumbers
Node *erase_at(Node *head, int i) {
    if (!head || i < 1) return head;

    if (i == 1) {
        Node *tmp = head->next;
        free(head);
        return tmp;
    }

    Node *prev = head;
    for (int k = 1; k < i - 1 && prev; k++) {
        prev = prev->next;
    }
    if (!prev || !prev->next) return head;

    Node *victim = prev->next;
    prev->next = victim->next;
    free(victim);
    return head;
}
```

## C++：简单封装

```cpp showLineNumbers
#include <iostream>

struct Node {
    int data;
    Node *next;
    explicit Node(int v) : data(v), next(nullptr) {}
};

class SinglyList {
public:
    ~SinglyList() {
        while (head_) {
            Node *tmp = head_->next;
            delete head_;
            head_ = tmp;
        }
    }

    void push_front(int value) {
        Node *node = new Node(value);
        node->next = head_;
        head_ = node;
    }

    void print() const {
        for (Node *p = head_; p; p = p->next) {
            std::cout << p->data << ' ';
        }
        std::cout << '\n';
    }

private:
    Node *head_ = nullptr;
};
```

工程里更常用 `std::forward_list`（单向）或 `std::list`（双向）。手写一遍是为了真正理解指针。

## 数组 vs 链表（怎么选）

| 需求 | 更倾向 |
| --- | --- |
| 频繁按下标访问 | 数组 / 顺序表 |
| 频繁在头部插入删除 | 链表（或 deque） |
| 遍历为主、局部性重要 | 数组 |
| 元素位置分散、需 O(1) 拼接 | 链表 |

很多现代场景里，`vector` 因缓存优势反而更快。选型要结合实测，但先把复杂度差异记牢。

## 常见错误清单

1. `p->next` 前未判断 `p == NULL`  
2. 释放结点前没有保存 `next`  
3. 头插后忘记更新 `head`  
4. 循环条件写成 `p->next` 导致漏最后一个结点（视需求而定）  

## 小结

单向链表用单个 `next` 表达「下一个是谁」，换来插入删除的灵活性，牺牲了随机访问。掌握头插、按位插入删除、遍历和释放后，再学双向链表会轻松很多。

下一篇：[双向链表](/data-structures/doubly-linked-list/)。
