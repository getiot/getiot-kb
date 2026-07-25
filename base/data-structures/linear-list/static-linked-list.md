---
sidebar_position: 6
slug: /static-linked-list
sidebar_label: 静态链表
---

# 静态链表

**静态链表**用**数组**模拟链表：每个数组元素保存数据和「下一个元素的下标」，用下标代替指针。在没有指针、或不便动态分配的环境（早期语言、部分嵌入式、教学演示）中很有用。

## 本文解决什么问题

- 「游标」如何代替指针
- 备用链表如何模拟分配与回收
- 现代 C/C++ 中它处于什么位置

## 示意

```text
下标:  0      1      2      3
数据:  -      a      c      b
游标:  1      3      -1     2
```

若头游标为 `1`，则访问顺序：`1 → 3 → 2`，得到序列 `a, b, c`。`-1` 表示空（类似 `NULL`）。

## 结构体示例

```c showLineNumbers
#define MAXN 100
#define EMPTY -1

typedef struct {
    int data;
    int next;  /* 下一个结点下标，EMPTY 表示空 */
} SNode;

SNode space[MAXN];
```

## 备用链表：在数组上模拟 malloc / free

常见做法是把空闲槽也串成一条链，称为**备用链表**：

1. 初始化：把所有下标串起来，`space[i].next = i + 1`，最后一个为 `EMPTY`  
2. 分配：从备用链表头取一个下标  
3. 释放：把头插回备用链表  

```c showLineNumbers
int avail;  /* 备用链表头下标 */

void init_space(void) {
    for (int i = 0; i < MAXN - 1; i++) {
        space[i].next = i + 1;
    }
    space[MAXN - 1].next = EMPTY;
    avail = 0;
}

int malloc_node(void) {
    if (avail == EMPTY) return EMPTY;
    int i = avail;
    avail = space[i].next;
    return i;
}

void free_node(int i) {
    space[i].next = avail;
    avail = i;
}
```

业务链表则另用一个 `head` 下标，在 `space[]` 上穿线。插入删除改的是 `next` 游标，不必像顺序表那样搬移大量数据。

## 优缺点

| | 说明 |
| --- | --- |
| 优点 | 内存连续、无真正指针；插入删除改游标即可 |
| 缺点 | 实现绕；容量受数组限制；调试不如指针直观 |
| 现状 | 现代 C/C++ 更常用动态链表或 `vector`；静态链表偏教学与特殊环境 |

## 和顺序表、动态链表的关系

- 相对顺序表：逻辑上是「链接」，中间插入不必搬整段元素  
- 相对动态链表：没有 `malloc` 碎片问题（数组一次备好），但失去灵活扩容（除非再设计扩容）  

理解静态链表，有助于明白：**链接的本质是「指向下一个位置的引用」**，引用可以是指针，也可以是下标。

## 小结

静态链表帮助理解「链接 = 下一个位置的引用」。概念弄清即可；工程上优先用动态链表或顺序表，除非环境限制迫使你用游标。

下一章进入操作受限的线性表：[栈](/data-structures/stack/)。
