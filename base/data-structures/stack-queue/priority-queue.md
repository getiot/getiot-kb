---
sidebar_position: 5
slug: /priority-queue
sidebar_label: 优先队列
---

# 优先队列

**优先队列（Priority Queue）**不是按到达顺序出队，而是按**优先级**出队：每次取出当前最优（最大或最小）元素。

可以把它想成「自动排序的队列」：谁优先级高，谁先离开。

## 本文解决什么问题

- 优先队列与普通队列的差别
- 为何常用堆实现
- C++ `std::priority_queue` 怎么用
- 典型应用与复杂度

## 基本操作

| 操作 | 含义 | 堆实现复杂度 |
| --- | --- | --- |
| `push` | 插入元素 | $O(\log n)$ |
| `pop` | 删除当前最值 | $O(\log n)$ |
| `top` | 查看当前最值 | $O(1)$ |

若用有序数组 / 有序链表，插入或删除之一往往会退化到 $O(n)$。**二叉堆**能在插入与删除最值之间取得平衡，因此是默认实现。详见 [堆](/data-structures/heap/)。

## 和 FIFO 队列的对比

| | 普通队列 | 优先队列 |
| --- | --- | --- |
| 出队依据 | 谁先来 | 谁优先级高 |
| 顺序 | FIFO | 由优先级决定 |
| 典型结构 | 链表 / 循环数组 | 堆 |

## C++：`std::priority_queue`

默认是**最大堆**（`top` 为当前最大）：

```cpp showLineNumbers
#include <iostream>
#include <queue>
#include <vector>

int main() {
    std::priority_queue<int> maxpq;
    maxpq.push(3);
    maxpq.push(5);
    maxpq.push(1);
    std::cout << maxpq.top() << '\n';  // 5
    maxpq.pop();

    /* 最小堆：比较器改为 greater */
    std::priority_queue<int, std::vector<int>, std::greater<int>> minpq;
    minpq.push(3);
    minpq.push(5);
    minpq.push(1);
    std::cout << minpq.top() << '\n';  // 1
    return 0;
}
```

自定义优先级时，传入比较器或重载 `operator<`（注意 `priority_queue` 的比较语义与 `sort` 有时容易搞反，写完用小例子验证）。

## 手写直觉（数组堆）

把堆画成完全二叉树，用数组下标存：

- 父：`(i - 1) / 2`  
- 左孩子：`2i + 1`，右孩子：`2i + 2`  

插入：放到末尾再「上浮」；删除最值：用末尾覆盖堆顶再「下沉」。具体代码见堆一章。

## 应用

| 场景 | 说明 |
| --- | --- |
| 任务调度 | 高优先级任务先执行 |
| Top-K | 用大小为 K 的堆维护候选 |
| Dijkstra | 用优先队列扩展当前最近顶点（非负权） |
| 哈夫曼编码 | 反复取两个最小权值合并 |

## 常见误区

- 以为 `priority_queue` 支持任意位置删除 / 降键：标准库接口很受限；需要时用 `set` 或专用堆  
- 忘记默认是最大堆，写出和预期相反的顺序  
- 把优先队列当成已排序数组去随机访问第 $k$ 个  

## 小结

优先队列是「带优先级的队列抽象」；入门阶段掌握堆实现复杂度，并会用 `std::priority_queue` 即可。结构细节放到 [堆](/data-structures/heap/) 深挖。

下一章进入 [数组](/data-structures/array/)（串、数组和广义表）。
