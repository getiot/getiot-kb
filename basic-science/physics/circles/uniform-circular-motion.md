---
sidebar_position: 2
---

# 匀速圆周运动

匀速圆周运动是物体沿圆形轨迹以恒定速率运动的运动形式。理解匀速圆周运动，是学习圆周运动的基础。

## 什么是匀速圆周运动？

### 定义

**匀速圆周运动**（Uniform Circular Motion）：物体沿圆形轨迹运动，速度大小恒定，方向不断改变。

**通俗理解**：物体"绕圈转"，速度大小不变，但方向一直改变。

### 特点

1. **轨迹**：圆形
2. **速率**：恒定不变（$v = \text{\text{常数}}$）
3. **速度方向**：始终沿切线方向，方向不断改变
4. **加速度**：有加速度（向心加速度），但大小恒定

### 匀速圆周运动 vs 匀速直线运动

| 特征 | 匀速直线运动 | 匀速圆周运动 |
|:----:|:----------:|:----------:|
| 轨迹 | 直线 | 圆形 |
| 速度大小 | 恒定 | 恒定 |
| 速度方向 | 不变 | 不断改变 |
| 加速度 | 零 | 有（向心加速度） |

**注意**：虽然叫"匀速"，但有加速度（方向改变）。

## 描述匀速圆周运动的物理量

### 1. 周期（Period）

**周期**（$T$）：物体转一圈所用的时间。

**单位**：秒（s）

**公式**：
$$
T = \frac{2\pi r}{v}
$$
其中：
- $r$：半径（单位：米，m）
- $v$：速率（单位：米每秒，m/s）

**通俗理解**：周期就是"转一圈的时间"。

### 2. 频率（Frequency）

**频率**（$f$）：单位时间内转动的圈数。

**单位**：赫兹（Hz），1 Hz = 1 转/秒

**公式**：
$$
f = \frac{1}{T} = \frac{v}{2\pi r}
$$
**关系**：
$$
T = \frac{1}{f}
$$
**通俗理解**：频率就是"每秒转几圈"。

### 3. 角速度（Angular Velocity）

**角速度**（$\omega$）：物体转动的角速度。

**单位**：弧度每秒（rad/s）

**公式**：
$$
\omega = \frac{2\pi}{T} = 2\pi f = \frac{v}{r}
$$
**关系**：
$$
v = r\omega
$$
**通俗理解**：角速度就是"转动的快慢"。

### 4. 线速度（Linear Velocity）

**线速度**（$v$）：物体运动的速率。

**单位**：米每秒（m/s）

**公式**：
$$
v = \frac{2\pi r}{T} = 2\pi rf = r\omega
$$
**特点**：

- 大小恒定
- 方向沿切线方向，不断改变

**通俗理解**：线速度就是"运动的快慢"。

## 匀速圆周运动的关系

### 基本关系

对于匀速圆周运动，有以下几个基本关系：

1. **线速度与角速度**：$$v = r\omega$$
   
2. **周期与频率**：$$T = \frac{1}{f}$$
   
3. **角速度与周期**：$$\omega = \frac{2\pi}{T} = 2\pi f$$
   
4. **线速度与周期**：$$v = \frac{2\pi r}{T} = 2\pi rf$$

### 常见换算

如果已知其中一个量，可以求出其他量：

- 已知周期 $T$ 和半径 $r$：$v = \frac{2\pi r}{T}$，$\omega = \frac{2\pi}{T}$，$f = \frac{1}{T}$
- 已知频率 $f$ 和半径 $r$：$v = 2\pi rf$，$\omega = 2\pi f$，$T = \frac{1}{f}$
- 已知角速度 $\omega$ 和半径 $r$：$v = r\omega$，$T = \frac{2\pi}{\omega}$，$f = \frac{\omega}{2\pi}$

## 实际应用

### 游戏开发

在游戏开发中，匀速圆周运动用于：

- **角色移动**：角色绕点旋转
- **物体旋转**：物体的圆周运动
- **轨道运动**：物体沿轨道运动

```javascript
// 匀速圆周运动的模拟
class UniformCircularMotion {
  constructor(radius, angularVelocity) {
    this.radius = radius; // \text{半径}
    this.angularVelocity = angularVelocity; // \text{角速度}（rad/s）
    this.angle = 0; // \text{当前角度}（\text{弧度}）
    this.centerX = 0; // \text{圆心} x \text{坐标}
    this.centerY = 0; // \text{圆心} y \text{坐标}
  }
  
  // 更新位置
  update(deltaTime) {
    // \text{更新角度}：θ = ωt
    this.angle += this.angularVelocity * deltaTime;
    
    // \text{计算位置}：x = r*cos(θ), y = r*sin(θ)
    this.x = this.centerX + this.radius * Math.cos(this.angle);
    this.y = this.centerY + this.radius * Math.sin(this.angle);
    
    // \text{计算速度}：v = rω
    this.velocity = this.radius * this.angularVelocity;
    
    // \text{计算速度方向}（\text{切线方向}）
    this.velocityX = -this.velocity * Math.sin(this.angle);
    this.velocityY = this.velocity * Math.cos(this.angle);
  }
  
  // 从周期计算角速度
  static angularVelocityFromPeriod(period) {
    // ω = 2π/T
    return 2 * Math.PI / period;
  }
  
  // 从频率计算角速度
  static angularVelocityFromFrequency(frequency) {
    // ω = 2πf
    return 2 * Math.PI * frequency;
  }
}

// 使用示例
let motion = new UniformCircularMotion(5, 2); // 半径 5 m，角速度 2 rad/s
motion.update(0.1); // 更新 0.1 秒
// 角度变化 = 2 × 0.1 = 0.2 rad
// 位置：x = 5 × cos(0.2), y = 5 × sin(0.2)
// 速度 = 5 × 2 = 10 m/s
```

### 机器人控制

在机器人控制中，匀速圆周运动用于：

- **路径规划**：机器人沿圆周路径移动
- **跟踪控制**：机器人跟踪圆周轨迹
- **姿态控制**：机器人的旋转控制

### 传感器应用

在传感器应用中，匀速圆周运动用于：

- **陀螺仪**：陀螺仪的旋转运动
- **旋转编码器**：旋转编码器的角度测量
- **GPS**：GPS 卫星的轨道运动

## 常见问题

### 1. 求周期

**问题**：物体以速率 10 m/s 在半径为 5 m 的圆周上运动，求周期。

**分析**：

$$T = \frac{2\pi r}{v} = \frac{2\pi \times 5}{10} = \pi \approx 3.14 \text{ s}$$

### 2. 求频率

**问题**：物体在半径为 2 m 的圆周上运动，角速度为 5 rad/s，求频率。

**分析**：

$$f = \frac{\omega}{2\pi} = \frac{5}{2\pi} \approx 0.796 \text{ Hz}$$

### 3. 求角速度

**问题**：物体以周期 2 s 在圆周上运动，求角速度。

**分析**：

$$\omega = \frac{2\pi}{T} = \frac{2\pi}{2} = \pi \approx 3.14 \text{ rad/s}$$

### 4. 求线速度

**问题**：物体在半径为 3 m 的圆周上运动，角速度为 4 rad/s，求线速度。

**分析**：

$$v = r\omega = 3 \times 4 = 12 \text{ m/s}$$

## 常见错误

1. **混淆速度和速率**：匀速圆周运动中，速率恒定，但速度方向不断改变
2. **忽略加速度**：匀速圆周运动有加速度（向心加速度），虽然速率不变
3. **单位错误**：角速度的单位是 rad/s，不是度/s
4. **公式混淆**：周期、频率、角速度的公式容易混淆

## 小结

匀速圆周运动的核心内容：

1. **特点**：
   - 轨迹：圆形
   - 速率：恒定
   - 速度方向：不断改变
   - 加速度：有（向心加速度）

2. **物理量**：
   - 周期：$T = \frac{2\pi r}{v} = \frac{1}{f}$
   - 频率：$f = \frac{1}{T} = \frac{v}{2\pi r}$
   - 角速度：$\omega = \frac{2\pi}{T} = \frac{v}{r}$
   - 线速度：$v = r\omega = \frac{2\pi r}{T}$

3. **关系**：
   - $v = r\omega$
   - $T = \frac{1}{f}$
   - $\omega = 2\pi f = \frac{2\pi}{T}$

**记住**：匀速圆周运动中，速率恒定，但速度方向不断改变，有向心加速度！