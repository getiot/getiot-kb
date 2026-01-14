---
sidebar_position: 5
slug: /css-2d-transforms
---

# CSS 2D 变换

CSS 变换（Transform）允许你改变元素的位置、大小、形状和方向，而不会影响文档流。2D 变换在二维平面上操作元素，是创建动画和交互效果的基础。

## 为什么需要这个特性

2D 变换解决了以下问题：

1. **视觉变换**：移动、旋转、缩放、倾斜元素
2. **不影响布局**：变换不会影响其他元素的位置
3. **性能优化**：使用 GPU 加速，性能更好
4. **动画基础**：与过渡和动画结合，创建流畅效果
5. **交互反馈**：提供视觉反馈，增强用户体验

## 核心概念解释

### transform 属性

`transform` 属性用于对元素应用变换。可以同时应用多个变换，用空格分隔。

```css
.element {
  transform: translateX(50px);
  transform: translateX(50px) rotate(45deg);
  transform: translateX(50px) rotate(45deg) scale(1.2);
}
```

**重要**：变换不会影响文档流，元素仍占据原来的空间。

### 变换原点

`transform-origin` 设置变换的原点（变换围绕的点）。

```css
.element {
  transform-origin: center center;  /* 中心（默认） */
  transform-origin: top left;      /* 左上角 */
  transform-origin: 50% 50%;        /* 中心（百分比） */
  transform-origin: 20px 30px;      /* 像素值 */
}
```

## 核心变换函数

### 1. translate() / translateX() / translateY()

移动元素。

```css
.element {
  transform: translate(50px, 100px);  /* 水平 50px，垂直 100px */
  transform: translateX(50px);        /* 只水平移动 */
  transform: translateY(100px);       /* 只垂直移动 */
}
```

**使用场景**：
- 居中定位
- 悬停效果
- 滑动动画

### 2. scale() / scaleX() / scaleY()

缩放元素。

```css
.element {
  transform: scale(1.5);      /* 放大 1.5 倍 */
  transform: scale(0.5);      /* 缩小 0.5 倍 */
  transform: scale(2, 1.5);    /* 水平 2 倍，垂直 1.5 倍 */
  transform: scaleX(2);       /* 只水平缩放 */
  transform: scaleY(1.5);      /* 只垂直缩放 */
}
```

**使用场景**：
- 悬停放大效果
- 点击反馈
- 加载动画

### 3. rotate()

旋转元素。

```css
.element {
  transform: rotate(45deg);   /* 顺时针旋转 45 度 */
  transform: rotate(-45deg);   /* 逆时针旋转 45 度 */
  transform: rotate(90deg);    /* 旋转 90 度 */
  transform: rotate(1.57rad);  /* 使用弧度 */
}
```

**使用场景**：
- 图标旋转
- 加载动画
- 装饰效果

### 4. skew() / skewX() / skewY()

倾斜元素。

```css
.element {
  transform: skew(10deg, 5deg);  /* 水平倾斜 10 度，垂直倾斜 5 度 */
  transform: skewX(10deg);       /* 只水平倾斜 */
  transform: skewY(5deg);        /* 只垂直倾斜 */
}
```

**使用场景**：
- 创建倾斜效果
- 装饰性设计
- 特殊视觉效果

### 5. matrix()

使用矩阵进行复杂变换。

```css
.element {
  transform: matrix(1, 0, 0, 1, 50, 100);
  /* matrix(scaleX, skewY, skewX, scaleY, translateX, translateY) */
}
```

**注意**：`matrix()` 比较复杂，通常使用其他变换函数更直观。

## 常见组合用法

### 1. 居中定位

```css
.modal {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
```

### 2. 悬停效果

```css
.card {
  transition: transform 0.3s ease;
}

.card:hover {
  transform: translateY(-4px) scale(1.02);
}
```

### 3. 点击反馈

```css
.button {
  transition: transform 0.1s ease;
}

.button:active {
  transform: scale(0.98);
}
```

### 4. 旋转动画

```css
.icon {
  transition: transform 0.3s ease;
}

.icon:hover {
  transform: rotate(180deg);
}
```

### 5. 组合变换

```css
.element {
  transform: translateX(50px) rotate(45deg) scale(1.2);
}
```

## 示例

### 示例 1：卡片悬停效果

```html
<div class="card">
  <h3>卡片标题</h3>
  <p>卡片内容</p>
</div>
```

```css
.card {
  background-color: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card:hover {
  transform: translateY(-4px) scale(1.02);
  box-shadow: 0 4px 8px rgba(0,0,0,0.15);
}
```

### 示例 2：按钮点击效果

```html
<button class="btn">点击我</button>
```

```css
.btn {
  background-color: #007bff;
  color: white;
  padding: 12px 24px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: transform 0.1s ease, background-color 0.3s ease;
}

.btn:hover {
  background-color: #0056b3;
}

.btn:active {
  transform: scale(0.98);
}
```

### 示例 3：图标旋转

```html
<button class="rotate-btn">
  <span class="icon">↻</span>
  刷新
</button>
```

```css
.rotate-btn {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 20px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.icon {
  display: inline-block;
  transition: transform 0.3s ease;
}

.rotate-btn:hover .icon {
  transform: rotate(180deg);
}

.rotate-btn:active .icon {
  transform: rotate(360deg);
}
```

### 示例 4：滑动菜单

```html
<nav class="slide-menu">
  <ul>
    <li><a href="#">首页</a></li>
    <li><a href="#">关于</a></li>
    <li><a href="#">服务</a></li>
  </ul>
</nav>
```

```css
.slide-menu {
  position: fixed;
  top: 0;
  left: -250px;  /* 初始位置在左侧外 */
  width: 250px;
  height: 100vh;
  background-color: #333;
  transition: transform 0.3s ease;
}

.slide-menu.open {
  transform: translateX(250px);  /* 滑入 */
}
```

### 示例 5：翻转卡片

```html
<div class="flip-card">
  <div class="flip-card-inner">
    <div class="flip-card-front">正面</div>
    <div class="flip-card-back">背面</div>
  </div>
</div>
```

```css
.flip-card {
  width: 300px;
  height: 200px;
  perspective: 1000px;
}

.flip-card-inner {
  position: relative;
  width: 100%;
  height: 100%;
  transition: transform 0.6s;
  transform-style: preserve-3d;
}

.flip-card:hover .flip-card-inner {
  transform: rotateY(180deg);
}

.flip-card-front,
.flip-card-back {
  position: absolute;
  width: 100%;
  height: 100%;
  backface-visibility: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
}

.flip-card-back {
  transform: rotateY(180deg);
}
```

## 注意事项

### 1. 变换不影响布局

变换不会影响文档流，元素仍占据原来的空间：

```css
.element {
  transform: translateX(100px);  /* 视觉上移动了，但空间还在原处 */
}
```

### 2. 变换顺序很重要

变换按照从左到右的顺序应用：

```css
/* 先移动后旋转 */
.element {
  transform: translateX(50px) rotate(45deg);
}

/* 先旋转后移动（结果不同） */
.element {
  transform: rotate(45deg) translateX(50px);
}
```

### 3. 性能优化

`transform` 和 `opacity` 是性能最好的属性，因为它们可以使用 GPU 加速：

```css
/* 推荐：性能好 */
.element {
  transition: transform 0.3s;
}

/* 不推荐：可能影响性能 */
.element {
  transition: width 0.3s;
}
```

### 4. 变换原点

理解 `transform-origin` 对变换的影响：

```css
.element {
  transform-origin: top left;  /* 从左上角旋转 */
  transform: rotate(45deg);
}
```

### 5. 百分比值

`translate` 的百分比值是相对于元素自身的尺寸：

```css
.element {
  width: 200px;
  transform: translateX(50%);  /* 移动 100px（自身宽度的 50%） */
}
```

## 小结

CSS 2D 变换提供了强大的元素变换能力：

- **移动**：`translate()` 移动元素位置
- **缩放**：`scale()` 改变元素大小
- **旋转**：`rotate()` 旋转元素
- **倾斜**：`skew()` 倾斜元素
- **组合**：可以组合多个变换

**使用建议**：
- 变换不影响布局
- 注意变换顺序
- 优先使用 transform 优化性能
- 理解变换原点
- 注意百分比值的计算方式

掌握了 2D 变换，你就能创建各种动态效果。在下一章，我们将学习 3D 变换，了解如何在三维空间中操作元素。
