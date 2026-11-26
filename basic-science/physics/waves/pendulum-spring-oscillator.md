---
sidebar_position: 3
---

# 单摆和弹簧振子

单摆和弹簧振子是简谐振动的典型例子。理解它们的运动规律，掌握它们的应用，是学习振动的基础。

## 单摆

### 什么是单摆？

**单摆**（Simple Pendulum）：由不可伸长的轻绳（或轻杆）和悬挂在其一端的质点组成的理想模型。

**结构**：
- **轻绳（或轻杆）**：长度 $l$，质量忽略不计
- **质点**：质量 $m$，体积忽略不计
- **悬挂点**：固定点

**通俗理解**：单摆就是"钟摆"，像"摆钟"的摆一样。

### 单摆的运动规律

**单摆的运动规律**（小角度近似）：

当摆角 $\theta < 5°$（或 $10°$）时，单摆近似做简谐振动。

**位移方程**（小角度近似）：

$$\theta(t) = \theta_0 \cos(\omega t + \phi)$$

其中：
- $\theta(t)$：摆角（单位：rad）
- $\theta_0$：最大摆角（单位：rad），振幅
- $\omega$：角频率（单位：rad/s）
- $t$：时间（单位：s）
- $\phi$：初相位（单位：rad）

**周期**（单摆周期公式）：

$$T = 2\pi \sqrt{\frac{l}{g}}$$

其中：
- $T$：周期（单位：s）
- $l$：摆长（单位：m）
- $g$：重力加速度（单位：m/s²），通常取 $g = 9.8 \text{ m/s}^2$ 或 $10 \text{ m/s}^2$

**频率**：

$$f = \frac{1}{T} = \frac{1}{2\pi} \sqrt{\frac{g}{l}}$$

**角频率**：

$$\omega = \frac{2\pi}{T} = \sqrt{\frac{g}{l}}$$

**通俗理解**：
- 周期与摆长的平方根成正比：摆长越长，周期越长
- 周期与重力加速度的平方根成反比：重力越大，周期越短
- 周期与质量无关：质量不同，周期相同（理想单摆）

### 单摆的特点

**单摆的特点**：

1. **小角度近似**：只有在摆角很小（$\theta < 5°$）时，才近似做简谐振动
2. **周期与质量无关**：周期只取决于摆长和重力加速度
3. **等时性**：相同摆长，周期相同（理想单摆）

**通俗理解**：
- 小角度：摆角越小，越接近简谐振动
- 周期固定：相同摆长，周期不变
- 质量无关：质量不影响周期

## 弹簧振子

### 什么是弹簧振子？

**弹簧振子**（Spring Oscillator）：由轻弹簧和质量块组成的理想模型。

**结构**：
- **轻弹簧**：劲度系数 $k$，质量忽略不计
- **质量块**：质量 $m$
- **光滑水平面**：无摩擦（理想情况）

**通俗理解**：弹簧振子就是"弹簧上的物体"，像"弹簧玩具"一样。

### 弹簧振子的运动规律

**弹簧振子的运动规律**：

弹簧振子做简谐振动（无需小角度近似）。

**位移方程**：

$$x(t) = A \cos(\omega t + \phi)$$

其中：
- $x(t)$：位移（单位：m）
- $A$：振幅（单位：m），位移的最大值
- $\omega$：角频率（单位：rad/s）
- $t$：时间（单位：s）
- $\phi$：初相位（单位：rad）

**周期**（弹簧振子周期公式）：

$$T = 2\pi \sqrt{\frac{m}{k}}$$

其中：
- $T$：周期（单位：s）
- $m$：质量（单位：kg）
- $k$：劲度系数（单位：N/m）

**频率**：

$$f = \frac{1}{T} = \frac{1}{2\pi} \sqrt{\frac{k}{m}}$$

**角频率**：

$$\omega = \frac{2\pi}{T} = \sqrt{\frac{k}{m}}$$

**通俗理解**：
- 周期与质量的平方根成正比：质量越大，周期越长
- 周期与劲度系数的平方根成反比：劲度越大，周期越短
- 精确简谐振动：弹簧振子始终做简谐振动（无小角度限制）

### 弹簧振子的特点

**弹簧振子的特点**：

1. **精确简谐振动**：始终做简谐振动（无小角度限制）
2. **周期与质量有关**：周期取决于质量和劲度系数
3. **能量守恒**：动能和势能相互转换，总能量守恒

**通俗理解**：
- 精确简谐：弹簧振子总是做简谐振动
- 质量影响：质量越大，周期越长
- 能量转换：动能和势能来回转换

### 弹簧振子的能量

**弹簧振子的能量**：

**总能量**：

$$E = \frac{1}{2} k A^2$$

其中：
- $E$：总能量（单位：J）
- $k$：劲度系数（单位：N/m）
- $A$：振幅（单位：m）

**动能**：

$$E_k = \frac{1}{2} m v^2$$

**势能**：

$$E_p = \frac{1}{2} k x^2$$

**能量守恒**：

$$E = E_k + E_p = \frac{1}{2} k A^2 = \text{\text{常数}}$$

**通俗理解**：
- 总能量：只与振幅和劲度系数有关
- 动能和势能：相互转换，总和不变
- 平衡位置：动能最大，势能为零
- 最大位移：动能为零，势能最大

## 单摆 vs 弹簧振子

### 对比表

| 特征 | 单摆 | 弹簧振子 |
|------|------|---------|
| **周期公式** | $T = 2\pi \sqrt{\frac{l}{g}}$ | $T = 2\pi \sqrt{\frac{m}{k}}$ |
| **周期与质量** | 无关 | 有关（$T \propto \sqrt{m}$） |
| **周期与长度** | 有关（$T \propto \sqrt{l}$） | 无关（与劲度系数有关） |
| **简谐振动** | 小角度近似 | 精确简谐 |
| **能量** | 重力势能和动能 | 弹性势能和动能 |

**通俗理解**：
- 单摆：周期由摆长决定，小角度近似
- 弹簧振子：周期由质量和劲度决定，精确简谐

## 实际应用

### 游戏开发

在游戏开发中，单摆和弹簧振子用于：

- **物理引擎**：模拟单摆和弹簧振子的运动
- **游戏机制**：钟摆、弹簧、弹性效果等
- **动画设计**：模拟弹性动画效果

```javascript
// 单摆和弹簧振子的应用
class PendulumSpringOscillator {
  static G = 9.8; // \text{重力加速度} m/s²
  
  // \text{计算单摆周期}
  static calculatePendulumPeriod(length) {
    // T = 2π√(l/g)
    return 2 * Math.PI * Math.sqrt(length / this.G);
  }
  
  // 计算单摆频率
  static calculatePendulumFrequency(length) {
    // f = 1/T = 1/(2π√(l/g))
    return 1 / this.calculatePendulumPeriod(length);
  }
  
  // 计算单摆角频率
  static calculatePendulumAngularFrequency(length) {
    // ω = 2π/T = √(g/l)
    return Math.sqrt(this.G / length);
  }
  
  // 计算单摆位移（小角度近似）
  static calculatePendulumDisplacement(maxAngle, angularFrequency, time, phase = 0) {
    // θ(t) = θ₀cos(ωt + φ)（\text{角度}：\text{弧度}）
    return maxAngle * Math.cos(angularFrequency * time + phase);
  }
  
  // 计算弹簧振子周期
  static calculateSpringPeriod(mass, springConstant) {
    // T = 2π√(m/k)
    return 2 * Math.PI * Math.sqrt(mass / springConstant);
  }
  
  // 计算弹簧振子频率
  static calculateSpringFrequency(mass, springConstant) {
    // f = 1/T = 1/(2π√(m/k))
    return 1 / this.calculateSpringPeriod(mass, springConstant);
  }
  
  // 计算弹簧振子角频率
  static calculateSpringAngularFrequency(mass, springConstant) {
    // ω = 2π/T = √(k/m)
    return Math.sqrt(springConstant / mass);
  }
  
  // 计算弹簧振子位移
  static calculateSpringDisplacement(amplitude, angularFrequency, time, phase = 0) {
    // x(t) = A cos(ωt + φ)
    return amplitude * Math.cos(angularFrequency * time + phase);
  }
  
  // 计算弹簧振子速度
  static calculateSpringVelocity(amplitude, angularFrequency, time, phase = 0) {
    // v(t) = -Aω sin(ωt + φ)
    return -amplitude * angularFrequency * Math.sin(angularFrequency * time + phase);
  }
  
  // 计算弹簧振子加速度
  static calculateSpringAcceleration(amplitude, angularFrequency, time, phase = 0) {
    // a(t) = -Aω² cos(ωt + φ)
    return -amplitude * angularFrequency * angularFrequency * Math.cos(angularFrequency * time + phase);
  }
  
  // 计算弹簧振子总能量
  static calculateSpringTotalEnergy(springConstant, amplitude) {
    // E = ½kA²
    return 0.5 * springConstant * amplitude * amplitude;
  }
  
  // 计算弹簧振子动能
  static calculateSpringKineticEnergy(mass, velocity) {
    // E_k = ½mv²
    return 0.5 * mass * velocity * velocity;
  }
  
  // 计算弹簧振子势能
  static calculateSpringPotentialEnergy(springConstant, displacement) {
    // E_p = ½kx²
    return 0.5 * springConstant * displacement * displacement;
  }
}

// 使用示例
let pendulumPeriod = PendulumSpringOscillator.calculatePendulumPeriod(1);
// 摆长 1 m
// T = 2π√(1/9.8) ≈ 2.01 s

let pendulumDisplacement = PendulumSpringOscillator.calculatePendulumDisplacement(0.1, 3.13, 0.5);
// 最大摆角 0.1 rad，角频率 3.13 rad/s（摆长 1 m），时间 0.5 s
// θ(0.5) = 0.1 × cos(3.13 × 0.5) ≈ 0.1 × cos(1.565) ≈ 0.007 rad

let springPeriod = PendulumSpringOscillator.calculateSpringPeriod(0.5, 100);
// 质量 0.5 kg，劲度系数 100 N/m
// T = 2π√(0.5/100) ≈ 0.444 s

let springDisplacement = PendulumSpringOscillator.calculateSpringDisplacement(0.05, 14.14, 0.1);
// 振幅 0.05 m，角频率 14.14 rad/s（质量 0.5 kg，劲度 100 N/m），时间 0.1 s
// x(0.1) = 0.05 × cos(14.14 × 0.1) ≈ 0.05 × cos(1.414) ≈ 0.005 m

let springTotalEnergy = PendulumSpringOscillator.calculateSpringTotalEnergy(100, 0.05);
// 劲度系数 100 N/m，振幅 0.05 m
// E = ½ × 100 × 0.05² = 0.125 J
```

### 电子工程

在电子工程中，单摆和弹簧振子用于：

- **传感器应用**：加速度传感器、振动传感器等
- **滤波器设计**：利用振动特性设计滤波器
- **时钟系统**：利用单摆的等时性设计时钟

### Arduino/Raspberry Pi

在 Arduino/Raspberry Pi 中，单摆和弹簧振子用于：

- **传感器应用**：加速度传感器、振动传感器等
- **时钟系统**：利用单摆设计时钟系统
- **控制应用**：利用振动特性进行控制

## 常见问题

### 1. 单摆周期

**问题**：单摆，摆长 0.5 m，求周期（取 $g = 10 \text{ m/s}^2$）。

**分析**：
$$T = 2\pi \sqrt{\frac{l}{g}} = 2\pi \sqrt{\frac{0.5}{10}} = 2\pi \sqrt{0.05} \approx 1.41 \text{ s}$$

### 2. 弹簧振子周期

**问题**：弹簧振子，质量 0.2 kg，劲度系数 80 N/m，求周期。

**分析**：
$$T = 2\pi \sqrt{\frac{m}{k}} = 2\pi \sqrt{\frac{0.2}{80}} = 2\pi \sqrt{0.0025} \approx 0.314 \text{ s}$$

### 3. 弹簧振子能量

**问题**：弹簧振子，劲度系数 100 N/m，振幅 0.03 m，求总能量。

**分析**：
$$E = \frac{1}{2} k A^2 = \frac{1}{2} \times 100 \times 0.03^2 = 0.045 \text{ J}$$

## 常见错误

1. **公式混淆**：单摆和弹簧振子的周期公式不同，注意区分
2. **单位错误**：摆长单位是 m，质量单位是 kg，劲度系数单位是 N/m
3. **小角度限制**：单摆只有小角度时才近似简谐振动
4. **质量影响**：单摆周期与质量无关，弹簧振子周期与质量有关

## 小结

单摆和弹簧振子的核心内容：

1. **单摆**：
   - 周期：$T = 2\pi \sqrt{\frac{l}{g}}$
   - 周期与摆长有关，与质量无关
   - 小角度近似做简谐振动

2. **弹簧振子**：
   - 周期：$T = 2\pi \sqrt{\frac{m}{k}}$
   - 周期与质量和劲度系数有关
   - 精确做简谐振动

3. **能量**：
   - 弹簧振子总能量：$E = \frac{1}{2} k A^2$
   - 能量守恒：动能和势能相互转换

4. **应用**：
   - 单摆：钟摆、振动传感器
   - 弹簧振子：弹簧系统、弹性效果

**记住**：单摆周期 $T = 2\pi \sqrt{\frac{l}{g}}$，弹簧振子周期 $T = 2\pi \sqrt{\frac{m}{k}}$！
