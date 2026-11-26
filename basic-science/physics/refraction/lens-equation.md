---
sidebar_position: 6
---

# 透镜成像公式

透镜成像公式是描述透镜成像时物距、像距和焦距关系的公式。掌握透镜成像公式，理解物距、像距、焦距的关系，是学习光学和实际应用的基础。

## 透镜成像公式

### 透镜成像公式

**透镜成像公式**（Lens Equation）：

$$
\frac{1}{s} + \frac{1}{s'} = \frac{1}{f}
$$
其中：
- $s$：物距（物到光心的距离，单位：m）
- $s'$：像距（像到光心的距离，单位：m）
- $f$：焦距（焦点到光心的距离，单位：m）

**符号规定**：
- **物距** $s$：实物为正（$s > 0$）
- **像距** $s'$：实像为正（$s' > 0$），虚像为负（$s' < 0$）
- **焦距** $f$：凸透镜为正（$f > 0$），凹透镜为负（$f < 0$）

**通俗理解**：
- 物距：物体到光心的距离（实物为正）
- 像距：像到光心的距离（实像为正，虚像为负）
- 焦距：焦点到光心的距离（凸透镜为正，凹透镜为负）

### 透镜成像公式的推导

**透镜成像公式的推导**（简化，几何光学）：

根据相似三角形和折射定律，可以推导出透镜成像公式：

$$
\frac{1}{s} + \frac{1}{s'} = \frac{1}{f}
$$
**通俗理解**：

- 公式表示了物距、像距、焦距之间的关系
- 三个量中知道两个，可以求第三个

### 放大率公式

**放大率**（Magnification，$m$）：

$$
m = \frac{h'}{h} = -\frac{s'}{s}
$$
其中：
- $m$：放大率（单位：1，无量纲）
- $h'$：像高（单位：m）
- $h$：物高（单位：m）
- $s'$：像距（单位：m）
- $s$：物距（单位：m）

**符号规定**：
- $m > 0$：正立像（像和物同向）
- $m < 0$：倒立像（像和物反向）
- $|m| > 1$：放大像
- $|m| < 1$：缩小像
- $|m| = 1$：等大像

**通俗理解**：
- 放大率：像高与物高的比值（或像距与物距的比值的负值）
- 正数：正立像
- 负数：倒立像
- 绝对值大于 1：放大
- 绝对值小于 1：缩小

## 透镜成像公式的应用

### 1. 求像距

**问题**：物体距离透镜 3 m，焦距 1 m（凸透镜），求像距。

**分析**：

$$\frac{1}{s} + \frac{1}{s'} = \frac{1}{f}$$

$$\frac{1}{3} + \frac{1}{s'} = \frac{1}{1}$$

$$\frac{1}{s'} = 1 - \frac{1}{3} = \frac{2}{3}$$

$$s' = \frac{3}{2} = 1.5 \text{ m}$$

**结论**：像距 1.5 m（实像，在镜后）。

### 2. 求物距

**问题**：像距 2 m（实像），焦距 1 m（凸透镜），求物距。

**分析**：

$$\frac{1}{s} + \frac{1}{s'} = \frac{1}{f}$$

$$\frac{1}{s} + \frac{1}{2} = \frac{1}{1}$$

$$\frac{1}{s} = 1 - \frac{1}{2} = \frac{1}{2}$$

$$s = 2 \text{ m}$$

**结论**：物距 2 m。

### 3. 求焦距

**问题**：物距 4 m，像距 2 m（实像），求焦距。

**分析**：

$$\frac{1}{s} + \frac{1}{s'} = \frac{1}{f}$$

$$\frac{1}{4} + \frac{1}{2} = \frac{1}{f}$$

$$\frac{1}{f} = \frac{1}{4} + \frac{1}{2} = \frac{3}{4}$$

$$f = \frac{4}{3} \approx 1.33 \text{ m}$$

**结论**：焦距 1.33 m（凸透镜）。

### 4. 求放大率

**问题**：物距 3 m，像距 1.5 m（实像），求放大率。

**分析**：

$$m = -\frac{s'}{s} = -\frac{1.5}{3} = -0.5$$

**结论**：放大率 -0.5（倒立、缩小）。

## 特殊情况

### 1. 物距等于焦距

**物距等于焦距**（$s = f$）：

$$\frac{1}{s} + \frac{1}{s'} = \frac{1}{f}$$

$$\frac{1}{f} + \frac{1}{s'} = \frac{1}{f}$$

$$\frac{1}{s'} = 0$$

$$s' = \infty$$

**结论**：像距为无穷大（不成像，平行光）。

### 2. 物距等于 2 倍焦距

**物距等于 2 倍焦距**（$s = 2f$）：

$$\frac{1}{s} + \frac{1}{s'} = \frac{1}{f}$$

$$\frac{1}{2f} + \frac{1}{s'} = \frac{1}{f}$$

$$\frac{1}{s'} = \frac{1}{f} - \frac{1}{2f} = \frac{1}{2f}$$

$$s' = 2f$$

**结论**：像距等于 2 倍焦距（实像、倒立、等大）。

### 3. 物距小于焦距

**物距小于焦距**（$s < f$，凸透镜）：

$$\frac{1}{s} + \frac{1}{s'} = \frac{1}{f}$$

$$\frac{1}{s'} = \frac{1}{f} - \frac{1}{s} < 0$$

$$s' < 0$$

**结论**：像距为负（虚像、正立、放大）。

## 实际应用

### 游戏开发

在游戏开发中，透镜成像公式用于：

- **图形渲染**：计算透镜成像位置和大小
- **物理引擎**：模拟光的折射和成像
- **视觉效果**：实现透镜效果、成像效果

```javascript
// 透镜成像公式的应用
class LensEquation {
  // \text{计算像距}（\text{从物距和焦距}）
  static calculateImageDistance(objectDistance, focalLength) {
    // 1/s + 1/s' = 1/f
    // 1/s' = 1/f - 1/s
    // s' = 1 / (1/f - 1/s) = fs / (s - f)
    if (objectDistance === focalLength) {
      return Infinity; // \text{不成像}（\text{平行光}）
    }
    if (objectDistance === 0) {
      throw new Error("\text{物距不能为零}");
    }
    return (focalLength * objectDistance) / (objectDistance - focalLength);
  }
  
  // 计算物距（从像距和焦距）
  static calculateObjectDistance(imageDistance, focalLength) {
    // 1/s = 1/f - 1/s'
    // s = 1 / (1/f - 1/s') = fs' / (s' - f)
    if (imageDistance === focalLength) {
      return Infinity; // \text{不成像}（\text{平行光}）
    }
    if (imageDistance === 0) {
      throw new Error("\text{像距不能为零}");
    }
    return (focalLength * imageDistance) / (imageDistance - focalLength);
  }
  
  // 计算焦距（从物距和像距）
  static calculateFocalLength(objectDistance, imageDistance) {
    // 1/f = 1/s + 1/s'
    // f = 1 / (1/s + 1/s') = ss' / (s + s')
    if (objectDistance === 0 || imageDistance === 0) {
      throw new Error("\text{物距和像距不能为零}");
    }
    return (objectDistance * imageDistance) / (objectDistance + imageDistance);
  }
  
  // 计算放大率（从物距和像距）
  static calculateMagnification(objectDistance, imageDistance) {
    // m = -s'/s
    if (objectDistance === 0) {
      throw new Error("\text{物距不能为零}");
    }
    return -imageDistance / objectDistance;
  }
  
  // 计算像高（从物高和放大率）
  static calculateImageHeight(objectHeight, magnification) {
    // h' = mh
    return magnification * objectHeight;
  }
  
  // 计算物高（从像高和放大率）
  static calculateObjectHeight(imageHeight, magnification) {
    // h = h'/m
    if (magnification === 0) {
      throw new Error("\text{放大率不能为零}");
    }
    return imageHeight / magnification;
  }
  
  // 判断像的性质（从像距和放大率）
  static determineImageProperties(imageDistance, magnification) {
    const isReal = imageDistance > 0;
    const isVirtual = !isReal;
    const isUpright = magnification > 0;
    const isInverted = !isUpright;
    const isEnlarged = Math.abs(magnification) > 1;
    const isReduced = Math.abs(magnification) < 1;
    const isSameSize = Math.abs(magnification) === 1;
    
    return {
      imageDistance,
      magnification,
      isReal,
      isVirtual,
      isUpright,
      isInverted,
      isEnlarged,
      isReduced,
      isSameSize
    };
  }
}

// 使用示例
let imageDistance = LensEquation.calculateImageDistance(3, 1);
// 物距 3 m，焦距 1 m
// s' = 1×3 / (3-1) = 1.5 m

let objectDistance = LensEquation.calculateObjectDistance(1.5, 1);
// 像距 1.5 m，焦距 1 m
// s = 1×1.5 / (1.5-1) = 3 m

let focalLength = LensEquation.calculateFocalLength(3, 1.5);
// 物距 3 m，像距 1.5 m
// f = 3×1.5 / (3+1.5) = 1 m

let magnification = LensEquation.calculateMagnification(3, 1.5);
// 物距 3 m，像距 1.5 m
// m = -1.5 / 3 = -0.5（倒立、缩小）

let imageHeight = LensEquation.calculateImageHeight(2, -0.5);
// 物高 2 m，放大率 -0.5
// h' = -0.5 × 2 = -1 m（倒立、像高 1 m）

let properties = LensEquation.determineImageProperties(1.5, -0.5);
// 像距 1.5 m，放大率 -0.5
// 实像：true
// 虚像：false
// 正立：false
// 倒立：true
// 放大：false
// 缩小：true
```

### 电子工程

在电子工程中，透镜成像公式用于：

- **光学系统**：设计透镜、成像系统
- **测量系统**：光学测量系统
- **显示系统**：透镜显示系统

### Arduino/Raspberry Pi

在 Arduino/Raspberry Pi 中，透镜成像公式用于：

- **传感器应用**：光传感器、成像传感器
- **实验项目**：透镜成像实验
- **视觉应用**：视觉系统、图像识别

## 常见问题

### 1. 像距计算

**问题**：物体距离凸透镜 4 m，焦距 1 m，求像距。

**分析**：

$$s' = \frac{fs}{s - f} = \frac{1 \times 4}{4 - 1} = \frac{4}{3} \approx 1.33 \text{ m}$$

### 2. 物距计算

**问题**：像距 2 m（实像），焦距 1 m，求物距。

**分析**：

$$s = \frac{fs'}{s' - f} = \frac{1 \times 2}{2 - 1} = 2 \text{ m}$$

### 3. 焦距计算

**问题**：物距 3 m，像距 1.5 m（实像），求焦距。

**分析**：

$$f = \frac{ss'}{s + s'} = \frac{3 \times 1.5}{3 + 1.5} = \frac{4.5}{4.5} = 1 \text{ m}$$

### 4. 放大率计算

**问题**：物距 4 m，像距 2 m（实像），求放大率。

**分析**：

$$m = -\frac{s'}{s} = -\frac{2}{4} = -0.5$$

## 常见错误

1. **符号错误**：注意物距、像距、焦距的符号规定（实像为正，虚像为负；凸透镜 $f > 0$，凹透镜 $f < 0$）
2. **公式应用错误**：注意公式的适用条件（物距、像距、焦距不能为零或相等）
3. **放大率符号理解错误**：放大率负值表示倒立，正值表示正立

## 小结

透镜成像公式的核心内容：

1. **透镜成像公式**：$\frac{1}{s} + \frac{1}{s'} = \frac{1}{f}$
   - $s$：物距（实物为正）
   - $s'$：像距（实像为正，虚像为负）
   - $f$：焦距（凸透镜为正，凹透镜为负）

2. **放大率公式**：$m = \frac{h'}{h} = -\frac{s'}{s}$
   - $m > 0$：正立像
   - $m < 0$：倒立像
   - $|m| > 1$：放大像
   - $|m| < 1$：缩小像

3. **特殊情况**：
   - $s = f$：$s' = \infty$（不成像，平行光）
   - $s = 2f$：$s' = 2f$（实像、倒立、等大）
   - $s < f$（凸透镜）：$s' < 0$（虚像、正立、放大）

**记住**：透镜成像公式 $\frac{1}{s} + \frac{1}{s'} = \frac{1}{f}$，放大率 $m = -\frac{s'}{s}$，注意符号规定！