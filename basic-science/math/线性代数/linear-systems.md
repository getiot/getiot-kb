---
sidebar_position: 8
slug: /linear-systems
---

# 线性方程组

线性方程组是线性代数的重要应用！掌握线性方程组的求解方法，是学习线性代数的关键。

## 什么是线性方程组？

**线性方程组**（System of Linear Equations）是多个线性方程的集合。

### 一般形式

一个 $m$ 个方程、$n$ 个未知数的线性方程组：

$$
\begin{cases}
a_{11}x_1 + a_{12}x_2 + \cdots + a_{1n}x_n = b_1 \\
a_{21}x_1 + a_{22}x_2 + \cdots + a_{2n}x_n = b_2 \\
\vdots \\
a_{m1}x_1 + a_{m2}x_2 + \cdots + a_{mn}x_n = b_m
\end{cases}
$$


### 矩阵形式

线性方程组可以写成矩阵形式：

$$
A\vec{x} = \vec{b}
$$
其中：
- **$A$**：系数矩阵
- **$\vec{x}$**：未知数向量
- **$\vec{b}$**：常数向量

## 线性方程组的解

### 解的个数

线性方程组可能有：

- **唯一解**：有且仅有一个解
- **无穷多解**：有无限多个解
- **无解**：没有解

### 判断方法

线性方程组 $A\vec{x} = \vec{b}$ 的解的情况：

- **唯一解**：$\text{rank}(A) = \text{rank}([A|\vec{b}]) = n$（未知数个数）
- **无穷多解**：$\text{rank}(A) = \text{rank}([A|\vec{b}]) < n$
- **无解**：$\text{rank}(A) < \text{rank}([A|\vec{b}])$

## 求解方法

### 方法 1：高斯消元法

**高斯消元法**（Gaussian Elimination）是通过初等行变换将增广矩阵化为行阶梯形，然后回代求解。

**步骤**：
1. 写出增广矩阵 $[A|\vec{b}]$
2. 通过初等行变换化为行阶梯形
3. 回代求解

**例子**：求解线性方程组
$$
\begin{cases}
x + 2y = 5 \\
3x + 4y = 11
\end{cases}
$$


**增广矩阵**：

$$
\begin{bmatrix}
1 & 2 & | & 5 \\
3 & 4 & | & 11
\end{bmatrix}
$$


**初等行变换**：

$$
\begin{bmatrix}
1 & 2 & | & 5 \\
0 & -2 & | & -4
\end{bmatrix} \to \begin{bmatrix}
1 & 2 & | & 5 \\
0 & 1 & | & 2
\end{bmatrix}
$$


**回代**：

从第二个方程：$y = 2$

代入第一个方程：$x + 2 \times 2 = 5$，所以 $x = 1$

**解**：$x = 1$，$y = 2$

### 方法 2：逆矩阵法

如果 $A$ 是 $n \times n$ 方阵且可逆，则：

$$
\vec{x} = A^{-1}\vec{b}
$$
**例子**：求解线性方程组
$$
\begin{cases}
x + 2y = 5 \\
3x + 4y = 11
\end{cases}
$$


**矩阵形式**：

$$
\begin{bmatrix} 1 & 2 \\ 3 & 4 \end{bmatrix} \begin{bmatrix} x \\ y \end{bmatrix} = \begin{bmatrix} 5 \\ 11 \end{bmatrix}
$$


**逆矩阵**：
$$
A^{-1} = \begin{bmatrix} -2 & 1 \\ \frac{3}{2} & -\frac{1}{2} \end{bmatrix}
$$


**解**：

$$
\begin{bmatrix} x \\ y \end{bmatrix} = \begin{bmatrix} -2 & 1 \\ \frac{3}{2} & -\frac{1}{2} \end{bmatrix} \begin{bmatrix} 5 \\ 11 \end{bmatrix} = \begin{bmatrix} 1 \\ 2 \end{bmatrix}
$$


### 方法 3：克莱默法则

**克莱默法则**（Cramer's Rule）使用行列式求解线性方程组。

对于线性方程组 $A\vec{x} = \vec{b}$，如果 $\det(A) \neq 0$，则：

$$
x_i = \frac{\det(A_i)}{\det(A)}
$$
其中 $A_i$ 是将 $A$ 的第 $i$ 列替换为 $\vec{b}$ 得到的矩阵。

**例子**：求解线性方程组

$$
\begin{cases}
x + 2y = 5 \\
3x + 4y = 11
\end{cases}
$$

$$
\det(A) = \begin{vmatrix} 1 & 2 \\ 3 & 4 \end{vmatrix} = -2
$$

$$
x = \frac{\begin{vmatrix} 5 & 2 \\ 11 & 4 \end{vmatrix}}{-2} = \frac{-2}{-2} = 1
$$

$$
y = \frac{\begin{vmatrix} 1 & 5 \\ 3 & 11 \end{vmatrix}}{-2} = \frac{-4}{-2} = 2
$$


## 齐次线性方程组

### 定义

**齐次线性方程组**是常数项全为 0 的线性方程组：
$$
A\vec{x} = \vec{0}
$$


### 性质

- **零解**：$\vec{x} = \vec{0}$ 总是解
- **非零解**：当 $\text{rank}(A) < n$ 时，有非零解

## 生活中的应用

#### 工程

- ⚙️ **电路分析**：分析电路网络
- 🏗️ **结构分析**：分析建筑和机械结构

#### 经济

- 💰 **经济模型**：分析经济模型
- 📊 **投入产出分析**：分析投入产出关系

#### 科学

- 🔬 **物理问题**：解决物理问题
- 🧪 **化学问题**：解决化学问题

## 常见错误

#### 错误 1：矩阵大小不匹配

要注意系数矩阵和常数向量的维度。

#### 错误 2：无解判断错误

要正确判断线性方程组是否有解。

#### 错误 3：计算错误

要仔细计算，注意符号。

## 小练习

1. 用高斯消元法求解：$\begin{cases} x + y = 3 \\ 2x - y = 1 \end{cases}$
2. 用逆矩阵法求解：$\begin{cases} 2x + y = 5 \\ x + 2y = 4 \end{cases}$
3. 用克莱默法则求解：$\begin{cases} x + 2y = 5 \\ 3x + 4y = 11 \end{cases}$
4. 应用题：一个工厂生产两种产品，已知生产关系和资源限制，建立线性方程组并求解

---

> 💡 **小贴士**：线性方程组是线性代数的重要应用。记住：可以用高斯消元法、逆矩阵法、克莱默法则求解。掌握线性方程组的求解方法，你就能解决很多实际问题！