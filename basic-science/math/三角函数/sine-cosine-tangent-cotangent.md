---
sidebar_position: 3
slug: /sine-cosine-tangent-cotangent
---

# 正弦、余弦、正切、余切

正弦、余弦、正切、余切是四个最基本的三角函数！深入理解它们，是学习三角函数的关键。

## 正弦函数（Sine）

### 定义

**正弦函数**（Sine Function）记作 $\sin\theta$，定义为：

$$
\sin\theta = \frac{\text{对边}}{\text{斜边}}
$$
在单位圆中，$\sin\theta$ 是角度 $\theta$ 对应的点的 $y$ 坐标。

### 性质

- **定义域**：所有实数
- **值域**：$[-1, 1]$
- **周期**：$2\pi$（或 $360°$）
- **奇函数**：$\sin(-\theta) = -\sin\theta$

### 图像

正弦函数的图像是正弦曲线（正弦波）：

- 从 $0$ 开始，先上升后下降
- 在 $x = \frac{\pi}{2}$ 处达到最大值 1
- 在 $x = \pi$ 处回到 0
- 在 $x = \frac{3\pi}{2}$ 处达到最小值 -1
- 在 $x = 2\pi$ 处回到 0，完成一个周期

### 特殊值

| 角度 | 弧度 | $\sin\theta$ |
|:----:|:----:|:------------:|
| $0°$ | $0$ | $0$ |
| $30°$ | $\frac{\pi}{6}$ | $\frac{1}{2}$ |
| $45°$ | $\frac{\pi}{4}$ | $\frac{\sqrt{2}}{2}$ |
| $60°$ | $\frac{\pi}{3}$ | $\frac{\sqrt{3}}{2}$ |
| $90°$ | $\frac{\pi}{2}$ | $1$ |

## 余弦函数（Cosine）

### 定义

**余弦函数**（Cosine Function）记作 $\cos\theta$，定义为：

$$
\cos\theta = \frac{\text{邻边}}{\text{斜边}}
$$
在单位圆中，$\cos\theta$ 是角度 $\theta$ 对应的点的 $x$ 坐标。

### 性质

- **定义域**：所有实数
- **值域**：$[-1, 1]$
- **周期**：$2\pi$（或 $360°$）
- **偶函数**：$\cos(-\theta) = \cos\theta$

### 图像

余弦函数的图像是余弦曲线（余弦波）：

- 从 $1$ 开始，先下降后上升
- 在 $x = 0$ 处达到最大值 1
- 在 $x = \frac{\pi}{2}$ 处为 0
- 在 $x = \pi$ 处达到最小值 -1
- 在 $x = \frac{3\pi}{2}$ 处为 0
- 在 $x = 2\pi$ 处回到 1，完成一个周期

### 特殊值

| 角度 | 弧度 | $\cos\theta$ |
|:----:|:----:|:------------:|
| $0°$ | $0$ | $1$ |
| $30°$ | $\frac{\pi}{6}$ | $\frac{\sqrt{3}}{2}$ |
| $45°$ | $\frac{\pi}{4}$ | $\frac{\sqrt{2}}{2}$ |
| $60°$ | $\frac{\pi}{3}$ | $\frac{1}{2}$ |
| $90°$ | $\frac{\pi}{2}$ | $0$ |

## 正切函数（Tangent）

### 定义

**正切函数**（Tangent Function）记作 $\tan\theta$，定义为：

$$
\tan\theta = \frac{\sin\theta}{\cos\theta} = \frac{\text{对边}}{\text{邻边}}
$$

### 性质

- **定义域**：所有实数，除了 $\cos\theta = 0$ 的点（即 $\theta = \frac{\pi}{2} + k\pi$，$k$ 为整数）
- **值域**：所有实数
- **周期**：$\pi$（或 $180°$）
- **奇函数**：$\tan(-\theta) = -\tan\theta$

### 图像

正切函数的图像是正切曲线：

- 在每个周期内，从 $-\infty$ 上升到 $+\infty$
- 在 $x = \frac{\pi}{2} + k\pi$ 处有垂直渐近线
- 在 $x = 0$ 处为 0

### 特殊值

| 角度 | 弧度 | $\tan\theta$ |
|:----:|:----:|:------------:|
| $0°$ | $0$ | $0$ |
| $30°$ | $\frac{\pi}{6}$ | $\frac{\sqrt{3}}{3}$ |
| $45°$ | $\frac{\pi}{4}$ | $1$ |
| $60°$ | $\frac{\pi}{3}$ | $\sqrt{3}$ |
| $90°$ | $\frac{\pi}{2}$ | 不存在（无穷大） |

## 余切函数（Cotangent）

### 定义

**余切函数**（Cotangent Function）记作 $\cot\theta$，定义为：

$$
\cot\theta = \frac{\cos\theta}{\sin\theta} = \frac{\text{邻边}}{\text{对边}} = \frac{1}{\tan\theta}
$$

### 性质

- **定义域**：所有实数，除了 $\sin\theta = 0$ 的点（即 $\theta = k\pi$，$k$ 为整数）
- **值域**：所有实数
- **周期**：$\pi$（或 $180°$）
- **奇函数**：$\cot(-\theta) = -\cot\theta$

### 图像

余切函数的图像是余切曲线：

- 在每个周期内，从 $+\infty$ 下降到 $-\infty$
- 在 $x = k\pi$ 处有垂直渐近线
- 在 $x = \frac{\pi}{2}$ 处为 0

### 特殊值

| 角度 | 弧度 | $\cot\theta$ |
|:----:|:----:|:------------:|
| $0°$ | $0$ | 不存在（无穷大） |
| $30°$ | $\frac{\pi}{6}$ | $\sqrt{3}$ |
| $45°$ | $\frac{\pi}{4}$ | $1$ |
| $60°$ | $\frac{\pi}{3}$ | $\frac{\sqrt{3}}{3}$ |
| $90°$ | $\frac{\pi}{2}$ | $0$ |

## 函数之间的关系

### 基本关系

$$
\tan\theta = \frac{\sin\theta}{\cos\theta}
$$

$$
\cot\theta = \frac{\cos\theta}{\sin\theta} = \frac{1}{\tan\theta}
$$



### 平方和关系

$$
\sin^2\theta + \cos^2\theta = 1
$$

**推导**：在单位圆中，$x^2 + y^2 = 1$，而 $x = \cos\theta$，$y = \sin\theta$，所以 $\sin^2\theta + \cos^2\theta = 1$。

### 和角公式

$$
\sin(\alpha + \beta) = \sin\alpha\cos\beta + \cos\alpha\sin\beta
$$


$$
\cos(\alpha + \beta) = \cos\alpha\cos\beta - \sin\alpha\sin\beta
$$

$$
\tan(\alpha + \beta) = \frac{\tan\alpha + \tan\beta}{1 - \tan\alpha\tan\beta}
$$


## 生活中的应用

#### 物理

- ⚡ **波动**：描述正弦波和余弦波
- 🔬 **振动**：描述简谐振动

#### 工程

- 🏗️ **信号处理**：处理周期信号
- ⚙️ **控制系统**：分析控制系统

#### 计算机

- 💻 **图形学**：绘制周期图形
- 🎮 **游戏开发**：模拟周期性运动

## 常见错误

#### 错误 1：混淆正弦和余弦

- **正弦**：对边比斜边
- **余弦**：邻边比斜边

#### 错误 2：正切函数定义域错误

正切函数在 $\theta = \frac{\pi}{2} + k\pi$ 处无定义。

#### 错误 3：特殊值记忆错误

要准确记忆特殊角的三角函数值。

## 小练习

1. 求 $\sin 30°$、$\cos 60°$、$\tan 45°$ 的值
2. 如果 $\sin\theta = \frac{3}{5}$，且 $\theta$ 是锐角，求 $\cos\theta$ 和 $\tan\theta$
3. 验证：$\sin^2 30° + \cos^2 30° = 1$
4. 应用题：一个直角三角形，一个锐角是 $30°$，斜边是 10，求对边和邻边

---

> 💡 **小贴士**：正弦、余弦、正切、余切是四个最基本的三角函数。记住：$\sin^2\theta + \cos^2\theta = 1$，$\tan\theta = \frac{\sin\theta}{\cos\theta}$。掌握这些函数，你就能解决很多三角函数问题！