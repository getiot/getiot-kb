---
sidebar_position: 2
slug: /fourier-transform
---

# 傅里叶变换

傅里叶变换是信号处理的基础！理解傅里叶变换，能帮助我们分析信号的频率成分。

## 什么是傅里叶变换？

**傅里叶变换**（Fourier Transform）是将函数从时域转换到频域的积分变换。

### 简单理解

傅里叶变换就像"把信号分解成不同频率的正弦波"：

- 任何信号都可以分解为不同频率的正弦波
- 每个频率分量有不同的振幅和相位
- 通过变换，可以看到信号的频率成分

### 定义

函数 $f(t)$ 的**傅里叶变换**：

$$F(\omega) = \int_{-\infty}^{\infty} f(t) e^{-i\omega t} dt$$

其中：
- $f(t)$ 是时域函数
- $F(\omega)$ 是频域函数
- $\omega$ 是角频率
- $i = \sqrt{-1}$ 是虚数单位

### 逆变换

**傅里叶逆变换**（Inverse Fourier Transform）：

$$f(t) = \frac{1}{2\pi} \int_{-\infty}^{\infty} F(\omega) e^{i\omega t} d\omega$$

## 傅里叶变换的性质

### 线性性质

$$\mathcal{F}[af(t) + bg(t)] = aF(\omega) + bG(\omega)$$

其中 $\mathcal{F}$ 表示傅里叶变换，$a, b$ 是常数。

### 时移性质

$$\mathcal{F}[f(t - t_0)] = e^{-i\omega t_0} F(\omega)$$

时域中的平移对应频域中的相位变化。

### 频移性质

$$\mathcal{F}[e^{i\omega_0 t} f(t)] = F(\omega - \omega_0)$$

时域中的调制对应频域中的平移。

### 尺度变换

$$\mathcal{F}[f(at)] = \frac{1}{|a|} F\left(\frac{\omega}{a}\right)$$

时域中的压缩对应频域中的扩展。

### 卷积定理

时域卷积对应频域乘积：

$$\mathcal{F}[f(t) * g(t)] = F(\omega) G(\omega)$$

频域卷积对应时域乘积：

$$\mathcal{F}[f(t) g(t)] = \frac{1}{2\pi} F(\omega) * G(\omega)$$

### 微分性质

$$\mathcal{F}[f'(t)] = i\omega F(\omega)$$

$$\mathcal{F}[f^{(n)}(t)] = (i\omega)^n F(\omega)$$

时域中的微分对应频域中的乘法。

### 积分性质

$$\mathcal{F}\left[\int_{-\infty}^{t} f(\tau) d\tau\right] = \frac{F(\omega)}{i\omega} + \pi F(0) \delta(\omega)$$

时域中的积分对应频域中的除法。

### 对称性

如果 $f(t)$ 是实函数，则：

$$F(-\omega) = \overline{F(\omega)}$$

其中 $\overline{F(\omega)}$ 是 $F(\omega)$ 的共轭。

## 常见函数的傅里叶变换

### 矩形脉冲

$$f(t) = \begin{cases}
1 & \text{如果 } |t| < T/2 \\
0 & \text{如果 } |t| > T/2
\end{cases}$$

$$F(\omega) = T \frac{\sin(\omega T/2)}{\omega T/2} = T \text{sinc}\left(\frac{\omega T}{2}\right)$$

### 高斯函数

$$f(t) = e^{-at^2} \quad (a > 0)$$

$$F(\omega) = \sqrt{\frac{\pi}{a}} e^{-\omega^2/(4a)}$$

### 指数衰减函数

$$f(t) = e^{-at} u(t) \quad (a > 0)$$

其中 $u(t)$ 是单位阶跃函数。

$$F(\omega) = \frac{1}{a + i\omega}$$

### 正弦函数

$$f(t) = \sin(\omega_0 t)$$

$$F(\omega) = \frac{\pi}{i} [\delta(\omega - \omega_0) - \delta(\omega + \omega_0)]$$

其中 $\delta(\omega)$ 是狄拉克δ函数。

### 余弦函数

$$f(t) = \cos(\omega_0 t)$$

$$F(\omega) = \pi [\delta(\omega - \omega_0) + \delta(\omega + \omega_0)]$$

## 离散傅里叶变换（DFT）

### 定义

对于离散序列 $x[n]$（$n = 0, 1, 2, \ldots, N-1$），**离散傅里叶变换**：

$$X[k] = \sum_{n=0}^{N-1} x[n] e^{-i 2\pi kn/N} \quad (k = 0, 1, 2, \ldots, N-1)$$

### 逆变换

$$x[n] = \frac{1}{N} \sum_{k=0}^{N-1} X[k] e^{i 2\pi kn/N} \quad (n = 0, 1, 2, \ldots, N-1)$$

## 傅里叶变换的应用

### 信号处理

- 📡 **信号分析**：分析信号的频率成分
- 🔊 **滤波**：设计滤波器，去除噪声
- 📺 **压缩**：压缩音频和视频信号

### 图像处理

- 🖼️ **图像分析**：分析图像的频率特征
- 🎨 **图像增强**：增强图像的某些频率成分
- 🔍 **图像压缩**：压缩图像数据

### 通信工程

- 📻 **调制**：调制信号
- 📡 **解调**：解调信号
- 🔐 **编码**：编码和解码信号

### 物理

- ⚡ **波动分析**：分析波动现象
- 🔬 **量子力学**：分析波函数
- 🌊 **光学**：分析光的传播

## 生活中的应用

### 音频处理

- 🎵 **音乐分析**：分析音乐的频率成分
- 🔊 **降噪**：去除音频中的噪声
- 🎤 **语音识别**：识别语音信号

### 医学

- 🏥 **医学成像**：MRI、CT 等医学成像
- 💊 **信号分析**：分析生理信号（心电图、脑电图）

### 科学

- 🔬 **光谱分析**：分析光谱
- 📊 **数据分析**：分析实验数据

## 常见错误

### 错误 1：变换公式使用错误

要正确使用傅里叶变换的定义，注意积分区间和核函数。

### 错误 2：性质应用错误

要正确应用傅里叶变换的性质，注意条件。

### 错误 3：离散和连续混淆

要区分连续傅里叶变换和离散傅里叶变换。

## 小练习

1. 求函数 $f(t) = e^{-|t|}$ 的傅里叶变换
2. 利用时移性质，求 $f(t - t_0)$ 的傅里叶变换
3. 利用卷积定理，计算两个矩形脉冲的卷积
4. 应用题：在音频处理中，如何用傅里叶变换分析音频信号的频率成分？

---

> 💡 **小贴士**：傅里叶变换是将函数从时域转换到频域的积分变换。记住：时域卷积对应频域乘积，时域微分对应频域乘法。掌握傅里叶变换，你就能分析信号的频率成分！