---
sidebar_position: 4
---

# 串联电路和并联电路

串联电路和并联电路是电路中两种最基本的连接方式。理解它们的特性和计算方法，是分析复杂电路的基础。

## 串联电路

### 串联电路的定义

**串联电路**（Series Circuit）：多个元件首尾相连，电流只有一条路径的电路。

**特点**：
- 电流只有一条路径
- 电流处处相等：$I_1 = I_2 = I_3 = \cdots = I_{\text{总}}$
- 总电压等于各元件电压之和：$U_{\text{总}} = U_1 + U_2 + U_3 + \cdots$

**通俗理解**：串联就像"一列火车"，所有元件排成一列，电流依次流过。

### 串联电路的电阻

**串联电路的总电阻等于各电阻之和**：

$$
R_{\text{总}} = R_1 + R_2 + R_3 + \cdots
$$
**推导**：

- 总电压：$U_{\text{总}} = U_1 + U_2 + U_3 + \cdots$
- 根据欧姆定律：$U_1 = IR_1$，$U_2 = IR_2$，$U_3 = IR_3$，$\cdots$
- 总电压：$U_{\text{总}} = IR_1 + IR_2 + IR_3 + \cdots = I(R_1 + R_2 + R_3 + \cdots)$
- 根据欧姆定律：$U_{\text{总}} = IR_{\text{总}}$
- 因此：$IR_{\text{总}} = I(R_1 + R_2 + R_3 + \cdots)$
- 所以：$R_{\text{总}} = R_1 + R_2 + R_3 + \cdots$

**结论**：串联时，总电阻大于任何一个电阻。

### 串联电路的分压

**串联电路的分压**：总电压按电阻比例分配。

$$
U_1 : U_2 : U_3 : \cdots = R_1 : R_2 : R_3 : \cdots
$$
**具体计算**：

$$U_1 = \frac{R_1}{R_{\text{总}}} U_{\text{总}}$$

$$U_2 = \frac{R_2}{R_{\text{总}}} U_{\text{总}}$$

$$U_3 = \frac{R_3}{R_{\text{总}}} U_{\text{总}}$$

**通俗理解**：串联时，电阻越大，分到的电压越大（像"分蛋糕"，大块分大份"）。

**例子**：两个电阻 $R_1 = 10 \Omega$ 和 $R_2 = 20 \Omega$ 串联，电压为 30 V。
- 总电阻：$R_{\text{总}} = 10 + 20 = 30 \Omega$
- 电流：$I = \frac{30}{30} = 1 \text{ A}$
- $R_1$ 的电压：$U_1 = 1 \times 10 = 10 \text{ V}$ 或 $U_1 = \frac{10}{30} \times 30 = 10 \text{ V}$
- $R_2$ 的电压：$U_2 = 1 \times 20 = 20 \text{ V}$ 或 $U_2 = \frac{20}{30} \times 30 = 20 \text{ V}$

### 串联电路的缺点

**串联电路的缺点**：
1. **一个元件损坏，整个电路断路**：所有元件串联，如果其中一个断开，整个电路都不工作
2. **电流相同，难以控制**：所有元件电流相同，不能单独控制
3. **总电阻增大**：串联时总电阻增大，电流减小

**例子**：圣诞树上的彩灯，如果其中一个灯泡坏了，所有灯泡都不亮（串联电路）。

## 并联电路

### 并联电路的定义

**并联电路**（Parallel Circuit）：多个元件两端分别连接在一起，电流有多条路径的电路。

**特点**：
- 电流有多条路径
- 电压处处相等：$U_1 = U_2 = U_3 = \cdots = U_{\text{总}}$
- 总电流等于各支路电流之和：$I_{\text{总}} = I_1 + I_2 + I_3 + \cdots$

**通俗理解**：并联就像"多条路"，电流可以走不同的路，但电压相同。

### 并联电路的电阻

**并联电路的总电阻的倒数等于各电阻倒数之和**：

$$
\frac{1}{R_{\text{总}}} = \frac{1}{R_1} + \frac{1}{R_2} + \frac{1}{R_3} + \cdots
$$
**推导**：

- 总电流：$I_{\text{总}} = I_1 + I_2 + I_3 + \cdots$
- 根据欧姆定律：$I_1 = \frac{U}{R_1}$，$I_2 = \frac{U}{R_2}$，$I_3 = \frac{U}{R_3}$，$\cdots$
- 总电流：$I_{\text{总}} = \frac{U}{R_1} + \frac{U}{R_2} + \frac{U}{R_3} + \cdots = U(\frac{1}{R_1} + \frac{1}{R_2} + \frac{1}{R_3} + \cdots)$
- 根据欧姆定律：$I_{\text{总}} = \frac{U}{R_{\text{总}}}$
- 因此：$\frac{U}{R_{\text{总}}} = U(\frac{1}{R_1} + \frac{1}{R_2} + \frac{1}{R_3} + \cdots)$
- 所以：$\frac{1}{R_{\text{总}}} = \frac{1}{R_1} + \frac{1}{R_2} + \frac{1}{R_3} + \cdots$

**结论**：并联时，总电阻小于任何一个电阻。

**两个电阻并联**：

$$
R_{\text{总}} = \frac{R_1 R_2}{R_1 + R_2}
$$
**推导**：

$$\frac{1}{R_{\text{总}}} = \frac{1}{R_1} + \frac{1}{R_2} = \frac{R_2 + R_1}{R_1 R_2}$$

$$R_{\text{总}} = \frac{R_1 R_2}{R_1 + R_2}$$

**n 个相同电阻并联**：

$$
R_{\text{总}} = \frac{R}{n}
$$
**推导**：

$$\frac{1}{R_{\text{总}}} = \frac{1}{R} + \frac{1}{R} + \cdots + \frac{1}{R} = \frac{n}{R}$$

$$R_{\text{总}} = \frac{R}{n}$$

### 并联电路的分流

**并联电路的分流**：总电流按电阻反比例分配（电阻越大，电流越小）。

$$
I_1 : I_2 : I_3 : \cdots = \frac{1}{R_1} : \frac{1}{R_2} : \frac{1}{R_3} : \cdots
$$
**具体计算**：

$$I_1 = \frac{R_{\text{总}}}{R_1} I_{\text{总}}$$

$$I_2 = \frac{R_{\text{总}}}{R_2} I_{\text{总}}$$

$$I_3 = \frac{R_{\text{总}}}{R_3} I_{\text{总}}$$

**通俗理解**：并联时，电阻越大，分到的电流越小（像"水管"，粗的管子流量大"）。

**例子**：两个电阻 $R_1 = 6 \Omega$ 和 $R_2 = 3 \Omega$ 并联，电压为 12 V。
- 总电阻：$R_{\text{总}} = \frac{6 \times 3}{6 + 3} = 2 \Omega$
- 总电流：$I_{\text{总}} = \frac{12}{2} = 6 \text{ A}$
- $R_1$ 的电流：$I_1 = \frac{12}{6} = 2 \text{ A}$ 或 $I_1 = \frac{2}{6} \times 6 = 2 \text{ A}$
- $R_2$ 的电流：$I_2 = \frac{12}{3} = 4 \text{ A}$ 或 $I_2 = \frac{2}{3} \times 6 = 4 \text{ A}$

### 并联电路的优点

**并联电路的优点**：
1. **一个元件损坏，其他元件仍工作**：各支路独立，互不影响
2. **电压相同，易于控制**：各元件电压相同，可以单独控制
3. **总电阻减小**：并联时总电阻减小，电流增大

**例子**：家庭电路，每个电器独立工作，互不影响（并联电路）。

## 串联 vs 并联

### 对比表

| 特征 | 串联 | 并联 |
|:----:|------|------|
| **连接方式** | 首尾相连 | 两端分别连接 |
| **电流路径** | 一条路径 | 多条路径 |
| **电流** | 处处相等：$I_1 = I_2 = I_3 = \cdots$ | 总电流 = 各支路电流之和：$I_{\text{总}} = I_1 + I_2 + I_3 + \cdots$ |
| **电压** | 总电压 = 各元件电压之和：$U_{\text{总}} = U_1 + U_2 + U_3 + \cdots$ | 处处相等：$U_1 = U_2 = U_3 = \cdots$ |
| **总电阻** | $R_{\text{总}} = R_1 + R_2 + R_3 + \cdots$（增大） | $\frac{1}{R_{\text{总}}} = \frac{1}{R_1} + \frac{1}{R_2} + \frac{1}{R_3} + \cdots$（减小） |
| **分压/分流** | 分压：按电阻比例分配 | 分流：按电阻反比例分配 |
| **元件损坏** | 一个损坏，整个电路断路 | 一个损坏，其他仍工作 |
| **应用** | 限流、分压 | 家庭电路、照明电路 |

### 记忆口诀

**串联**：
- 电流相同，电压相加，电阻相加
- "一列火车，电流相同，电压分压"

**并联**：
- 电压相同，电流相加，电阻减小
- "多条路，电压相同，电流分流"

## 混合电路

### 混合电路的定义

**混合电路**（Mixed Circuit）：既有串联又有并联的电路。

**分析步骤**：
1. 识别串联和并联部分
2. 逐步化简，先求并联总电阻，再求串联总电阻
3. 求总电流和总电压
4. 逐步求各元件的电流和电压

**例子**：电路如图所示（请参考电路图），已知 $R_1 = 4 \Omega$，$R_2 = 6 \Omega$，$R_3 = 12 \Omega$，电压为 18 V。

**分析**：
1. **识别**：$R_2$ 和 $R_3$ 并联，再与 $R_1$ 串联
2. **$R_2$ 和 $R_3$ 并联**：$R_{23} = \frac{R_2 R_3}{R_2 + R_3} = \frac{6 \times 12}{6 + 12} = 4 \Omega$
3. **总电阻**：$R_{\text{总}} = R_1 + R_{23} = 4 + 4 = 8 \Omega$
4. **总电流**：$I_{\text{总}} = \frac{U}{R_{\text{总}}} = \frac{18}{8} = 2.25 \text{ A}$
5. **$R_1$ 的电压**：$U_1 = I_{\text{总}} R_1 = 2.25 \times 4 = 9 \text{ V}$
6. **$R_{23}$ 的电压**：$U_{23} = I_{\text{总}} R_{23} = 2.25 \times 4 = 9 \text{ V}$ 或 $U_{23} = U - U_1 = 18 - 9 = 9 \text{ V}$
7. **$R_2$ 的电流**：$I_2 = \frac{U_{23}}{R_2} = \frac{9}{6} = 1.5 \text{ A}$
8. **$R_3$ 的电流**：$I_3 = \frac{U_{23}}{R_3} = \frac{9}{12} = 0.75 \text{ A}$
9. **验证**：$I_2 + I_3 = 1.5 + 0.75 = 2.25 \text{ A} = I_{\text{总}}$（正确）

## 实际应用

### 游戏开发

在游戏开发中，串联和并联电路用于：

- **电路模拟**：模拟电路中的电流、电压、电阻
- **物理引擎**：模拟电子系统
- **游戏机制**：电路解谜游戏

```javascript
// 串联和并联电路的应用
class SeriesParallelCircuits {
  // \text{串联总电阻}
  static calculateSeriesResistance(resistances) {
    // R = R₁ + R₂ + R₃ + ...
    return resistances.reduce((sum, R) => sum + R, 0);
  }
  
  // 并联总电阻
  static calculateParallelResistance(resistances) {
    // 1/R = 1/R₁ + 1/R₂ + 1/R₃ + ...
    let reciprocalSum = resistances.reduce((sum, R) => sum + 1/R, 0);
    return 1 / reciprocalSum;
  }
  
  // 两个电阻并联
  static calculateParallelResistanceTwo(R1, R2) {
    // R = R₁R₂/(R₁ + R₂)
    return (R1 * R2) / (R1 + R2);
  }
  
  // 串联分压
  static calculateSeriesVoltageDivision(voltage, resistances) {
    let totalResistance = this.calculateSeriesResistance(resistances);
    let currents = voltage / totalResistance;
    return resistances.map(R => currents * R);
  }
  
  // 并联分流
  static calculateParallelCurrentDivision(current, resistances) {
    let totalResistance = this.calculateParallelResistance(resistances);
    return resistances.map(R => (totalResistance / R) * current);
  }
  
  // 混合电路分析
  static analyzeMixedCircuit(voltage, seriesResistances, parallelResistances) {
    // \text{先求并联总电阻}
    let parallelResistance = this.calculateParallelResistance(parallelResistances);
    
    // \text{再求总电阻}
    let totalResistance = this.calculateSeriesResistance([...seriesResistances, parallelResistance]);
    
    // \text{总电流}
    let totalCurrent = voltage / totalResistance;
    
    // \text{串联部分的电压}
    let seriesVoltage = seriesResistances.map(R => totalCurrent * R);
    
    // \text{并联部分的电压}
    let parallelVoltage = totalCurrent * parallelResistance;
    
    // \text{并联各支路的电流}
    let parallelCurrents = parallelResistances.map(R => parallelVoltage / R);
    
    return {
      totalResistance,
      totalCurrent,
      seriesVoltage,
      parallelVoltage,
      parallelCurrents
    };
  }
}

// 使用示例
let seriesR = SeriesParallelCircuits.calculateSeriesResistance([10, 20, 30]);
// 串联：10 Ω + 20 Ω + 30 Ω = 60 Ω

let parallelR = SeriesParallelCircuits.calculateParallelResistance([6, 3, 2]);
// 并联：1/(1/6 + 1/3 + 1/2) = 1 Ω

let twoParallelR = SeriesParallelCircuits.calculateParallelResistanceTwo(6, 3);
// 两个电阻并联：6×3/(6+3) = 2 Ω

let seriesVoltages = SeriesParallelCircuits.calculateSeriesVoltageDivision(30, [10, 20]);
// 电压 30 V，电阻 10 Ω 和 20 Ω 串联
// 电压：10 V 和 20 V

let parallelCurrents = SeriesParallelCircuits.calculateParallelCurrentDivision(6, [6, 3]);
// 电流 6 A，电阻 6 Ω 和 3 Ω 并联
// 电流：2 A 和 4 A
```

### 电子工程

在电子工程中，串联和并联电路用于：

- **电路设计**：设计电路，选择合适的连接方式
- **分压电路**：串联分压，降低电压
- **分流电路**：并联分流，分配电流
- **限流电路**：串联限流，控制电流

### Arduino/Raspberry Pi

在 Arduino/Raspberry Pi 中，串联和并联电路用于：

- **LED 连接**：多个 LED 串联或并联
- **传感器连接**：多个传感器并联
- **分压电路**：电阻分压，降低电压到安全范围

**例子**：LED 限流
- 电源电压：5 V
- LED 工作电压：2 V，工作电流：20 mA
- 所需限流电阻：$R = \frac{5 - 2}{0.02} = 150 \Omega$

## 常见问题

### 1. 串联电路

**问题**：三个电阻 $R_1 = 10 \Omega$，$R_2 = 20 \Omega$，$R_3 = 30 \Omega$ 串联，电压为 60 V，求各电阻的电压。

**分析**：
- 总电阻：$R_{\text{总}} = 10 + 20 + 30 = 60 \Omega$
- 电流：$I = \frac{60}{60} = 1 \text{ A}$
- $R_1$ 的电压：$U_1 = 1 \times 10 = 10 \text{ V}$
- $R_2$ 的电压：$U_2 = 1 \times 20 = 20 \text{ V}$
- $R_3$ 的电压：$U_3 = 1 \times 30 = 30 \text{ V}$

### 2. 并联电路

**问题**：三个电阻 $R_1 = 6 \Omega$，$R_2 = 3 \Omega$，$R_3 = 2 \Omega$ 并联，电压为 12 V，求各电阻的电流。

**分析**：
- 总电阻：$\frac{1}{R_{\text{总}}} = \frac{1}{6} + \frac{1}{3} + \frac{1}{2} = 1$，所以 $R_{\text{总}} = 1 \Omega$
- 总电流：$I_{\text{总}} = \frac{12}{1} = 12 \text{ A}$
- $R_1$ 的电流：$I_1 = \frac{12}{6} = 2 \text{ A}$
- $R_2$ 的电流：$I_2 = \frac{12}{3} = 4 \text{ A}$
- $R_3$ 的电流：$I_3 = \frac{12}{2} = 6 \text{ A}$
- 验证：$I_1 + I_2 + I_3 = 2 + 4 + 6 = 12 \text{ A} = I_{\text{总}}$（正确）

### 3. 混合电路

**问题**：电路如图所示，已知 $R_1 = 4 \Omega$，$R_2 = 6 \Omega$，$R_3 = 12 \Omega$，$R_4 = 3 \Omega$，电压为 24 V，求各电阻的电流和电压。

**分析**：
- $R_2$ 和 $R_3$ 并联：$R_{23} = \frac{6 \times 12}{6 + 12} = 4 \Omega$
- $R_{23}$ 和 $R_4$ 并联：$R_{234} = \frac{4 \times 3}{4 + 3} = \frac{12}{7} \Omega$
- 总电阻：$R_{\text{总}} = R_1 + R_{234} = 4 + \frac{12}{7} = \frac{40}{7} \Omega$
- 总电流：$I_{\text{总}} = \frac{24}{\frac{40}{7}} = 4.2 \text{ A}$
- 后续分析类似...

## 常见错误

1. **串联并联混淆**：记住串联时电流相同，并联时电压相同
2. **总电阻计算错误**：串联是相加，并联是倒数相加
3. **分压分流公式混淆**：串联是分压，并联是分流
4. **混合电路分析错误**：要逐步化简，先并后串

## 小结

串联和并联电路的核心内容：

1. **串联电路**：
   - 电流相同，电压相加，电阻相加
   - 总电阻：$R_{\text{总}} = R_1 + R_2 + R_3 + \cdots$
   - 分压：$U_i = \frac{R_i}{R_{\text{总}}} U_{\text{总}}$

2. **并联电路**：
   - 电压相同，电流相加，电阻减小
   - 总电阻：$\frac{1}{R_{\text{总}}} = \frac{1}{R_1} + \frac{1}{R_2} + \frac{1}{R_3} + \cdots$
   - 分流：$I_i = \frac{R_{\text{总}}}{R_i} I_{\text{总}}$

3. **混合电路**：
   - 逐步化简，先求并联总电阻，再求串联总电阻
   - 逐步求各元件的电流和电压

4. **应用**：
   - 串联：限流、分压
   - 并联：家庭电路、照明电路

**记住**：串联电流相同，并联电压相同，串联电阻相加，并联电阻减小！