---
sidebar_position: 2
slug: /binary-tree
sidebar_label: 二叉树
---

# 二叉树

**树**表示层次关系：一个结点可以有多个孩子。**二叉树**限制每个结点最多两个孩子，通常叫左孩子、右孩子。

```text
        1
       / \
      2   3
     / \
    4   5
```

## 常用术语

- **根（root）**：最顶上的结点  
- **叶子**：没有孩子的结点  
- **深度 / 高度**：从根往下或从叶往上的层数（不同教材定义略有差异，阅读时看清约定）  
- **遍历**：按某种顺序访问每个结点恰好一次  

## 三种经典遍历

对结点 `N`，左右子树为 `L`、`R`：

| 名称 | 顺序 | 口诀 |
| --- | --- | --- |
| 前序 | N, L, R | 根左右 |
| 中序 | L, N, R | 左根右 |
| 后序 | L, R, N | 左右根 |

层序遍历则是「一层一层从左到右」，通常用队列实现（BFS）。

## C：结点与递归遍历

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int data;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

TreeNode *new_node(int value) {
    TreeNode *n = (TreeNode *)malloc(sizeof(TreeNode));
    n->data = value;
    n->left = n->right = NULL;
    return n;
}

void preorder(const TreeNode *root) {
    if (!root) return;
    printf("%d ", root->data);
    preorder(root->left);
    preorder(root->right);
}

void inorder(const TreeNode *root) {
    if (!root) return;
    inorder(root->left);
    printf("%d ", root->data);
    inorder(root->right);
}

void free_tree(TreeNode *root) {
    if (!root) return;
    free_tree(root->left);
    free_tree(root->right);
    free(root);
}

int main(void) {
    TreeNode *root = new_node(1);
    root->left = new_node(2);
    root->right = new_node(3);
    root->left->left = new_node(4);
    root->left->right = new_node(5);

    printf("preorder: ");
    preorder(root);
    printf("\ninorder:  ");
    inorder(root);
    printf("\n");

    free_tree(root);
    return 0;
}
```

## C++：同样可用结构体

```cpp showLineNumbers
#include <iostream>

struct TreeNode {
    int data;
    TreeNode *left;
    TreeNode *right;
    explicit TreeNode(int v) : data(v), left(nullptr), right(nullptr) {}
};

void inorder(const TreeNode *root) {
    if (!root) return;
    inorder(root->left);
    std::cout << root->data << ' ';
    inorder(root->right);
}

int main() {
    TreeNode *root = new TreeNode(1);
    root->left = new TreeNode(2);
    root->right = new TreeNode(3);

    inorder(root);
    std::cout << '\n';
    // 演示省略完整析构；练习时记得释放整棵树
    return 0;
}
```

## 为什么要学二叉树

- 表达式树、文件系统目录、UI 控件树都是树形思维  
- **二叉搜索树**、**堆**、**Huffman 树**都建立在二叉树（或近似）之上  
- 递归与树遍历是算法训练的基本功  

## 小结

先记住「结点 + 左右孩子」和三种遍历顺序。遍历细节（含层序、非递归直觉）见下一篇 [二叉树的遍历](/data-structures/binary-tree-traversal/)；加上「左小右大」约束则得到 [二叉搜索树](/data-structures/bst/)。
