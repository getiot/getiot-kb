---
sidebar_position: 6
slug: /inverse-trigonometric-functions
---

# 反三角函数

反三角函数是三角函数的反函数！理解反三角函数，能帮助我们解决"已知函数值求角度"的问题。

## 什么是反三角函数？

**反三角函数**（Inverse Trigonometric Functions）是三角函数的反函数，用于根据三角函数值求角度。

简单来说，反三角函数就像"反过来"：

- 三角函数：已知角度，求函数值
- 反三角函数：已知函数值，求角度

反三角函数通常用 $\arcsin$、$\arccos$、$\arctan$ 等表示，也可以用 $\sin^{-1}$、$\cos^{-1}$、$\tan^{-1}$ 表示。

**注意**：$\sin^{-1}x$ 表示反三角函数，不是 $\frac{1}{\sin x}$。

## 反正弦函数（Arcsine）

### 定义

**反正弦函数**（Arcsine Function）记作 $\arcsin x$ 或 $\sin^{-1}x$，定义为：

$$
y = \arcsin x \Leftrightarrow x = \sin y
$$
其中 $y \in [-\frac{\pi}{2}, \frac{\pi}{2}]$，$x \in [-1, 1]$。

### 性质

- **定义域**：$[-1, 1]$
- **值域**：$[-\frac{\pi}{2}, \frac{\pi}{2}]$
- **单调性**：单调递增
- **奇函数**：$\arcsin(-x) = -\arcsin x$

### 例子

**例子 1**：$\arcsin\left(\frac{1}{2}\right) = \frac{\pi}{6}$（或 $30°$）

因为 $\sin\left(\frac{\pi}{6}\right) = \frac{1}{2}$。

**例子 2**：$\arcsin\left(\frac{\sqrt{2}}{2}\right) = \frac{\pi}{4}$（或 $45°$）

因为 $\sin\left(\frac{\pi}{4}\right) = \frac{\sqrt{2}}{2}$。

## 反余弦函数（Arccosine）

### 定义

**反余弦函数**（Arccosine Function）记作 $\arccos x$ 或 $\cos^{-1}x$，定义为：

$$
y = \arccos x \Leftrightarrow x = \cos y
$$
其中 $y \in [0, \pi]$，$x \in [-1, 1]$。

### 性质

- **定义域**：$[-1, 1]$
- **值域**：$[0, \pi]$
- **单调性**：单调递减

### 例子

**例子 1**：$\arccos\left(\frac{1}{2}\right) = \frac{\pi}{3}$（或 $60°$）

因为 $\cos\left(\frac{\pi}{3}\right) = \frac{1}{2}$。

**例子 2**：$\arccos\left(\frac{\sqrt{2}}{2}\right) = \frac{\pi}{4}$（或 $45°$）

因为 $\cos\left(\frac{\pi}{4}\right) = \frac{\sqrt{2}}{2}$。

## 反正切函数（Arctangent）

### 定义

**反正切函数**（Arctangent Function）记作 $\arctan x$ 或 $\tan^{-1}x$，定义为：

$$
y = \arctan x \Leftrightarrow x = \tan y
$$
其中 $y \in (-\frac{\pi}{2}, \frac{\pi}{2})$，$x \in (-\infty, +\infty)$。

### 性质

- **定义域**：所有实数
- **值域**：$(-\frac{\pi}{2}, \frac{\pi}{2})$
- **单调性**：单调递增
- **奇函数**：$\arctan(-x) = -\arctan x$

### 例子

**例子 1**：$\arctan(1) = \frac{\pi}{4}$（或 $45°$）

因为 $\tan\left(\frac{\pi}{4}\right) = 1$。

**例子 2**：$\arctan\left(\frac{\sqrt{3}}{3}\right) = \frac{\pi}{6}$（或 $30°$）

因为 $\tan\left(\frac{\pi}{6}\right) = \frac{\sqrt{3}}{3}$。

## 反余切函数（Arccotangent）

### 定义

**反余切函数**（Arccotangent Function）记作 $\text{arccot } x$ 或 $\cot^{-1}x$，定义为：

$$
y = \text{arccot } x \Leftrightarrow x = \cot y
$$
其中 $y \in (0, \pi)$，$x \in (-\infty, +\infty)$。

### 性质

- **定义域**：所有实数
- **值域**：$(0, \pi)$
- **单调性**：单调递减

## 反三角函数的关系

### 互补关系

$$
\arcsin x + \arccos x = \frac{\pi}{2}
$$


$$
\arctan x + \text{arccot } x = \frac{\pi}{2}
$$


### 负值关系

$$
\arcsin(-x) = -\arcsin x
$$


$$
\arccos(-x) = \pi - \arccos x
$$

$$
\arctan(-x) = -\arctan x
$$


## 应用

### 解方程

使用反三角函数可以解三角函数方程。

**例子**：解方程 $\sin x = \frac{1}{2}$

$$x = \arcsin\left(\frac{1}{2}\right) = \frac{\pi}{6}$$

但要注意，$\sin x = \frac{1}{2}$ 有多个解，一般解为：

$$x = \frac{\pi}{6} + 2k\pi \quad \text{或} \quad x = \frac{5\pi}{6} + 2k\pi$$

其中 $k$ 是整数。

### 计算角度

使用反三角函数可以根据边长计算角度。

**例子**：在直角三角形中，如果对边是 3，斜边是 5，求角度 $\theta$。

$$\sin\theta = \frac{3}{5}$$

$$\theta = \arcsin\left(\frac{3}{5}\right) \approx 36.87°$$

## 常见错误

#### 错误 1：符号混淆

$\sin^{-1}x$ 表示反三角函数，不是 $\frac{1}{\sin x}$。

#### 错误 2：值域错误

要注意反三角函数的值域，不是所有角度都对应。

#### 错误 3：多值性忽略

三角函数是多值函数，反三角函数只取主值，要注意其他解。

## 小练习

1. 求 $\arcsin\left(\frac{\sqrt{3}}{2}\right)$
2. 求 $\arccos\left(\frac{1}{2}\right)$
3. 求 $\arctan(\sqrt{3})$
4. 应用题：在直角三角形中，如果对边是 4，邻边是 3，求角度 $\theta$（用反正切函数）

---

> 💡 **小贴士**：反三角函数是三角函数的反函数。记住：$\sin^{-1}x$ 表示反三角函数，不是 $\frac{1}{\sin x}$。掌握反三角函数，你就能解决"已知函数值求角度"的问题！