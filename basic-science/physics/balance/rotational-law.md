---
sidebar_position: 4
---

# 转动定律

转动定律是旋转运动的牛顿第二定律，揭示了力矩和角加速度的关系。

## 转动定律

### 定律内容

**转动定律**（Rotational Law）：物体的角加速度与所受的合外力矩成正比，与转动惯量成反比。
$$
\tau = I\alpha
$$
其中：
- $\tau$：合外力矩（单位：牛顿·米，N·m）
- $I$：转动惯量（单位：千克·米²，kg·m²）
- $\alpha$：角加速度（单位：弧度每秒平方，rad/s²）

**通俗理解**：力矩越大，角加速度越大；转动惯量越大，角加速度越小。

### 公式变形

$$
\alpha = \frac{\tau}{I}
$$

**含义**：角加速度 = 力矩 ÷ 转动惯量。

### 与牛顿第二定律的类比

转动定律与牛顿第二定律形式相同：

| 直线运动 | 旋转运动 |
|:-------:|:-------:|
| $F = ma$ | $\tau = I\alpha$ |
| 力 $F$ | 力矩 $\tau$ |
| 质量 $m$ | 转动惯量 $I$ |
| 加速度 $a$ | 角加速度 $\alpha$ |
| 动量 $p = mv$ | 角动量 $L = I\omega$ |

**记忆口诀**：转动定律就是"旋转版的牛顿第二定律"。

## 转动定律的推导

### 从牛顿第二定律推导

考虑一个质点绕轴转动：

根据牛顿第二定律：$$F = ma$$

对于圆周运动，切向力产生切向加速度：$$F_t = ma_t$$

其中 $a_t = r\alpha$（切向加速度），所以：$$F_t = mr\alpha$$

两边同时乘以 $r$：$$F_t r = mr^2\alpha$$

左边是力矩 $\tau = F_t r$，右边是转动惯量 $I = mr^2$，所以：$$\tau = I\alpha$$

这就是转动定律。

### 对于刚体

对于刚体（多个质点组成的系统），可以证明：$$\tau_{\text{合}} = I\alpha$$

其中 $\tau_{\text{合}}$ 是合外力矩，$I$ 是刚体的转动惯量。

## 转动定律的应用

### 1. 求角加速度

已知力矩和转动惯量，求角加速度：$$\alpha = \frac{\tau}{I}$$

例子：转动惯量为 5 kg·m² 的物体，受到 20 N·m 的力矩作用，求角加速度。

$$\alpha = \frac{20}{5} = 4 \text{ rad/s}^2$$

### 2. 求力矩

已知转动惯量和角加速度，求力矩：$$\tau = I\alpha$$

例子：转动惯量为 3 kg·m² 的物体，角加速度为 6 rad/s²，求合外力矩。

$$\tau = 3 \times 6 = 18 \text{ N·m}$$

### 3. 求转动惯量

已知力矩和角加速度，求转动惯量：$$I = \frac{\tau}{\alpha}$$

例子：物体受到 15 N·m 的力矩作用，角加速度为 5 rad/s²，求转动惯量。

$$I = \frac{15}{5} = 3 \text{ kg·m}^2$$

### 4. 多个力矩

如果有多个力矩作用在物体上，合外力矩等于各个力矩的代数和：

$$\tau_{\text{合}} = \tau_1 + \tau_2 + \tau_3 + \cdots$$

根据转动定律：

$$\tau_{\text{合}} = I\alpha$$

**注意**：力矩有正负，通常规定逆时针为正，顺时针为负。

## 匀角加速转动

如果力矩恒定（$\tau = \text{常数}$），角加速度也恒定（$\alpha = \text{常数}$），物体做匀角加速转动。

### 运动方程

匀角加速转动的运动方程：

1. **角速度公式**：

   $$\omega = \omega_0 + \alpha t$$

2. **角位移公式**：
   
   $$\theta = \omega_0 t + \frac{1}{2}\alpha t^2$$
   
3. **角速度-角位移关系式**：
   
   $$\omega^2 - \omega_0^2 = 2\alpha\theta$$

其中：
- $\omega_0$：初角速度
- $\omega$：末角速度
- $\alpha$：角加速度
- $t$：时间
- $\theta$：角位移

**注意**：这些公式与匀加速直线运动的公式形式相同。

## 实际应用

### 游戏开发

在游戏开发中，转动定律用于：

- **物理引擎**：模拟物体的旋转运动
- **角色旋转**：角色的旋转动画
- **物体旋转**：物体的旋转运动

```javascript
// 转动定律的应用
class RotationalDynamics {
  constructor(momentOfInertia) {
    this.momentOfInertia = momentOfInertia; // \text{转动惯量}
    this.angularVelocity = 0; // \text{角速度}
    this.angularAcceleration = 0; // \text{角加速度}
    this.angle = 0; // \text{角度}
  }
  
  // 应用力矩
  applyTorque(torque, deltaTime) {
    // τ = Iα，\text{所以} α = τ/I
    this.angularAcceleration = torque / this.momentOfInertia;
    
    // \text{更新角速度}：ω = ω₀ + αt
    this.angularVelocity += this.angularAcceleration * deltaTime;
    
    // \text{更新角度}：θ = ω₀t + ½αt²
    this.angle += this.angularVelocity * deltaTime + 
                  0.5 * this.angularAcceleration * deltaTime * deltaTime;
  }
  
  // 应用多个力矩
  applyTorques(torques, deltaTime) {
    // \text{计算合外力矩}
    let totalTorque = 0;
    for (let torque of torques) {
      totalTorque += torque;
    }
    
    // 应用合外力矩
    this.applyTorque(totalTorque, deltaTime);
  }
}

// 使用示例
let object = new RotationalDynamics(5); // 转动惯量 5 kg·m²
object.applyTorque(20, 0.1); // 应用 20 N·m 的力矩，作用 0.1 秒
// 角加速度 = 20 / 5 = 4 rad/s²
// 角速度 = 0 + 4 × 0.1 = 0.4 rad/s
```

### 机器人控制

在机器人控制中，转动定律用于：

- **关节控制**：机器人的关节旋转控制
- **姿态控制**：机器人的姿态调整
- **平衡控制**：机器人的平衡控制

### 工程设计

在工程中，转动定律用于：

- **机械设计**：设计旋转机械
- **电机控制**：电机的转矩控制
- **传动系统**：传动系统的设计

## 常见问题

### 1. 求角加速度

**问题**：质量为 2 kg、半径为 0.5 m 的圆盘，受到 10 N·m 的力矩作用，求角加速度。

**分析**：
- 转动惯量：$I = \frac{1}{2}mr^2 = \frac{1}{2} \times 2 \times 0.5^2 = 0.25 \text{ kg·m}^2$
- 角加速度：$\alpha = \frac{\tau}{I} = \frac{10}{0.25} = 40 \text{ rad/s}^2$

### 2. 求力矩

**问题**：转动惯量为 4 kg·m² 的物体，角速度从 5 rad/s 增加到 15 rad/s，用时 2 秒，求平均力矩。

**分析**：
- 角加速度：$\alpha = \frac{\Delta\omega}{\Delta t} = \frac{15 - 5}{2} = 5 \text{ rad/s}^2$
- 力矩：$\tau = I\alpha = 4 \times 5 = 20 \text{ N·m}$

### 3. 求转动惯量

**问题**：物体受到 30 N·m 的力矩作用，角加速度为 6 rad/s²，求转动惯量。

**分析**：

$$I = \frac{\tau}{\alpha} = \frac{30}{6} = 5 \text{ kg·m}^2$$

## 常见错误

1. **混淆力矩和力**：力矩不是力，是力对转动的效果
2. **转动惯量计算错误**：不同形状的物体，转动惯量公式不同
3. **方向错误**：力矩有方向，要注意正负
4. **单位错误**：力矩的单位是 N·m，转动惯量的单位是 kg·m²

## 小结

转动定律的核心内容：

1. **转动定律**（$\tau = I\alpha$）：
   - 物体的角加速度与合外力矩成正比，与转动惯量成反比
   - 与牛顿第二定律形式相同

2. **公式变形**：
   - $\alpha = \frac{\tau}{I}$（求角加速度）
   - $\tau = I\alpha$（求力矩）
   - $I = \frac{\tau}{\alpha}$（求转动惯量）

3. **匀角加速转动**：
   - $\omega = \omega_0 + \alpha t$
   - $\theta = \omega_0 t + \frac{1}{2}\alpha t^2$
   - $\omega^2 - \omega_0^2 = 2\alpha\theta$

**记住**：转动定律就是"旋转版的牛顿第二定律"，$\tau = I\alpha$！