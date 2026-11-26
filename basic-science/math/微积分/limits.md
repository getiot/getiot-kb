---
sidebar_position: 2
slug: /limits
---

# 极限

极限是微积分的基础！理解极限，是学习微积分的第一步。

## 什么是极限？

**极限**（Limit）是函数在某个点附近的行为，描述函数值趋近于某个值的过程。

### 简单理解

极限就像"无限接近"：

- 当 $x$ 无限接近某个值时
- 函数 $f(x)$ 无限接近某个值
- 这个值就是极限

### 定义

如果当 $x$ 无限接近 $a$ 时，$f(x)$ 无限接近 $L$，则称 $L$ 是 $f(x)$ 在 $x \to a$ 时的极限，记作：

$$
\lim_{x \to a} f(x) = L
$$


## 左极限和右极限

### 左极限

**左极限**（Left-hand Limit）是 $x$ 从左侧接近 $a$ 时的极限，记作：
$$
\lim_{x \to a^-} f(x)
$$


### 右极限

**右极限**（Right-hand Limit）是 $x$ 从右侧接近 $a$ 时的极限，记作：
$$
\lim_{x \to a^+} f(x)
$$


### 极限存在的条件

极限 $\lim_{x \to a} f(x)$ 存在当且仅当左极限和右极限都存在且相等：

$$
\lim_{x \to a^-} f(x) = \lim_{x \to a^+} f(x) = L
$$


## 极限的性质

### 性质 1：唯一性

如果极限存在，则它是唯一的。

### 性质 2：局部有界性

如果 $\lim_{x \to a} f(x) = L$，则 $f(x)$ 在 $a$ 的某个邻域内有界。

### 性质 3：保号性

如果 $\lim_{x \to a} f(x) = L > 0$，则存在 $a$ 的某个邻域，使得 $f(x) > 0$。

## 极限的运算法则

#### 加法

$$
\lim_{x \to a} [f(x) + g(x)] = \lim_{x \to a} f(x) + \lim_{x \to a} g(x)
$$



#### 减法

$$
\lim_{x \to a} [f(x) - g(x)] = \lim_{x \to a} f(x) - \lim_{x \to a} g(x)
$$



#### 乘法

$$
\lim_{x \to a} [f(x) \times g(x)] = \lim_{x \to a} f(x) \times \lim_{x \to a} g(x)
$$



#### 除法

$$
\lim_{x \to a} \frac{f(x)}{g(x)} = \frac{\lim_{x \to a} f(x)}{\lim_{x \to a} g(x)}
$$

其中 $\lim_{x \to a} g(x) \neq 0$。

#### 数乘

$$
\lim_{x \to a} [k f(x)] = k \lim_{x \to a} f(x)
$$

其中 $k$ 是常数。

## 重要极限

#### 极限 1

$$
\lim_{x \to 0} \frac{\sin x}{x} = 1
$$



#### 极限 2

$$
\lim_{x \to \infty} \left(1 + \frac{1}{x}\right)^x = e
$$

其中 $e \approx 2.71828$ 是自然常数。

#### 极限 3

$$
\lim_{x \to 0} \frac{e^x - 1}{x} = 1
$$



#### 极限 4

$$
\lim_{x \to 0} \frac{\ln(1 + x)}{x} = 1
$$



## 无穷小和无穷大

### 无穷小

如果 $\lim_{x \to a} f(x) = 0$，则称 $f(x)$ 是 $x \to a$ 时的**无穷小**（Infinitesimal）。

### 无穷大

如果 $\lim_{x \to a} f(x) = \infty$（或 $-\infty$），则称 $f(x)$ 是 $x \to a$ 时的**无穷大**（Infinity）。

### 关系

如果 $\lim_{x \to a} f(x) = \infty$，则 $\lim_{x \to a} \frac{1}{f(x)} = 0$。

## 极限的计算方法

### 方法 1：直接代入

如果函数在 $a$ 处连续，则：

$$
\lim_{x \to a} f(x) = f(a)
$$


### 方法 2：因式分解

对于 $\frac{0}{0}$ 型未定式，可以因式分解后约分。

**例子**：$\lim_{x \to 2} \frac{x^2 - 4}{x - 2}$

$$
\lim_{x \to 2} \frac{x^2 - 4}{x - 2} = \lim_{x \to 2} \frac{(x - 2)(x + 2)}{x - 2} = \lim_{x \to 2} (x + 2) = 4
$$


### 方法 3：有理化

对于含有根式的未定式，可以有理化。

**例子**：$\lim_{x \to 0} \frac{\sqrt{1 + x} - 1}{x}$

$$\lim_{x \to 0} \frac{\sqrt{1 + x} - 1}{x} = \lim_{x \to 0} \frac{(\sqrt{1 + x} - 1)(\sqrt{1 + x} + 1)}{x(\sqrt{1 + x} + 1)}$$

$$= \lim_{x \to 0} \frac{1 + x - 1}{x(\sqrt{1 + x} + 1)} = \lim_{x \to 0} \frac{1}{\sqrt{1 + x} + 1} = \frac{1}{2}$$

### 方法 4：洛必达法则

对于 $\frac{0}{0}$ 或 $\frac{\infty}{\infty}$ 型未定式，可以使用洛必达法则：

$$\lim_{x \to a} \frac{f(x)}{g(x)} = \lim_{x \to a} \frac{f'(x)}{g'(x)}$$

（需要满足一定条件）

## 生活中的应用

#### 物理

- ⚡ **瞬时速度**：用极限定义瞬时速度
- 🔬 **瞬时加速度**：用极限定义瞬时加速度

#### 工程

- 🏗️ **优化设计**：用极限分析优化问题
- ⚙️ **系统分析**：用极限分析系统行为

## 常见错误

#### 错误 1：极限和函数值混淆

极限是函数值趋近的值，不一定是函数在该点的值。

#### 错误 2：未定式处理错误

要正确处理 $\frac{0}{0}$、$\frac{\infty}{\infty}$ 等未定式。

#### 错误 3：极限不存在

不是所有函数在所有点都有极限。

## 小练习

1. 计算 $\lim_{x \to 2} (x^2 + 3x - 1)$
2. 计算 $\lim_{x \to 0} \frac{\sin x}{x}$
3. 计算 $\lim_{x \to 1} \frac{x^2 - 1}{x - 1}$
4. 应用题：用极限定义瞬时速度

---

> 💡 **小贴士**：极限是微积分的基础。记住：$\lim_{x \to 0} \frac{\sin x}{x} = 1$，$\lim_{x \to \infty} \left(1 + \frac{1}{x}\right)^x = e$。掌握极限的计算方法，你就能学习导数和积分！