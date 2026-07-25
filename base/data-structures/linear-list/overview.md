---
sidebar_position: 1
slug: /linear-list
sidebar_label: 线性表概述
---

# 线性表概述

**线性表（Linear List）**是 $n$ 个数据元素的有限序列。元素之间是一对一的次序关系：除第一个外每个元素有且仅有一个前驱，除最后一个外每个元素有且仅有一个后继。

当 $n = 0$ 时称为空表。

## 本文解决什么问题

- 线性表作为 ADT 提供哪些操作
- 顺序存储与链式存储如何选型
- 本章后续各篇分别学什么

## 抽象数据类型（ADT）视角

先关心「能做什么」，再关心「内存怎么放」：

| 操作 | 含义 |
| --- | --- |
| `InitList` | 构造空表 |
| `Length` / `Empty` | 求长度、判空 |
| `GetElem(i)` | 取第 $i$ 个元素（位序） |
| `LocateElem(e)` | 按值查找 |
| `Insert(i, e)` / `Delete(i)` | 插入、删除 |
| `Traverse` | 遍历 |

教材里位序常从 1 开始；C 数组下标从 0 开始——读代码时务必分清约定。

## 两种基本存储

| 方式 | 结构 | 特点 |
| --- | --- | --- |
| 顺序存储 | [顺序表](/data-structures/sequence-list/) | 连续内存，支持随机访问 |
| 链式存储 | [单向](/data-structures/singly-linked-list/) / [双向](/data-structures/doubly-linked-list/) / [循环](/data-structures/circular-linked-list/) 链表 | 结点用指针（或游标）相连，插入删除灵活 |
| 特殊形式 | [静态链表](/data-structures/static-linked-list/) | 用数组下标模拟指针 |

```text
顺序表:  [e1][e2][e3][e4]     ← 物理上也相邻

链表:    [e1|*] -> [e2|*] -> [e3|*] -> NULL
```

## 复杂度对比（务必记住）

| 操作 | 顺序表 | 单向链表 |
| --- | --- | --- |
| 随机访问第 $i$ 个 | $O(1)$ | $O(i)$ |
| 表头插入 / 删除 | $O(n)$（要搬移） / 尾部可 $O(1)$ | 头插 / 头删 $O(1)$ |
| 已知结点后插入 | 仍要搬移，$O(n)$ | $O(1)$ |
| 按值查找 | $O(n)$ | $O(n)$ |
| 额外空间 | 几乎只有元素本身 | 每个结点一个（或多个）指针 |

:::tip 开发者选型
- 读多、按下标访问多、缓存敏感 → 优先顺序表 / `std::vector`  
- 需要频繁在已知位置拼接、删除，且随机访问不重要 → 考虑链表  
- 现代机器上，小数据的 `vector` 常常比链表更快，**复杂度不是唯一标准**，但必须先会算复杂度  
:::

## 本章你将学到

1. [顺序表](/data-structures/sequence-list/)：数组实现的线性表，含扩容直觉  
2. [单向链表](/data-structures/singly-linked-list/)：最基础的链式结构  
3. [双向链表](/data-structures/doubly-linked-list/)：可向前，删除更方便  
4. [循环链表](/data-structures/circular-linked-list/)：首尾相接  
5. [静态链表](/data-structures/static-linked-list/)：数组游标模拟链接  

栈、队列可以看成操作受限的线性表，将在下一章展开。

## 小结

- 线性表 = 有穷序列 + 一组基本操作  
- 同一 ADT，顺序与链式两种落地，时空权衡不同  
- 先掌握抽象操作，再对比实现，选型会清晰很多  

下一篇：[顺序表](/data-structures/sequence-list/)。
