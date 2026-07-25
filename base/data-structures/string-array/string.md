---
sidebar_position: 3
slug: /string
sidebar_label: 串
---

# 串

**串（String）**是由字符组成的有限序列。它是线性表的特例：元素类型为字符，并衍生出大量面向文本的运算（连接、求子串、模式匹配等）。

## 本文解决什么问题

- 串的基本术语与运算
- C 字符数组与 C++ `std::string` 的差异
- 常见存储方式
- 如何衔接到模式匹配

## 基本概念

| 术语 | 含义 |
| --- | --- |
| 串长 | 字符个数 |
| 空串 | 长度为 0 的串 |
| 子串 | 串中任意连续一段 |
| 主串 | 包含子串的那个串 |
| 位序 | 字符在串中的位置（教材常从 1 起） |

注意：空格也是字符；「空格串」与「空串」不是一回事。

## C：以 `'\0'` 结尾的字符数组

```c showLineNumbers
#include <stdio.h>
#include <string.h>

int main(void) {
    char s[32] = "hello";
    printf("len=%zu\n", strlen(s));
    strcat(s, " world");   /* 确保 s 容量足够 */
    printf("%s\n", s);
    return 0;
}
```

:::warning
`strcpy` / `strcat` 不检查目标容量，缓冲区溢出是经典安全漏洞。更安全的写法使用 `snprintf`，或明确长度的 `strncpy`（注意是否手动补 `'\0'`）。
:::

C 串是「数组 + 约定结束符」，本身不自带长度字段；`strlen` 是 $O(n)$。

## C++：`std::string`

```cpp showLineNumbers
#include <iostream>
#include <string>

int main() {
    std::string s = "hello";
    s += " world";
    std::cout << s << ' ' << s.size() << '\n';
    std::cout << s.substr(0, 5) << '\n';  // hello
    return 0;
}
```

`std::string` 管理长度与容量，支持动态增长，日常开发优先用它，而不是裸 `char[]`。

## 存储方式简述

| 方式 | 说明 |
| --- | --- |
| 定长顺序串 | 固定缓冲区 + 当前长度 |
| 堆分配串 | 动态申请，可扩容（`std::string` 一类） |
| 块链串 | 分成多块用指针相连，较少作为入门重点 |

## 基本运算与复杂度直觉

| 运算 | 直觉代价 |
| --- | --- |
| 求长度（C 风格） | $O(n)$ |
| 求长度（带长度字段） | $O(1)$ |
| 连接 | 与结果长度相关 |
| 求子串 | 通常要拷贝，$O(k)$ |
| 比较 | 最坏与较短串长相关 |
| 模式匹配 | 见下一篇，朴素可达 $O(nm)$ |

## 小结

串是文本处理的基础。先熟悉长度、连接、子串与 C/C++ 两种表示，再进入 [模式匹配入门](/data-structures/string-matching/)。
