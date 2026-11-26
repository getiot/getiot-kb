---
sidebar_position: 3
---

# 动能和动能定理

动能是物体因运动而具有的能量，动能定理揭示了功和动能的关系。

## 什么是动能？

### 动能的定义

**动能**（Kinetic Energy）：物体因运动而具有的能量，等于物体质量与速度平方乘积的一半。

$$
E_k = \frac{1}{2}mv^2
$$
其中：
- $E_k$：动能（单位：焦耳，J）
- $m$：质量（单位：千克，kg）
- $v$：速度（单位：米每秒，m/s）

**通俗理解**：动能就是"运动带来的能量"，速度越快、质量越大，动能越大。

### 动能的特点

1. **标量**：动能只有大小，没有方向（总是正值）
2. **状态量**：动能是某一时刻的量，与时刻有关
3. **相对量**：动能的大小与参考系有关
4. **非负**：动能总是非负的（$E_k \geq 0$）

### 动能 vs 动量

- **动量**（$p = mv$）：描述物体运动的"量"，是矢量
- **动能**（$E_k = \frac{1}{2}mv^2$）：描述物体运动的"能量"，是标量

**关系**：
$$
E_k = \frac{p^2}{2m}
$$
其中 $p = mv$ 是动量。

### 动能的单位

动能的单位是**焦耳**（J），与功的单位相同。

**注意**：动能的单位也可以表示为千克·米²/秒²（kg·m²/s²），因为 $1 \text{ J} = 1 \mathrm{kg\cdot m^2/s^2}$。

## 动能定理

### 定理内容

**动能定理**（Work-Energy Theorem）：合外力对物体所做的功等于物体动能的变化量。

$$
W_{\text{合}} = \Delta E_k = E_{k\text{末}} - E_{k\text{初}} = \frac{1}{2}mv_2^2 - \frac{1}{2}mv_1^2
$$
其中：
- $W_{\text{合}}$：合外力对物体所做的功
- $\Delta E_k$：动能的变化量
- $E_{k\text{初}}$：初动能（$\frac{1}{2}mv_1^2$）
- $E_{k\text{末}}$：末动能（$\frac{1}{2}mv_2^2$）

**通俗理解**：
- 力对物体做正功，物体的动能增加
- 力对物体做负功，物体的动能减少
- 力对物体不做功，物体的动能不变

### 定理的含义

**动能定理**告诉我们：

1. **功转化为动能**：合外力对物体做功，动能发生变化
2. **动能变化等于功**：动能变化量等于合外力所做的功
3. **能量守恒**：动能定理是能量守恒的特殊情况

### 推导过程

根据牛顿第二定律：

$$F = ma = m\frac{\Delta v}{\Delta t}$$

从位移公式：

$$s = \frac{v_1 + v_2}{2} \times t$$

从速度公式：

$$v_2 = v_1 + at$$

所以：

$$s = \frac{v_1 + v_2}{2} \times \frac{v_2 - v_1}{a} = \frac{v_2^2 - v_1^2}{2a}$$

功：

$$W = Fs = ma \times \frac{v_2^2 - v_1^2}{2a} = \frac{1}{2}m(v_2^2 - v_1^2) = \frac{1}{2}mv_2^2 - \frac{1}{2}mv_1^2$$

所以：

$$W = \Delta E_k$$

这就是动能定理。

## 动能定理的应用

### 1. 求速度变化

已知力和位移，求速度变化：

$$\Delta E_k = W_{\text{合}}$$

$$v_2 = \sqrt{v_1^2 + \frac{2W_{\text{合}}}{m}}$$

例子：质量为 5 kg 的物体，初速度为 10 m/s，受到 20 N 的力作用 10 米（力与位移方向相同），求末速度。

**方法 1：用功计算**

$$W = Fs = 20 \times 10 = 200 \text{ J}$$

$$\Delta E_k = 200 \text{ J}$$

$$E_{k\text{末}} = E_{k\text{初}} + \Delta E_k = \frac{1}{2} \times 5 \times 10^2 + 200 = 250 + 200 = 450 \text{ J}$$

$$v_2 = \sqrt{\frac{2E_{k\text{末}}}{m}} = \sqrt{\frac{2 \times 450}{5}} = \sqrt{180} \approx 13.4 \text{ m/s}$$

**方法 2：用动能定理**

$$W = \frac{1}{2}mv_2^2 - \frac{1}{2}mv_1^2$$

$$200 = \frac{1}{2} \times 5 \times v_2^2 - \frac{1}{2} \times 5 \times 10^2$$

$$200 = 2.5v_2^2 - 250$$

$$v_2^2 = 180$$

$$v_2 \approx 13.4 \text{ m/s}$$

### 2. 求功

已知初速度和末速度，求合外力所做的功：

$$W_{\text{合}} = \frac{1}{2}mv_2^2 - \frac{1}{2}mv_1^2$$

例子：质量为 10 kg 的物体，初速度为 5 m/s，末速度为 10 m/s，求合外力所做的功。

$$W = \frac{1}{2} \times 10 \times 10^2 - \frac{1}{2} \times 10 \times 5^2 = 500 - 125 = 375 \text{ J}$$

### 3. 求力

已知初速度、末速度和位移，求平均力：

$$F = \frac{W}{s} = \frac{\Delta E_k}{s} = \frac{\frac{1}{2}m(v_2^2 - v_1^2)}{s}$$

例子：质量为 5 kg 的物体，初速度为 10 m/s，在 10 米内加速到 15 m/s，求平均力。

$$F = \frac{\frac{1}{2} \times 5 \times (15^2 - 10^2)}{10} = \frac{2.5 \times 125}{10} = 31.25 \text{ N}$$

## 多个力做功

如果有多个力作用在物体上，总功等于各个力做功的代数和：

$$W_{\text{总}} = W_1 + W_2 + W_3 + \cdots$$

根据动能定理：

$$W_{\text{总}} = \Delta E_k$$

所以：

$$W_1 + W_2 + W_3 + \cdots = \Delta E_k$$

**注意**：总功也可以先求合力，然后计算合力的功。

## 实际应用

### 游戏开发

在游戏开发中，动能和动能定理用于：

- **物理引擎**：计算物体的动能，判断碰撞效果
- **能量系统**：角色、机器的能量管理
- **碰撞检测**：根据动能判断碰撞的强度

```javascript
// 动能和动能定理的应用
class KineticEnergy {
  // \text{计算动能}
  static calculateKineticEnergy(mass, velocity) {
    // Ek = ½mv²
    return 0.5 * mass * velocity * velocity;
  }
  
  // 动能定理：计算功
  static calculateWorkFromKineticEnergy(mass, vInitial, vFinal) {
    // W = ΔEk = ½mv₂² - ½mv₁²
    let initialKE = this.calculateKineticEnergy(mass, vInitial);
    let finalKE = this.calculateKineticEnergy(mass, vFinal);
    return finalKE - initialKE;
  }
  
  // 动能定理：计算末速度
  static calculateFinalVelocity(mass, vInitial, work) {
    // W = ½mv₂² - ½mv₁²
    // v₂ = √(v₁² + 2W/m)
    let initialKE = this.calculateKineticEnergy(mass, vInitial);
    let finalKE = initialKE + work;
    return Math.sqrt(2 * finalKE / mass);
  }
  
  // 动能定理：计算力
  static calculateForce(mass, vInitial, vFinal, displacement) {
    // W = Fs = ΔEk
    // F = ΔEk / s
    let work = this.calculateWorkFromKineticEnergy(mass, vInitial, vFinal);
    return work / displacement;
  }
}

// 使用示例
let kineticEnergy = KineticEnergy.calculateKineticEnergy(10, 5);
// Ek = ½ × 10 × 5² = 125 J

let work = KineticEnergy.calculateWorkFromKineticEnergy(10, 5, 10);
// W = ½ × 10 × 10² - ½ × 10 × 5² = 500 - 125 = 375 J

let finalVelocity = KineticEnergy.calculateFinalVelocity(10, 5, 375);
// v₂ = √(5² + 2×375/10) = √(25 + 75) = 10 m/s

let force = KineticEnergy.calculateForce(10, 5, 10, 10);
// F = 375 / 10 = 37.5 N
```

### 机器人控制

在机器人控制中，动能和动能定理用于：

- **能量管理**：机器人的能量消耗和管理
- **运动控制**：根据动能控制机器人的运动速度
- **效率优化**：优化机器人的能量效率

### 工程设计

在工程中，动能和动能定理用于：

- **碰撞分析**：分析碰撞时的动能变化
- **安全设计**：设计缓冲装置，减小冲击力
- **能量分析**：分析机器运行时的能量消耗

## 常见问题

### 1. 求动能

**问题**：质量为 5 kg 的物体，速度为 10 m/s，求动能。

**分析**：

$$E_k = \frac{1}{2}mv^2 = \frac{1}{2} \times 5 \times 10^2 = 250 \text{ J}$$

### 2. 求速度变化

**问题**：质量为 10 kg 的物体，初速度为 5 m/s，受到 100 J 的功作用，求末速度。

**分析**：

根据动能定理：$$W = \Delta E_k = \frac{1}{2}mv_2^2 - \frac{1}{2}mv_1^2$$

$$100 = \frac{1}{2} \times 10 \times v_2^2 - \frac{1}{2} \times 10 \times 5^2$$

$$100 = 5v_2^2 - 125$$

$$v_2^2 = 45$$

$$v_2 = 3\sqrt{5} \approx 6.7 \text{ m/s}$$

### 3. 求功

**问题**：质量为 2 kg 的物体，速度从 5 m/s 增加到 10 m/s，求合外力所做的功。

**分析**：

$$W = \Delta E_k = \frac{1}{2}mv_2^2 - \frac{1}{2}mv_1^2 = \frac{1}{2} \times 2 \times 10^2 - \frac{1}{2} \times 2 \times 5^2 = 100 - 25 = 75 \text{ J}$$

## 常见错误

1. **混淆动能和动量**：动能是 $\frac{1}{2}mv^2$，动量是 $mv$，不要混淆
2. **公式错误**：动能是 $\frac{1}{2}mv^2$，不是 $mv^2$
3. **方向错误**：动能是标量，没有方向（但速度有方向）
4. **单位错误**：动能的单位是 J，不是 N·m（虽然数值相同，但含义不同）

## 小结

动能和动能定理的核心内容：

1. **动能**（$E_k = \frac{1}{2}mv^2$）：
   - 物体因运动而具有的能量
   - 标量，总是非负
   - 单位：焦耳（J）

2. **动能定理**（$W_{\text{合}} = \Delta E_k$）：
   - 合外力对物体所做的功等于动能变化量
   - $W = \frac{1}{2}mv_2^2 - \frac{1}{2}mv_1^2$
   - 这是能量守恒的特殊情况

3. **应用**：
   - 求速度变化
   - 求功
   - 求力

**记住**：动能定理告诉我们，功转化为动能，动能变化等于功！