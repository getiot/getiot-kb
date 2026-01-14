---
sidebar_position: 5
slug: /css-units
---

# CSS 测量单位

在 CSS 中，你需要为各种属性指定数值和单位。CSS 提供了多种测量单位，包括绝对单位、相对单位、角度单位、时间单位等。了解这些单位的特点和适用场景，有助于你编写更灵活、更易维护的 CSS 代码。

## 绝对单位（Absolute Units）

绝对单位是固定大小的单位，不会因为其他因素而改变。常见的绝对单位包括：

#### 1. 像素（px - Pixels）

`px` 是最常用的绝对单位，表示屏幕上的一个像素点。

```css
p {
  font-size: 16px;
  width: 200px;
  height: 100px;
}
```

**特点**：
- 固定大小，不会随其他因素变化
- 适合精确控制元素大小
- 在不同设备上显示大小可能不同（取决于设备像素密度）

#### 2. 点（pt - Points）

`pt` 是印刷单位，1 点等于 1/72 英寸，主要用于打印样式。

```css
@media print {
  p {
    font-size: 12pt;
  }
}
```

**特点**：
- 主要用于打印媒体
- 1pt = 1/72 英寸 ≈ 1.33px（在 96 DPI 屏幕上）

#### 3. 派卡（pc - Picas）

`pc` 也是印刷单位，1 派卡等于 12 点。

```css
@media print {
  .column {
    width: 30pc;
  }
}
```

**特点**：
- 主要用于打印媒体
- 1pc = 12pt = 1/6 英寸

#### 4. 英寸（in - Inches）

`in` 表示英寸，1 英寸等于 96 像素（在标准屏幕上）。

```css
@media print {
  .page {
    width: 8.5in;
    height: 11in;
  }
}
```

**特点**：
- 主要用于打印媒体
- 1in = 96px（在 96 DPI 屏幕上）

#### 5. 厘米（cm - Centimeters）

`cm` 表示厘米，1 厘米约等于 37.8 像素。

```css
@media print {
  .page {
    width: 21cm;
    height: 29.7cm;  /* A4 纸张 */
  }
}
```

**特点**：
- 主要用于打印媒体
- 1cm ≈ 37.8px

#### 6. 毫米（mm - Millimeters）

`mm` 表示毫米，1 毫米约等于 3.78 像素。

```css
@media print {
  .margin {
    margin: 10mm;
  }
}
```

**特点**：
- 主要用于打印媒体
- 1mm ≈ 3.78px

## 相对单位（Relative Units）

相对单位是相对于其他值计算的单位，会根据上下文动态调整。常见的相对单位包括：

#### 1. 百分比（% - Percentage）

`%` 是相对于父元素的单位。

```css
.container {
  width: 100%;
}

.child {
  width: 50%;  /* 父元素宽度的 50% */
  padding: 10%; /* 父元素宽度的 10% */
}
```

**特点**：
- 相对于父元素的对应属性
- 常用于响应式设计
- 对于 `font-size`，相对于父元素的字体大小

#### 2. em

`em` 是相对于当前元素的字体大小的单位。

```css
p {
  font-size: 16px;
  padding: 1em;  /* 16px */
}

h1 {
  font-size: 2em;  /* 父元素字体大小的 2 倍 */
  margin: 0.5em;    /* 当前字体大小的 0.5 倍 */
}
```

**特点**：
- 对于 `font-size`，相对于父元素的字体大小
- 对于其他属性，相对于当前元素的字体大小
- 具有继承性，适合创建可缩放的组件

#### 3. rem（Root em）

`rem` 是相对于根元素（`<html>`）的字体大小的单位。

```css
html {
  font-size: 16px;
}

p {
  font-size: 1rem;    /* 16px */
  padding: 1.5rem;     /* 24px */
}

h1 {
  font-size: 2rem;     /* 32px */
}
```

**特点**：
- 始终相对于根元素的字体大小
- 不受父元素影响，更可预测
- 适合创建一致的间距和大小系统

#### 4. vw（Viewport Width）

`vw` 是相对于视口宽度的单位，1vw 等于视口宽度的 1%。

```css
.container {
  width: 50vw;  /* 视口宽度的 50% */
}

h1 {
  font-size: 5vw;  /* 视口宽度的 5% */
}
```

**特点**：
- 相对于视口宽度
- 适合创建响应式布局
- 1vw = 视口宽度的 1%

#### 5. vh（Viewport Height）

`vh` 是相对于视口高度的单位，1vh 等于视口高度的 1%。

```css
.fullscreen {
  height: 100vh;  /* 视口高度的 100% */
}

.header {
  height: 10vh;   /* 视口高度的 10% */
}
```

**特点**：
- 相对于视口高度
- 适合创建全屏布局
- 1vh = 视口高度的 1%

#### 6. vmin 和 vmax

`vmin` 是视口宽度和高度中较小的那个值的 1%，`vmax` 是较大的那个值的 1%。

```css
.responsive {
  width: 50vmin;   /* 视口较小尺寸的 50% */
  height: 50vmax;  /* 视口较大尺寸的 50% */
}
```

**特点**：
- `vmin` = min(vw, vh)
- `vmax` = max(vw, vh)
- 适合创建在不同方向上都能适应的布局

#### 7. ch

`ch` 是相对于字符 "0" 的宽度的单位。

```css
.code-block {
  width: 80ch;  /* 大约 80 个字符的宽度 */
}
```

**特点**：
- 相对于当前字体的字符宽度
- 适合设置代码块、文章内容等宽度

#### 8. ex

`ex` 是相对于当前字体的小写字母 "x" 的高度的单位。

```css
.vertical-spacing {
  line-height: 2ex;  /* 2 倍小写 x 的高度 */
}
```

**特点**：
- 相对于当前字体的小写字母高度
- 使用较少，主要用于排版

## 角度单位（Angle Units）

用于旋转、渐变等需要角度的场景：

#### 1. 度（deg - Degrees）

`deg` 表示度数，一个完整的圆是 360 度。

```css
.rotate {
  transform: rotate(45deg);
}

.gradient {
  background: linear-gradient(90deg, red, blue);
}
```

#### 2. 弧度（rad - Radians）

`rad` 表示弧度，一个完整的圆是 2π 弧度。

```css
.rotate {
  transform: rotate(1.57rad);  /* 约 90 度 */
}
```

#### 3. 梯度（grad - Gradians）

`grad` 表示梯度，一个完整的圆是 400 梯度。

```css
.rotate {
  transform: rotate(100grad);  /* 90 度 */
}
```

#### 4. 转（turn）

`turn` 表示转数，一个完整的圆是 1 转。

```css
.rotate {
  transform: rotate(0.25turn);  /* 90 度 */
}
```

## 时间单位（Time Units）

用于动画和过渡：

#### 1. 秒（s - Seconds）

```css
.transition {
  transition: all 0.3s;
}

.animation {
  animation: fade 2s;
}
```

#### 2. 毫秒（ms - Milliseconds）

```css
.transition {
  transition: all 300ms;  /* 等同于 0.3s */
}
```

**换算关系**：1s = 1000ms

## 频率单位（Frequency Units）

用于音频等场景（使用较少）：

#### 1. 赫兹（Hz - Hertz）

```css
/* 主要用于 @media 查询 */
@media (min-resolution: 96dpi) {
  /* ... */
}
```

#### 2. 千赫兹（kHz - Kilohertz）

```css
/* 使用较少 */
```

## 分辨率单位（Resolution Units）

用于媒体查询，表示设备的分辨率：

#### 1. dpi（Dots Per Inch）

```css
@media (min-resolution: 96dpi) {
  /* 高分辨率设备 */
}
```

#### 2. dpcm（Dots Per Centimeter）

```css
@media (min-resolution: 38dpcm) {
  /* 高分辨率设备 */
}
```

#### 3. dppx（Dots Per Pixel）

```css
@media (min-resolution: 2dppx) {
  /* Retina 显示屏 */
}
```

## 无单位值（Unitless Values）

某些属性可以使用无单位的值：

#### 1. line-height

```css
p {
  line-height: 1.5;  /* 相对于字体大小的 1.5 倍 */
}
```

#### 2. z-index

```css
.header {
  z-index: 10;  /* 无单位 */
}
```

#### 3. opacity

```css
.fade {
  opacity: 0.5;  /* 0 到 1 之间的值 */
}
```

## 单位选择建议

### 1. 响应式设计

优先使用相对单位：

```css
.container {
  width: 90%;        /* 百分比 */
  max-width: 1200px; /* 最大宽度使用 px */
  padding: 1rem;     /* 使用 rem 保持一致性 */
}
```

### 2. 字体大小

推荐使用 `rem` 或 `em`：

```css
html {
  font-size: 16px;  /* 基准字体大小 */
}

h1 {
  font-size: 2rem;   /* 32px */
}

p {
  font-size: 1rem;   /* 16px */
  line-height: 1.5;  /* 无单位，相对于字体大小 */
}
```

### 3. 间距和尺寸

根据场景选择：

```css
/* 固定尺寸使用 px */
.icon {
  width: 24px;
  height: 24px;
}

/* 相对间距使用 rem */
.section {
  margin: 2rem 0;
  padding: 1rem;
}

/* 响应式宽度使用 % 或 vw */
.content {
  width: 100%;
  max-width: 50vw;
}
```

### 4. 全屏布局

使用视口单位：

```css
.fullscreen {
  width: 100vw;
  height: 100vh;
}

.header {
  height: 10vh;
}
```

## 单位换算参考

### 绝对单位换算（在 96 DPI 屏幕上）

- 1in = 96px = 72pt = 6pc = 2.54cm = 25.4mm

### 相对单位示例

假设根元素字体大小为 16px：

- 1rem = 16px
- 1em（在 16px 字体下）= 16px
- 100% = 父元素对应属性的 100%

假设视口宽度为 1920px：

- 1vw = 19.2px
- 50vw = 960px

## 小结

CSS 提供了丰富的测量单位：

- **绝对单位**：px、pt、in、cm、mm 等，固定大小
- **相对单位**：%、em、rem、vw、vh 等，相对于其他值
- **角度单位**：deg、rad、grad、turn，用于旋转和渐变
- **时间单位**：s、ms，用于动画和过渡
- **分辨率单位**：dpi、dpcm、dppx，用于媒体查询

选择合适的单位可以：

- 创建响应式布局
- 提高代码的可维护性
- 实现一致的视觉设计
- 优化不同设备的显示效果

在实际开发中，建议：
- 字体大小使用 `rem`
- 间距使用 `rem` 或 `em`
- 宽度使用 `%` 或 `vw`
- 固定尺寸使用 `px`

在接下来的教程中，你将学习如何使用这些单位来创建各种样式效果。
