---
sidebar_position: 2
---

# 简谐振动

简谐振动是最基本、最重要的振动形式。理解简谐振动的规律，掌握简谐振动的数学描述，是学习振动和波的基础。

## 什么是简谐振动？

### 简谐振动的定义

**简谐振动**（Simple Harmonic Motion，SHM）：物体在恢复力作用下，位移随时间按正弦或余弦函数规律变化的周期性运动。

**通俗理解**：简谐振动就是"来回摆动"，像"钟摆摆动"、"弹簧振动"一样，是一种周期性运动。

### 简谐振动的特点

**简谐振动的特点**：
1. **周期性**：运动是周期性的，重复进行
2. **恢复力**：受到指向平衡位置的恢复力作用
3. **正弦规律**：位移随时间按正弦或余弦函数变化

**通俗理解**：
- 周期性：运动不断重复
- 恢复力：总想回到平衡位置
- 正弦规律：位移变化像"波浪"

## 简谐振动的数学描述

### 位移方程

**位移方程**：

$$x(t) = A \cos(\omega t + \phi)$$

或者：

$$x(t) = A \sin(\omega t + \phi)$$

其中：
- $x(t)$：位移（单位：m）
- $A$：振幅（单位：m），位移的最大值
- $\omega$：角频率（单位：rad/s）
- $t$：时间（单位：s）
- $\phi$：初相位（单位：rad）

**通俗理解**：
- $A$：摆动的最大幅度（像"摆动多远"）
- $\omega$：摆动的快慢（像"摆得多快"）
- $\phi$：起始位置（像"从哪里开始摆动"）

### 速度方程

**速度方程**（位移对时间求导）：

$$v(t) = -A\omega \sin(\omega t + \phi)$$

或者：

$$v(t) = A\omega \cos(\omega t + \phi)$$

**特点**：
- 速度也是周期性变化的
- 速度的最大值：$v_{max} = A\omega$

### 加速度方程

**加速度方程**（速度对时间求导）：

$$a(t) = -A\omega^2 \cos(\omega t + \phi)$$

或者：

$$a(t) = -A\omega^2 \sin(\omega t + \phi)$$

**特点**：
- 加速度与位移成正比，方向相反
- 加速度的最大值：$a_{max} = A\omega^2$

**关系**：

$$a(t) = -\omega^2 x(t)$$

**通俗理解**：加速度总是指向平衡位置，与位移方向相反。

## 简谐振动的参数

### 1. 振幅（A）

**振幅**（Amplitude）：位移的最大值，表示振动的幅度。

$$A = x_{max}$$

**单位**：米（m）

**通俗理解**：振幅就是"摆动的最大距离"。

### 2. 周期（T）

**周期**（Period）：完成一次完整振动所需的时间。

**单位**：秒（s）

**通俗理解**：周期就是"摆动一次需要多长时间"。

### 3. 频率（f）

**频率**（Frequency）：单位时间内完成的振动次数。

$$f = \frac{1}{T}$$

**单位**：赫兹（Hz），1 Hz = 1 s⁻¹

**通俗理解**：频率就是"每秒摆动多少次"。

### 4. 角频率（ω）

**角频率**（Angular Frequency）：单位时间内转过的角度。

$$\omega = 2\pi f = \frac{2\pi}{T}$$

**单位**：弧度每秒（rad/s）

**通俗理解**：角频率就是"角速度"（像"转多快"）。

### 5. 相位（φ）

**相位**（Phase）：描述振动状态的物理量。

$$\phi = \omega t + \phi_0$$

其中 $\phi_0$ 是初相位。

**单位**：弧度（rad）

**通俗理解**：相位就是"振动的状态"（像"摆动到哪个位置"）。

## 简谐振动的能量

### 动能

**动能**（Kinetic Energy）：

$$E_k = \frac{1}{2}mv^2 = \frac{1}{2}mA^2\omega^2 \sin^2(\omega t + \phi)$$

**动能的最大值**：

$$E_{k,max} = \frac{1}{2}mA^2\omega^2$$

### 势能

**势能**（Potential Energy）：

$$E_p = \frac{1}{2}kx^2 = \frac{1}{2}mA^2\omega^2 \cos^2(\omega t + \phi)$$

其中 $k = m\omega^2$ 是弹簧劲度系数。

**势能的最大值**：

$$E_{p,max} = \frac{1}{2}mA^2\omega^2$$

### 总能量

**总能量**（Total Energy）：

$$E = E_k + E_p = \frac{1}{2}mA^2\omega^2$$

**特点**：
- 总能量守恒（不随时间变化）
- 总能量与振幅的平方成正比
- 动能和势能相互转换（一个增大，另一个减小）

**通俗理解**：
- 动能和势能不断转换（像"能量在动能和势能之间转移"）
- 总能量保持不变（能量守恒）

## 简谐振动的图像

### 位移-时间图

**位移-时间图**（$x-t$ 图）：

- 形状：正弦或余弦曲线
- 振幅：曲线的最大值
- 周期：曲线的周期

### 速度-时间图

**速度-时间图**（$v-t$ 图）：

- 形状：余弦或正弦曲线（与位移图相差 90°）
- 最大值：$v_{max} = A\omega$

### 加速度-时间图

**加速度-时间图**（$a-t$ 图）：

- 形状：与位移图相反（相差 180°）
- 最大值：$a_{max} = A\omega^2$

## 实际应用

### 游戏开发

在游戏开发中，简谐振动用于：

- **物理引擎**：模拟弹簧、钟摆等振动系统
- **动画设计**：创建周期性动画效果
- **游戏机制**：振动效果、摇摆效果等

```javascript
// 简谐振动的应用
class SimpleHarmonicMotion {
  // \text{计算位移}
  static calculateDisplacement(amplitude, angularFrequency, time, phase = 0) {
    // x(t) = A cos(ωt + φ)
    return amplitude * Math.cos(angularFrequency * time + phase);
  }
  
  // 计算速度
  static calculateVelocity(amplitude, angularFrequency, time, phase = 0) {
    // v(t) = -Aω sin(ωt + φ)
    return -amplitude * angularFrequency * Math.sin(angularFrequency * time + phase);
  }
  
  // 计算加速度
  static calculateAcceleration(amplitude, angularFrequency, time, phase = 0) {
    // a(t) = -Aω² cos(ωt + φ)
    return -amplitude * angularFrequency * angularFrequency * Math.cos(angularFrequency * time + phase);
  }
  
  // 计算角频率
  static calculateAngularFrequency(frequency) {
    // ω = 2πf
    return 2 * Math.PI * frequency;
  }
  
  // 计算周期
  static calculatePeriod(frequency) {
    // T = 1/f
    return 1 / frequency;
  }
  
  // 计算频率
  static calculateFrequency(period) {
    // f = 1/T
    return 1 / period;
  }
  
  // 计算动能
  static calculateKineticEnergy(mass, amplitude, angularFrequency, time, phase = 0) {
    // E_k = ½mv²
    const velocity = this.calculateVelocity(amplitude, angularFrequency, time, phase);
    return 0.5 * mass * velocity * velocity;
  }
  
  // 计算势能
  static calculatePotentialEnergy(mass, amplitude, angularFrequency, time, phase = 0) {
    // E_p = ½mω²x²
    const displacement = this.calculateDisplacement(amplitude, angularFrequency, time, phase);
    return 0.5 * mass * angularFrequency * angularFrequency * displacement * displacement;
  }
  
  // 计算总能量
  static calculateTotalEnergy(mass, amplitude, angularFrequency) {
    // E = ½mA²ω²
    return 0.5 * mass * amplitude * amplitude * angularFrequency * angularFrequency;
  }
  
  // 模拟简谐振动（生成时间序列数据）
  static simulateMotion(amplitude, angularFrequency, timeStep, duration, phase = 0) {
    const data = [];
    for (let t = 0; t <= duration; t += timeStep) {
      const displacement = this.calculateDisplacement(amplitude, angularFrequency, t, phase);
      const velocity = this.calculateVelocity(amplitude, angularFrequency, t, phase);
      const acceleration = this.calculateAcceleration(amplitude, angularFrequency, t, phase);
      const kineticEnergy = this.calculateKineticEnergy(1, amplitude, angularFrequency, t, phase); // \text{假设质量}1 kg
      const potentialEnergy = this.calculatePotentialEnergy(1, amplitude, angularFrequency, t, phase);
      const totalEnergy = this.calculateTotalEnergy(1, amplitude, angularFrequency);
      
      data.push({
        time: t,
        displacement,
        velocity,
        acceleration,
        kineticEnergy,
        potentialEnergy,
        totalEnergy
      });
    }
    return data;
  }
}

// 使用示例
let displacement = SimpleHarmonicMotion.calculateDisplacement(0.1, 314, 0.01);
// 振幅 0.1 m，角频率 314 rad/s（50 Hz），时间 0.01 s
// x(0.01) = 0.1 × cos(314 × 0.01) ≈ 0.1 × cos(3.14) ≈ -0.1 m

let angularFreq = SimpleHarmonicMotion.calculateAngularFrequency(50);
// 频率 50 Hz
// ω = 2π × 50 = 314 rad/s

let period = SimpleHarmonicMotion.calculatePeriod(50);
// 频率 50 Hz
// T = 1/50 = 0.02 s

let totalEnergy = SimpleHarmonicMotion.calculateTotalEnergy(1, 0.1, 314);
// 质量 1 kg，振幅 0.1 m，角频率 314 rad/s
// E = ½ × 1 × 0.1² × 314² = 493 J

let motionData = SimpleHarmonicMotion.simulateMotion(0.1, 314, 0.001, 0.1);
// 振幅 0.1 m，角频率 314 rad/s，时间步长 0.001 s，总时间 0.1 s
// 返回振动过程的时间序列数据
```

### 电子工程

在电子工程中，简谐振动用于：

- **信号处理**：理解正弦信号、余弦信号
- **滤波器设计**：理解频率响应
- **振荡器设计**：设计振荡电路

### Arduino/Raspberry Pi

在 Arduino/Raspberry Pi 中，简谐振动用于：

- **传感器应用**：振动传感器、加速度传感器等
- **电机控制**：理解伺服电机的控制原理
- **信号生成**：生成正弦波信号

## 常见问题

### 1. 位移计算

**问题**：简谐振动，振幅 0.2 m，周期 0.5 s，时间 0.1 s，初相位为 0，求位移。

**分析**：
- 角频率：$\omega = \frac{2\pi}{T} = \frac{2\pi}{0.5} = 4\pi \text{ rad/s}$
- 位移：$x(t) = A \cos(\omega t + \phi) = 0.2 \cos(4\pi \times 0.1) = 0.2 \cos(0.4\pi) \approx 0.162 \text{ m}$

### 2. 速度和加速度

**问题**：简谐振动，振幅 0.1 m，角频率 10 rad/s，时间 0.2 s，初相位为 0，求速度和加速度。

**分析**：
- 速度：$v(t) = -A\omega \sin(\omega t) = -0.1 \times 10 \times \sin(10 \times 0.2) = -\sin(2) \approx -0.909 \text{ m/s}$
- 加速度：$a(t) = -A\omega^2 \cos(\omega t) = -0.1 \times 10^2 \times \cos(10 \times 0.2) = -10\cos(2) \approx 4.16 \text{ m/s}^2$

### 3. 能量计算

**问题**：简谐振动，质量 2 kg，振幅 0.15 m，角频率 20 rad/s，求总能量。

**分析**：
$$E = \frac{1}{2}mA^2\omega^2 = \frac{1}{2} \times 2 \times 0.15^2 \times 20^2 = 9 \text{ J}$$

## 常见错误

1. **公式混淆**：位移、速度、加速度的公式不同，注意区分
2. **相位错误**：注意初相位的取值和单位（弧度）
3. **单位错误**：角频率单位是 rad/s，频率单位是 Hz
4. **符号错误**：注意速度和加速度的负号

## 小结

简谐振动的核心内容：

1. **简谐振动**：物体在恢复力作用下，位移随时间按正弦或余弦函数规律变化的周期性运动

2. **数学描述**：
   - 位移：$x(t) = A \cos(\omega t + \phi)$
   - 速度：$v(t) = -A\omega \sin(\omega t + \phi)$
   - 加速度：$a(t) = -A\omega^2 \cos(\omega t + \phi) = -\omega^2 x(t)$

3. **参数**：
   - 振幅 $A$：位移的最大值
   - 周期 $T$：完成一次完整振动的时间
   - 频率 $f = \frac{1}{T}$：单位时间内的振动次数
   - 角频率 $\omega = 2\pi f = \frac{2\pi}{T}$：单位时间内转过的角度
   - 相位 $\phi$：描述振动状态

4. **能量**：
   - 动能和势能相互转换
   - 总能量守恒：$E = \frac{1}{2}mA^2\omega^2$

**记住**：简谐振动按正弦或余弦规律变化，$a = -\omega^2 x$，总能量守恒！
