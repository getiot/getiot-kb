---
sidebar_position: 4
slug: /deque
sidebar_label: 双端队列
---

# 双端队列

**双端队列（Deque，Double-ended Queue）**允许在**两端**进行插入和删除，兼具栈与队列的部分灵活度。

读作 “deck”。

## 本文解决什么问题

- Deque 相对栈 / 队列多了哪些操作
- 典型应用场景
- C++ 里 `std::deque` 怎么用
- 和单调队列思想的关系（了解）

## 支持的操作（典型）

| 操作 | 含义 | 目标复杂度 |
| --- | --- | --- |
| `push_front` / `push_back` | 头 / 尾插入 | $O(1)$ 摊还 |
| `pop_front` / `pop_back` | 头 / 尾删除 | $O(1)$ 摊还 |
| `front` / `back` | 查看两端 | $O(1)$ |

相对普通队列：多了「队头插入、队尾删除」。  
相对栈：两端都能当「栈顶」用，但语义上更自由，也更容易用乱。

## 实现直觉

- 双向链表：两端操作自然 $O(1)$  
- 循环数组 / 分块数组：`std::deque` 常见实现思路之一（分段连续缓冲）  
- 自己用循环数组实现时，`head` 左移也要取模，比单端队列多几个边界  

初学不必手写完整 `std::deque` 级实现；先把操作语义用熟。

## C++ 示例

```cpp showLineNumbers
#include <deque>
#include <iostream>

int main() {
    std::deque<int> dq;
    dq.push_back(1);
    dq.push_front(0);
    dq.push_back(2);                 // 0, 1, 2
    std::cout << dq.front() << ' ' << dq.back() << '\n';  // 0 2
    dq.pop_front();                  // 1, 2
    dq.pop_back();                   // 1
    std::cout << dq.front() << '\n';
    return 0;
}
```

`std::queue` 默认常以 `deque` 为底层；需要随机访问中间元素时，`deque` 也支持下标，但随机访问常数通常不如 `vector`。

## 应用直觉

| 场景 | 用法 |
| --- | --- |
| 两端缓冲 | 既可能从前面来任务，也可能从后面追加 |
| 滑动窗口最值 | 维护候选下标的**单调队列**（deque 作容器） |
| 栈或队列模拟 | 只用一端或头尾分工 |

### 单调队列一句话

在滑动窗口问题中，用 deque 存「下标」，保持对应值单调，使队头始终是当前窗口最值候选。细节属于算法题技巧，容器本身仍是 deque。

## 怎么选

| 需求 | 更合适 |
| --- | --- |
| 只要 LIFO | 栈 |
| 只要 FIFO | 队列 |
| 两端都要进 / 出 | **deque** |
| 随机访问为主 | `vector` |

:::tip
业务语义若明确是栈或队列，请用栈 / 队列接口，不要图方便全程 `deque`——接口越宽，误用成本越高。
:::

## 小结

Deque 是「两头都能动的队列」。实现上记住两端 $O(1)$ 的目标；工程上优先 `std::deque`，需要时再自己用循环数组或双向链表实现。

下一篇：[优先队列](/data-structures/priority-queue/)。
