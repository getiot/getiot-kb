---
sidebar_position: 3
---

# 平面镜成像

平面镜是最常见的反射镜。理解平面镜成像的特点，掌握平面镜成像的规律，是学习光学和实际应用的基础。

## 什么是平面镜？

### 平面镜的定义

**平面镜**（Plane Mirror）：反射面为平面的镜子。

**通俗理解**：平面镜就是"平的镜子"，像"普通的镜子"一样。

### 平面镜的特点

**平面镜的特点**：

1. **反射面为平面**：没有曲率（曲率半径为无穷大）
2. **镜面反射**：发生镜面反射，能看到清晰的像
3. **成像规律简单**：成像规律简单，易于理解

**通俗理解**：
- 平面镜：平的镜子（像"玻璃镜子"）
- 能看到清晰的像（像"照镜子"）

## 平面镜成像

### 成像特点

**平面镜成像的特点**：

1. **虚像**：像不是实际光线会聚形成的（是虚像）
2. **像距等于物距**：像到镜面的距离等于物到镜面的距离（$s' = s$）
3. **像和物大小相等**：像的高度等于物的高度（$h' = h$）
4. **像和物关于镜面对称**：像和物关于镜面对称（左右相反）

**通俗理解**：
- 虚像：像不在镜后，是"假"的像（不能成像在屏幕上）
- 像距 = 物距：像和物到镜面的距离相等
- 大小相等：像和物一样大
- 左右相反：像和物左右相反（像"照镜子"）

### 成像规律

**平面镜成像规律**：

$$
s' = s
$$

$$
h' = h
$$

其中：
- $s'$：像距（像到镜面的距离，单位：m）
- $s$：物距（物到镜面的距离，单位：m）
- $h'$：像高（像的高度，单位：m）
- $h$：物高（物的高度，单位：m）

**通俗理解**：
- 像距 = 物距（像和物到镜面的距离相等）
- 像高 = 物高（像和物一样大）

### 成像光路图

**平面镜成像光路图**：

1. **画镜面**：画一条直线表示镜面
2. **画物体**：画物体（如箭头）
3. **画入射光线**：从物体顶部和底部画两条入射光线
4. **画法线**：在入射点画法线（垂直于镜面）
5. **画反射光线**：根据反射定律画反射光线（入射角 = 反射角）
6. **画虚像**：延长反射光线（虚线），交点即为虚像位置

**通俗理解**：
- 画光路图：从物体画光线，反射后延长（虚线），交点就是像的位置
- 像在镜后（虚像，不能成像在屏幕上）

## 平面镜成像的特点

### 1. 虚像

**虚像**（Virtual Image）：不是实际光线会聚形成的像。

**特点**：
- **不能在屏幕上成像**：像不在镜后，不能成像在屏幕上
- **用眼能看到**：延长反射光线（虚线），眼睛能看到像
- **像距为负**：习惯上用负号表示虚像（$s' < 0$，实际计算时取绝对值）

**通俗理解**：
- 虚像：像不在镜后，是"假"的像（像"镜中花、水中月"）
- 不能在屏幕上成像（像"影子"不是虚像）
- 用眼能看到（像"照镜子"能看到像）

### 2. 像距等于物距

**像距等于物距**：

$$
s' = s
$$
**验证**：通过光路图可以证明，像距等于物距。

**通俗理解**：

- 物体距离镜面 1 m，像也距离镜面 1 m（在镜后）
- 物体靠近镜面，像也靠近镜面
- 物体远离镜面，像也远离镜面

### 3. 像和物大小相等

**像和物大小相等**：
$$
h' = h
$$
**验证**：通过光路图可以证明，像高等于物高。

**通俗理解**：
- 物体高 1 m，像也高 1 m
- 平面镜不改变物体的大小（像"照镜子"）

### 4. 像和物关于镜面对称

**像和物关于镜面对称**：

- **左右相反**：像和物左右相反（像"照镜子"，左右相反）
- **前后颠倒**：像在镜后（前后颠倒）
- **上下不变**：像和物上下不变（上下不颠倒）

**通俗理解**：
- 左右相反：像"照镜子"，左右相反
- 前后颠倒：像在镜后
- 上下不变：像和物上下不变

## 实际应用

### 游戏开发

在游戏开发中，平面镜成像用于：

- **图形渲染**：模拟平面镜成像效果（如镜面反射、水面反射）
- **视觉效果**：实现镜像效果、反射效果
- **物理引擎**：模拟光的反射和成像

```javascript
// 平面镜成像的应用
class PlaneMirrors {
  // \text{计算像距}（\text{从物距}）
  static calculateImageDistance(objectDistance) {
    // \text{平面镜}：s' = s（\text{像距} = \text{物距}）
    return objectDistance;
  }
  
  // 计算像高（从物高）
  static calculateImageHeight(objectHeight) {
    // \text{平面镜}：h' = h（\text{像高} = \text{物高}）
    return objectHeight;
  }
  
  // 判断是否为虚像（平面镜总是成虚像）
  static isVirtualImage() {
    // \text{平面镜总是成虚像}
    return true;
  }
  
  // 计算像的位置（2D，简化）
  static calculateImagePosition2D(objectPosition, mirrorPosition, mirrorNormal) {
    // \text{平面镜成像}：\text{像和物关于镜面对称}
    // \text{简化}：\text{假设镜面为直线}，\text{法线归一化}
    
    // \text{计算物体到镜面的向量}
    const toMirror = {
      x: mirrorPosition.x - objectPosition.x,
      y: mirrorPosition.y - objectPosition.y
    };
    
    // 计算物体到镜面的距离（投影到法线上）
    const distance = toMirror.x * mirrorNormal.x + toMirror.y * mirrorNormal.y;
    
    // 计算像的位置（对称）
    const imagePosition = {
      x: objectPosition.x + 2 * distance * mirrorNormal.x,
      y: objectPosition.y + 2 * distance * mirrorNormal.y
    };
    
    return imagePosition;
  }
  
  // 模拟平面镜成像（简化）
  static simulatePlaneMirrorImaging(objectDistance, objectHeight) {
    const imageDistance = this.calculateImageDistance(objectDistance);
    const imageHeight = this.calculateImageHeight(objectHeight);
    const isVirtual = this.isVirtualImage();
    
    return {
      objectDistance,
      objectHeight,
      imageDistance,
      imageHeight,
      isVirtual,
      magnification: 1 // \text{放大率} = 1（\text{等大}）
    };
  }
}

// 使用示例
let imageDistance = PlaneMirrors.calculateImageDistance(1.5);
// 物距 1.5 m
// 像距 = 1.5 m（平面镜：s' = s）

let imageHeight = PlaneMirrors.calculateImageHeight(2.0);
// 物高 2.0 m
// 像高 = 2.0 m（平面镜：h' = h）

let isVirtual = PlaneMirrors.isVirtualImage();
// 平面镜总是成虚像（true）

let imagePos = PlaneMirrors.calculateImagePosition2D(
  {x: 2, y: 3},      // 物体位置
  {x: 0, y: 0},      // 镜面位置（原点）
  {x: 1, y: 0}       // 镜面法线（向右）
);
// 物体位置 (2, 3)，镜面在原点，法线向右
// 像位置（关于镜面对称）

let imaging = PlaneMirrors.simulatePlaneMirrorImaging(1.5, 2.0);
// 物距 1.5 m，物高 2.0 m
// 像距：1.5 m
// 像高：2.0 m
// 虚像：true
// 放大率：1（等大）
```

### 电子工程

在电子工程中，平面镜成像用于：

- **光学系统**：设计平面镜、反光镜
- **成像系统**：理解平面镜成像规律
- **激光系统**：设计激光反射镜

### Arduino/Raspberry Pi

在 Arduino/Raspberry Pi 中，平面镜成像用于：

- **传感器应用**：光传感器、反射传感器
- **实验项目**：平面镜成像实验
- **视觉应用**：视觉系统、图像识别

## 常见问题

### 1. 像距计算

**问题**：物体距离平面镜 2 m，求像距。

**分析**：
根据平面镜成像规律：$s' = s = 2 \text{ m}$

### 2. 像高计算

**问题**：物体高 1.5 m，求像高。

**分析**：
根据平面镜成像规律：$h' = h = 1.5 \text{ m}$

### 3. 像的性质

**问题**：平面镜成像，像的性质是什么？

**分析**：
- 虚像（不是实际光线会聚形成）
- 像距 = 物距
- 像高 = 物高
- 像和物关于镜面对称（左右相反）

## 常见错误

1. **像距符号错误**：虚像像距为负，但实际计算时通常取绝对值（$s' = s$）
2. **成像位置错误**：平面镜像在镜后（虚像），不是镜前
3. **大小关系错误**：平面镜像和物大小相等，不放大也不缩小

## 小结

平面镜成像的核心内容：

1. **平面镜**：反射面为平面的镜子

2. **成像规律**：
   - 像距 = 物距（$s' = s$）
   - 像高 = 物高（$h' = h$）
   - 放大率 = 1（等大）

3. **成像特点**：
   - 虚像（不是实际光线会聚形成）
   - 像和物关于镜面对称（左右相反，前后颠倒，上下不变）
   - 像在镜后（虚像，不能在屏幕上成像）

4. **应用**：
   - 日常照镜子
   - 潜望镜（多次反射）
   - 光学系统（改变光的方向）

**记住**：平面镜成像，像距 = 物距，像高 = 物高，虚像，像和物关于镜面对称！