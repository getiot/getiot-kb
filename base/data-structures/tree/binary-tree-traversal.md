---
sidebar_position: 3
slug: /binary-tree-traversal
sidebar_label: 二叉树的遍历
---

# 二叉树的遍历

**遍历**按某种次序访问树中每个结点恰好一次。二叉树最常用的是前序、中序、后序与层序。

结点定义见 [二叉树](/data-structures/binary-tree/)。

## 本文解决什么问题

- 四种遍历的次序与递归写法
- 层序与队列的关系
- 非递归（显式栈）直觉
- 各遍历的典型用途

## 三种递归遍历

对结点 $N$，左右子树 $L$、$R$：

| 名称 | 顺序 | 口诀 |
| --- | --- | --- |
| 前序（先序） | $N, L, R$ | 根左右 |
| 中序 | $L, N, R$ | 左根右 |
| 后序 | $L, R, N$ | 左右根 |

```c showLineNumbers
void preorder(TreeNode *root) {
    if (!root) return;
    printf("%d ", root->data);
    preorder(root->left);
    preorder(root->right);
}

void inorder(TreeNode *root) {
    if (!root) return;
    inorder(root->left);
    printf("%d ", root->data);
    inorder(root->right);
}

void postorder(TreeNode *root) {
    if (!root) return;
    postorder(root->left);
    postorder(root->right);
    printf("%d ", root->data);
}
```

时间均为 $\Theta(n)$（每个结点进出常数次）；递归栈空间最坏 $O(n)$（斜树），平衡时约 $O(\log n)$。

## 层序遍历（BFS）

用队列，一层一层从左到右：

```c showLineNumbers
#include <stdio.h>

#define QMAX 256

void level_order(TreeNode *root) {
    if (!root) return;
    TreeNode *q[QMAX];
    int head = 0, tail = 0;
    q[tail++] = root;

    while (head < tail) {
        TreeNode *p = q[head++];
        printf("%d ", p->data);
        if (p->left)  q[tail++] = p->left;
        if (p->right) q[tail++] = p->right;
    }
}
```

这与图的 BFS、树的「按层处理」同一套路。队列思想见 [队列](/data-structures/queue/)。

## 非递归中序（显式栈直觉）

1. 一路向左走，边走边压栈  
2. 栈空则结束；否则弹出并访问  
3. 转向该结点右子树，重复  

前序 / 后序也有经典栈写法；后序稍绕（要区分左右孩子是否访问过）。深度很大时，显式栈比递归更好控制内存。

## 应用提示

| 场景 | 常用遍历 |
| --- | --- |
| 表达式树打印中缀 | 中序（加括号规则） |
| 表达式求值 / 释放结点 | 后序 |
| 二叉搜索树导出有序序列 | 中序 |
| 按层输出 / 序列化按层 | 层序 |
| 复制树 | 常见前序或后序框架 |

## 由遍历序列还原二叉树（了解）

- 前序 + 中序可唯一确定一棵二叉树  
- 后序 + 中序亦可  
- 仅前序 + 后序在一般二叉树下**不一定**唯一  

这是练习题常见考点，帮助加深「遍历到底记下了什么信息」。

## 小结

先把四种遍历的次序记牢，并会写递归版与层序；需要时再练非递归。下一篇了解 [线索二叉树](/data-structures/threaded-binary-tree/) 如何用空指针存前驱后继。
