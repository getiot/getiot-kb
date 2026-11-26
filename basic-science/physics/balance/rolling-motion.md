---
sidebar_position: 7
---

# 滚动运动

滚动运动是物体既平动又转动的复合运动。理解滚动运动，能更好地分析轮子、球等物体的运动。

## 什么是滚动运动？

### 滚动运动的定义

**滚动运动**（Rolling Motion）：物体在接触面上既平动又转动的运动。

**通俗理解**：物体"滚着走"，既向前移动，又绕自身轴转动。

### 滚动运动的特点

1. **复合运动**：既有平动（质心运动），又有转动（绕质心转动）
2. **无滑动**：理想情况下，物体与接触面之间没有相对滑动
3. **能量转换**：平动能和转动动能可以相互转换

### 滚动条件

物体做滚动运动的条件：

1. **有摩擦力**：摩擦力提供转动力矩
2. **无滑动**：物体与接触面之间没有相对滑动（纯滚动）

**注意**：如果物体与接触面之间有相对滑动，称为"滑动滚动"。

## 纯滚动（无滑动滚动）

### 纯滚动的条件

**纯滚动**（Pure Rolling）：物体与接触面之间没有相对滑动。

**条件**：接触点的瞬时速度为零。

### 速度关系

在纯滚动的情况下，质心的线速度与角速度的关系：

$$
v = r\omega
$$
其中：
- $v$：质心的线速度（单位：米每秒，m/s）
- $r$：半径（单位：米，m）
- $\omega$：角速度（单位：弧度每秒，rad/s）

**推导**：
- 质心向前移动的速度：$v$
- 物体绕质心转动的线速度：$r\omega$（方向向后）
- 接触点的速度：$v - r\omega = 0$（纯滚动条件）

所以：$v = r\omega$。

**通俗理解**：纯滚动时，质心移动的速度等于轮缘转动的线速度。

### 加速度关系

在纯滚动的情况下，质心的线加速度与角加速度的关系：

$$
a = r\alpha
$$
其中：
- $a$：质心的线加速度
- $r$：半径
- $\alpha$：角加速度

**推导**：对 $v = r\omega$ 两边求导，得到 $a = r\alpha$。

## 滚动的能量

### 动能

滚动物体的总动能包括两部分：

1. **平动能**：质心运动的动能
   $$
   E_{k\text{平}} = \frac{1}{2}mv^2
   $$
   
2. **转动动能**：绕质心转动的动能
   $$
   E_{k\text{转}} = \frac{1}{2}I\omega^2
   $$

**总动能**：
$$
E_k = E_{k\text{平}} + E_{k\text{转}} = \frac{1}{2}mv^2 + \frac{1}{2}I\omega^2
$$


### 纯滚动时的动能

在纯滚动的情况下，$v = r\omega$，所以：

$$
E_k = \frac{1}{2}mv^2 + \frac{1}{2}I\omega^2 = \frac{1}{2}mv^2 + \frac{1}{2}I\frac{v^2}{r^2} = \frac{1}{2}\left(m + \frac{I}{r^2}\right)v^2
$$
**有效质量**：$m_{\text{有}效} = m + \frac{I}{r^2}$

**通俗理解**：滚动物体的"有效质量"大于实际质量（因为还要考虑转动）。

### 常见物体的转动惯量

对于常见的滚动物体：

1. **实心球**：$I = \frac{2}{5}mr^2$
   $$
   E_k = \frac{1}{2}mv^2 + \frac{1}{2} \times \frac{2}{5}mr^2 \times \frac{v^2}{r^2} = \frac{7}{10}mv^2
   $$
   
2. **圆盘（圆柱）**：$I = \frac{1}{2}mr^2$
   $$
   E_k = \frac{1}{2}mv^2 + \frac{1}{2} \times \frac{1}{2}mr^2 \times \frac{v^2}{r^2} = \frac{3}{4}mv^2
   $$
   
3. **圆环**：$I = mr^2$
   $$
   E_k = \frac{1}{2}mv^2 + \frac{1}{2}mr^2 \times \frac{v^2}{r^2} = mv^2
   $$



## 滚动的动力学

### 受力分析

滚动物体受到的力：

1. **重力**：$G = mg$（竖直向下）
2. **支持力**：$N$（竖直向上，垂直于接触面）
3. **摩擦力**：$f$（沿接触面，方向取决于情况）

### 运动方程

根据牛顿第二定律和转动定律：

**平动**（质心运动）：
$$
F_{\text{合}} = ma
$$
**转动**（绕质心转动）：
$$
\tau_{\text{合}} = I\alpha
$$


### 纯滚动时的摩擦力

在纯滚动的情况下，摩擦力的大小取决于：

1. **加速滚动**：摩擦力提供转动力矩，方向与运动方向相同
2. **减速滚动**：摩擦力阻碍转动，方向与运动方向相反
3. **匀速滚动**：摩擦力为零（理想情况）

**注意**：纯滚动时，摩擦力是静摩擦力，大小由运动方程确定。

## 实际应用

### 游戏开发

在游戏开发中，滚动运动用于：

- **物理引擎**：模拟轮子、球等物体的滚动
- **车辆模拟**：车辆的轮胎滚动
- **球类游戏**：球的滚动运动

```javascript
// 滚动运动的应用
class RollingMotion {
  constructor(mass, radius, momentOfInertia) {
    this.mass = mass;
    this.radius = radius;
    this.momentOfInertia = momentOfInertia;
    this.velocity = 0; // \text{质心速度}
    this.angularVelocity = 0; // \text{角速度}
    this.position = 0;
    this.angle = 0;
  }
  
  // 纯滚动条件
  get isPureRolling() {
    // v = rω
    return Math.abs(this.velocity - this.radius * this.angularVelocity) < 0.01;
  }
  
  // 更新滚动运动
  update(force, friction, deltaTime) {
    // \text{平动}：F = ma
    let acceleration = force / this.mass;
    this.velocity += acceleration * deltaTime;
    this.position += this.velocity * deltaTime;
    
    // \text{转动}：τ = Iα
    let torque = friction * this.radius;
    let angularAcceleration = torque / this.momentOfInertia;
    this.angularVelocity += angularAcceleration * deltaTime;
    this.angle += this.angularVelocity * deltaTime;
    
    // \text{纯滚动条件}：v = rω
    if (this.isPureRolling) {
      // \text{调整速度}，\text{满足纯滚动条件}
      this.velocity = this.radius * this.angularVelocity;
    }
  }
  
  // 计算总动能
  getTotalKineticEnergy() {
    // Ek = ½mv² + ½Iω²
    return 0.5 * this.mass * this.velocity * this.velocity + 
           0.5 * this.momentOfInertia * this.angularVelocity * this.angularVelocity;
  }
}

// 使用示例
// 实心球滚动：I = ⅖mr²
let ball = new RollingMotion(10, 0.5, 0.4 * 10 * 0.5 * 0.5); // 质量 10 kg，半径 0.5 m
ball.update(10, 2, 0.1); // 力 10 N，摩擦力 2 N，时间 0.1 s
```

### 机器人控制

在机器人控制中，滚动运动用于：

- **轮式机器人**：轮式机器人的运动控制
- **平衡控制**：机器人的平衡控制
- **路径规划**：机器人的路径规划

### 工程设计

在工程中，滚动运动用于：

- **车辆设计**：车辆轮胎的设计
- **机械设计**：滚动机械的设计
- **摩擦分析**：滚动摩擦的分析

## 常见问题

### 1. 求滚动速度

**问题**：半径为 $r$ 的轮子，角速度为 $\omega$，求质心的线速度（纯滚动）。

**分析**：

根据纯滚动条件：

$$v = r\omega$$

### 2. 求滚动动能

**问题**：质量为 $m$、半径为 $r$ 的实心球，以速度 $v$ 纯滚动，求总动能。

**分析**：
- 平动能：$E_{k\text{平}} = \frac{1}{2}mv^2$
- 转动动能：$E_{k\text{转}} = \frac{1}{2}I\omega^2 = \frac{1}{2} \times \frac{2}{5}mr^2 \times \frac{v^2}{r^2} = \frac{1}{5}mv^2$
- 总动能：$E_k = \frac{1}{2}mv^2 + \frac{1}{5}mv^2 = \frac{7}{10}mv^2$

### 3. 求摩擦力

**问题**：质量为 $m$、半径为 $r$ 的圆盘在水平面上滚动，受到水平力 $F$ 作用，求摩擦力（纯滚动）。

**分析**：
- **平动**：$F - f = ma$
- **转动**：$fr = I\alpha = \frac{1}{2}mr^2\alpha$
- **纯滚动条件**：$a = r\alpha$

联立求解：

$$F - f = ma$$

$$fr = \frac{1}{2}mr^2 \times \frac{a}{r} = \frac{1}{2}mra$$

所以：

$$f = \frac{1}{3}F$$

**结论**：摩擦力等于外力的三分之一。

## 常见错误

1. **忽略转动动能**：忘记考虑转动动能，只考虑平动能
2. **纯滚动条件错误**：忘记 $v = r\omega$ 的条件
3. **摩擦力方向错误**：摩擦力的方向判断错误
4. **转动惯量错误**：不同形状的物体，转动惯量公式不同

## 滚动 vs 滑动

### 纯滚动

- **条件**：$v = r\omega$（无相对滑动）
- **摩擦力**：静摩擦力，大小由运动方程确定
- **能量**：平动能 + 转动动能

### 滑动滚动

- **条件**：$v \neq r\omega$（有相对滑动）
- **摩擦力**：滑动摩擦力，$f = \mu N$
- **能量**：平动能 + 转动动能 + 摩擦损耗

### 纯滑动

- **条件**：只滑动，不转动（$\omega = 0$）
- **摩擦力**：滑动摩擦力
- **能量**：只有平动能

## 小结

滚动运动的核心内容：

1. **纯滚动条件**：$v = r\omega$（无相对滑动）

2. **速度关系**：
   - 质心速度：$v$
   - 角速度：$\omega = \frac{v}{r}$

3. **动能**：
   - 平动能：$E_{k\text{平}} = \frac{1}{2}mv^2$
   - 转动动能：$E_{k\text{转}} = \frac{1}{2}I\omega^2$
   - 总动能：$E_k = \frac{1}{2}mv^2 + \frac{1}{2}I\omega^2$

4. **动力学**：
   - 平动：$F_{\text{合}} = ma$
   - 转动：$\tau_{\text{合}} = I\alpha$
   - 纯滚动：$a = r\alpha$

**记住**：滚动运动是平动和转动的复合运动，纯滚动时 $v = r\omega$！