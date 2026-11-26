---
sidebar_position: 2
slug: /complex-number-basics
---

# 复数的基本概念

理解复数的基本概念，是学习复数的第一步！

## 什么是复数？

**复数**（Complex Number）是形如 $a + bi$ 的数，其中 $a$ 和 $b$ 是实数，$i$ 是虚数单位。

### 虚数单位

**虚数单位** $i$ 定义为：

$$i^2 = -1$$

因此：

$$i = \sqrt{-1}$$

### 复数的形式

复数 $z$ 的一般形式：

$$z = a + bi$$

其中：
- $a$ 是**实部**（Real Part），记作 $\text{Re}(z) = a$
- $b$ 是**虚部**（Imaginary Part），记作 $\text{Im}(z) = b$

### 例子

**例子 1**：$z = 3 + 4i$

- 实部：$\text{Re}(z) = 3$
- 虚部：$\text{Im}(z) = 4$

**例子 2**：$z = -2 + 5i$

- 实部：$\text{Re}(z) = -2$
- 虚部：$\text{Im}(z) = 5$

**例子 3**：$z = 7$（纯实数）

- 实部：$\text{Re}(z) = 7$
- 虚部：$\text{Im}(z) = 0$
- 可以写成：$z = 7 + 0i$

**例子 4**：$z = 3i$（纯虚数）

- 实部：$\text{Re}(z) = 0$
- 虚部：$\text{Im}(z) = 3$
- 可以写成：$z = 0 + 3i$

## 复数的分类

### 实数

如果 $b = 0$，则 $z = a$ 是**实数**（Real Number）。

所有实数都是复数（虚部为 0）。

### 虚数

如果 $b \neq 0$，则 $z = a + bi$ 是**虚数**（Imaginary Number）。

### 纯虚数

如果 $a = 0$ 且 $b \neq 0$，则 $z = bi$ 是**纯虚数**（Pure Imaginary Number）。

## 复数的相等

两个复数 $z_1 = a_1 + b_1 i$ 和 $z_2 = a_2 + b_2 i$ **相等**当且仅当：

$$a_1 = a_2 \quad \text{且} \quad b_1 = b_2$$

即实部和虚部分别相等。

## 共轭复数

### 定义

复数 $z = a + bi$ 的**共轭复数**（Conjugate）是：

$$\bar{z} = a - bi$$

即保持实部不变，虚部取相反数。

### 性质

- $\overline{\bar{z}} = z$
- $\overline{z_1 + z_2} = \bar{z_1} + \bar{z_2}$
- $\overline{z_1 z_2} = \bar{z_1} \bar{z_2}$
- $\overline{\left(\frac{z_1}{z_2}\right)} = \frac{\bar{z_1}}{\bar{z_2}}$

### 例子

**例子**：$z = 3 + 4i$

$$\bar{z} = 3 - 4i$$

## 复数的模

### 定义

复数 $z = a + bi$ 的**模**（Modulus）或**绝对值**是：

$$|z| = \sqrt{a^2 + b^2}$$

### 几何意义

模表示复数在复平面上到原点的距离。

### 性质

- $|z| \ge 0$，且 $|z| = 0$ 当且仅当 $z = 0$
- $|z_1 z_2| = |z_1| |z_2|$
- $\left|\frac{z_1}{z_2}\right| = \frac{|z_1|}{|z_2|}$（$z_2 \neq 0$）
- $|z|^2 = z \bar{z}$

### 例子

**例子**：$z = 3 + 4i$

$$|z| = \sqrt{3^2 + 4^2} = \sqrt{9 + 16} = \sqrt{25} = 5$$

## 复数的幅角

### 定义

复数 $z = a + bi$（$z \neq 0$）的**幅角**（Argument）$\theta$ 是：

$$\theta = \arg(z) = \arctan\left(\frac{b}{a}\right)$$

通常取 $-\pi < \theta \le \pi$（主值）。

### 几何意义

幅角表示复数在复平面上与正实轴的夹角。

### 例子

**例子**：$z = 1 + i$

$$\theta = \arg(z) = \arctan\left(\frac{1}{1}\right) = \arctan(1) = \frac{\pi}{4}$$

## 复数的极坐标形式

### 定义

复数 $z = a + bi$ 可以写成**极坐标形式**：

$$z = r(\cos \theta + i \sin \theta) = r e^{i\theta}$$

其中：
- $r = |z| = \sqrt{a^2 + b^2}$ 是模
- $\theta = \arg(z)$ 是幅角

### 转换公式

从代数形式到极坐标形式：

$$r = \sqrt{a^2 + b^2}, \quad \theta = \arctan\left(\frac{b}{a}\right)$$

从极坐标形式到代数形式：

$$a = r \cos \theta, \quad b = r \sin \theta$$

### 例子

**例子**：$z = 1 + i$

- $r = \sqrt{1^2 + 1^2} = \sqrt{2}$
- $\theta = \frac{\pi}{4}$

所以：

$$z = \sqrt{2}\left(\cos\frac{\pi}{4} + i\sin\frac{\pi}{4}\right) = \sqrt{2} e^{i\pi/4}$$

## 生活中的应用

### 物理

- ⚡ **电路分析**：分析交流电路
- 🔬 **量子力学**：描述量子态

### 工程

- 📡 **信号处理**：处理信号和波形
- 🏗️ **控制理论**：分析控制系统

## 常见错误

### 错误 1：虚数单位计算错误

记住：$i^2 = -1$，$i^3 = -i$，$i^4 = 1$，然后循环。

### 错误 2：模的计算错误

模是 $\sqrt{a^2 + b^2}$，不是 $a + b$。

### 错误 3：幅角的范围错误

要注意幅角的主值范围是 $-\pi < \theta \le \pi$。

## 小练习

1. 写出复数 $z = -3 + 4i$ 的实部、虚部、共轭复数和模
2. 将 $z = 1 + \sqrt{3}i$ 写成极坐标形式
3. 计算 $|3 + 4i|$
4. 应用题：在电路分析中，如何用复数表示交流电压？

---

> 💡 **小贴士**：复数是形如 $a + bi$ 的数，其中 $i^2 = -1$。记住：模 $|z| = \sqrt{a^2 + b^2}$，共轭复数 $\bar{z} = a - bi$。掌握复数的基本概念，你就能进行复数的运算！