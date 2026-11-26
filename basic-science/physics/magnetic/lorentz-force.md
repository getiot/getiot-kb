---
sidebar_position: 5
---

# 洛伦兹力

洛伦兹力是磁场对运动电荷的作用力。理解洛伦兹力，掌握带电粒子在磁场中的运动规律，是学习磁场和电磁学的关键。

## 洛伦兹力的定义

### 什么是洛伦兹力？

**洛伦兹力**（Lorentz Force）：磁场对运动电荷的作用力。

$$
\vec{F} = q\vec{v} \times \vec{B}
$$
其中：
- $\vec{F}$：洛伦兹力（单位：牛顿，N）
- $q$：电荷量（单位：库仑，C）
- $\vec{v}$：电荷的速度（单位：米每秒，m/s）
- $\vec{B}$：磁感应强度（单位：特斯拉，T）
- $\times$：矢量叉积

**通俗理解**：洛伦兹力 = 电荷量 × 速度 × 磁感应强度（叉积）。

### 洛伦兹力的大小

**洛伦兹力的大小**：

$$
F = |q| |v| |B| \sin\theta
$$
其中：
- $F$：洛伦兹力的大小（单位：N）
- $|q|$：电荷量的绝对值（单位：C）
- $|v|$：速度的大小（单位：m/s）
- $|B|$：磁感应强度的大小（单位：T）
- $\theta$：速度与磁场的夹角（单位：度或弧度）

**特殊情况**：
- 如果速度与磁场垂直：$F = |q| |v| |B|$（$\theta = 90^\circ$）
- 如果速度与磁场平行：$F = 0$（$\theta = 0^\circ$ 或 $180^\circ$）

**通俗理解**：
- 速度与磁场垂直时，洛伦兹力最大
- 速度与磁场平行时，洛伦兹力为零

### 洛伦兹力的方向

**洛伦兹力的方向**：由左手定则确定。

**左手定则**（Left-Hand Rule）：
1. 伸开左手，拇指与四指垂直
2. 四指指向正电荷运动方向（负电荷相反）
3. 掌心朝向磁场方向（或磁场分量）
4. 拇指指向洛伦兹力方向

**通俗理解**：左手定则判断洛伦兹力方向，注意正电荷和负电荷的方向不同。

### 洛伦兹力的特点

**洛伦兹力的特点**：
1. **不做功**：洛伦兹力总是垂直于速度方向，不做功
2. **改变方向**：洛伦兹力只改变速度的方向，不改变速度的大小
3. **方向判断**：使用左手定则（注意正负电荷）

**通俗理解**：
- 洛伦兹力不改变速度大小（不做功）
- 只改变速度方向（改变运动方向）

## 带电粒子在磁场中的运动

### 1. 速度与磁场垂直

**运动轨迹**：匀速圆周运动。

**特点**：
- 速度大小不变（洛伦兹力不做功）
- 速度方向改变（洛伦兹力改变方向）
- 轨迹是圆形

**轨道半径**：

$$
r = \frac{mv}{|q|B}
$$
其中：
- $r$：轨道半径（单位：m）
- $m$：粒子质量（单位：kg）
- $v$：速度大小（单位：m/s）
- $|q|$：电荷量的绝对值（单位：C）
- $B$：磁感应强度（单位：T）

**周期**：
$$
T = \frac{2\pi m}{|q|B}
$$
**角速度**：
$$
\omega = \frac{|q|B}{m}
$$
**通俗理解**：

- 速度与磁场垂直时，粒子做匀速圆周运动
- 轨道半径与速度成正比，与磁感应强度成反比
- 周期与速度无关，只与质量和磁感应强度有关

### 2. 速度与磁场平行

**运动轨迹**：匀速直线运动。

**特点**：
- 洛伦兹力为零（$F = 0$）
- 速度不变
- 轨迹是直线

**通俗理解**：速度与磁场平行时，洛伦兹力为零，粒子做匀速直线运动。

### 3. 速度与磁场成任意角度

**运动轨迹**：螺旋运动（螺旋线）。

**特点**：
- 速度分解为平行分量和垂直分量
- 平行分量：匀速直线运动（洛伦兹力为零）
- 垂直分量：匀速圆周运动（洛伦兹力不为零）
- 轨迹是螺旋线

**螺距**：
$$
h = v_{\parallel} T = \frac{2\pi m v_{\parallel}}{|q|B}
$$
其中 $v_{\parallel} = v \cos\theta$ 是速度的平行分量。

**通俗理解**：
- 速度与磁场成任意角度时，粒子做螺旋运动
- 平行分量决定螺距，垂直分量决定半径

## 实际应用

### 游戏开发

在游戏开发中，洛伦兹力用于：

- **物理引擎**：模拟带电粒子在磁场中的运动
- **粒子系统**：模拟带电粒子的运动轨迹
- **游戏机制**：磁力效果、粒子加速器等

```javascript
// 洛伦兹力的应用
class LorentzForce {
  // \text{计算洛伦兹力的大小}
  static calculateForce(charge, velocity, magneticField, angle) {
    // F = |q||v||B|sinθ（\text{角度}：\text{度}）
    const angleRad = (angle * Math.PI) / 180;
    return Math.abs(charge) * Math.abs(velocity) * Math.abs(magneticField) * Math.sin(angleRad);
  }
  
  // 计算洛伦兹力（矢量，简化为一维或二维）
  static calculateForceVector(charge, velocity, magneticField, angle) {
    // F = qvBsinθ
    const force = this.calculateForce(charge, velocity, magneticField, angle);
    // \text{方向}：\text{左手定则}（\text{正电荷}：\text{力方向与速度和磁场垂直}）
    // \text{这里简化处理}，\text{返回大小和方向}
    return {
      magnitude: force,
      direction: 'perpendicular' // \text{垂直于速度和磁场平面}
    };
  }
  
  // 计算轨道半径（速度与磁场垂直）
  static calculateRadius(mass, velocity, charge, magneticField) {
    // r = mv/(|q|B)
    return (mass * Math.abs(velocity)) / (Math.abs(charge) * Math.abs(magneticField));
  }
  
  // 计算周期（速度与磁场垂直）
  static calculatePeriod(mass, charge, magneticField) {
    // T = 2πm/(|q|B)
    return (2 * Math.PI * mass) / (Math.abs(charge) * Math.abs(magneticField));
  }
  
  // 计算角速度（速度与磁场垂直）
  static calculateAngularVelocity(charge, magneticField, mass) {
    // ω = |q|B/m
    return (Math.abs(charge) * Math.abs(magneticField)) / mass;
  }
  
  // 计算螺距（速度与磁场成任意角度）
  static calculatePitch(mass, velocity, charge, magneticField, angle) {
    // h = v∥T = 2πmv∥/(|q|B)
    // v∥ = v cosθ
    const angleRad = (angle * Math.PI) / 180;
    const vParallel = Math.abs(velocity) * Math.cos(angleRad);
    const period = this.calculatePeriod(mass, charge, magneticField);
    return vParallel * period;
  }
  
  // 模拟带电粒子在磁场中的运动（简化，一维或二维）
  static simulateParticleMotion(charge, mass, initialVelocity, magneticField, time, angle) {
    // \text{简化模拟}：\text{假设速度与磁场垂直}，\text{做匀速圆周运动}
    if (Math.abs(angle - 90) < 0.1) {
      // \text{速度与磁场垂直}
      const radius = this.calculateRadius(mass, initialVelocity, charge, magneticField);
      const angularVelocity = this.calculateAngularVelocity(charge, magneticField, mass);
      const x = radius * Math.cos(angularVelocity * time);
      const y = radius * Math.sin(angularVelocity * time);
      return { x, y, radius, angularVelocity };
    } else {
      // \text{速度与磁场成任意角度}，\text{做螺旋运动}（\text{这里简化处理}）
      return { x: 0, y: 0, radius: 0, angularVelocity: 0 };
    }
  }
}

// 使用示例
let force = LorentzForce.calculateForce(1.6e-19, 1e6, 0.1, 90);
// 电荷 1.6×10⁻¹⁹ C（电子），速度 10⁶ m/s，磁场 0.1 T，角度 90°（垂直）
// F = 1.6×10⁻¹⁹ × 10⁶ × 0.1 × sin(90°) = 1.6×10⁻¹⁴ N

let radius = LorentzForce.calculateRadius(9.1e-31, 1e6, 1.6e-19, 0.1);
// 质量 9.1×10⁻³¹ kg（电子），速度 10⁶ m/s，电荷 1.6×10⁻¹⁹ C，磁场 0.1 T
// r = 9.1×10⁻³¹ × 10⁶ / (1.6×10⁻¹⁹ × 0.1) = 5.69×10⁻⁵ m = 56.9 μm

let period = LorentzForce.calculatePeriod(9.1e-31, 1.6e-19, 0.1);
// 质量 9.1×10⁻³¹ kg（电子），电荷 1.6×10⁻¹⁹ C，磁场 0.1 T
// T = 2π × 9.1×10⁻³¹ / (1.6×10⁻¹⁹ × 0.1) = 3.57×10⁻¹⁰ s
```

### 电子工程

在电子工程中，洛伦兹力用于：

- **粒子加速器**：加速带电粒子
- **质谱仪**：分离不同质量的粒子
- **磁控管**：控制电子的运动

### Arduino/Raspberry Pi

在 Arduino/Raspberry Pi 中，洛伦兹力用于：

- **传感器应用**：霍尔传感器、磁传感器等
- **电机控制**：理解电机的工作原理

## 常见问题

### 1. 洛伦兹力计算

**问题**：电荷 $q = 2 \times 10^{-6} \text{ C}$，速度 $v = 10^5 \text{ m/s}$，磁场 $B = 0.5 \text{ T}$，速度与磁场垂直，求洛伦兹力。

**分析**：

$$F = |q| |v| |B| \sin\theta = 2 \times 10^{-6} \times 10^5 \times 0.5 \times \sin(90°) = 0.1 \text{ N}$$

### 2. 轨道半径计算

**问题**：电子（$m = 9.1 \times 10^{-31} \text{ kg}$，$q = -1.6 \times 10^{-19} \text{ C}$），速度 $v = 2 \times 10^6 \text{ m/s}$，磁场 $B = 0.2 \text{ T}$，速度与磁场垂直，求轨道半径。

**分析**：

$$r = \frac{mv}{|q|B} = \frac{9.1 \times 10^{-31} \times 2 \times 10^6}{|-1.6 \times 10^{-19}| \times 0.2} = \frac{1.82 \times 10^{-24}}{3.2 \times 10^{-20}} = 5.69 \times 10^{-5} \text{ m} = 56.9 \text{ }\mu\text{m}$$

### 3. 周期计算

**问题**：电子（$m = 9.1 \times 10^{-31} \text{ kg}$，$q = -1.6 \times 10^{-19} \text{ C}$），磁场 $B = 0.1 \text{ T}$，求周期。

**分析**：

$$T = \frac{2\pi m}{|q|B} = \frac{2\pi \times 9.1 \times 10^{-31}}{1.6 \times 10^{-19} \times 0.1} = \frac{5.72 \times 10^{-30}}{1.6 \times 10^{-20}} = 3.57 \times 10^{-10} \text{ s}$$

## 常见错误

1. **方向错误**：使用左手定则时，注意正电荷和负电荷的方向不同
2. **角度错误**：$\theta$ 是速度与磁场的夹角，不是其他角度
3. **电荷量错误**：注意电荷量的正负，但计算力的大小时用绝对值
4. **公式混淆**：不同运动情况的公式不同，注意区分

## 小结

洛伦兹力的核心内容：

1. **洛伦兹力**（$\vec{F} = q\vec{v} \times \vec{B}$）：
   - 磁场对运动电荷的作用力
   - 大小：$F = |q| |v| |B| \sin\theta$
   - 方向：左手定则

2. **特点**：
   - 不做功（垂直于速度方向）
   - 只改变速度方向，不改变速度大小

3. **运动轨迹**：
   - 速度与磁场垂直：匀速圆周运动（$r = \frac{mv}{|q|B}$，$T = \frac{2\pi m}{|q|B}$）
   - 速度与磁场平行：匀速直线运动（$F = 0$）
   - 速度与磁场成任意角度：螺旋运动（螺距 $h = v_{\parallel} T$）

4. **应用**：
   - 粒子加速器
   - 质谱仪
   - 磁控管

**记住**：洛伦兹力不做功，只改变速度方向，左手定则判断方向！
