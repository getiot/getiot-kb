---
sidebar_position: 6
slug: /multivariable-calculus
---

# 多元微积分

多元微积分是研究多元函数的微积分！理解多元微积分，能帮助我们解决多维空间的问题。

## 什么是多元微积分？

**多元微积分**（Multivariable Calculus）是研究多元函数（多个自变量的函数）的极限、导数、积分的数学分支。

### 简单理解

多元微积分就像"多维空间的微积分"：

- 研究多个变量的函数
- 推广一元微积分的概念
- 解决多维空间的问题

### 例子

**例子**：$f(x, y) = x^2 + y^2$

- 这是一个二元函数
- 输入：$(x, y)$（二维点）
- 输出：$f(x, y)$（一个数）

## 多元函数的极限

### 定义

如果当 $(x, y) \to (a, b)$ 时，$f(x, y) \to L$，则：

$$\lim_{(x, y) \to (a, b)} f(x, y) = L$$

### 注意

多元函数的极限比一元函数复杂，因为 $(x, y)$ 可以从任意方向接近 $(a, b)$。

### 例子

**例子**：$\lim_{(x, y) \to (0, 0)} \frac{xy}{x^2 + y^2}$

这个极限不存在，因为从不同方向接近 $(0, 0)$ 得到不同的值。

## 偏导数

### 定义

**偏导数**（Partial Derivative）是多元函数对某个变量的导数，其他变量视为常数。

函数 $f(x, y)$ 对 $x$ 的偏导数：

$$\frac{\partial f}{\partial x} = \lim_{h \to 0} \frac{f(x + h, y) - f(x, y)}{h}$$

函数 $f(x, y)$ 对 $y$ 的偏导数：

$$\frac{\partial f}{\partial y} = \lim_{h \to 0} \frac{f(x, y + h) - f(x, y)}{h}$$

### 表示方法

偏导数有多种表示方法：

- $\frac{\partial f}{\partial x}$（莱布尼茨记号）
- $f_x$（下标记号）
- $D_x f$（算子记号）

### 例子

**例子**：$f(x, y) = x^2 + 3xy + y^2$

- $\frac{\partial f}{\partial x} = 2x + 3y$（把 $y$ 看作常数）
- $\frac{\partial f}{\partial y} = 3x + 2y$（把 $x$ 看作常数）

## 全微分

### 定义

**全微分**（Total Differential）是多元函数在某个点的线性近似。

如果 $z = f(x, y)$，则全微分：

$$dz = \frac{\partial f}{\partial x} dx + \frac{\partial f}{\partial y} dy$$

### 几何意义

全微分是函数在某个点的切平面的增量。

## 链式法则（多元）

### 公式

如果 $z = f(x, y)$，且 $x = g(t)$，$y = h(t)$，则：

$$\frac{dz}{dt} = \frac{\partial f}{\partial x} \frac{dx}{dt} + \frac{\partial f}{\partial y} \frac{dy}{dt}$$

### 例子

**例子**：$z = x^2 + y^2$，$x = t$，$y = t^2$

- $\frac{\partial z}{\partial x} = 2x = 2t$
- $\frac{\partial z}{\partial y} = 2y = 2t^2$
- $\frac{dx}{dt} = 1$
- $\frac{dy}{dt} = 2t$
- $\frac{dz}{dt} = 2t \times 1 + 2t^2 \times 2t = 2t + 4t^3$

## 方向导数

### 定义

**方向导数**（Directional Derivative）是函数在某个方向上的变化率。

函数 $f(x, y)$ 在点 $(a, b)$ 沿单位向量 $\vec{u} = (u_1, u_2)$ 的方向导数：

$$D_{\vec{u}} f(a, b) = \frac{\partial f}{\partial x}(a, b) u_1 + \frac{\partial f}{\partial y}(a, b) u_2$$

### 梯度

**梯度**（Gradient）是一个向量，其分量是函数的偏导数：

$$\nabla f = \left(\frac{\partial f}{\partial x}, \frac{\partial f}{\partial y}\right)$$

方向导数可以用梯度表示：

$$D_{\vec{u}} f = \nabla f \cdot \vec{u}$$

## 多元函数的极值

### 临界点

**临界点**是偏导数都为 0 的点。

### 判别法

对于函数 $f(x, y)$，设：

$$D = f_{xx} f_{yy} - (f_{xy})^2$$

在临界点 $(a, b)$ 处：

- 如果 $D > 0$ 且 $f_{xx} > 0$，则 $f$ 在 $(a, b)$ 处有极小值
- 如果 $D > 0$ 且 $f_{xx} < 0$，则 $f$ 在 $(a, b)$ 处有极大值
- 如果 $D < 0$，则 $f$ 在 $(a, b)$ 处有鞍点
- 如果 $D = 0$，则无法判断

## 重积分

### 二重积分

**二重积分**（Double Integral）是二元函数在区域上的积分。

$$\iint_D f(x, y) dA = \iint_D f(x, y) dx dy$$

### 几何意义

二重积分表示函数 $f(x, y)$ 在区域 $D$ 上的**体积**（如果 $f(x, y) \ge 0$）。

### 计算方法

#### 累次积分

$$\iint_D f(x, y) dA = \int_a^b \left[\int_{g_1(x)}^{g_2(x)} f(x, y) dy\right] dx$$

或

$$\iint_D f(x, y) dA = \int_c^d \left[\int_{h_1(y)}^{h_2(y)} f(x, y) dx\right] dy$$

**例子**：$\iint_D (x + y) dA$，其中 $D$ 是 $0 \le x \le 1$，$0 \le y \le 2$

$$\iint_D (x + y) dA = \int_0^1 \left[\int_0^2 (x + y) dy\right] dx$$

$$= \int_0^1 \left[xy + \frac{y^2}{2}\right]_0^2 dx = \int_0^1 (2x + 2) dx = \left[x^2 + 2x\right]_0^1 = 3$$

### 三重积分

**三重积分**（Triple Integral）是三元函数在区域上的积分。

$$\iiint_V f(x, y, z) dV = \iiint_V f(x, y, z) dx dy dz$$

## 生活中的应用

### 物理

- ⚡ **场论**：描述电场、磁场
- 🔬 **流体力学**：描述流体的运动

### 工程

- 🏗️ **结构分析**：分析多维结构
- ⚙️ **优化设计**：多维优化问题

### 科学

- 🔬 **多变量系统**：分析多变量系统
- 📊 **数据分析**：多维数据分析

## 常见错误

### 错误 1：偏导数和全导数混淆

- **偏导数**：对某个变量求导，其他变量视为常数
- **全导数**：所有变量都变化时的导数

### 错误 2：积分顺序错误

计算重积分时，要注意积分的顺序。

### 错误 3：区域确定错误

要正确确定积分区域。

## 小练习

1. 求 $f(x, y) = x^2 + 2xy + y^2$ 的偏导数 $\frac{\partial f}{\partial x}$ 和 $\frac{\partial f}{\partial y}$
2. 计算 $\iint_D xy dA$，其中 $D$ 是 $0 \le x \le 2$，$0 \le y \le 1$
3. 求函数 $f(x, y) = x^2 + y^2$ 在点 $(1, 1)$ 处的梯度
4. 应用题：一个矩形的长和宽分别是 $x$ 和 $y$，面积是 $xy$，如果 $x$ 和 $y$ 都变化，如何用全微分近似面积的变化？

---

> 💡 **小贴士**：多元微积分是研究多元函数的微积分。记住：偏导数是把其他变量看作常数，重积分是计算多维区域的累积值。掌握多元微积分，你就能解决多维空间的问题！