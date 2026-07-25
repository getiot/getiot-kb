---
sidebar_position: 5
slug: /bst
sidebar_label: 二叉搜索树
---

# 二叉搜索树

**二叉搜索树（BST，Binary Search Tree）**是一种特殊的二叉树，对任意结点：

- 左子树所有值 **&lt;** 结点值  
- 右子树所有值 **&gt;** 结点值  

（相等元素的放置策略需事先约定，本篇假设 key 互异。）

因此，**中序遍历 BST 会得到有序序列**。

## 基本操作复杂度

在「比较均衡」的树上：

| 操作 | 平均 | 最坏（退化成链） |
| --- | --- | --- |
| 查找 / 插入 / 删除 | $O(\log n)$ | $O(n)$ |

若插入序列本身有序，朴素 BST 可能退化成链表。工程上会用 AVL、红黑树等自平衡树；C++ 的 `std::map` / `std::set` 通常基于平衡树。

## C：查找与插入

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int key;
    struct Node *left;
    struct Node *right;
} Node;

Node *new_node(int key) {
    Node *n = (Node *)malloc(sizeof(Node));
    n->key = key;
    n->left = n->right = NULL;
    return n;
}

Node *insert(Node *root, int key) {
    if (!root) {
        return new_node(key);
    }
    if (key < root->key) {
        root->left = insert(root->left, key);
    } else if (key > root->key) {
        root->right = insert(root->right, key);
    }
    return root;
}

Node *search(Node *root, int key) {
    if (!root || root->key == key) {
        return root;
    }
    if (key < root->key) {
        return search(root->left, key);
    }
    return search(root->right, key);
}

void inorder(Node *root) {
    if (!root) return;
    inorder(root->left);
    printf("%d ", root->key);
    inorder(root->right);
}

int main(void) {
    Node *root = NULL;
    int keys[] = {8, 3, 10, 1, 6, 14};
    for (int i = 0; i < 6; i++) {
        root = insert(root, keys[i]);
    }

    inorder(root);  /* 1 3 6 8 10 14 */
    printf("\n");

    printf("find 6? %s\n", search(root, 6) ? "yes" : "no");
    return 0;
}
```

## C++：对照 `std::set`

```cpp showLineNumbers
#include <iostream>
#include <set>

int main() {
    std::set<int> s = {8, 3, 10, 1, 6, 14};
    for (int x : s) {
        std::cout << x << ' ';  // 有序输出
    }
    std::cout << '\n';
    std::cout << std::boolalpha << (s.count(6) > 0) << '\n';
    return 0;
}
```

手写 BST 是为了理解「比较后向左或向右走」；项目里有序关联容器优先用标准库。

## 删除（思路）

删除结点分三种情况：

1. 叶子：直接去掉  
2. 只有一个孩子：用孩子顶上  
3. 两个孩子：常用「右子树最小结点」或「左子树最大结点」替换后再删替换者  

初学可先熟练查找与插入，删除作为练习题。

## 小结

BST 用「左小右大」把查找变成树高路径上的比较。它连接了「树」和「有序表」两种直觉；为避免退化，下一篇看 [平衡二叉树（AVL）](/data-structures/avl/)。
