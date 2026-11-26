---
sidebar_position: 8
---

# 变压器

变压器是利用电磁感应改变电压的装置。理解变压器的原理，掌握变压器的应用，是学习电力系统的基础。

## 什么是变压器？

### 变压器的定义

**变压器**（Transformer）：利用电磁感应改变电压的装置。

**结构**：
- **原线圈**（Primary Coil）：输入线圈
- **副线圈**（Secondary Coil）：输出线圈
- **铁芯**：连接两个线圈的磁路（通常由硅钢片叠成）

**通俗理解**：变压器就是"改变电压的装置"，像"水管改变水压"一样。

### 变压器的工作原理

**变压器的工作原理**：

1. **原线圈电流变化**：交流电通过原线圈（原电流）
2. **产生变化的磁场**：原电流产生变化的磁场（磁通量变化）
3. **副线圈磁通量变化**：变化的磁场通过副线圈（磁通量变化）
4. **产生感应电动势**：根据法拉第定律，副线圈产生感应电动势（副电压）
5. **改变电压**：副线圈的匝数不同，电压不同（改变电压）

**通俗理解**：原线圈电流变化 → 磁场变化 → 副线圈磁通量变化 → 产生电压（改变电压）。

### 变压器的原理图

**变压器原理图**：

```
原线圈（N₁ 匝） ────┐
                   │
                   │ 铁芯
                   │
副线圈（N₂ 匝） ────┘
```

## 变压器的原理

### 电压变换

**电压变换公式**（理想变压器）：

$$
\frac{U_1}{U_2} = \frac{N_1}{N_2}
$$
其中：
- $U_1$：原线圈电压（单位：V）
- $U_2$：副线圈电压（单位：V）
- $N_1$：原线圈匝数
- $N_2$：副线圈匝数

**通俗理解**：
- 匝数越多，电压越高
- 电压比 = 匝数比

**推导**：
- 原线圈：$U_1 = -N_1 \frac{d\Phi}{dt}$
- 副线圈：$U_2 = -N_2 \frac{d\Phi}{dt}$
- 因为磁通量变化率相同（通过同一铁芯），所以：$\frac{U_1}{U_2} = \frac{N_1}{N_2}$

### 电流变换

**电流变换公式**（理想变压器，忽略损耗）：

$$
\frac{I_1}{I_2} = \frac{N_2}{N_1}
$$
其中：
- $I_1$：原线圈电流（单位：A）
- $I_2$：副线圈电流（单位：A）

**通俗理解**：
- 匝数越多，电流越小
- 电流比 = 匝数比的倒数

**推导**（功率守恒）：
- 原线圈功率：$P_1 = U_1 I_1$
- 副线圈功率：$P_2 = U_2 I_2$
- 理想变压器：$P_1 = P_2$（忽略损耗）
- 因此：$U_1 I_1 = U_2 I_2$
- 所以：$\frac{I_1}{I_2} = \frac{U_2}{U_1} = \frac{N_2}{N_1}$

### 功率守恒

**功率守恒**（理想变压器）：
$$
P_1 = P_2
$$
即：

$$
U_1 I_1 = U_2 I_2
$$
**通俗理解**：理想变压器不消耗功率（功率守恒）。

## 变压器的类型

### 1. 升压变压器

**升压变压器**（Step-Up Transformer）：副线圈电压高于原线圈电压。

**特点**：
- $N_2 > N_1$（副线圈匝数多于原线圈）
- $U_2 > U_1$（副线圈电压高于原线圈）
- $I_2 < I_1$（副线圈电流小于原线圈）

**应用**：
- 电力传输（升高电压，减小电流，减少损耗）
- 高压电源

### 2. 降压变压器

**降压变压器**（Step-Down Transformer）：副线圈电压低于原线圈电压。

**特点**：
- $N_2 < N_1$（副线圈匝数少于原线圈）
- $U_2 < U_1$（副线圈电压低于原线圈）
- $I_2 > I_1$（副线圈电流大于原线圈）

**应用**：
- 家用电器（降低电压到安全范围）
- 电源适配器

### 3. 隔离变压器

**隔离变压器**（Isolation Transformer）：原线圈和副线圈匝数相同。

**特点**：
- $N_1 = N_2$（原线圈和副线圈匝数相同）
- $U_1 = U_2$（电压不变）
- $I_1 = I_2$（电流不变）

**应用**：
- 电路隔离（电气隔离，安全）
- 信号隔离

## 变压器的效率

### 效率的定义

**效率**（Efficiency）：输出功率与输入功率的比值。

$$
\eta = \frac{P_{\text{输出}}}{P_{\text{输入}}} \times 100\%
$$
其中：
- $\eta$：效率（单位：%）
- $P_{\text{输}出}$：输出功率（单位：W）
- $P_{\text{输}入}$：输入功率（单位：W）

**理想变压器**：$\eta = 100\%$（无损耗）

**实际变压器**：$\eta < 100\%$（有损耗）

### 损耗

**变压器的损耗**：

1. **铜损**（Copper Loss）：线圈电阻产生的热量（$I^2R$）
2. **铁损**（Iron Loss）：
   - **磁滞损耗**：铁芯磁化时产生的热量
   - **涡流损耗**：铁芯中感应电流产生的热量

**减少损耗的方法**：
- 使用低电阻导线（减少铜损）
- 使用硅钢片（减少磁滞损耗和涡流损耗）
- 优化设计（提高效率）

## 实际应用

### 游戏开发

在游戏开发中，变压器用于：

- **物理引擎**：模拟变压器的工作原理
- **游戏机制**：电力系统、电源系统等

```javascript
// 变压器的应用
class Transformers {
  // \text{计算电压变换}
  static calculateVoltageTransformation(primaryVoltage, primaryTurns, secondaryTurns) {
    // U₂/U₁ = N₂/N₁
    // U₂ = U₁ × (N₂/N₁)
    return primaryVoltage * (secondaryTurns / primaryTurns);
  }
  
  // 计算电流变换
  static calculateCurrentTransformation(primaryCurrent, primaryTurns, secondaryTurns) {
    // I₂/I₁ = N₁/N₂
    // I₂ = I₁ × (N₁/N₂)
    return primaryCurrent * (primaryTurns / secondaryTurns);
  }
  
  // 计算匝数比
  static calculateTurnsRatio(primaryTurns, secondaryTurns) {
    // \text{匝数比} = N₂/N₁
    return secondaryTurns / primaryTurns;
  }
  
  // 计算功率（理想变压器，功率守恒）
  static calculatePower(voltage, current) {
    // P = UI
    return voltage * current;
  }
  
  // 计算效率
  static calculateEfficiency(outputPower, inputPower) {
    // η = P\text{输出}/P\text{输入} × 100%
    if (inputPower === 0) {
      throw new Error("\text{输入功率不能为零}");
    }
    return (outputPower / inputPower) * 100;
  }
  
  // 分析变压器（综合）
  static analyzeTransformer(primaryVoltage, primaryTurns, secondaryTurns, primaryCurrent, efficiency = 100) {
    // \text{计算副线圈电压}
    const secondaryVoltage = this.calculateVoltageTransformation(primaryVoltage, primaryTurns, secondaryTurns);
    
    // \text{计算副线圈电流}（\text{理想变压器}）
    const secondaryCurrentIdeal = this.calculateCurrentTransformation(primaryCurrent, primaryTurns, secondaryTurns);
    
    // \text{计算输入功率}
    const inputPower = this.calculatePower(primaryVoltage, primaryCurrent);
    
    // \text{计算输出功率}（\text{考虑效率}）
    const outputPower = inputPower * (efficiency / 100);
    
    // \text{计算实际副线圈电流}（\text{考虑效率}）
    const secondaryCurrentActual = outputPower / secondaryVoltage;
    
    // \text{计算匝数比}
    const turnsRatio = this.calculateTurnsRatio(primaryTurns, secondaryTurns);
    
    return {
      primaryVoltage,
      secondaryVoltage,
      primaryTurns,
      secondaryTurns,
      turnsRatio,
      primaryCurrent,
      secondaryCurrentIdeal,
      secondaryCurrentActual,
      inputPower,
      outputPower,
      efficiency
    };
  }
}

// 使用示例
let secondaryVoltage = Transformers.calculateVoltageTransformation(220, 1000, 100);
// 原线圈电压 220 V，原线圈 1000 匝，副线圈 100 匝
// U₂ = 220 × (100/1000) = 22 V（降压变压器）

let secondaryCurrent = Transformers.calculateCurrentTransformation(2, 1000, 100);
// 原线圈电流 2 A，原线圈 1000 匝，副线圈 100 匝
// I₂ = 2 × (1000/100) = 20 A（降压变压器，电流增大）

let analysis = Transformers.analyzeTransformer(220, 1000, 100, 2, 95);
// 原线圈电压 220 V，原线圈 1000 匝，副线圈 100 匝，原线圈电流 2 A，效率 95%
// 副线圈电压：22 V（降压）
// 副线圈电流（理想）：20 A
// 副线圈电流（实际）：19 A（考虑效率）
// 输入功率：440 W
// 输出功率：418 W（效率 95%）
```

### 电子工程

在电子工程中，变压器用于：

- **电力系统**：电力传输和分配（升压和降压）
- **电源设计**：设计电源适配器
- **信号处理**：信号隔离和耦合

### Arduino/Raspberry Pi

在 Arduino/Raspberry Pi 中，变压器用于：

- **电源系统**：降低电压到安全范围（如 220 V → 5 V）
- **隔离**：电气隔离，保护设备
- **传感器应用**：信号隔离和耦合

## 常见问题

### 1. 电压变换

**问题**：变压器，原线圈 2000 匝，副线圈 200 匝，原线圈电压 220 V，求副线圈电压。

**分析**：

$$\frac{U_1}{U_2} = \frac{N_1}{N_2}$$

$$U_2 = U_1 \times \frac{N_2}{N_1} = 220 \times \frac{200}{2000} = 22 \text{ V}$$

### 2. 电流变换

**问题**：变压器，原线圈 2000 匝，副线圈 200 匝，原线圈电流 1 A，求副线圈电流（理想变压器）。

**分析**：

$$\frac{I_1}{I_2} = \frac{N_2}{N_1}$$

$$I_2 = I_1 \times \frac{N_1}{N_2} = 1 \times \frac{2000}{200} = 10 \text{ A}$$

### 3. 功率计算

**问题**：变压器，原线圈电压 220 V，电流 2 A，效率 90%，求输出功率。

**分析**：
- 输入功率：$P_{\text{输}入} = U_1 I_1 = 220 \times 2 = 440 \text{ W}$
- 输出功率：$P_{\text{输}出} = P_{\text{输}入} \times \eta = 440 \times 0.9 = 396 \text{ W}$

## 常见错误

1. **公式混淆**：电压比 = 匝数比，电流比 = 匝数比的倒数
2. **方向错误**：注意电压和电流的方向（由楞次定律确定）
3. **效率错误**：实际变压器效率小于 100%，需要考虑损耗

## 小结

变压器的核心内容：

1. **变压器**：利用电磁感应改变电压的装置

2. **原理**：
   - 电压变换：$\frac{U_1}{U_2} = \frac{N_1}{N_2}$
   - 电流变换：$\frac{I_1}{I_2} = \frac{N_2}{N_1}$
   - 功率守恒：$P_1 = P_2$（理想变压器）

3. **类型**：
   - 升压变压器：$N_2 > N_1$，$U_2 > U_1$
   - 降压变压器：$N_2 < N_1$，$U_2 < U_1$
   - 隔离变压器：$N_2 = N_1$，$U_2 = U_1$

4. **效率**：$\eta = \frac{P_{\text{输}出}}{P_{\text{输}入}} \times 100\%$

5. **应用**：
   - 电力传输（升压和降压）
   - 电源适配器（降压）
   - 电路隔离（电气隔离）

**记住**：变压器改变电压，电压比 = 匝数比，电流比 = 匝数比的倒数，功率守恒！