---
sidebar_position: 6
slug: /number-theory
---

# 数论基础

数论是研究整数的性质和关系的数学分支！从密码学到编码理论，从算法设计到计算机科学，数论无处不在。

## 什么是数论？

**数论**（Number Theory）是研究整数的性质和关系的数学分支。

### 简单理解

数论就像"研究整数的秘密"：

- 整数的整除性
- 素数的性质
- 同余关系
- 最大公约数和最小公倍数

## 整除

### 定义

如果存在整数 $q$，使得 $b = aq$，则称 $a$ **整除** $b$，记作 $a \mid b$。

如果 $a$ 不整除 $b$，记作 $a \nmid b$。

### 性质

- 如果 $a \mid b$ 且 $b \mid c$，则 $a \mid c$
- 如果 $a \mid b$ 且 $a \mid c$，则 $a \mid (bx + cy)$（$x, y$ 是整数）
- 如果 $a \mid b$ 且 $b \mid a$，则 $a = \pm b$

## 最大公约数

### 定义

**最大公约数**（Greatest Common Divisor，GCD）$d = \gcd(a, b)$ 是同时整除 $a$ 和 $b$ 的最大正整数。

### 性质

- $\gcd(a, b) = \gcd(b, a)$
- $\gcd(a, b) = \gcd(a, b - ka)$（$k$ 是整数）
- $\gcd(a, 0) = |a|$

### 欧几里得算法

**欧几里得算法**（Euclidean Algorithm）用于计算最大公约数：

$$\gcd(a, b) = \gcd(b, a \bmod b)$$

**算法**：
1. 如果 $b = 0$，则 $\gcd(a, b) = a$
2. 否则，$\gcd(a, b) = \gcd(b, a \bmod b)$

**例子**：$\gcd(48, 18)$

- $\gcd(48, 18) = \gcd(18, 48 \bmod 18) = \gcd(18, 12)$
- $\gcd(18, 12) = \gcd(12, 18 \bmod 12) = \gcd(12, 6)$
- $\gcd(12, 6) = \gcd(6, 12 \bmod 6) = \gcd(6, 0) = 6$

### 扩展欧几里得算法

**扩展欧几里得算法**（Extended Euclidean Algorithm）不仅计算 $\gcd(a, b)$，还找到 $x, y$，使得：

$$ax + by = \gcd(a, b)$$

**应用**：求解线性同余方程 $ax \equiv b \pmod{m}$

## 最小公倍数

### 定义

**最小公倍数**（Least Common Multiple，LCM）$l = \text{lcm}(a, b)$ 是同时被 $a$ 和 $b$ 整除的最小正整数。

### 关系

$$\gcd(a, b) \times \text{lcm}(a, b) = |ab|$$

**例子**：$\gcd(12, 18) = 6$，$\text{lcm}(12, 18) = 36$，$6 \times 36 = 12 \times 18 = 216$

## 素数

### 定义

**素数**（Prime Number）是大于 1 且只能被 1 和自身整除的正整数。

**合数**（Composite Number）是大于 1 且不是素数的正整数。

### 性质

- 除了 2，所有素数都是奇数
- 有无限多个素数（欧几里得证明）
- 每个大于 1 的整数都可以唯一分解为素数的乘积（算术基本定理）

### 素性测试

#### 试除法

**试除法**是检查 $n$ 是否是素数的最简单方法：检查 $n$ 是否能被 $2$ 到 $\sqrt{n}$ 之间的整数整除。

**复杂度**：$O(\sqrt{n})$

#### 费马小定理

**费马小定理**：如果 $p$ 是素数，$a$ 不是 $p$ 的倍数，则：

$$a^{p-1} \equiv 1 \pmod{p}$$

**注意**：这是必要但不充分条件。

#### 米勒-拉宾素性测试

**米勒-拉宾素性测试**（Miller-Rabin Primality Test）是概率性素性测试算法。

## 同余

### 定义

如果 $a - b$ 能被 $m$ 整除，则称 $a$ 和 $b$ **模 $m$ 同余**，记作：

$$a \equiv b \pmod{m}$$

### 性质

- $a \equiv a \pmod{m}$（自反性）
- 如果 $a \equiv b \pmod{m}$，则 $b \equiv a \pmod{m}$（对称性）
- 如果 $a \equiv b \pmod{m}$ 且 $b \equiv c \pmod{m}$，则 $a \equiv c \pmod{m}$（传递性）

### 运算

- 如果 $a \equiv b \pmod{m}$ 且 $c \equiv d \pmod{m}$，则：
  - $a + c \equiv b + d \pmod{m}$
  - $a - c \equiv b - d \pmod{m}$
  - $ac \equiv bd \pmod{m}$
  - 如果 $\gcd(c, m) = 1$，则 $ac \equiv bc \pmod{m}$ 蕴含 $a \equiv b \pmod{m}$

### 同余方程

**线性同余方程**：$ax \equiv b \pmod{m}$

**解的存在性**：方程有解当且仅当 $\gcd(a, m) \mid b$

**解法**：使用扩展欧几里得算法

**例子**：求解 $3x \equiv 4 \pmod{7}$

- $\gcd(3, 7) = 1$，所以有解
- $3x \equiv 4 \pmod{7}$ 等价于 $3x + 7y = 4$
- 使用扩展欧几里得算法：$3 \times (-2) + 7 \times 1 = 1$
- 所以 $3 \times (-8) + 7 \times 4 = 4$
- 因此 $x \equiv -8 \equiv 6 \pmod{7}$

### 中国剩余定理

**中国剩余定理**（Chinese Remainder Theorem）用于求解同余方程组：

$$\begin{cases}
x \equiv a_1 \pmod{m_1} \\
x \equiv a_2 \pmod{m_2} \\
\vdots \\
x \equiv a_n \pmod{m_n}
\end{cases}$$

如果 $m_1, m_2, \ldots, m_n$ 两两互质，则方程组有唯一解模 $m_1 m_2 \cdots m_n$。

## 欧拉函数

### 定义

**欧拉函数**（Euler's Totient Function）$\phi(n)$ 是小于 $n$ 且与 $n$ 互质的正整数的个数。

### 性质

- 如果 $p$ 是素数，则 $\phi(p) = p - 1$
- 如果 $p$ 是素数，则 $\phi(p^k) = p^k - p^{k-1}$
- 如果 $\gcd(m, n) = 1$，则 $\phi(mn) = \phi(m) \phi(n)$

### 欧拉定理

**欧拉定理**：如果 $\gcd(a, n) = 1$，则：

$$a^{\phi(n)} \equiv 1 \pmod{n}$$

这是费马小定理的推广。

## 数论的应用

### 密码学

- 🔐 **RSA加密**：基于大数分解的困难性
- 🔒 **公钥密码**：基于数论的密码系统

### 计算机科学

- 💻 **算法设计**：数论算法
- 🔢 **哈希函数**：基于数论的哈希函数

### 编码理论

- 📡 **错误纠正码**：基于数论的编码
- 🔗 **校验和**：基于数论的校验

## 常见错误

### 错误 1：整除和同余混淆

- **整除**：$a \mid b$ 表示 $a$ 整除 $b$
- **同余**：$a \equiv b \pmod{m}$ 表示 $a$ 和 $b$ 模 $m$ 同余

### 错误 2：最大公约数计算错误

要正确使用欧几里得算法。

### 错误 3：同余方程求解错误

要注意同余方程解的存在性和唯一性。

## 小练习

1. 计算 $\gcd(123, 456)$
2. 判断 17 是否是素数
3. 求解 $5x \equiv 3 \pmod{7}$
4. 应用题：在RSA加密中，如何选择两个大素数？

---

> 💡 **小贴士**：数论是研究整数的性质和关系的数学分支。记住：$\gcd(a, b) \times \text{lcm}(a, b) = |ab|$，欧拉定理 $a^{\phi(n)} \equiv 1 \pmod{n}$（当 $\gcd(a, n) = 1$）。掌握数论，你就能理解密码学和编码理论！