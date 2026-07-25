---
sidebar_position: 3
slug: /circular-queue
sidebar_label: 循环队列
---

# 循环队列

用数组实现队列时，若队头只进不退，前面空间会浪费。**循环队列**把数组首尾相接，用取模更新下标，让空出来的槽可以再次使用。

## 本文解决什么问题

- `head` / `tail` 的常见约定
- 如何区分空与满（`size` 法 vs 牺牲槽位法）
- 一份可运行的完整实现

## 关键下标（本教程约定）

- `head`：队头元素所在下标（出队端）  
- `tail`：下一个可写位置（入队端）  
- 入队：`data[tail]=x; tail=(tail+1)%MAXN`  
- 出队：`x=data[head]; head=(head+1)%MAXN`

```text
下标:  0  1  2  3  4  5  6  7
       .  a  b  c  .  .  .  .
          ^head    ^tail
```

当 `tail` 增到末尾后再入队，会绕回 `0`。

## 如何区分空与满

仅比较 `head == tail` **不够**：空和满都可能出现该等式（取决于约定）。常见两种策略：

### 方法一：另存 `size`（推荐入门）

- 空：`size == 0`  
- 满：`size == MAXN`  

### 方法二：牺牲一个槽位

不用 `size`，约定：

- 空：`head == tail`  
- 满：`(tail + 1) % MAXN == head`  

最大有效元素个数为 `MAXN - 1`。

## 完整例子（size 法）

```c showLineNumbers
#include <stdio.h>
#include <stdbool.h>

#define MAXN 8

typedef struct {
    int data[MAXN];
    int head;
    int tail;
    int size;
} CirQueue;

void init(CirQueue *q) {
    q->head = q->tail = q->size = 0;
}

bool enqueue(CirQueue *q, int value) {
    if (q->size == MAXN) return false;
    q->data[q->tail] = value;
    q->tail = (q->tail + 1) % MAXN;
    q->size++;
    return true;
}

bool dequeue(CirQueue *q, int *out) {
    if (q->size == 0) return false;
    *out = q->data[q->head];
    q->head = (q->head + 1) % MAXN;
    q->size--;
    return true;
}

int main(void) {
    CirQueue q;
    int x;
    init(&q);

    for (int i = 1; i <= 5; i++) enqueue(&q, i);
    dequeue(&q, &x);
    printf("out=%d\n", x);           /* 1 */

    enqueue(&q, 6);
    while (dequeue(&q, &x)) {
        printf("%d ", x);            /* 2 3 4 5 6 */
    }
    printf("\n");
    return 0;
}
```

## 牺牲槽位法片段

```c showLineNumbers
bool full(const CirQueue *q) {
    return (q->tail + 1) % MAXN == q->head;
}

bool empty(const CirQueue *q) {
    return q->head == q->tail;
}
```

此时结构体里可以不再存 `size`，但要记得容量少 1。

## 常见错误

| 错误 | 说明 |
| --- | --- |
| 取模忘记 | `tail++` 越界 |
| 空满判定混用两套约定 | 逻辑自相矛盾 |
| 出队后未更新 `head` | 反复读同一元素 |
| `MAXN` 过小却不检查满 | 覆盖未出队数据 |

## 小结

循环队列让数组队列真正可用。先固定空 / 满策略，再写代码；入门优先用 `size` 字段，边界最不容易晕。

下一篇：[双端队列](/data-structures/deque/)。
