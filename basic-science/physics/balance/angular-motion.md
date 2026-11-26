---
sidebar_position: 2
---

# 角位移、角速度和角加速度

角位移、角速度和角加速度是描述旋转运动的基本物理量，与直线运动中的位移、速度和加速度相对应。

## 旋转运动 vs 直线运动

旋转运动和直线运动有很多相似之处，可以类比理解：

| 直线运动 | 旋转运动 |
|:-------:|:-------:|
| 位移 $s$ | 角位移 $\theta$ |
| 速度 $v$ | 角速度 $\omega$ |
| 加速度 $a$ | 角加速度 $\alpha$ |
| 质量 $m$ | 转动惯量 $I$ |
| 力 $F$ | 力矩 $\tau$ |
| 动量 $p = mv$ | 角动量 $L = I\omega$ |

**通俗理解**：旋转运动就是"转圈的运动"，与"直线运动"相对应。

## 角位移（Angular Displacement）

### 角位移的定义

**角位移**（Angular Displacement）：物体绕轴转动的角度变化。
$$
\theta = \theta_2 - \theta_1
$$
其中：
- $\theta$：角位移（单位：弧度，rad）
- $\theta_1$：初位置的角度
- $\theta_2$：末位置的角度

**通俗理解**：角位移就是"转了多少角度"。

### 角位移的单位

角位移的单位：

1. **弧度**（rad）：国际单位
   - 1 弧度 = 180°/π ≈ 57.3°
   - 1 周 = 2π 弧度 = 360°

2. **度**（°）：常用单位
   - 1° = π/180 弧度 ≈ 0.0175 弧度
   - 1 周 = 360°

### 弧度与度的换算

$$
\theta_{\text{弧度}} = \theta_{\text{度}} \times \frac{\pi}{180}
$$


$$
\theta_{\text{度}} = \theta_{\text{弧度}} \times \frac{180}{\pi}
$$
**常见角度**：

- 90° = π/2 弧度
- 180° = π 弧度
- 360° = 2π 弧度

### 为什么用弧度？

使用弧度的好处：

1. **公式简洁**：弧长公式 $s = r\theta$（弧度制），如果用度，需要乘以 $\pi/180$
2. **数学方便**：三角函数在弧度制下更简洁
3. **物理意义**：弧度是"单位半径对应的弧长"

## 角速度（Angular Velocity）

### 角速度的定义

**角速度**（Angular Velocity）：角位移随时间的变化率，描述转动的快慢。

$$
\omega = \frac{\Delta\theta}{\Delta t} = \frac{\theta_2 - \theta_1}{t_2 - t_1}
$$
其中：
- $\omega$：角速度（单位：弧度每秒，rad/s）
- $\Delta\theta$：角位移
- $\Delta t$：时间间隔

**通俗理解**：角速度就是"转动的快慢"，单位时间转了多少角度。

### 平均角速度和瞬时角速度

- **平均角速度**：在一段时间内的平均快慢
  $$
  \omega_{\text{平均}} = \frac{\Delta\theta}{\Delta t}
  $$
  
- **瞬时角速度**：某一时刻的角速度
  $$
  \omega = \lim_{\Delta t \to 0} \frac{\Delta\theta}{\Delta t}
  $$



### 角速度与线速度的关系

**线速度**：物体上某一点沿圆周运动的线速度。

$$
v = r\omega
$$
其中：
- $v$：线速度（单位：米每秒，m/s）
- $r$：半径（单位：米，m）
- $\omega$：角速度（单位：弧度每秒，rad/s）

**通俗理解**：线速度 = 半径 × 角速度。

**推导**：在时间 $\Delta t$ 内，角位移为 $\Delta\theta$，弧长为 $\Delta s = r\Delta\theta$，所以：
$$
v = \frac{\Delta s}{\Delta t} = \frac{r\Delta\theta}{\Delta t} = r\omega
$$


### 角速度的单位

角速度的单位是**弧度每秒**（rad/s）。

**常用单位**：
- 弧度每秒（rad/s）
- 转每秒（rps），1 rps = 2π rad/s
- 转每分钟（rpm），1 rpm = 2π/60 rad/s ≈ 0.105 rad/s

### 周期和频率

**周期**（$T$）：物体转一圈所用的时间。

$$
T = \frac{2\pi}{\omega}
$$
**频率**（$f$）：单位时间内转动的圈数。
$$
f = \frac{1}{T} = \frac{\omega}{2\pi}
$$
**关系**：
$$
\omega = 2\pi f = \frac{2\pi}{T}
$$


## 角加速度（Angular Acceleration）

### 角加速度的定义

**角加速度**（Angular Acceleration）：角速度随时间的变化率，描述角速度变化的快慢。

$$
\alpha = \frac{\Delta\omega}{\Delta t} = \frac{\omega_2 - \omega_1}{t_2 - t_1}
$$
其中：
- $\alpha$：角加速度（单位：弧度每秒平方，rad/s²）
- $\Delta\omega$：角速度变化量
- $\Delta t$：时间间隔

**通俗理解**：角加速度就是"角速度变化的速度"。

### 平均角加速度和瞬时角加速度

- **平均角加速度**：在一段时间内的平均变化率
  $$
  \alpha_{\text{平均}} = \frac{\Delta\omega}{\Delta t}
  $$
  
- **瞬时角加速度**：某一时刻的角加速度
  $$
  \alpha = \lim_{\Delta t \to 0} \frac{\Delta\omega}{\Delta t}
  $$



### 角加速度与线加速度的关系

**切向加速度**：物体上某一点沿圆周运动的切向加速度。

$$
a_t = r\alpha
$$
其中：
- $a_t$：切向加速度（单位：米每秒平方，m/s²）
- $r$：半径
- $\alpha$：角加速度

**通俗理解**：切向加速度 = 半径 × 角加速度。

**注意**：圆周运动还有**向心加速度**（法向加速度）：

$$
a_n = \frac{v^2}{r} = r\omega^2
$$
**总加速度**：
$$
a = \sqrt{a_t^2 + a_n^2}
$$


### 角加速度的单位

角加速度的单位是**弧度每秒平方**（rad/s²）。

## 匀角加速转动

### 运动方程

如果角加速度恒定（$\alpha = \text{常数}$），称为**匀角加速转动**，运动方程与匀加速直线运动类似：

1. **角速度公式**：
   $$
   \omega = \omega_0 + \alpha t
   $$
   
2. **角位移公式**：
   $$
   \theta = \omega_0 t + \frac{1}{2}\alpha t^2
   $$
   
3. **角速度-角位移关系式**：
   $$
   \omega^2 - \omega_0^2 = 2\alpha\theta
   $$

其中：
- $\omega_0$：初角速度
- $\omega$：末角速度
- $\alpha$：角加速度
- $t$：时间
- $\theta$：角位移

**注意**：这些公式与匀加速直线运动的公式形式相同，只是物理量不同。

## 实际应用

### 游戏开发

在游戏开发中，角位移、角速度和角加速度用于：

- **角色旋转**：角色的旋转动画
- **物体旋转**：物体的旋转运动
- **物理引擎**：模拟旋转运动

```javascript
// 角位移、角速度和角加速度的应用
class AngularMotion {
  constructor(angle, angularVelocity, angularAcceleration) {
    this.angle = angle; // \text{角位移}（\text{弧度}）
    this.angularVelocity = angularVelocity; // \text{角速度}（rad/s）
    this.angularAcceleration = angularAcceleration; // \text{角加速度}（rad/s²）
  }
  
  // 更新角运动（匀角加速）
  update(deltaTime) {
    // \text{角速度公式}：ω = ω₀ + αt
    this.angularVelocity += this.angularAcceleration * deltaTime;
    
    // \text{角位移公式}：θ = ω₀t + ½αt²
    this.angle += this.angularVelocity * deltaTime + 
                  0.5 * this.angularAcceleration * deltaTime * deltaTime;
  }
  
  // 角速度转线速度
  angularToLinear(radius) {
    // v = rω
    return radius * this.angularVelocity;
  }
  
  // 角加速度转切向加速度
  angularToTangentialAcceleration(radius) {
    // a_t = rα
    return radius * this.angularAcceleration;
  }
}

// 使用示例
let rotation = new AngularMotion(0, 0, 1); // 初始角度 0，角速度 0，角加速度 1 rad/s²
rotation.update(0.1); // 更新 0.1 秒
// 角速度 = 0 + 1 × 0.1 = 0.1 rad/s
// 角位移 = 0 + 0 × 0.1 + 0.5 × 1 × 0.1² = 0.005 rad
```

### 机器人控制

在机器人控制中，角位移、角速度和角加速度用于：

- **关节控制**：机器人的关节旋转控制
- **姿态控制**：机器人的姿态调整
- **平衡控制**：机器人的平衡控制

### 传感器应用

在传感器应用中，角位移、角速度和角加速度用于：

- **陀螺仪**：测量角速度
- **角度传感器**：测量角位移
- **姿态传感器**：测量物体的姿态

## 常见问题

### 1. 求角速度

**问题**：物体在 2 秒内转动了 4π 弧度，求平均角速度。

**分析**：
$$\omega_{\text{平均}} = \frac{\Delta\theta}{\Delta t} = \frac{4\pi}{2} = 2\pi \text{ rad/s}$$

### 2. 求角加速度

**问题**：物体的角速度从 10 rad/s 增加到 20 rad/s，用时 2 秒，求角加速度。

**分析**：
$$\alpha = \frac{\Delta\omega}{\Delta t} = \frac{20 - 10}{2} = 5 \text{ rad/s}^2$$

### 3. 求角位移

**问题**：物体以角速度 5 rad/s 匀速转动 3 秒，求角位移。

**分析**：

$$\theta = \omega t = 5 \times 3 = 15 \text{ rad}$$

### 4. 角速度与线速度的转换

**问题**：半径为 0.5 m 的轮子，角速度为 10 rad/s，求轮缘上一点的线速度。

**分析**：

$$v = r\omega = 0.5 \times 10 = 5 \text{ m/s}$$

## 常见错误

1. **混淆角度和弧度**：注意角度和弧度的换算
2. **混淆角速度和线速度**：角速度是 $\omega$，线速度是 $v = r\omega$
3. **单位错误**：角速度的单位是 rad/s，不是度/s
4. **公式混淆**：旋转运动的公式与直线运动的公式形式相同，但物理量不同

## 小结

角位移、角速度和角加速度：

1. **角位移**（$\theta$）：
   - 物体转动的角度变化
   - 单位：弧度（rad）或度（°）

2. **角速度**（$\omega = \frac{\Delta\theta}{\Delta t}$）：
   - 角位移随时间的变化率
   - 单位：弧度每秒（rad/s）
   - 与线速度的关系：$v = r\omega$

3. **角加速度**（$\alpha = \frac{\Delta\omega}{\Delta t}$）：
   - 角速度随时间的变化率
   - 单位：弧度每秒平方（rad/s²）
   - 与切向加速度的关系：$a_t = r\alpha$

4. **匀角加速转动**：
   - $\omega = \omega_0 + \alpha t$
   - $\theta = \omega_0 t + \frac{1}{2}\alpha t^2$
   - $\omega^2 - \omega_0^2 = 2\alpha\theta$

**记住**：旋转运动与直线运动类似，只是用角度代替位移，用角速度代替速度！
