---
sidebar_position: 7
slug: /eigenvalues-and-eigenvectors
---

# 特征值和特征向量

特征值和特征向量是矩阵的重要性质！理解它们，能帮助我们分析矩阵的特征和进行矩阵分解。

## 什么是特征值和特征向量？

**特征值**（Eigenvalue）和**特征向量**（Eigenvector）是方阵 $A$ 的特征，满足：

$$
A\vec{v} = \lambda\vec{v}
$$
其中：
- **$\lambda$**：特征值（标量）
- **$\vec{v}$**：特征向量（非零向量）

### 简单理解

特征值和特征向量就像"矩阵的特殊方向和缩放"：

- 特征向量是矩阵作用后方向不变的向量
- 特征值是矩阵作用后特征向量的缩放因子

## 特征值和特征向量的求法

### 特征方程

从 $A\vec{v} = \lambda\vec{v}$ 可以得到：

$$
(A - \lambda I)\vec{v} = \vec{0}
$$
这是一个齐次线性方程组，有非零解当且仅当：

$$
\det(A - \lambda I) = 0
$$
这个方程叫做**特征方程**（Characteristic Equation）。

### 步骤

1. **求特征值**：解特征方程 $\det(A - \lambda I) = 0$
2. **求特征向量**：对每个特征值 $\lambda$，解方程组 $(A - \lambda I)\vec{v} = \vec{0}$

### 例子

**例子**：求矩阵 $A = \begin{bmatrix} 2 & 1 \\ 1 & 2 \end{bmatrix}$ 的特征值和特征向量

**步骤 1**：求特征值

$$A - \lambda I = \begin{bmatrix} 2 - \lambda & 1 \\ 1 & 2 - \lambda \end{bmatrix}$$

$$\det(A - \lambda I) = (2 - \lambda)^2 - 1 = \lambda^2 - 4\lambda + 3 = 0$$

解得：$\lambda_1 = 1$，$\lambda_2 = 3$

**步骤 2**：求特征向量

对于 $\lambda_1 = 1$：

$$(A - I)\vec{v} = \begin{bmatrix} 1 & 1 \\ 1 & 1 \end{bmatrix}\vec{v} = \vec{0}$$

解得：$\vec{v}_1 = \begin{bmatrix} 1 \\ -1 \end{bmatrix}$（或它的倍数）

对于 $\lambda_2 = 3$：

$$(A - 3I)\vec{v} = \begin{bmatrix} -1 & 1 \\ 1 & -1 \end{bmatrix}\vec{v} = \vec{0}$$

解得：$\vec{v}_2 = \begin{bmatrix} 1 \\ 1 \end{bmatrix}$（或它的倍数）

## 特征值和特征向量的性质

### 性质 1：特征值的和

所有特征值的和等于矩阵的迹：

$$
\lambda_1 + \lambda_2 + \cdots + \lambda_n = \text{tr}(A)
$$


### 性质 2：特征值的积

所有特征值的积等于矩阵的行列式：

$$
\lambda_1 \lambda_2 \cdots \lambda_n = \det(A)
$$


### 性质 3：特征向量的线性无关性

不同特征值对应的特征向量线性无关。

### 性质 4：相似矩阵

如果 $B = P^{-1}AP$，则 $A$ 和 $B$ 有相同的特征值。

## 对角化

### 定义

如果 $n \times n$ 矩阵 $A$ 有 $n$ 个线性无关的特征向量，则 $A$ 可以**对角化**：

$$
A = PDP^{-1}
$$
其中：
- **$D$**：对角矩阵，对角线元素是 $A$ 的特征值
- **$P$**：列向量是 $A$ 的特征向量的矩阵

### 条件

矩阵 $A$ 可以对角化当且仅当 $A$ 有 $n$ 个线性无关的特征向量。

### 例子

**例子**：对角化矩阵 $A = \begin{bmatrix} 2 & 1 \\ 1 & 2 \end{bmatrix}$

从前面的例子，我们知道：
- 特征值：$\lambda_1 = 1$，$\lambda_2 = 3$
- 特征向量：$\vec{v}_1 = \begin{bmatrix} 1 \\ -1 \end{bmatrix}$，$\vec{v}_2 = \begin{bmatrix} 1 \\ 1 \end{bmatrix}$

$$
P = \begin{bmatrix} 1 & 1 \\ -1 & 1 \end{bmatrix}, \quad D = \begin{bmatrix} 1 & 0 \\ 0 & 3 \end{bmatrix}
$$


$$
P^{-1} = \frac{1}{2}\begin{bmatrix} 1 & -1 \\ 1 & 1 \end{bmatrix}
$$


验证：$A = PDP^{-1}$

## 应用

### 矩阵的幂

如果 $A = PDP^{-1}$，则：

$$A^k = PD^kP^{-1}$$

其中 $D^k$ 是对角矩阵，对角线元素是 $D$ 的对角线元素的 $k$ 次幂。

### 系统分析

特征值和特征向量在系统分析中应用广泛。

### 数据降维

主成分分析（PCA）使用特征值和特征向量进行数据降维。

## 生活中的应用

#### 物理

- ⚡ **量子力学**：量子力学中的本征值和本征态
- 🔬 **振动分析**：分析振动系统的固有频率

#### 工程

- ⚙️ **控制系统**：分析控制系统的稳定性
- 🏗️ **结构分析**：分析结构的固有频率

#### 数据科学

- 📊 **主成分分析**：用特征值和特征向量进行数据降维
- 🤖 **机器学习**：在机器学习中使用特征值和特征向量

## 常见错误

#### 错误 1：特征向量为零向量

特征向量必须是非零向量。

#### 错误 2：特征值计算错误

要仔细计算特征方程。

#### 错误 3：对角化条件

不是所有矩阵都可以对角化。

## 小练习

1. 求矩阵 $A = \begin{bmatrix} 3 & 1 \\ 0 & 2 \end{bmatrix}$ 的特征值和特征向量
2. 如果矩阵 $A$ 的特征值是 $\lambda_1 = 2$，$\lambda_2 = 3$，求 $\text{tr}(A)$ 和 $\det(A)$
3. 判断矩阵 $A = \begin{bmatrix} 1 & 1 \\ 0 & 1 \end{bmatrix}$ 是否可以对角化
4. 应用题：用特征值和特征向量分析系统的稳定性

---

> 💡 **小贴士**：特征值和特征向量是矩阵的重要性质。记住：$A\vec{v} = \lambda\vec{v}$，特征值的和等于迹，特征值的积等于行列式。掌握特征值和特征向量，你就能分析矩阵的特征！