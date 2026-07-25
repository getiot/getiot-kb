---
sidebar_position: 1
slug: /stack
sidebar_label: 栈
---

# 栈

**栈（Stack）**是一种「后进先出」（LIFO，Last In First Out）的线性结构：只能在同一端（**栈顶**）做插入和删除。

可以把它想象成一摞盘子：后放上去的，先被拿走。

## 本文解决什么问题

- 栈的 ADT 与典型应用
- 数组实现如何处理满 / 空
- 用括号匹配把语义跑通
- 和 `std::stack` / `vector` 的关系

## 基本操作

| 操作 | 含义 | 典型复杂度 |
| --- | --- | --- |
| `push` | 入栈 | $O(1)$ |
| `pop` | 出栈 | $O(1)$ |
| `top` / `peek` | 看栈顶但不删除 | $O(1)$ |
| `empty` | 是否为空 | $O(1)$ |

栈是操作受限的线性表：不允许访问任意中间元素（ADT 层面）。

## 典型用途

- 函数调用栈、表达式求值、括号匹配  
- 撤销（Undo）：后做的操作先撤销  
- 用显式栈模拟 DFS / 递归  

## C：数组实现

```c showLineNumbers
#include <stdio.h>
#include <stdbool.h>

#define MAXN 100

typedef struct {
    int data[MAXN];
    int top;  /* 下一个可写位置；空栈为 0 */
} Stack;

void init(Stack *s) { s->top = 0; }

bool push(Stack *s, int value) {
    if (s->top >= MAXN) return false;  /* 栈满 */
    s->data[s->top++] = value;
    return true;
}

bool pop(Stack *s, int *out) {
    if (s->top == 0) return false;     /* 栈空 */
    *out = s->data[--s->top];
    return true;
}

bool top(const Stack *s, int *out) {
    if (s->top == 0) return false;
    *out = s->data[s->top - 1];
    return true;
}
```

也可用链表实现：头插 / 头删即 push / pop，容量更灵活，但常数与缓存通常不如数组。

## 完整例子：括号匹配

```c showLineNumbers
#include <stdio.h>
#include <stdbool.h>
#include <string.h>

#define MAXN 256

typedef struct {
    char data[MAXN];
    int top;
} CharStack;

static void init(CharStack *s) { s->top = 0; }
static bool push(CharStack *s, char c) {
    if (s->top >= MAXN) return false;
    s->data[s->top++] = c;
    return true;
}
static bool pop(CharStack *s, char *out) {
    if (s->top == 0) return false;
    *out = s->data[--s->top];
    return true;
}

static int match(char l, char r) {
    return (l == '(' && r == ')') ||
           (l == '[' && r == ']') ||
           (l == '{' && r == '}');
}

bool brackets_ok(const char *s) {
    CharStack st;
    init(&st);
    for (int i = 0; s[i]; i++) {
        char c = s[i];
        if (c == '(' || c == '[' || c == '{') {
            if (!push(&st, c)) return false;
        } else if (c == ')' || c == ']' || c == '}') {
            char left;
            if (!pop(&st, &left) || !match(left, c)) return false;
        }
    }
    return st.top == 0;
}

int main(void) {
    printf("%d\n", brackets_ok("{[()]}"));  /* 1 */
    printf("%d\n", brackets_ok("([)]"));    /* 0 */
    return 0;
}
```

思路：遇左括号入栈；遇右括号则检查栈顶是否配对并出栈；结束时栈应为空。

## C++：手写与 STL

```cpp showLineNumbers
#include <iostream>
#include <stack>
#include <vector>

class IntStack {
public:
    void push(int v) { data_.push_back(v); }
    void pop() { data_.pop_back(); }
    int top() const { return data_.back(); }
    bool empty() const { return data_.empty(); }
private:
    std::vector<int> data_;
};

int main() {
    std::stack<int> st;
    st.push(10);
    st.push(20);
    std::cout << st.top() << '\n';  // 20
    return 0;
}
```

`std::stack` 默认底层是 `deque`；自己用 `vector` 模拟也很常见。

## 常见错误

| 错误 | 说明 |
| --- | --- |
| 空栈仍 `pop` / `top` | 未定义行为或读脏数据 |
| 满栈仍 `push` | 越界写 |
| 把 `top` 当成下标用错约定 | 有人令 `top=-1` 表示空，有人令 `top=0` 表示下一可写；统一即可 |

## 小结

栈限制了访问方式，换来清晰语义：只关心「最近放进去的那个」。实现上数组或链表都可以；工程中优先 `std::stack` 或 `vector` 模拟。

下一篇：[队列](/data-structures/queue/)。
