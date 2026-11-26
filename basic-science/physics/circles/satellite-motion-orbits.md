---
sidebar_position: 6
---

# 卫星运动和轨道

卫星运动是人造卫星绕地球运动的运动形式。理解卫星运动和轨道，是学习航天知识的基础。

## 什么是卫星运动？

### 卫星运动的定义

**卫星运动**：卫星在地球引力作用下绕地球运动的运动形式。

**通俗理解**：卫星"绕地球转"，就像月球绕地球一样。

### 卫星运动的特点

1. **万有引力提供向心力**：地球对卫星的万有引力提供圆周运动的向心力
2. **轨道运动**：卫星沿轨道运动（圆形或椭圆形）
3. **能量守恒**：卫星的机械能守恒（忽略大气阻力）

## 卫星轨道的类型

### 1. 圆形轨道

**圆形轨道**：卫星绕地球做匀速圆周运动。

**特点**：
- 轨道半径恒定
- 速度大小恒定
- 周期恒定

**适用**：大多数人造卫星

### 2. 椭圆形轨道

**椭圆形轨道**：卫星绕地球做椭圆运动。

**特点**：
- 轨道半径变化（近地点和远地点）
- 速度大小变化（近地点快，远地点慢）
- 周期恒定

**适用**：某些特殊任务卫星

### 3. 同步轨道

**同步轨道**：卫星的周期等于地球自转周期（24 小时）。

**特点**：
- 周期：$T = 24 \text{ \text{小时}} = 86400 \text{ \text{秒}}$
- 轨道高度：约 35786 km（地球同步轨道）
- 相对地面静止：从地面看，卫星好像静止不动

**适用**：通信卫星、气象卫星等

### 4. 极地轨道

**极地轨道**：卫星轨道通过地球两极。

**特点**：
- 轨道倾角：约 90°
- 可以覆盖全球
- 高度较低（几百到几千公里）

**适用**：地球观测卫星、气象卫星等

## 卫星运动的动力学

### 万有引力提供向心力

卫星绕地球运动时，地球的万有引力提供向心力：

$$
G\frac{M_{\text{地}}m}{r^2} = m\frac{v^2}{r}
$$
其中：
- $G$：万有引力常数
- $M_{\text{地}}$：地球质量
- $m$：卫星质量
- $r$：轨道半径（卫星到地心的距离）
- $v$：轨道速度

**简化**：
$$
G\frac{M_{\text{地}}}{r^2} = \frac{v^2}{r}
$$
所以：
$$
v = \sqrt{\frac{GM_{\text{地}}}{r}}
$$
**结论**：轨道速度与轨道半径的平方根成反比（轨道越大，速度越小）。

### 轨道周期

根据周期公式：

$$
T = \frac{2\pi r}{v} = \frac{2\pi r}{\sqrt{GM_{\text{地}}/r}} = 2\pi\sqrt{\frac{r^3}{GM_{\text{地}}}}
$$
**结论**：轨道周期与轨道半径的 3/2 次方成正比（轨道越大，周期越长）。

### 轨道高度

**轨道高度**（$h$）：卫星到地面的距离。

**关系**：
$$
r = R_{\text{地}} + h
$$
其中：
- $r$：轨道半径（卫星到地心的距离）
- $R_{\text{地}}$：地球半径（约 $6.37 \times 10^6 \text{ m}$）
- $h$：轨道高度

**通俗理解**：轨道高度越高，轨道半径越大，速度越小，周期越长。

## 常见轨道

### 1. 近地轨道（Low Earth Orbit, LEO）

**高度**：约 160 - 2000 km

**特点**：
- 高度较低
- 周期较短（约 90 - 120 分钟）
- 速度快（约 7.8 km/s）

**适用**：国际空间站、大多数人造卫星

**例子**：国际空间站轨道高度约 400 km，周期约 90 分钟。

### 2. 中轨道（Medium Earth Orbit, MEO）

**高度**：约 2000 - 35786 km

**特点**：
- 高度中等
- 周期中等（几小时）
- 速度中等

**适用**：GPS 卫星、导航卫星

**例子**：GPS 卫星轨道高度约 20200 km，周期约 12 小时。

### 3. 地球同步轨道（Geosynchronous Orbit, GEO）

**高度**：约 35786 km

**特点**：
- 高度较高
- 周期：24 小时（与地球自转同步）
- 速度：约 3.07 km/s
- 相对地面静止

**适用**：通信卫星、气象卫星、电视广播卫星

**例子**：通信卫星轨道高度约 35786 km，周期 24 小时，相对地面静止。

## 实际应用

### 游戏开发

在游戏开发中，卫星运动用于：

- **天体模拟**：模拟卫星运动
- **轨道计算**：计算卫星轨道
- **物理引擎**：模拟天体运动

```javascript
// 卫星运动和轨道的应用
class SatelliteMotion {
  static G = 6.67e-11; // \text{万有引力常数}
  static M_EARTH = 5.97e24; // \text{地球质量}（kg）
  static R_EARTH = 6.37e6; // \text{地球半径}（m）
  
  // \text{计算轨道速度}
  static calculateOrbitalVelocity(orbitalRadius) {
    // v = √(GM/r)
    return Math.sqrt(this.G * this.M_EARTH / orbitalRadius);
  }
  
  // 计算轨道周期
  static calculateOrbitalPeriod(orbitalRadius) {
    // T = 2π√(r³/GM)
    return 2 * Math.PI * Math.sqrt(
      (orbitalRadius * orbitalRadius * orbitalRadius) / 
      (this.G * this.M_EARTH)
    );
  }
  
  // 从轨道高度计算轨道半径
  static calculateOrbitalRadius(altitude) {
    // r = R + h
    return this.R_EARTH + altitude;
  }
  
  // 计算同步轨道高度
  static calculateGeosynchronousAltitude() {
    // T = 24 \text{小时} = 86400 \text{秒}
    const T = 86400;
    // T = 2π√(r³/GM)
    // r = ³√(GMT²/4π²)
    const r = Math.cbrt(
      (this.G * this.M_EARTH * T * T) / (4 * Math.PI * Math.PI)
    );
    // h = r - R
    return r - this.R_EARTH;
  }
}

// 使用示例
let leoRadius = SatelliteMotion.calculateOrbitalRadius(400e3); // 400 km
let leoVelocity = SatelliteMotion.calculateOrbitalVelocity(leoRadius);
// 近地轨道速度 ≈ 7.67 km/s

let geoAltitude = SatelliteMotion.calculateGeosynchronousAltitude();
// 地球同步轨道高度 ≈ 35786 km

let geoRadius = SatelliteMotion.calculateOrbitalRadius(geoAltitude);
let geoVelocity = SatelliteMotion.calculateOrbitalVelocity(geoRadius);
// 地球同步轨道速度 ≈ 3.07 km/s
let geoPeriod = SatelliteMotion.calculateOrbitalPeriod(geoRadius);
// 地球同步轨道周期 ≈ 86400 秒 = 24 小时
```

### 航空航天

在航空航天中，卫星运动用于：

- **轨道设计**：卫星轨道设计
- **轨道预测**：预测卫星位置
- **任务规划**：航天任务规划

### 导航系统

在导航系统中，卫星运动用于：

- **GPS**：GPS 卫星轨道
- **北斗**：北斗卫星轨道
- **伽利略**：伽利略卫星轨道

## 常见问题

### 1. 求轨道速度

**问题**：卫星在高度 500 km 的轨道上运动，求轨道速度。

**分析**：
- 轨道半径：$r = 6.37 \times 10^6 + 500 \times 10^3 = 6.87 \times 10^6 \text{ m}$
- 轨道速度：$v = \sqrt{\frac{GM_{\text{地}}}{r}} = \sqrt{\frac{6.67 \times 10^{-11} \times 5.97 \times 10^{24}}{6.87 \times 10^6}} \approx 7.61 \text{ km/s}$

### 2. 求轨道周期

**问题**：卫星在高度 1000 km 的轨道上运动，求轨道周期。

**分析**：
- 轨道半径：$r = 6.37 \times 10^6 + 1000 \times 10^3 = 7.37 \times 10^6 \text{ m}$
- 轨道周期：$T = 2\pi\sqrt{\frac{r^3}{GM_{\text{地}}}} \approx 6300 \text{ 秒} \approx 105 \text{ \text{分}钟}$

### 3. 求同步轨道高度

**问题**：求地球同步轨道的高度。

**分析**：
- 周期：$T = 86400 \text{ 秒}$（24 小时）
- 轨道半径：$r = \sqrt[3]{\frac{GMT^2}{4\pi^2}} \approx 4.22 \times 10^7 \text{ m}$
- 轨道高度：$h = r - R_{\text{地}} = 4.22 \times 10^7 - 6.37 \times 10^6 \approx 3.58 \times 10^7 \text{ m} = 35786 \text{ km}$

**结论**：地球同步轨道高度约为 35786 km。

## 常见错误

1. **混淆轨道高度和轨道半径**：轨道高度是到地面的距离，轨道半径是到地心的距离
2. **速度方向错误**：轨道速度方向沿切线方向，不是指向地心
3. **周期计算错误**：周期与轨道半径的关系是 $T^2 \propto r^3$，不是 $T \propto r$
4. **单位错误**：注意单位统一，特别是距离和时间的单位

## 小结

卫星运动和轨道的核心内容：

1. **轨道类型**：
   - 圆形轨道
   - 椭圆形轨道
   - 同步轨道（高度约 35786 km，周期 24 小时）
   - 极地轨道

2. **动力学**：
   - 万有引力提供向心力：$G\frac{M_{\text{地}}m}{r^2} = m\frac{v^2}{r}$
   - 轨道速度：$v = \sqrt{\frac{GM_{\text{地}}}{r}}$
   - 轨道周期：$T = 2\pi\sqrt{\frac{r^3}{GM_{\text{地}}}}$

3. **轨道高度**：
   - 近地轨道（160 - 2000 km）
   - 中轨道（2000 - 35786 km）
   - 地球同步轨道（35786 km）

**记住**：卫星运动是万有引力提供向心力的圆周运动，轨道越高，速度越小，周期越长！