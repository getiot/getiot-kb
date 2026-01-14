---
sidebar_position: 4
slug: /css-box-model
---

# CSS 盒模型与尺寸属性

盒模型是 CSS 的基础概念之一，理解盒模型对于掌握 CSS 布局至关重要。盒模型定义了元素如何占用空间，包括内容、内边距、边框和外边距。

## 该类属性解决什么问题

盒模型与尺寸属性主要解决以下问题：

1. **元素大小控制**：精确控制元素的宽度和高度
2. **间距管理**：通过内外边距控制元素之间的间距
3. **布局计算**：理解元素实际占用的空间，正确计算布局
4. **响应式设计**：使用相对单位和最大最小尺寸，实现响应式布局

## 盒模型基础

### 标准盒模型

在标准盒模型中，元素的宽度和高度只包括**内容区域**，不包括内边距、边框和外边距。

```
┌─────────────────────────────────┐
│         margin (外边距)          │
│  ┌───────────────────────────┐  │
│  │      border (边框)         │  │
│  │  ┌─────────────────────┐  │  │
│  │  │   padding (内边距)   │  │  │
│  │  │  ┌───────────────┐  │  │  │
│  │  │  │  content      │  │  │  │
│  │  │  │  (内容区域)    │  │  │  │
│  │  │  └───────────────┘  │  │  │
│  │  └─────────────────────┘  │  │
│  └───────────────────────────┘  │
└─────────────────────────────────┘
```

**总宽度** = width + padding-left + padding-right + border-left + border-right + margin-left + margin-right

**总高度** = height + padding-top + padding-bottom + border-top + border-bottom + margin-top + margin-bottom

### 替代盒模型（border-box）

在替代盒模型中，元素的宽度和高度包括**内容、内边距和边框**，不包括外边距。

```
┌─────────────────────────────────┐
│         margin (外边距)          │
│  ┌───────────────────────────┐  │
│  │  border + padding + content │  │
│  │  (总宽度 = width)          │  │
│  └───────────────────────────┘  │
└─────────────────────────────────┘
```

**总宽度** = width（已包含 padding 和 border）+ margin-left + margin-right

**总高度** = height（已包含 padding 和 border）+ margin-top + margin-bottom

## 核心属性介绍

### 尺寸属性

#### width

设置元素的宽度。

```css
div {
  width: 300px;        /* 固定宽度 */
  width: 50%;          /* 相对父元素 */
  width: 50vw;         /* 相对视口 */
  width: auto;          /* 自动（默认） */
  width: 100%;          /* 占满父元素 */
}
```

#### height

设置元素的高度。

```css
div {
  height: 200px;       /* 固定高度 */
  height: 50vh;        /* 相对视口 */
  height: auto;         /* 自动（默认） */
  height: 100%;         /* 占满父元素 */
}
```

#### min-width / max-width

设置元素的最小/最大宽度。

```css
div {
  min-width: 300px;    /* 最小宽度 */
  max-width: 1200px;   /* 最大宽度 */
  width: 100%;          /* 在最小和最大之间自适应 */
}
```

#### min-height / max-height

设置元素的最小/最大高度。

```css
div {
  min-height: 200px;    /* 最小高度 */
  max-height: 600px;    /* 最大高度 */
  height: auto;         /* 在最小和最大之间自适应 */
}
```

### 内边距属性

#### padding

设置元素的内边距（内容与边框之间的距离）。

```css
div {
  padding: 20px;                    /* 所有方向 */
  padding: 20px 40px;               /* 上下 左右 */
  padding: 10px 20px 30px 40px;     /* 上 右 下 左 */
  padding-top: 10px;                /* 单独设置 */
  padding-right: 20px;
  padding-bottom: 30px;
  padding-left: 40px;
}
```

### 外边距属性

#### margin

设置元素的外边距（元素与其他元素之间的距离）。

```css
div {
  margin: 20px;                     /* 所有方向 */
  margin: 20px auto;                /* 上下 左右（auto 用于居中） */
  margin: 10px 20px 30px 40px;      /* 上 右 下 左 */
  margin-top: 10px;                 /* 单独设置 */
  margin-right: 20px;
  margin-bottom: 30px;
  margin-left: 40px;
}
```

**margin 的特殊值**：

```css
div {
  margin: auto;        /* 自动（用于水平居中） */
  margin: 0;           /* 无外边距 */
  margin: -10px;       /* 负值（可以重叠） */
}
```

### 盒模型属性

#### box-sizing

设置盒模型的计算方式。

```css
div {
  box-sizing: content-box;  /* 标准盒模型（默认） */
  box-sizing: border-box;   /* 替代盒模型 */
}
```

**推荐**：使用 `border-box`，因为它更直观，更容易计算。

```css
/* 全局设置 */
* {
  box-sizing: border-box;
}
```

## 常见组合用法

### 1. 容器布局

```css
.container {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;        /* 水平居中 */
  padding: 20px;
  box-sizing: border-box;
}
```

### 2. 卡片组件

```css
.card {
  width: 300px;
  padding: 20px;
  margin: 20px;
  box-sizing: border-box;
}

/* 响应式 */
@media (max-width: 768px) {
  .card {
    width: 100%;
    margin: 10px 0;
  }
}
```

### 3. 按钮尺寸

```css
.button {
  padding: 10px 20px;
  min-width: 100px;
  height: 40px;
  box-sizing: border-box;
}
```

### 4. 表单输入框

```css
.input {
  width: 100%;
  padding: 10px;
  box-sizing: border-box;
  border: 1px solid #ccc;
}
```

## 示例演示

### 示例 1：盒模型对比

```html
<div class="box content-box">标准盒模型</div>
<div class="box border-box">替代盒模型</div>
```

```css
.box {
  width: 200px;
  padding: 20px;
  border: 10px solid #007bff;
  margin: 20px;
  background-color: #f0f0f0;
}

.content-box {
  box-sizing: content-box;  /* 总宽度 = 200 + 20*2 + 10*2 = 260px */
}

.border-box {
  box-sizing: border-box;    /* 总宽度 = 200px（已包含 padding 和 border） */
}
```

### 示例 2：响应式容器

```html
<div class="container">
  <div class="content">内容区域</div>
</div>
```

```css
.container {
  width: 100%;
  max-width: 1200px;
  min-width: 320px;      /* 最小宽度（移动设备） */
  margin: 0 auto;
  padding: 20px;
  box-sizing: border-box;
}

.content {
  width: 100%;
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  box-sizing: border-box;
}
```

### 示例 3：网格布局

```html
<div class="grid">
  <div class="grid-item">项目 1</div>
  <div class="grid-item">项目 2</div>
  <div class="grid-item">项目 3</div>
</div>
```

```css
.grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
  padding: 20px;
  box-sizing: border-box;
}

.grid-item {
  padding: 20px;
  box-sizing: border-box;
  background-color: #f0f0f0;
}
```

### 示例 4：间距系统

```css
/* 建立间距系统 */
:root {
  --spacing-xs: 4px;
  --spacing-sm: 8px;
  --spacing-md: 16px;
  --spacing-lg: 24px;
  --spacing-xl: 32px;
}

.card {
  padding: var(--spacing-lg);
  margin-bottom: var(--spacing-md);
}

.button {
  padding: var(--spacing-sm) var(--spacing-md);
  margin-right: var(--spacing-sm);
}
```

## 使用建议

### 1. 全局设置 border-box

推荐在项目开始时全局设置 `border-box`：

```css
*,
*::before,
*::after {
  box-sizing: border-box;
}
```

这样可以避免盒模型计算带来的困扰。

### 2. 使用相对单位

优先使用相对单位（`%`、`rem`、`em`、`vw`、`vh`），便于响应式设计：

```css
.container {
  width: 90%;
  max-width: 1200px;
  padding: 2rem;
  margin: 0 auto;
}
```

### 3. 建立间距系统

使用 CSS 变量建立统一的间距系统：

```css
:root {
  --spacing-unit: 8px;
  --spacing-1: var(--spacing-unit);
  --spacing-2: calc(var(--spacing-unit) * 2);
  --spacing-3: calc(var(--spacing-unit) * 3);
  --spacing-4: calc(var(--spacing-unit) * 4);
}
```

### 4. 注意 margin 折叠

相邻元素的垂直 margin 会折叠（取较大值）：

```css
/* 元素 1 */
.element1 {
  margin-bottom: 20px;
}

/* 元素 2 */
.element2 {
  margin-top: 30px;  /* 实际间距是 30px，不是 50px */
}
```

**解决方案**：
- 使用 padding 代替 margin
- 使用 Flexbox 或 Grid 布局
- 使用 `display: inline-block`

### 5. 负 margin 的使用

负 margin 可以用于重叠效果，但要谨慎使用：

```css
.overlap {
  margin-top: -20px;  /* 向上移动，与上方元素重叠 */
}
```

## 小结

盒模型与尺寸属性控制元素的大小和间距：

- **尺寸属性**：`width`、`height`、`min-width`、`max-width` 等
- **内边距**：`padding` 控制内容与边框的距离
- **外边距**：`margin` 控制元素之间的距离
- **盒模型**：`box-sizing` 控制尺寸计算方式

**使用建议**：
- 全局设置 `border-box`
- 使用相对单位
- 建立间距系统
- 注意 margin 折叠
- 谨慎使用负 margin

理解了盒模型，你就能精确控制元素的大小和间距。在下一章，我们将学习布局与定位属性，了解如何控制元素在页面中的位置。
