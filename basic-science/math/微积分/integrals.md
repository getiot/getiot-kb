---
sidebar_position: 4
slug: /integrals
---

# 积分

积分是微积分的另一个核心概念！理解积分，能帮助我们计算面积、体积和解决累积问题。

## 什么是积分？

**积分**（Integral）是导数的逆运算，用于计算函数的累积效果。

### 简单理解

积分就像"累积求和"：

- 把函数值"累积"起来
- 可以计算曲线下的面积
- 可以计算体积、质量等累积量

### 定积分和不定积分

- **不定积分**：求原函数（反导数）
- **定积分**：计算函数在区间上的累积值

## 不定积分

### 定义

**不定积分**（Indefinite Integral）是求导数的逆运算。

如果 $F'(x) = f(x)$，则：

$$\int f(x) dx = F(x) + C$$

其中 $C$ 是常数（积分常数）。

### 性质

- $\int [f(x) + g(x)] dx = \int f(x) dx + \int g(x) dx$
- $\int k f(x) dx = k \int f(x) dx$（$k$ 是常数）

## 基本积分公式

### 幂函数

$$\int x^n dx = \frac{x^{n+1}}{n+1} + C \quad (n \neq -1)$$

**例子**：
- $\int x^2 dx = \frac{x^3}{3} + C$
- $\int x dx = \frac{x^2}{2} + C$
- $\int dx = x + C$

### 指数函数

$$\int e^x dx = e^x + C$$

$$\int a^x dx = \frac{a^x}{\ln a} + C \quad (a > 0, a \neq 1)$$

### 对数函数

$$\int \frac{1}{x} dx = \ln |x| + C$$

### 三角函数

- $\int \sin x dx = -\cos x + C$
- $\int \cos x dx = \sin x + C$
- $\int \sec^2 x dx = \tan x + C$
- $\int \csc^2 x dx = -\cot x + C$

## 定积分

### 定义

**定积分**（Definite Integral）是函数在区间 $[a, b]$ 上的累积值。

$$\int_a^b f(x) dx = \lim_{n \to \infty} \sum_{i=1}^{n} f(\xi_i) \Delta x_i$$

其中 $\Delta x_i$ 是区间的分割，$\xi_i$ 是每个小区间内的点。

### 几何意义

定积分 $\int_a^b f(x) dx$ 表示函数 $f(x)$ 在区间 $[a, b]$ 上的**曲线下的面积**。

- 如果 $f(x) \ge 0$，则定积分是曲线下的面积
- 如果 $f(x) < 0$，则定积分是曲线上的面积的负值

### 牛顿-莱布尼茨公式

如果 $F'(x) = f(x)$，则：

$$\int_a^b f(x) dx = F(b) - F(a) = F(x)\Big|_a^b$$

**例子**：$\int_0^2 x^2 dx$

- $F(x) = \frac{x^3}{3}$（因为 $F'(x) = x^2$）
- $\int_0^2 x^2 dx = F(2) - F(0) = \frac{2^3}{3} - \frac{0^3}{3} = \frac{8}{3}$

## 积分的性质

### 性质 1：区间可加性

$$\int_a^b f(x) dx = \int_a^c f(x) dx + \int_c^b f(x) dx$$

### 性质 2：区间反转

$$\int_a^b f(x) dx = -\int_b^a f(x) dx$$

### 性质 3：常数倍

$$\int_a^b k f(x) dx = k \int_a^b f(x) dx$$

### 性质 4：和差

$$\int_a^b [f(x) \pm g(x)] dx = \int_a^b f(x) dx \pm \int_a^b g(x) dx$$

## 换元积分法

### 第一类换元法（凑微分）

如果 $\int f(u) du = F(u) + C$，且 $u = g(x)$，则：

$$\int f(g(x)) g'(x) dx = F(g(x)) + C$$

**例子**：$\int 2x e^{x^2} dx$

- 设 $u = x^2$，则 $du = 2x dx$
- $\int 2x e^{x^2} dx = \int e^u du = e^u + C = e^{x^2} + C$

### 第二类换元法

如果 $x = g(t)$，则：

$$\int f(x) dx = \int f(g(t)) g'(t) dt$$

## 分部积分法

### 公式

$$\int u dv = uv - \int v du$$

或

$$\int f(x) g'(x) dx = f(x) g(x) - \int f'(x) g(x) dx$$

### 例子

**例子**：$\int x e^x dx$

- 设 $u = x$，$dv = e^x dx$
- 则 $du = dx$，$v = e^x$
- $\int x e^x dx = x e^x - \int e^x dx = x e^x - e^x + C = e^x(x - 1) + C$

## 积分的应用

### 应用 1：计算面积

曲线 $y = f(x)$ 在区间 $[a, b]$ 上的面积：

$$S = \int_a^b |f(x)| dx$$

### 应用 2：计算体积

曲线 $y = f(x)$ 绕 $x$ 轴旋转形成的旋转体体积：

$$V = \pi \int_a^b [f(x)]^2 dx$$

### 应用 3：物理应用

- **位移**：速度对时间的积分是位移
- **功**：力对位移的积分是功

## 生活中的应用

### 物理

- ⚡ **运动学**：计算位移、功、能量
- 🔬 **力学**：计算力、动量

### 工程

- 🏗️ **结构分析**：计算面积、体积
- ⚙️ **系统分析**：计算累积效果

### 经济

- 💰 **成本分析**：计算总成本
- 📈 **收益分析**：计算总收益

## 常见错误

### 错误 1：积分常数遗漏

不定积分要加上积分常数 $C$。

### 错误 2：定积分计算错误

使用牛顿-莱布尼茨公式时，要注意 $F(b) - F(a)$。

### 错误 3：换元法使用错误

使用换元法时，要注意变量的替换和积分限的变化。

## 小练习

1. 求 $\int x^3 dx$
2. 求 $\int \sin x dx$
3. 计算 $\int_0^1 x^2 dx$
4. 应用题：一个物体的速度函数是 $v(t) = 3t^2 + 2t$，求 $t = 0$ 到 $t = 2$ 的位移

---

> 💡 **小贴士**：积分是导数的逆运算。记住：$\int x^n dx = \frac{x^{n+1}}{n+1} + C$，$\int e^x dx = e^x + C$，$\int \sin x dx = -\cos x + C$。掌握积分的计算，你就能计算面积、体积和累积量！