---
sidebar_position: 4
slug: /string-matching
sidebar_label: 模式匹配入门
---

# 模式匹配入门

**模式匹配**在主串中查找模式串第一次出现的位置（或是否出现）。设主串长度 $n$，模式串长度 $m$。

## 本文解决什么问题

- 朴素匹配如何写、复杂度为何是 $O(nm)$
- KMP 在优化什么（建立直觉）
- 工程里常用什么

## 朴素匹配（蛮力）

主串每个起点与模式串逐字符比较；失败则主串起点 +1 再试。

```c showLineNumbers
int naive_match(const char *s, const char *p) {
    int n = 0, m = 0;
    while (s[n]) n++;
    while (p[m]) m++;
    for (int i = 0; i + m <= n; i++) {
        int j = 0;
        while (j < m && s[i + j] == p[j]) j++;
        if (j == m) return i;   /* 返回起始下标 */
    }
    return -1;
}
```

- 最坏时间约 $O(n\cdot m)$（例如主串全 `a`，模式 `aaa...ab`）  
- 最好可以很快（首字符就对不上）  
- 属于 [蛮力法](/data-structures/brute-force/)  

## 为什么还能更快：KMP 直觉

朴素算法的浪费在于：一旦失配，主串指针往往回退，已经比过的信息被丢掉。

**KMP** 预处理模式串，得到 `next`（或称前缀函数 / failure function）：当第 $j$ 个字符失配时，模式串跳到 `next[j]`，**主串指针不回退**。

```text
主串:   a b a b a b a c
模式:   a b a b a c
                    ^ 失配
         利用「已匹配前缀」的最长真前后缀，把模式往右滑到正确位置
```

- 预处理：$O(m)$  
- 匹配：$O(n)$  
- 总计：$O(n + m)$  

完整 `next` 构造与证明略长，初学建议：

1. 先写对朴素算法并用多组样例测  
2. 再对照可信实现理解 `next`  
3. 需要时再手推小例子  

:::note 需要验证
网上 `next` 数组有「是否含自身」「下标从 0/1」等多种约定，抄代码前务必与自己的匹配循环一致。
:::

## 其他算法（了解）

| 算法 | 特点 |
| --- | --- |
| Boyer-Moore | 从右往左比，坏字符 / 好后缀跳转，实用文本搜索常很快 |
| Sunday | 实现相对好记的跳跃算法 |
| Rabin-Karp | 滚动哈希，适合多模式或指纹比对 |

标准库层面：C++ 可用 `std::string::find`；具体算法由实现决定，通常够用。

## 和本章其他内容的关系

- 串的存储见 [串](/data-structures/string/)  
- 暴力枚举思想见 [蛮力法](/data-structures/brute-force/)  
- 每次排除可能性的思想接近 [减治](/data-structures/decrease-and-conquer/)（KMP 的跳跃）  

## 小结

模式匹配是串的核心运算。朴素法对应蛮力；KMP 等用预处理避免主串回退。开发中先保证朴素正确，再按性能需求上 KMP 或库函数。

下一篇：[广义表](/data-structures/generalized-list/)。
