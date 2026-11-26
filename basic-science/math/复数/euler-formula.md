---
sidebar_position: 6
slug: /euler-formula
---

# 欧拉公式

欧拉公式是数学中最美丽的公式之一！它连接了指数函数、三角函数和复数。

## 什么是欧拉公式？

**欧拉公式**（Euler's Formula）是：

$$e^{i\theta} = \cos \theta + i \sin \theta$$

### 简单理解

欧拉公式就像"把指数和三角函数连接起来"：

- 左边：指数函数 $e^{i\theta}$
- 右边：三角函数 $\cos \theta + i \sin \theta$
- 通过虚数单位 $i$ 连接

### 历史背景

欧拉公式由瑞士数学家莱昂哈德·欧拉（Leonhard Euler）在 18 世纪提出，被认为是数学中最美丽的公式之一。

## 欧拉公式的推导

### 方法 1：泰勒级数

**指数函数的泰勒级数**：

$$e^x = 1 + x + \frac{x^2}{2!} + \frac{x^3}{3!} + \frac{x^4}{4!} + \cdots$$

**正弦函数的泰勒级数**：

$$\sin x = x - \frac{x^3}{3!} + \frac{x^5}{5!} - \frac{x^7}{7!} + \cdots$$

**余弦函数的泰勒级数**：

$$\cos x = 1 - \frac{x^2}{2!} + \frac{x^4}{4!} - \frac{x^6}{6!} + \cdots$$

将 $x = i\theta$ 代入 $e^x$ 的泰勒级数：

$$e^{i\theta} = 1 + i\theta + \frac{(i\theta)^2}{2!} + \frac{(i\theta)^3}{3!} + \frac{(i\theta)^4}{4!} + \cdots$$

利用 $i^2 = -1$，$i^3 = -i$，$i^4 = 1$，整理得：

$$e^{i\theta} = \left(1 - \frac{\theta^2}{2!} + \frac{\theta^4}{4!} - \cdots\right) + i\left(\theta - \frac{\theta^3}{3!} + \frac{\theta^5}{5!} - \cdots\right)$$

$$= \cos \theta + i \sin \theta$$

### 方法 2：微分方程

考虑函数 $f(\theta) = e^{-i\theta}(\cos \theta + i \sin \theta)$

求导：

$$f'(\theta) = -i e^{-i\theta}(\cos \theta + i \sin \theta) + e^{-i\theta}(-\sin \theta + i \cos \theta)$$

$$= e^{-i\theta}[(-i \cos \theta + \sin \theta) + (-\sin \theta + i \cos \theta)] = 0$$

所以 $f(\theta)$ 是常数。

当 $\theta = 0$ 时，$f(0) = 1$，所以 $f(\theta) = 1$。

因此：

$$e^{-i\theta}(\cos \theta + i \sin \theta) = 1$$

即：

$$e^{i\theta} = \cos \theta + i \sin \theta$$

## 欧拉恒等式

### 定义

当 $\theta = \pi$ 时，欧拉公式变成**欧拉恒等式**（Euler's Identity）：

$$e^{i\pi} + 1 = 0$$

或

$$e^{i\pi} = -1$$

### 意义

欧拉恒等式连接了数学中最重要的五个数：

- $e$：自然常数
- $i$：虚数单位
- $\pi$：圆周率
- $1$：单位元
- $0$：零元

## 欧拉公式的性质

### 周期性

$$e^{i(\theta + 2\pi)} = e^{i\theta} e^{i2\pi} = e^{i\theta} (\cos 2\pi + i \sin 2\pi) = e^{i\theta}$$

所以 $e^{i\theta}$ 是周期函数，周期为 $2\pi$。

### 模和幅角

$$|e^{i\theta}| = \sqrt{\cos^2 \theta + \sin^2 \theta} = 1$$

$$\arg(e^{i\theta}) = \theta$$

所以 $e^{i\theta}$ 在复平面上是单位圆上的点。

### 共轭

$$\overline{e^{i\theta}} = \cos \theta - i \sin \theta = e^{-i\theta}$$

### 乘法

$$e^{i\theta_1} e^{i\theta_2} = e^{i(\theta_1 + \theta_2)}$$

这对应复数的乘法：模相乘，幅角相加。

### 除法

$$\frac{e^{i\theta_1}}{e^{i\theta_2}} = e^{i(\theta_1 - \theta_2)}$$

这对应复数的除法：模相除，幅角相减。

### 幂

$$(e^{i\theta})^n = e^{in\theta}$$

这对应复数的幂：模的 $n$ 次幂，幅角的 $n$ 倍。

## 欧拉公式的应用

### 复数的极坐标形式

复数 $z = a + bi$ 可以写成：

$$z = |z| e^{i\theta} = r e^{i\theta}$$

其中 $r = |z|$，$\theta = \arg(z)$。

### 三角函数的表示

**正弦函数**：

$$\sin \theta = \frac{e^{i\theta} - e^{-i\theta}}{2i}$$

**余弦函数**：

$$\cos \theta = \frac{e^{i\theta} + e^{-i\theta}}{2}$$

### 复数的运算

使用欧拉公式，复数的运算变得更简单：

- **乘法**：$z_1 z_2 = r_1 r_2 e^{i(\theta_1 + \theta_2)}$
- **除法**：$\frac{z_1}{z_2} = \frac{r_1}{r_2} e^{i(\theta_1 - \theta_2)}$
- **幂**：$z^n = r^n e^{in\theta}$
- **根**：$\sqrt[n]{z} = \sqrt[n]{r} e^{i(\theta + 2k\pi)/n}$

### 傅里叶变换

欧拉公式在傅里叶变换中有重要应用：

$$e^{i\omega t} = \cos(\omega t) + i \sin(\omega t)$$

### 波动方程

欧拉公式用于表示波动：

$$e^{i(kx - \omega t)} = \cos(kx - \omega t) + i \sin(kx - \omega t)$$

## 生活中的应用

### 物理

- ⚡ **电路分析**：分析交流电路的相位关系
- 🔬 **量子力学**：表示量子态的波函数
- 🌊 **波动**：表示波的振幅和相位

### 工程

- 📡 **信号处理**：分析信号的频率和相位
- 🏗️ **控制理论**：分析系统的稳定性

### 数学

- 📐 **复分析**：研究复变函数的性质
- 🔢 **数论**：解析数论

## 常见错误

### 错误 1：指数运算错误

记住：$e^{i\theta}$ 的模是 1，不是 $e^\theta$。

### 错误 2：角度单位混淆

要注意角度是用弧度还是度数。

### 错误 3：周期性忽略

要注意 $e^{i\theta}$ 的周期性，$e^{i(\theta + 2k\pi)} = e^{i\theta}$。

## 小练习

1. 用欧拉公式表示 $e^{i\pi/2}$
2. 用欧拉公式表示 $e^{i\pi}$
3. 计算 $(1 + i)^4$（使用欧拉公式）
4. 应用题：在电路分析中，如何用欧拉公式表示交流电压？

---

> 💡 **小贴士**：欧拉公式 $e^{i\theta} = \cos \theta + i \sin \theta$ 是数学中最美丽的公式之一。记住：$e^{i\pi} = -1$，$|e^{i\theta}| = 1$。掌握欧拉公式，你就能更好地理解复数和三角函数！