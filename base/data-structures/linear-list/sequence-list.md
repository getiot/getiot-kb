---
sidebar_position: 2
slug: /sequence-list
sidebar_label: 顺序表
---

# 顺序表

**顺序表**用一段连续内存存放线性表元素，逻辑上相邻的元素在物理上也相邻。C 语言里最常见的实现是数组（定长，或配合 `malloc`/`realloc` 做成可扩容表）；C++ 工程中对应 `std::vector`。

## 本文解决什么问题

- 顺序表的插入、删除为什么是 $O(n)$
- 定长与动态扩容怎么写
- 和 `std::vector` 如何对照

## 特点一览

| 操作 | 典型复杂度 | 说明 |
| --- | --- | --- |
| 按下标访问 | $O(1)$ | 随机访问，地址可算 |
| 尾部插入（容量足够） | $O(1)$ | 扩容时单次变贵，均摊常仍 $O(1)$ |
| 中间 / 头部插入删除 | $O(n)$ | 需要搬移元素 |
| 按值查找（无序） | $O(n)$ | 需扫描 |

优点：随机访问快、缓存友好、实现简单。  
缺点：插入删除可能大量搬移；定长版容量固定，动态版有扩容开销。

## C：定长顺序表

约定位序从 1 开始（教材常见）；数组下标仍是 0 起。

```c showLineNumbers
#include <stdio.h>

#define MAXN 100

typedef struct {
    int data[MAXN];
    int length;
} SqList;

void init(SqList *L) {
    L->length = 0;
}

/* 在位序 i 插入 e，成功返回 1 */
int insert(SqList *L, int i, int e) {
    if (i < 1 || i > L->length + 1 || L->length >= MAXN) {
        return 0;
    }
    for (int j = L->length; j >= i; j--) {
        L->data[j] = L->data[j - 1];   /* 从后往前挪，避免覆盖 */
    }
    L->data[i - 1] = e;
    L->length++;
    return 1;
}

/* 删除位序 i，元素带回 *e */
int erase(SqList *L, int i, int *e) {
    if (i < 1 || i > L->length) {
        return 0;
    }
    *e = L->data[i - 1];
    for (int j = i; j < L->length; j++) {
        L->data[j - 1] = L->data[j];
    }
    L->length--;
    return 1;
}

int main(void) {
    SqList L;
    init(&L);
    insert(&L, 1, 10);
    insert(&L, 2, 20);
    insert(&L, 2, 15);   /* 10, 15, 20 */
    for (int i = 0; i < L.length; i++) {
        printf("%d ", L.data[i]);
    }
    printf("\n");
    return 0;
}
```

### 插入时为什么从后往前搬？

若从前往后赋值，尚未挪走的元素会被覆盖。从尾部开始挪，才能安全腾出插入空位。

## C：动态扩容直觉

```c showLineNumbers
#include <stdlib.h>

typedef struct {
    int *data;
    int length;
    int capacity;
} DynList;

int ensure(DynList *L) {
    if (L->length < L->capacity) return 1;
    int new_cap = L->capacity ? L->capacity * 2 : 4;
    int *p = (int *)realloc(L->data, sizeof(int) * new_cap);
    if (!p) return 0;
    L->data = p;
    L->capacity = new_cap;
    return 1;
}

int push_back(DynList *L, int e) {
    if (!ensure(L)) return 0;
    L->data[L->length++] = e;
    return 1;
}
```

容量按 2 倍扩张时，单次 `push_back` 最坏 $O(n)$，但**摊还**到每次插入仍是 $O(1)$。这与 [复杂度分析](/data-structures/complexity/) 中的摊还直觉一致。

## C++：`std::vector`

```cpp showLineNumbers
#include <iostream>
#include <vector>

int main() {
    std::vector<int> a = {10, 20};
    a.insert(a.begin() + 1, 15);   // 10, 15, 20
    a.push_back(30);
    for (int x : a) {
        std::cout << x << ' ';
    }
    std::cout << '\n';
    return 0;
}
```

`vector` 保证连续存储与随机访问；中间 `insert`/`erase` 仍是线性复杂度。

## 常见错误

| 错误 | 说明 |
| --- | --- |
| 位序与下标混用 | `i` 从 1 起时，访问应用 `data[i-1]` |
| 插入时从前往后搬 | 会覆盖数据 |
| 满表仍插入 | 定长版要检查 `length >= MAXN` |
| `realloc` 失败未处理 | 可能丢掉原指针前应先用临时变量接住 |

## 和链表怎么选

见 [线性表概述](/data-structures/linear-list/) 中的对比表。经验法则：默认从 `vector` / 顺序表想起，只有明确需要链式操作时再换链表。

## 小结

顺序表擅长随机访问，不擅长频繁的中间插入删除。把「搬移代价」和「扩容摊还」想清楚，后面学栈、队列的数组实现会非常顺。

下一篇：[单向链表](/data-structures/singly-linked-list/)。
