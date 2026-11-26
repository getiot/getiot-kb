---
sidebar_position: 5
---

# 电容器

电容器是储存电荷的装置，是电路中常用的电子元件。理解电容器，掌握电容的计算，是学习电路的基础。

## 什么是电容器？

### 电容器的定义

**电容器**（Capacitor）：能够储存电荷的装置，由两个相互靠近的导体（极板）和它们之间的绝缘介质组成。

**通俗理解**：电容器就是"储电器"，可以储存电荷，像"电池"一样（但原理不同）。

### 电容器的结构

电容器的基本结构：

1. **两个极板**：两个相互靠近的导体（如金属板）
2. **绝缘介质**：两个极板之间的绝缘材料（如空气、塑料、陶瓷）

**通俗理解**：
- 极板：储存电荷的"容器"
- 介质：防止电荷泄漏的"绝缘层"

### 电容器的工作原理

电容器的工作原理：

1. **充电**：给电容器施加电压，电荷在极板上积累
2. **储存**：电荷储存在极板上，形成电场
3. **放电**：电容器通过电路释放电荷

**通俗理解**：
- 充电：把电荷"存"进去
- 储存：电荷"存"在极板上
- 放电：把电荷"放"出来

## 什么是电容？

### 电容的定义

**电容**（Capacitance）：电容器储存电荷的能力，等于极板上的电荷量与两极板间电压的比值。

$$
C = \frac{Q}{U}
$$
其中：
- $C$：电容（单位：法拉，F）
- $Q$：极板上的电荷量（单位：库仑，C）
- $U$：两极板间的电压（单位：伏特，V）

**通俗理解**：电容就是"存电的能力"，电容越大，储存的电荷越多。

### 电容的特点

1. **标量**：电容只有大小，没有方向
2. **与电压无关**：电容是电容器的属性，与电压无关（理想情况下）
3. **与电荷无关**：电容只取决于电容器的结构（极板面积、距离、介质）

### 电容的单位

电容的单位：

1. **法拉**（F）：国际单位
   - 1 F = 1 C/V（库仑每伏特）
   - 非常大的单位，实际中很少使用

2. **常用单位**：
   - 微法（$\mu$F），1 $\mu$F = $10^{-6}$ F
   - 纳法（nF），1 nF = $10^{-9}$ F
   - 皮法（pF），1 pF = $10^{-12}$ F

**换算**：

- 1 F = $10^6$ $\mu$F
- 1 $\mu$F = $10^3$ nF = $10^6$ pF

## 平行板电容器

### 平行板电容器的定义

**平行板电容器**：由两个平行且靠近的金属板组成的电容器。

**特点**：
- 结构简单
- 电场均匀（忽略边缘效应）
- 理论分析常用

### 平行板电容器的电容

**平行板电容器的电容公式**：

$$
C = \frac{\varepsilon_0 \varepsilon_r A}{d}
$$
其中：
- $C$：电容（单位：F）
- $\varepsilon_0$：真空介电常数，$\varepsilon_0 = 8.85 \times 10^{-12} \text{ F/m}$
- $\varepsilon_r$：相对介电常数（介质的相对介电常数）
- $A$：极板面积（单位：平方米，m²）
- $d$：极板间距离（单位：米，m）

**通俗理解**：
- 极板面积越大，电容越大
- 极板间距离越小，电容越大
- 介质的相对介电常数越大，电容越大

### 相对介电常数

**相对介电常数**（$\varepsilon_r$）：介质的介电常数与真空介电常数的比值。
$$
\varepsilon_r = \frac{\varepsilon}{\varepsilon_0}
$$
其中 $\varepsilon$ 是介质的介电常数。

**常见介质的相对介电常数**：

| 介质 | 相对介电常数 |
|------|------------|
| 真空 | 1 |
| 空气 | 1.0006 ≈ 1 |
| 纸 | 2-3 |
| 云母 | 5-7 |
| 玻璃 | 5-10 |
| 陶瓷 | 6-100 |
| 水 | 80 |

**通俗理解**：
- 相对介电常数越大，电容越大
- 真空和空气的相对介电常数约为 1
- 水的相对介电常数很大（80）

### 平行板电容器的电场

平行板电容器内部的电场（忽略边缘效应）：

**电场强度**：

$$E = \frac{U}{d}$$

**电场强度与电荷密度的关系**：

$$E = \frac{\sigma}{\varepsilon_0}$$

其中 $\sigma = \frac{Q}{A}$ 是电荷面密度。

**电势差与电场强度的关系**：

$$U = Ed$$

## 电容器的连接

### 1. 串联

**串联**：多个电容器首尾相连。

**特点**：
- 总电荷量等于各电容器的电荷量：$Q_{\text{总}} = Q_1 = Q_2 = Q_3 = \cdots$
- 总电压等于各电容器的电压之和：$U_{\text{总}} = U_1 + U_2 + U_3 + \cdots$
- **总电容的倒数等于各电容器电容的倒数之和**：

$$
\frac{1}{C_{\text{总}}} = \frac{1}{C_1} + \frac{1}{C_2} + \frac{1}{C_3} + \cdots
$$



**两个电容器串联**：
$$
\frac{1}{C_{\text{总}}} = \frac{1}{C_1} + \frac{1}{C_2}
$$

$$
C_{\text{总}} = \frac{C_1 C_2}{C_1 + C_2}
$$

**结论**：串联时，总电容小于任何一个电容器的电容。

### 2. 并联

**并联**：多个电容器的一端连接在一起，另一端也连接在一起。

**特点**：
- 总电压等于各电容器的电压：$U_{\text{总}} = U_1 = U_2 = U_3 = \cdots$
- 总电荷量等于各电容器的电荷量之和：$Q_{\text{总}} = Q_1 + Q_2 + Q_3 + \cdots$
- **总电容等于各电容器电容之和**：

$$
C_{\text{总}} = C_1 + C_2 + C_3 + \cdots
$$

**结论**：并联时，总电容大于任何一个电容器的电容。

### 3. 串联 vs 并联

| 特征 | 串联 | 并联 |
|:----:|:----:|:----:|
| **总电容** | $C_{\text{总}} < C_{\text{最小}}$ | $C_{\text{总}} > C_{\text{最大}}$ |
| **总电压** | $U_{\text{总}} = U_1 + U_2 + \cdots$ | $U_{\text{总}} = U_1 = U_2 = \cdots$ |
| **总电荷** | $Q_{\text{总}} = Q_1 = Q_2 = \cdots$ | $Q_{\text{总}} = Q_1 + Q_2 + \cdots$ |
| **应用** | 增加耐压 | 增加电容 |

## 电容器的能量

### 电容器的能量

**电容器储存的能量**：

$$
E = \frac{1}{2}CU^2 = \frac{1}{2}\frac{Q^2}{C} = \frac{1}{2}QU
$$
其中：
- $E$：能量（单位：焦耳，J）
- $C$：电容（单位：F）
- $U$：电压（单位：V）
- $Q$：电荷量（单位：C）

**推导**：
- 充电过程：$W = \int_0^Q U \, dq = \int_0^Q \frac{q}{C} \, dq = \frac{1}{2}\frac{Q^2}{C}$
- 因为 $Q = CU$，所以 $E = \frac{1}{2}CU^2$

**通俗理解**：
- 电容器储存的能量与电压的平方成正比
- 电压越高，储存的能量越多

## 实际应用

### 游戏开发

在游戏开发中，电容器用于：

- **物理引擎**：模拟电容器的充放电过程
- **电路模拟**：模拟电路中的电容器
- **能量系统**：游戏中的能量储存系统

```javascript
// 电容器的应用
class Capacitor {
  constructor(capacitance) {
    this.capacitance = capacitance; // \text{电容}（F）
    this.charge = 0; // \text{电荷量}（C）
    this.voltage = 0; // \text{电压}（V）
  }
  
  // 计算电压
  calculateVoltage() {
    // U = Q/C
    this.voltage = this.charge / this.capacitance;
    return this.voltage;
  }
  
  // 计算电荷量
  calculateCharge() {
    // Q = CU
    this.charge = this.capacitance * this.voltage;
    return this.charge;
  }
  
  // 计算能量
  calculateEnergy() {
    // E = ½CU² = ½Q²/C = ½QU
    return 0.5 * this.capacitance * this.voltage * this.voltage;
  }
  
  // 充电（增加电荷）
  charge(deltaCharge) {
    this.charge += deltaCharge;
    this.calculateVoltage();
  }
  
  // 放电（减少电荷）
  discharge(deltaCharge) {
    this.charge -= deltaCharge;
    if (this.charge < 0) this.charge = 0;
    this.calculateVoltage();
  }
  
  // 平行板电容器电容计算
  static calculateParallelPlateCapacitance(area, distance, relativePermittivity = 1) {
    const EPSILON_0 = 8.85e-12; // \text{真空介电常数} F/m
    // C = ε₀εᵣA/d
    return EPSILON_0 * relativePermittivity * area / distance;
  }
  
  // 串联总电容
  static calculateSeriesCapacitance(capacitances) {
    // 1/C = 1/C₁ + 1/C₂ + ...
    let reciprocalSum = 0;
    for (let C of capacitances) {
      reciprocalSum += 1 / C;
    }
    return 1 / reciprocalSum;
  }
  
  // 并联总电容
  static calculateParallelCapacitance(capacitances) {
    // C = C₁ + C₂ + ...
    let total = 0;
    for (let C of capacitances) {
      total += C;
    }
    return total;
  }
}

// 使用示例
let capacitor = new Capacitor(1e-6); // 1 μF
capacitor.charge(1e-3); // 充电 1 mC
let voltage = capacitor.calculateVoltage();
// U = 1e-3 / 1e-6 = 1000 V

let energy = capacitor.calculateEnergy();
// E = ½ × 1e-6 × 1000² = 0.5 J

let parallelPlateC = Capacitor.calculateParallelPlateCapacitance(0.01, 0.001, 1);
// 面积 0.01 m²，距离 0.001 m，相对介电常数 1（空气）
// C = 8.85e-12 × 1 × 0.01 / 0.001 = 8.85e-11 F = 88.5 pF

let seriesC = Capacitor.calculateSeriesCapacitance([1e-6, 2e-6]);
// 串联：1 μF 和 2 μF
// C = 1/(1/1e-6 + 1/2e-6) = 1/(1.5e6) = 6.67e-7 F = 0.667 μF

let parallelC = Capacitor.calculateParallelCapacitance([1e-6, 2e-6]);
// 并联：1 μF 和 2 μF
// C = 1e-6 + 2e-6 = 3e-6 F = 3 μF
```

### 电子工程

在电子工程中，电容器用于：

- **电路设计**：滤波、耦合、去耦等
- **电源设计**：稳压、滤波等
- **信号处理**：信号耦合、滤波等

## 常见问题

### 1. 求电容

**问题**：平行板电容器的极板面积为 0.05 m²，极板间距离为 0.002 m，介质为空气（$\varepsilon_r = 1$），求电容。

**分析**：

$$C = \frac{\varepsilon_0 \varepsilon_r A}{d} = \frac{8.85 \times 10^{-12} \times 1 \times 0.05}{0.002} = 2.21 \times 10^{-10} \text{ F} = 221 \text{ pF}$$

### 2. 求电荷量

**问题**：电容为 100 $\mu$F 的电容器，电压为 12 V，求极板上的电荷量。

**分析**：

$$Q = CU = 100 \times 10^{-6} \times 12 = 1.2 \times 10^{-3} \text{ C} = 1.2 \text{ mC}$$

### 3. 求电压

**问题**：电容为 50 $\mu$F 的电容器，极板上的电荷量为 2 mC，求电压。

**分析**：

$$U = \frac{Q}{C} = \frac{2 \times 10^{-3}}{50 \times 10^{-6}} = 40 \text{ V}$$

### 4. 求能量

**问题**：电容为 200 $\mu$F 的电容器，电压为 24 V，求储存的能量。

**分析**：

$$E = \frac{1}{2}CU^2 = \frac{1}{2} \times 200 \times 10^{-6} \times 24^2 = 0.0576 \text{ J} = 57.6 \text{ mJ}$$

### 5. 串联和并联

**问题**：两个电容器，$C_1 = 10 \mu$F，$C_2 = 20 \mu$F，求串联和并联的总电容。

**分析**：
- **串联**：$C_{\text{总}} = \frac{C_1 C_2}{C_1 + C_2} = \frac{10 \times 20}{10 + 20} = \frac{200}{30} \approx 6.67 \mu\text{F}$
- **并联**：$C_{\text{总}} = C_1 + C_2 = 10 + 20 = 30 \mu\text{F}$

## 常见错误

1. **混淆电容和电荷量**：电容是属性，电荷量是储存的电荷
2. **单位错误**：电容的单位是 F，常用 $\mu$F、nF、pF
3. **串联并联公式混淆**：串联是倒数相加，并联是直接相加
4. **距离单位错误**：平行板电容器公式中的距离单位是 m，不是 cm 或 mm

## 小结

电容器的核心内容：

1. **电容器**：储存电荷的装置，由两个极板和介质组成

2. **电容**（$C = \frac{Q}{U}$）：
   - 电容器储存电荷的能力
   - 标量，单位：法拉（F）

3. **平行板电容器**（$C = \frac{\varepsilon_0 \varepsilon_r A}{d}$）：
   - 面积越大，电容越大
   - 距离越小，电容越大
   - 相对介电常数越大，电容越大

4. **连接方式**：
   - 串联：$\frac{1}{C_{\text{总}}} = \frac{1}{C_1} + \frac{1}{C_2} + \cdots$
   - 并联：$C_{\text{总}} = C_1 + C_2 + \cdots$

5. **能量**（$E = \frac{1}{2}CU^2$）：
   - 电容器储存的能量与电压的平方成正比

**记住**：电容器储存电荷，电容是储存电荷的能力，$C = \frac{Q}{U}$！