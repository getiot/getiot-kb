---
sidebar_position: 4
slug: /hash-table
sidebar_label: 哈希表
---

# 哈希表

**哈希表（Hash Table）**希望做到：给定一个键（key），通过哈希函数算出下标，在平均 $O(1)$ 时间内完成插入、查找、删除。

可以把它想成「会自己算柜号的储物柜」：不用从第一个柜子挨个找。

## 核心思想

1. 有一个数组（桶，buckets）  
2. 哈希函数 `h(key)` 把 key 映射到 `[0, capacity)`  
3. 把 `(key, value)` 放进对应桶  

理想情况不同 key 映射到不同下标；现实中会发生**冲突（collision）**。

## 冲突怎么处理（了解即可）

常见两种入门方案：

- **链地址法**：每个桶是一条链表，冲突的元素挂在同一条链上  
- **开放地址法**：冲突后按规则探测下一个空槽（线性探测等）

负载因子（已存元素 / 容量）升高后，冲突变多，需要**扩容并重新哈希**。

## 平均复杂度

| 操作 | 平均 | 最坏（退化） |
| --- | --- | --- |
| 查找 / 插入 / 删除 | $O(1)$ | $O(n)$（例如全挤在一条链） |

好的哈希函数 + 合理负载因子，是保持平均 $O(1)$ 的关键。

## C：极简链地址示例

下面用「整数 key 映射到小表」演示思想，不是工业级实现：

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define CAP 8

typedef struct Node {
    int key;
    int value;
    struct Node *next;
} Node;

static Node *table[CAP];

static unsigned hash_int(int key) {
    return (unsigned)key % CAP;
}

void put(int key, int value) {
    unsigned i = hash_int(key);
    for (Node *p = table[i]; p; p = p->next) {
        if (p->key == key) {
            p->value = value;  /* 更新 */
            return;
        }
    }
    Node *node = (Node *)malloc(sizeof(Node));
    node->key = key;
    node->value = value;
    node->next = table[i];
    table[i] = node;
}

bool get(int key, int *out) {
    unsigned i = hash_int(key);
    for (Node *p = table[i]; p; p = p->next) {
        if (p->key == key) {
            *out = p->value;
            return true;
        }
    }
    return false;
}

int main(void) {
    int v;
    put(1, 100);
    put(9, 200);   /* 1 和 9 在 CAP=8 时可能冲突，挂到同一链 */
    put(1, 150);   /* 更新 key=1 */

    if (get(1, &v)) {
        printf("1 -> %d\n", v);
    }
    if (get(9, &v)) {
        printf("9 -> %d\n", v);
    }
    return 0;
}
```

## C++：优先用标准库

```cpp showLineNumbers
#include <iostream>
#include <unordered_map>
#include <string>

int main() {
    std::unordered_map<std::string, int> ages;
    ages["Alice"] = 20;
    ages["Bob"] = 22;

    if (ages.count("Alice")) {
        std::cout << ages["Alice"] << '\n';
    }

    for (const auto &kv : ages) {
        std::cout << kv.first << " => " << kv.second << '\n';
    }
    return 0;
}
```

需要有序遍历键时，用 `std::map`（通常基于树，操作 $O(\log n)$），不要和哈希表混为一谈。

## 什么时候用哈希表

- 大量「根据 ID / 名字快速查」  
- 统计词频、去重、缓存  
- 两数之和等「空间换时间」的经典题  

不适合：需要按键有序输出；对最坏 $O(n)$ 完全不能容忍且无法控制哈希质量时，要更谨慎。

## 小结

哈希表用「计算下标」换查找速度，冲突处理决定了它是否稳定。理解链地址后，日常开发直接用 `unordered_map` / `unordered_set` 即可。

冲突策略的对照见下一篇 [哈希冲突处理](/data-structures/hash-collision/)。
