---
sidebar_position: 4
---

# 球面镜成像

球面镜是反射面为球面的镜子。理解球面镜成像的特点，掌握球面镜成像的规律，是学习光学和实际应用的基础。

## 什么是球面镜？

### 球面镜的定义

**球面镜**（Spherical Mirror）：反射面为球面的镜子。

**分类**：
1. **凹面镜**（Concave Mirror）：反射面为凹面（向内凹）
2. **凸面镜**（Convex Mirror）：反射面为凸面（向外凸）

**通俗理解**：
- 凹面镜：像"勺子内侧"，向内凹
- 凸面镜：像"勺子外侧"，向外凸

### 球面镜的主要参数

**球面镜的主要参数**：

1. **曲率中心**（Center of Curvature，$C$）：球心
2. **曲率半径**（Radius of Curvature，$R$）：球半径
3. **焦点**（Focus，$F$）：焦点（距离顶点 $f = \frac{R}{2}$）
4. **顶点**（Vertex，$V$）：镜面中心点
5. **主轴**（Principal Axis）：通过曲率中心和顶点的直线

**通俗理解**：
- 曲率中心：球的中心
- 曲率半径：球的半径
- 焦点：平行光会聚（凹面镜）或发散（凸面镜）的点
- 焦距：焦点到顶点的距离，$f = \frac{R}{2}$

## 凹面镜

### 凹面镜的定义

**凹面镜**（Concave Mirror）：反射面为凹面的球面镜。

**特点**：
- 反射面向内凹（像"勺子内侧"）
- 平行光会聚到焦点
- 可以成实像或虚像

**通俗理解**：凹面镜就是"向内凹的镜子"，像"勺子内侧"一样。

### 凹面镜的成像规律

**凹面镜的成像规律**（物距、像距、焦距的关系）：

$$
\frac{1}{s} + \frac{1}{s'} = \frac{1}{f}
$$
其中：
- $s$：物距（物到顶点的距离，单位：m）
- $s'$：像距（像到顶点的距离，单位：m）
- $f$：焦距（焦点到顶点的距离，单位：m）

**符号规定**：
- **物距** $s$：实物为正（$s > 0$）
- **像距** $s'$：实像为正（$s' > 0$），虚像为负（$s' < 0$）
- **焦距** $f$：凹面镜为正（$f > 0$）

**放大率**（Magnification）：

$$
m = \frac{h'}{h} = -\frac{s'}{s}
$$
其中：
- $m$：放大率（单位：1）
- $h'$：像高（单位：m）
- $h$：物高（单位：m）

**符号规定**：
- $m > 0$：正立像（像和物同向）
- $m < 0$：倒立像（像和物反向）
- $|m| > 1$：放大像
- $|m| < 1$：缩小像
- $|m| = 1$：等大像

### 凹面镜的成像情况

**凹面镜的成像情况**（物距变化）：

| 物距 $s$ | 像距 $s'$ | 像的性质 | 放大率 $m$ |
|:-------:|:--------:|:-------:|:---------:|
| $s > 2f$ | $f < s' < 2f$ | 实像、倒立、缩小 | $|m| < 1$ |
| $s = 2f$ | $s' = 2f$ | 实像、倒立、等大 | $|m| = 1$ |
| $f < s < 2f$ | $s' > 2f$ | 实像、倒立、放大 | $|m| > 1$ |
| $s = f$ | $s' = \infty$ | 不成像（平行光） | - |
| $s < f$ | $s' < 0$ | 虚像、正立、放大 | $|m| > 1$ |

**通俗理解**：
- 物体很远（$s > 2f$）：像小、倒立（像"相机"）
- 物体较远（$s = 2f$）：像等大、倒立
- 物体较近（$f < s < 2f$）：像大、倒立（像"投影仪"）
- 物体很近（$s < f$）：像大、正立（像"放大镜"）

## 凸面镜

### 凸面镜的定义

**凸面镜**（Convex Mirror）：反射面为凸面的球面镜。

**特点**：
- 反射面向外凸（像"勺子外侧"）
- 平行光发散（虚焦点）
- 总是成虚像、正立、缩小

**通俗理解**：凸面镜就是"向外凸的镜子"，像"勺子外侧"一样。

### 凸面镜的成像规律

**凸面镜的成像规律**：

$$
\frac{1}{s} + \frac{1}{s'} = \frac{1}{f}
$$
**符号规定**：

- **物距** $s$：实物为正（$s > 0$）
- **像距** $s'$：虚像为负（$s' < 0$）
- **焦距** $f$：凸面镜为负（$f < 0$）

**放大率**：

$$
m = \frac{h'}{h} = -\frac{s'}{s}
$$
**凸面镜的成像情况**：

- **总是成虚像**：像距为负（$s' < 0$）
- **总是正立**：放大率为正（$m > 0$）
- **总是缩小**：$|m| < 1$

**通俗理解**：
- 凸面镜：总是成虚像、正立、缩小（像"汽车后视镜"）

## 实际应用

### 游戏开发

在游戏开发中，球面镜成像用于：

- **图形渲染**：模拟球面镜成像效果（如凸面镜、凹面镜）
- **视觉效果**：实现扭曲效果、鱼眼效果
- **物理引擎**：模拟光的反射和成像

```javascript
// 球面镜成像的应用
class SphericalMirrors {
  // \text{计算像距}（\text{凹面镜或凸面镜}）
  static calculateImageDistance(objectDistance, focalLength) {
    // 1/s + 1/s' = 1/f
    // 1/s' = 1/f - 1/s
    // s' = 1 / (1/f - 1/s) = fs / (s - f)
    if (objectDistance === focalLength) {
      return Infinity; // \text{不成像}（\text{平行光}）
    }
    return (focalLength * objectDistance) / (objectDistance - focalLength);
  }
  
  // 计算放大率
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
  
  // 判断像的性质（简化）
  static determineImageProperties(objectDistance, focalLength) {
    const imageDistance = this.calculateImageDistance(objectDistance, focalLength);
    const magnification = this.calculateMagnification(objectDistance, imageDistance);
    
    const isReal = imageDistance > 0;
    const isUpright = magnification > 0;
    const isEnlarged = Math.abs(magnification) > 1;
    const isReduced = Math.abs(magnification) < 1;
    const isSameSize = Math.abs(magnification) === 1;
    
    return {
      objectDistance,
      focalLength,
      imageDistance,
      magnification,
      isReal,
      isVirtual: !isReal,
      isUpright,
      isInverted: !isUpright,
      isEnlarged,
      isReduced,
      isSameSize
    };
  }
  
  // 凹面镜成像（简化）
  static concaveMirrorImaging(objectDistance, objectHeight, focalLength) {
    // \text{凹面镜}：f > 0
    if (focalLength <= 0) {
      throw new Error("\text{凹面镜焦距必须为正}");
    }
    
    const imageDistance = this.calculateImageDistance(objectDistance, focalLength);
    const magnification = this.calculateMagnification(objectDistance, imageDistance);
    const imageHeight = this.calculateImageHeight(objectHeight, magnification);
    
    return {
      type: 'concave',
      objectDistance,
      objectHeight,
      focalLength,
      imageDistance,
      magnification,
      imageHeight,
      ...this.determineImageProperties(objectDistance, focalLength)
    };
  }
  
  // 凸面镜成像（简化）
  static convexMirrorImaging(objectDistance, objectHeight, focalLength) {
    // \text{凸面镜}：f < 0
    if (focalLength >= 0) {
      throw new Error("\text{凸面镜焦距必须为负}");
    }
    
    const imageDistance = this.calculateImageDistance(objectDistance, focalLength);
    const magnification = this.calculateMagnification(objectDistance, imageDistance);
    const imageHeight = this.calculateImageHeight(objectHeight, magnification);
    
    return {
      type: 'convex',
      objectDistance,
      objectHeight,
      focalLength,
      imageDistance,
      magnification,
      imageHeight,
      ...this.determineImageProperties(objectDistance, focalLength)
    };
  }
}

// 使用示例
let imageDistance1 = SphericalMirrors.calculateImageDistance(3, 1);
// 物距 3 m，焦距 1 m（凹面镜）
// s' = 1×3 / (3-1) = 1.5 m（实像）

let imageDistance2 = SphericalMirrors.calculateImageDistance(0.5, 1);
// 物距 0.5 m，焦距 1 m（凹面镜）
// s' = 1×0.5 / (0.5-1) = -1 m（虚像）

let magnification = SphericalMirrors.calculateMagnification(3, 1.5);
// 物距 3 m，像距 1.5 m
// m = -1.5 / 3 = -0.5（倒立、缩小）

let imageHeight = SphericalMirrors.calculateImageHeight(2, -0.5);
// 物高 2 m，放大率 -0.5
// h' = -0.5 × 2 = -1 m（倒立、像高 1 m）

let concaveImaging = SphericalMirrors.concaveMirrorImaging(3, 2, 1);
// 物距 3 m，物高 2 m，焦距 1 m（凹面镜）
// 像距：1.5 m（实像）
// 放大率：-0.5（倒立、缩小）
// 像高：1 m

let convexImaging = SphericalMirrors.convexMirrorImaging(3, 2, -1);
// 物距 3 m，物高 2 m，焦距 -1 m（凸面镜）
// 像距：-0.75 m（虚像）
// 放大率：0.25（正立、缩小）
// 像高：0.5 m
```

### 电子工程

在电子工程中，球面镜成像用于：

- **光学系统**：设计凹面镜、凸面镜
- **成像系统**：理解球面镜成像规律
- **激光系统**：设计激光反射镜

### Arduino/Raspberry Pi

在 Arduino/Raspberry Pi 中，球面镜成像用于：

- **传感器应用**：光传感器、反射传感器
- **实验项目**：球面镜成像实验
- **视觉应用**：视觉系统、图像识别

## 常见问题

### 1. 凹面镜像距计算

**问题**：物体距离凹面镜 4 m，焦距 1 m，求像距。

**分析**：

$$\frac{1}{s} + \frac{1}{s'} = \frac{1}{f}$$

$$\frac{1}{4} + \frac{1}{s'} = \frac{1}{1}$$

$$\frac{1}{s'} = 1 - \frac{1}{4} = \frac{3}{4}$$

$$s' = \frac{4}{3} \approx 1.33 \text{ m}$$

**结论**：像距 1.33 m（实像，在镜前）。

### 2. 凸面镜像距计算

**问题**：物体距离凸面镜 2 m，焦距 -1 m，求像距。

**分析**：

$$\frac{1}{s} + \frac{1}{s'} = \frac{1}{f}$$

$$\frac{1}{2} + \frac{1}{s'} = \frac{1}{-1} = -1$$

$$\frac{1}{s'} = -1 - \frac{1}{2} = -\frac{3}{2}$$

$$s' = -\frac{2}{3} \approx -0.67 \text{ m}$$

**结论**：像距 -0.67 m（虚像，在镜后）。

### 3. 放大率计算

**问题**：物距 3 m，像距 1.5 m，求放大率。

**分析**：

$$m = -\frac{s'}{s} = -\frac{1.5}{3} = -0.5$$

**结论**：放大率 -0.5（倒立、缩小）。

## 常见错误

1. **符号错误**：注意物距、像距、焦距的符号规定（实像为正，虚像为负）
2. **公式混淆**：凹面镜和凸面镜的公式相同，区别在于焦距的符号（凹面镜 $f > 0$，凸面镜 $f < 0$）
3. **成像情况混淆**：凹面镜可以成实像或虚像，凸面镜总是成虚像

## 小结

球面镜成像的核心内容：

1. **球面镜**：
   - **凹面镜**：反射面为凹面（$f > 0$）
   - **凸面镜**：反射面为凸面（$f < 0$）

2. **成像公式**：
   - $\frac{1}{s} + \frac{1}{s'} = \frac{1}{f}$（物距、像距、焦距的关系）
   - $m = -\frac{s'}{s}$（放大率）

3. **凹面镜成像**：
   - 可以成实像或虚像
   - 物距 > 2f：实像、倒立、缩小
   - 物距 = 2f：实像、倒立、等大
   - 物距 < 2f 且 > f：实像、倒立、放大
   - 物距 < f：虚像、正立、放大

4. **凸面镜成像**：
   - 总是成虚像、正立、缩小（$s' < 0$，$m > 0$，$|m| < 1$）

5. **焦距**：
   - $f = \frac{R}{2}$（焦距 = 曲率半径 / 2）

**记住**：球面镜成像公式 $\frac{1}{s} + \frac{1}{s'} = \frac{1}{f}$，凹面镜 $f > 0$，凸面镜 $f < 0$，凸面镜总是成虚像！