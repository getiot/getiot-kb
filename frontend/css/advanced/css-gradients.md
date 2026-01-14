---
sidebar_position: 3
slug: /css-gradients
---

# CSS 渐变

渐变是 CSS 中用于创建平滑颜色过渡的强大工具。通过渐变，你可以创建从一种颜色到另一种颜色的平滑过渡，或者创建复杂的多色渐变效果，无需使用图片。

## 为什么需要这个特性

渐变解决了以下问题：

1. **视觉效果**：创建平滑的颜色过渡，增强视觉吸引力
2. **减少图片**：使用 CSS 渐变代替背景图片，减少 HTTP 请求
3. **灵活性**：可以动态调整渐变方向和颜色
4. **性能**：CSS 渐变比图片加载更快
5. **响应式**：渐变可以随容器大小自适应

## 核心概念解释

渐变是一种图像，由两种或多种颜色之间的平滑过渡组成。CSS 支持三种类型的渐变：

1. **线性渐变（Linear Gradient）**：沿着一条直线过渡
2. **径向渐变（Radial Gradient）**：从中心点向外辐射过渡
3. **圆锥渐变（Conic Gradient）**：围绕中心点旋转过渡

## 线性渐变

线性渐变沿着一条直线创建颜色过渡。

### 基本语法

```css
background: linear-gradient(direction, color1, color2, ...);
```

### 方向

可以使用关键字或角度指定渐变方向：

```css
/* 关键字 */
.element {
  background: linear-gradient(to right, red, blue);      /* 从左到右 */
  background: linear-gradient(to bottom, red, blue);     /* 从上到下 */
  background: linear-gradient(to top right, red, blue);  /* 到右上角 */
}

/* 角度 */
.element {
  background: linear-gradient(45deg, red, blue);         /* 45 度角 */
  background: linear-gradient(90deg, red, blue);         /* 90 度（从上到下） */
  background: linear-gradient(180deg, red, blue);         /* 180 度（从右到左） */
}
```

### 颜色停止点

可以指定颜色的位置：

```css
.element {
  background: linear-gradient(to right, red 0%, blue 100%);
  background: linear-gradient(to right, red 0%, yellow 50%, blue 100%);
  background: linear-gradient(to right, red, yellow 30%, blue);
}
```

### 多色渐变

可以添加多个颜色：

```css
.element {
  background: linear-gradient(to right, red, orange, yellow, green, blue, indigo, violet);
}
```

### 透明度渐变

可以创建透明到不透明的渐变：

```css
.element {
  background: linear-gradient(to bottom, rgba(0,0,0,0), rgba(0,0,0,0.8));
  /* 从透明到半透明黑色 */
}
```

## 径向渐变

径向渐变从中心点向外辐射创建颜色过渡。

### 基本语法

```css
background: radial-gradient(shape size at position, color1, color2, ...);
```

### 形状和大小

```css
.element {
  background: radial-gradient(circle, red, blue);           /* 圆形 */
  background: radial-gradient(ellipse, red, blue);         /* 椭圆形 */
  background: radial-gradient(circle at center, red, blue); /* 指定位置 */
  background: radial-gradient(circle 100px, red, blue);    /* 指定大小 */
}
```

### 位置

可以指定渐变的中心位置：

```css
.element {
  background: radial-gradient(circle at top left, red, blue);
  background: radial-gradient(circle at 30% 50%, red, blue);
  background: radial-gradient(circle at 100px 100px, red, blue);
}
```

### 大小关键字

```css
.element {
  background: radial-gradient(closest-side, red, blue);
  background: radial-gradient(farthest-side, red, blue);
  background: radial-gradient(closest-corner, red, blue);
  background: radial-gradient(farthest-corner, red, blue);
}
```

## 圆锥渐变

圆锥渐变围绕中心点旋转创建颜色过渡。

### 基本语法

```css
background: conic-gradient(from angle at position, color1, color2, ...);
```

### 示例

```css
.element {
  background: conic-gradient(red, yellow, green, blue, red);
  background: conic-gradient(from 45deg, red, blue);
  background: conic-gradient(from 0deg at 50% 50%, red, yellow, green, blue, red);
}
```

## 常见用法

### 1. 按钮渐变

```css
.button {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 8px;
}

.button:hover {
  background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
}
```

### 2. 卡片背景

```css
.card {
  background: linear-gradient(to bottom, #fff, #f5f5f5);
  border-radius: 8px;
  padding: 20px;
}
```

### 3. 遮罩效果

```css
.hero {
  background-image: url("hero.jpg");
  background-size: cover;
  position: relative;
}

.hero::after {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(to bottom, transparent, rgba(0,0,0,0.7));
}
```

### 4. 文字渐变

```css
.gradient-text {
  background: linear-gradient(135deg, #667eea, #764ba2);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}
```

### 5. 加载动画

```css
.loader {
  width: 50px;
  height: 50px;
  border: 4px solid #f3f3f3;
  border-top: 4px solid #3498db;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
```

## 示例

### 示例 1：渐变按钮

```html
<button class="gradient-button">渐变按钮</button>
```

```css
.gradient-button {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 8px;
  font-size: 16px;
  cursor: pointer;
  transition: transform 0.3s, box-shadow 0.3s;
}

.gradient-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(102, 126, 234, 0.4);
}

.gradient-button:active {
  transform: translateY(0);
}
```

### 示例 2：卡片渐变背景

```html
<div class="gradient-card">
  <h3>卡片标题</h3>
  <p>卡片内容</p>
</div>
```

```css
.gradient-card {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 4px 8px rgba(0,0,0,0.2);
}
```

### 示例 3：文字渐变效果

```html
<h1 class="gradient-title">渐变标题</h1>
```

```css
.gradient-title {
  font-size: 3rem;
  font-weight: bold;
  background: linear-gradient(135deg, #667eea, #764ba2, #f093fb);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}
```

### 示例 4：径向渐变背景

```html
<div class="radial-bg">内容</div>
```

```css
.radial-bg {
  background: radial-gradient(circle at center, #667eea, #764ba2);
  padding: 50px;
  color: white;
  text-align: center;
}
```

### 示例 5：多重渐变

```css
.complex-gradient {
  background:
    linear-gradient(to bottom, rgba(0,0,0,0.3), rgba(0,0,0,0.7)),
    radial-gradient(circle at top left, rgba(255,0,0,0.3), transparent),
    url("bg.jpg");
  background-size: cover;
}
```

## 注意事项

### 1. 浏览器兼容性

某些渐变语法可能不支持旧浏览器：

```css
/* 提供降级方案 */
.element {
  background-color: #667eea;  /* 降级方案 */
  background: linear-gradient(135deg, #667eea, #764ba2);
}
```

### 2. 性能考虑

复杂的多重渐变可能影响性能：

```css
/* 避免过度使用 */
.element {
  background:
    linear-gradient(...),
    radial-gradient(...),
    conic-gradient(...),
    url("image.jpg");  /* 可能影响性能 */
}
```

### 3. 文字渐变兼容性

文字渐变需要特殊处理：

```css
.gradient-text {
  background: linear-gradient(135deg, #667eea, #764ba2);
  -webkit-background-clip: text;  /* WebKit 前缀 */
  -webkit-text-fill-color: transparent;
  background-clip: text;  /* 标准语法 */
}
```

### 4. 渐变方向

理解角度和关键字的关系：

- `0deg` 或 `to top`：从下到上
- `90deg` 或 `to right`：从左到右
- `180deg` 或 `to bottom`：从上到下
- `270deg` 或 `to left`：从右到左

### 5. 颜色停止点

合理使用颜色停止点创建平滑过渡：

```css
/* 推荐：平滑过渡 */
.element {
  background: linear-gradient(to right, red, yellow, blue);
}

/* 不推荐：突然变化 */
.element {
  background: linear-gradient(to right, red 0%, red 49%, blue 50%, blue 100%);
}
```

## 小结

CSS 渐变是创建平滑颜色过渡的强大工具：

- **线性渐变**：沿着直线过渡
- **径向渐变**：从中心点向外辐射
- **圆锥渐变**：围绕中心点旋转

**使用建议**：
- 提供降级方案
- 注意性能影响
- 文字渐变需要特殊处理
- 理解渐变方向
- 合理使用颜色停止点

掌握了 CSS 渐变，你就能创建丰富的视觉效果。在下一章，我们将学习 CSS 过渡，了解如何创建平滑的状态变化。
