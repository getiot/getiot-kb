---
sidebar_position: 5
slug: /matrix-operations
---

# 矩阵运算

矩阵运算是线性代数的核心！掌握矩阵运算，是学习线性代数的关键。

## 矩阵的加法

### 定义

如果 $A = [a_{ij}]$ 和 $B = [b_{ij}]$ 都是 $m \times n$ 矩阵，则：

$$
(A + B)_{ij} = a_{ij} + b_{ij}
$$


### 条件

两个矩阵可以相加当且仅当它们的**大小相同**（行数和列数都相等）。

### 例子

**例子**：

$$
A = \begin{bmatrix} 1 & 2 \\ 3 & 4 \end{bmatrix}, \quad B = \begin{bmatrix} 5 & 6 \\ 7 & 8 \end{bmatrix}
$$

$$
A + B = \begin{bmatrix} 1+5 & 2+6 \\ 3+7 & 4+8 \end{bmatrix} = \begin{bmatrix} 6 & 8 \\ 10 & 12 \end{bmatrix}
$$


### 性质

- **交换律**：$A + B = B + A$
- **结合律**：$(A + B) + C = A + (B + C)$
- **零矩阵**：$A + O = A$

## 矩阵的数乘

### 定义

如果 $A = [a_{ij}]$ 是 $m \times n$ 矩阵，$k$ 是实数，则：

$$
(kA)_{ij} = ka_{ij}
$$


### 例子

**例子**：

$$
A = \begin{bmatrix} 1 & 2 \\ 3 & 4 \end{bmatrix}, \quad 2A = \begin{bmatrix} 2 & 4 \\ 6 & 8 \end{bmatrix}
$$


### 性质

- $k(A + B) = kA + kB$
- $(k + l)A = kA + lA$
- $(kl)A = k(lA)$

## 矩阵的乘法

### 定义

如果 $A = [a_{ij}]$ 是 $m \times n$ 矩阵，$B = [b_{ij}]$ 是 $n \times p$ 矩阵，则 $C = AB$ 是 $m \times p$ 矩阵，其中：

$$
c_{ij} = \sum_{k=1}^{n} a_{ik}b_{kj}
$$


### 条件

两个矩阵可以相乘当且仅当**第一个矩阵的列数等于第二个矩阵的行数**。

### 例子

**例子 1**：
$$
A = \begin{bmatrix} 1 & 2 \\ 3 & 4 \end{bmatrix}, \quad B = \begin{bmatrix} 5 & 6 \\ 7 & 8 \end{bmatrix}
$$

$$
AB = \begin{bmatrix}
1 \times 5 + 2 \times 7 & 1 \times 6 + 2 \times 8 \\
3 \times 5 + 4 \times 7 & 3 \times 6 + 4 \times 8
\end{bmatrix} = \begin{bmatrix} 19 & 22 \\ 43 & 50 \end{bmatrix}
$$


**例子 2**：

$$
A = \begin{bmatrix} 1 & 2 & 3 \end{bmatrix}, \quad B = \begin{bmatrix} 4 \\ 5 \\ 6 \end{bmatrix}
$$

$$
AB = \begin{bmatrix} 1 \times 4 + 2 \times 5 + 3 \times 6 \end{bmatrix} = \begin{bmatrix} 32 \end{bmatrix}
$$


### 性质

- **结合律**：$(AB)C = A(BC)$
- **分配律**：$A(B + C) = AB + AC$，$(A + B)C = AC + BC$
- **数乘**：$k(AB) = (kA)B = A(kB)$
- **单位矩阵**：$AI = IA = A$
- **转置**：$(AB)^T = B^T A^T$

### 注意

**矩阵乘法不满足交换律**：一般情况下，$AB \neq BA$。

## 矩阵的幂

### 定义

如果 $A$ 是 $n \times n$ 方阵，则：

$$
A^k = \underbrace{A \cdot A \cdots A}_{k \text{ 个}}
$$


### 例子

**例子**：

$$
A = \begin{bmatrix} 1 & 1 \\ 0 & 1 \end{bmatrix}
$$

$$
A^2 = \begin{bmatrix} 1 & 1 \\ 0 & 1 \end{bmatrix} \begin{bmatrix} 1 & 1 \\ 0 & 1 \end{bmatrix} = \begin{bmatrix} 1 & 2 \\ 0 & 1 \end{bmatrix}
$$

$$
A^3 = A^2 A = \begin{bmatrix} 1 & 2 \\ 0 & 1 \end{bmatrix} \begin{bmatrix} 1 & 1 \\ 0 & 1 \end{bmatrix} = \begin{bmatrix} 1 & 3 \\ 0 & 1 \end{bmatrix}
$$


## 矩阵的转置

### 定义

矩阵 $A$ 的转置 $A^T$ 是将 $A$ 的行和列互换。

### 性质

- $(A^T)^T = A$
- $(A + B)^T = A^T + B^T$
- $(kA)^T = kA^T$
- $(AB)^T = B^T A^T$

## 生活中的应用

#### 计算机图形学

- 💻 **图形变换**：用矩阵乘法进行图形变换
- 🎮 **游戏开发**：用矩阵进行游戏开发

#### 数据科学

- 📊 **数据处理**：用矩阵运算处理数据
- 🤖 **机器学习**：用矩阵运算进行机器学习

#### 工程

- ⚙️ **系统分析**：用矩阵分析系统
- 🏗️ **结构分析**：用矩阵分析结构

## 常见错误

#### 错误 1：矩阵大小不匹配

两个矩阵相加或相乘时，要注意大小是否匹配。

#### 错误 2：矩阵乘法交换律

矩阵乘法不满足交换律，$AB \neq BA$。

#### 错误 3：转置公式错误

$(AB)^T = B^T A^T$，不是 $A^T B^T$。

## 小练习

1. 如果 $A = \begin{bmatrix} 1 & 2 \\ 3 & 4 \end{bmatrix}$，$B = \begin{bmatrix} 5 & 6 \\ 7 & 8 \end{bmatrix}$，求 $A + B$ 和 $AB$
2. 如果 $A = \begin{bmatrix} 1 & 2 \\ 3 & 4 \end{bmatrix}$，求 $2A$ 和 $A^2$
3. 如果 $A = \begin{bmatrix} 1 & 2 \\ 3 & 4 \end{bmatrix}$，求 $A^T$
4. 应用题：用矩阵表示线性变换，计算变换后的向量

---

> 💡 **小贴士**：矩阵运算是线性代数的核心。记住：矩阵乘法不满足交换律，$(AB)^T = B^T A^T$。掌握矩阵运算，你就能解决很多线性代数问题！