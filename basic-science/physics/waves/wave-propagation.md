---
sidebar_position: 6
---

# 波的传播

波的传播是波动现象的核心。理解波的传播规律，掌握波的传播速度和特点，是学习波动现象的关键。

## 波的传播过程

### 波的传播

**波的传播**：波在介质中从一点传播到另一点的过程。

**特点**：
- **传播能量**：波传播能量
- **传播信息**：波传播信息
- **不传播物质**：介质本身不移动（只在平衡位置附近振动）

**通俗理解**：波传播时，能量和信息向前传播，但介质本身不移动（像"麦浪"，麦子不移动，只是波动）。

### 波前

**波前**（Wave Front）：波传播过程中，相位相同的点组成的曲面。

**类型**：
- **平面波前**：平面波（波前是平面）
- **球面波前**：球面波（波前是球面）

**通俗理解**：波前就是"波的前沿"，像"海浪的前沿"一样。

### 波线

**波线**（Ray）：表示波传播方向的射线，垂直于波前。

**通俗理解**：波线就是"波的传播方向"，像"箭头的方向"一样。

## 波速

### 波速的定义

**波速**（Wave Speed，$v$）：波传播的速度。

**公式**：

$$v = \lambda f = \frac{\lambda}{T}$$

其中：
- $v$：波速（单位：m/s）
- $\lambda$：波长（单位：m）
- $f$：频率（单位：Hz）
- $T$：周期（单位：s）

**通俗理解**：波速 = 波长 × 频率（像"速度 = 路程 × 频率"）。

### 波速与介质的关系

**波速与介质的关系**：

1. **机械波**：波速取决于介质的性质
   - **固体**：波速最大（如声波在钢铁中约 5000 m/s）
   - **液体**：波速中等（如声波在水中约 1500 m/s）
   - **气体**：波速最小（如声波在空气中约 340 m/s）

2. **电磁波**：波速取决于介质
   - **真空中**：$c = 3 \times 10^8 \text{ m/s}$（光速）
   - **介质中**：$v = \frac{c}{n}$（$n$ 是折射率）

**通俗理解**：
- 机械波：介质越硬，波速越快（固体 > 液体 > 气体）
- 电磁波：介质折射率越大，波速越慢

### 常见波速

**常见波速值**：

| 波的类型 | 介质 | 波速（m/s） |
|---------|------|-----------|
| 声波 | 空气（20°C） | 约 340 |
| 声波 | 水 | 约 1500 |
| 声波 | 钢铁 | 约 5000 |
| 光波 | 真空 | $3 \times 10^8$ |
| 光波 | 空气 | 约 $3 \times 10^8$ |
| 光波 | 水 | 约 $2.25 \times 10^8$ |
| 光波 | 玻璃 | 约 $2 \times 10^8$ |

## 波的反射

### 波的反射

**波的反射**（Wave Reflection）：波遇到界面时，改变传播方向的现象。

**反射定律**：
- **入射角等于反射角**：$\theta_i = \theta_r$
- **入射波、反射波、法线在同一平面内**

**通俗理解**：波反射时，入射角 = 反射角（像"镜子反射光线"一样）。

### 反射的类型

**反射的类型**：

1. **全反射**：波完全反射（如全内反射）
2. **部分反射**：波部分反射，部分透射

**通俗理解**：
- 全反射：波全部反射
- 部分反射：波部分反射，部分透射

## 波的折射

### 波的折射

**波的折射**（Wave Refraction）：波从一种介质进入另一种介质时，改变传播方向的现象。

**折射定律**（斯涅尔定律）：

$$\frac{\sin\theta_1}{\sin\theta_2} = \frac{v_1}{v_2} = \frac{n_2}{n_1}$$

其中：
- $\theta_1$：入射角（单位：度或弧度）
- $\theta_2$：折射角（单位：度或弧度）
- $v_1$、$v_2$：两种介质中的波速（单位：m/s）
- $n_1$、$n_2$：两种介质的折射率

**通俗理解**：
- 波速大的介质：折射角大（波偏折小）
- 波速小的介质：折射角小（波偏折大）

### 折射的应用

**折射的应用**：
- **光学**：透镜、棱镜
- **声学**：声波传播
- **通信**：光纤通信

## 波的透射

### 波的透射

**波的透射**（Wave Transmission）：波通过界面继续传播的现象。

**透射系数**：透射波的强度与入射波的强度的比值。

**通俗理解**：透射就是"波穿过界面"，像"光线穿过玻璃"一样。

## 实际应用

### 游戏开发

在游戏开发中，波的传播用于：

- **物理引擎**：模拟波的传播、反射、折射
- **游戏机制**：水波、声波、光波效果等

```javascript
// 波的传播的应用
class WavePropagation {
  // \text{计算波速}
  static calculateWaveSpeed(wavelength, frequency) {
    // v = λf
    return wavelength * frequency;
  }
  
  // 计算反射角（反射定律）
  static calculateReflectionAngle(incidentAngle) {
    // θᵣ = θᵢ（\text{入射角等于反射角}）
    return incidentAngle;
  }
  
  // 计算折射角（折射定律）
  static calculateRefractionAngle(incidentAngle, speed1, speed2) {
    // sinθ₂/sinθ₁ = v₂/v₁
    // θ₂ = arcsin(v₂/v₁ × sinθ₁)
    const angleRad = (incidentAngle * Math.PI) / 180;
    const sinRefraction = (speed2 / speed1) * Math.sin(angleRad);
    
    // \text{检查是否全内反射}
    if (Math.abs(sinRefraction) > 1) {
      return null; // \text{全内反射}
    }
    
    const refractionAngleRad = Math.asin(sinRefraction);
    return (refractionAngleRad * 180) / Math.PI;
  }
  
  // 计算临界角（全内反射）
  static calculateCriticalAngle(speed1, speed2) {
    // \text{临界角}：sinθ_c = v₁/v₂（\text{假设} v₁ < v₂）
    // θ_c = arcsin(v₁/v₂)
    if (speed1 >= speed2) {
      return null; // \text{无全内反射}
    }
    const criticalAngleRad = Math.asin(speed1 / speed2);
    return (criticalAngleRad * 180) / Math.PI;
  }
  
  // 计算传播距离
  static calculatePropagationDistance(waveSpeed, time) {
    // \text{距离} = \text{速度} × \text{时间}
    return waveSpeed * time;
  }
  
  // 计算传播时间
  static calculatePropagationTime(waveSpeed, distance) {
    // \text{时间} = \text{距离} / \text{速度}
    return distance / waveSpeed;
  }
}

// 使用示例
let waveSpeed = WavePropagation.calculateWaveSpeed(0.34, 1000);
// 波长 0.34 m，频率 1000 Hz
// v = 0.34 × 1000 = 340 m/s

let reflectionAngle = WavePropagation.calculateReflectionAngle(30);
// 入射角 30°
// 反射角：30°（等于入射角）

let refractionAngle = WavePropagation.calculateRefractionAngle(30, 340, 1500);
// 入射角 30°，介质1波速 340 m/s（空气），介质2波速 1500 m/s（水）
// θ₂ = arcsin(1500/340 × sin(30°)) = arcsin(2.21) > 1（全内反射，实际不可能）
// 修正：应从水到空气（1500→340），θ₂ = arcsin(340/1500 × sin(30°)) ≈ 6.5°

let criticalAngle = WavePropagation.calculateCriticalAngle(340, 1500);
// 介质1波速 340 m/s（空气），介质2波速 1500 m/s（水）
// 临界角：无（因为空气波速小于水波速，不会全内反射）

let distance = WavePropagation.calculatePropagationDistance(340, 2);
// 波速 340 m/s，时间 2 s
// 距离 = 340 × 2 = 680 m

let time = WavePropagation.calculatePropagationTime(340, 1000);
// 波速 340 m/s，距离 1000 m
// 时间 = 1000 / 340 ≈ 2.94 s
```

### 电子工程

在电子工程中，波的传播用于：

- **通信系统**：理解电磁波的传播
- **信号处理**：理解信号的传播和衰减
- **传感器应用**：声波传感器、光传感器等

## 常见问题

### 1. 波速计算

**问题**：声波，波长 0.68 m，频率 500 Hz，求波速。

**分析**：
$$v = \lambda f = 0.68 \times 500 = 340 \text{ m/s}$$

### 2. 反射角

**问题**：波，入射角 45°，求反射角。

**分析**：
$$\theta_r = \theta_i = 45°$$

### 3. 折射角

**问题**：波从空气（波速 340 m/s）进入水（波速 1500 m/s），入射角 30°，求折射角。

**分析**：
$$\frac{\sin\theta_1}{\sin\theta_2} = \frac{v_1}{v_2}$$

$$\sin\theta_2 = \frac{v_2}{v_1} \sin\theta_1 = \frac{1500}{340} \times \sin(30°) = 2.21 \times 0.5 = 1.105 > 1$$

**注意**：这种情况不可能（全内反射），应从水到空气。

**修正**：波从水进入空气，入射角 30°。

$$\sin\theta_2 = \frac{v_2}{v_1} \sin\theta_1 = \frac{340}{1500} \times \sin(30°) = 0.227 \times 0.5 = 0.113$$

$$\theta_2 = \arcsin(0.113) \approx 6.5°$$

## 常见错误

1. **波速公式错误**：注意 $v = \lambda f$，不要搞混
2. **反射折射混淆**：注意反射和折射的区别
3. **全内反射判断错误**：注意全内反射的条件（从波速大的介质到波速小的介质）

## 小结

波的传播的核心内容：

1. **波的传播**：波在介质中传播能量和信息

2. **波速**（$v = \lambda f = \frac{\lambda}{T}$）：
   - 机械波：取决于介质性质（固体 > 液体 > 气体）
   - 电磁波：取决于介质折射率

3. **反射定律**：$\theta_i = \theta_r$（入射角等于反射角）

4. **折射定律**：$\frac{\sin\theta_1}{\sin\theta_2} = \frac{v_1}{v_2}$（斯涅尔定律）

5. **全内反射**：从波速大的介质到波速小的介质，入射角大于临界角时发生

**记住**：波速 $v = \lambda f$，反射角 = 入射角，折射角由斯涅尔定律确定！
