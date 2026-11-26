---
sidebar_position: 5
slug: /trigonometric-identities
---

# 三角恒等式

三角恒等式是三角函数之间的重要关系！掌握这些恒等式，能帮助我们简化和解决三角函数问题。

## 什么是三角恒等式？

**三角恒等式**（Trigonometric Identities）是对于所有角度都成立的三角函数等式。

### 简单理解

三角恒等式就像"三角函数的规律"：

- 无论角度是多少，这些关系都成立
- 用这些关系可以简化计算
- 用这些关系可以证明其他等式

## 基本恒等式

### 平方和恒等式

$$
\sin^2\theta + \cos^2\theta = 1
$$

**推导**：在单位圆中，$x^2 + y^2 = 1$，而 $x = \cos\theta$，$y = \sin\theta$，所以 $\sin^2\theta + \cos^2\theta = 1$。

**变形**：
- $\sin^2\theta = 1 - \cos^2\theta$
- $\cos^2\theta = 1 - \sin^2\theta$

### 商数恒等式

$$
\tan\theta = \frac{\sin\theta}{\cos\theta}
$$


$$
\cot\theta = \frac{\cos\theta}{\sin\theta} = \frac{1}{\tan\theta}
$$


### 倒数恒等式

$$
\sec\theta = \frac{1}{\cos\theta}
$$


$$
\csc\theta = \frac{1}{\sin\theta}
$$

$$
\cot\theta = \frac{1}{\tan\theta}
$$


## 和角公式

### 正弦和角公式

$$
\sin(\alpha + \beta) = \sin\alpha\cos\beta + \cos\alpha\sin\beta
$$


$$
\sin(\alpha - \beta) = \sin\alpha\cos\beta - \cos\alpha\sin\beta
$$


### 余弦和角公式

$$
\cos(\alpha + \beta) = \cos\alpha\cos\beta - \sin\alpha\sin\beta
$$


$$
\cos(\alpha - \beta) = \cos\alpha\cos\beta + \sin\alpha\sin\beta
$$


### 正切和角公式

$$
\tan(\alpha + \beta) = \frac{\tan\alpha + \tan\beta}{1 - \tan\alpha\tan\beta}
$$


$$
\tan(\alpha - \beta) = \frac{\tan\alpha - \tan\beta}{1 + \tan\alpha\tan\beta}
$$


## 倍角公式

### 正弦倍角公式

$$
\sin(2\theta) = 2\sin\theta\cos\theta
$$

**推导**：在正弦和角公式中，令 $\alpha = \beta = \theta$，则：
$$
\sin(2\theta) = \sin(\theta + \theta) = \sin\theta\cos\theta + \cos\theta\sin\theta = 2\sin\theta\cos\theta
$$


### 余弦倍角公式

$$
\cos(2\theta) = \cos^2\theta - \sin^2\theta = 2\cos^2\theta - 1 = 1 - 2\sin^2\theta
$$

**推导**：在余弦和角公式中，令 $\alpha = \beta = \theta$，则：
$$
\cos(2\theta) = \cos(\theta + \theta) = \cos\theta\cos\theta - \sin\theta\sin\theta = \cos^2\theta - \sin^2\theta
$$
利用 $\sin^2\theta + \cos^2\theta = 1$，可以得到其他形式。

### 正切倍角公式

$$
\tan(2\theta) = \frac{2\tan\theta}{1 - \tan^2\theta}
$$



## 半角公式

### 正弦半角公式

$$
\sin\left(\frac{\theta}{2}\right) = \pm\sqrt{\frac{1 - \cos\theta}{2}}
$$

符号取决于 $\frac{\theta}{2}$ 所在的象限。

### 余弦半角公式

$$
\cos\left(\frac{\theta}{2}\right) = \pm\sqrt{\frac{1 + \cos\theta}{2}}
$$

符号取决于 $\frac{\theta}{2}$ 所在的象限。

### 正切半角公式

$$
\tan\left(\frac{\theta}{2}\right) = \frac{\sin\theta}{1 + \cos\theta} = \frac{1 - \cos\theta}{\sin\theta}
$$



## 积化和差公式

### 正弦积化和差

$$
\sin\alpha\sin\beta = \frac{1}{2}[\cos(\alpha - \beta) - \cos(\alpha + \beta)]
$$


$$
\cos\alpha\cos\beta = \frac{1}{2}[\cos(\alpha - \beta) + \cos(\alpha + \beta)]
$$

$$
\sin\alpha\cos\beta = \frac{1}{2}[\sin(\alpha + \beta) + \sin(\alpha - \beta)]
$$


## 和差化积公式

### 正弦和差化积

$$
\sin\alpha + \sin\beta = 2\sin\left(\frac{\alpha + \beta}{2}\right)\cos\left(\frac{\alpha - \beta}{2}\right)
$$


$$
\sin\alpha - \sin\beta = 2\cos\left(\frac{\alpha + \beta}{2}\right)\sin\left(\frac{\alpha - \beta}{2}\right)
$$


### 余弦和差化积

$$
\cos\alpha + \cos\beta = 2\cos\left(\frac{\alpha + \beta}{2}\right)\cos\left(\frac{\alpha - \beta}{2}\right)
$$


$$
\cos\alpha - \cos\beta = -2\sin\left(\frac{\alpha + \beta}{2}\right)\sin\left(\frac{\alpha - \beta}{2}\right)
$$


## 辅助角公式

### 形式

$$
a\sin\theta + b\cos\theta = \sqrt{a^2 + b^2}\sin(\theta + \phi)
$$

其中 $\phi = \arctan\left(\frac{b}{a}\right)$。

## 应用

#### 简化计算

使用三角恒等式可以简化复杂的三角函数表达式。

**例子**：化简 $\sin^2\theta + \cos^2\theta$
$$
\sin^2\theta + \cos^2\theta = 1
$$


#### 证明等式

使用三角恒等式可以证明其他等式。

**例子**：证明 $\sin(2\theta) = 2\sin\theta\cos\theta$

使用倍角公式即可证明。

#### 解方程

使用三角恒等式可以解三角函数方程。



## 小练习

1. 验证：$\sin^2 30° + \cos^2 30° = 1$
2. 使用和角公式计算：$\sin(45° + 30°)$
3. 使用倍角公式计算：$\cos(2 \times 30°)$
4. 化简：$\frac{\sin\theta}{\cos\theta} + \frac{\cos\theta}{\sin\theta}$

---

> 💡 **小贴士**：三角恒等式是三角函数之间的重要关系。记住：$\sin^2\theta + \cos^2\theta = 1$，$\sin(2\theta) = 2\sin\theta\cos\theta$。掌握这些恒等式，你就能简化和解决很多三角函数问题！