---
sidebar_position: 2
slug: /css-functions
---

# CSS 函数与数学函数

CSS 函数是 CSS 中用于计算值的工具，它们可以接受参数并返回结果。从简单的颜色函数到复杂的数学计算，CSS 函数让样式变得更加动态和灵活。

## 为什么需要这个特性

CSS 函数解决了以下问题：

1. **动态计算**：根据上下文动态计算值
2. **代码复用**：避免重复计算相同的值
3. **响应式设计**：根据视口大小动态调整
4. **复杂计算**：进行复杂的数学运算
5. **类型转换**：在不同单位之间转换

## CSS 函数分类

CSS 函数可以按照功能分为以下几类：

### 1. 颜色函数

#### rgb() / rgba()

使用 RGB 值创建颜色。

```css
.element {
  color: rgb(255, 0, 0);           /* 红色 */
  color: rgba(255, 0, 0, 0.5);    /* 半透明红色 */
  background-color: rgb(0, 123, 255);
}
```

#### hsl() / hsla()

使用 HSL 值创建颜色。

```css
.element {
  color: hsl(0, 100%, 50%);        /* 红色 */
  color: hsla(0, 100%, 50%, 0.5);  /* 半透明红色 */
  background-color: hsl(210, 100%, 50%);  /* 蓝色 */
}
```

#### color-mix()

混合两种颜色。

```css
.element {
  color: color-mix(in srgb, blue 50%, white);
  /* 混合 50% 的蓝色和 50% 的白色 */
}
```

### 2. 数学函数

#### calc()

执行数学计算。

```css
.element {
  width: calc(100% - 40px);        /* 宽度减去 40px */
  height: calc(100vh - 80px);       /* 视口高度减去 80px */
  padding: calc(20px + 10px);       /* 加法 */
  margin: calc(2rem * 2);           /* 乘法 */
  font-size: calc(16px / 2);        /* 除法 */
}
```

**注意**：运算符前后必须有空格。

#### min()

返回最小值。

```css
.element {
  width: min(100%, 1200px);        /* 不超过 1200px */
  font-size: min(2rem, 24px);       /* 取较小值 */
}
```

#### max()

返回最大值。

```css
.element {
  width: max(300px, 50%);           /* 至少 300px */
  font-size: max(14px, 1rem);       /* 取较大值 */
}
```

#### clamp()

限制值在最小值和最大值之间。

```css
.element {
  font-size: clamp(14px, 4vw, 24px);
  /* 最小值 14px，理想值 4vw，最大值 24px */
  width: clamp(300px, 50%, 1200px);
  /* 最小值 300px，理想值 50%，最大值 1200px */
}
```

### 3. 变换函数

#### translate() / translateX() / translateY()

移动元素。

```css
.element {
  transform: translate(50px, 100px);
  transform: translateX(50px);
  transform: translateY(100px);
}
```

#### scale() / scaleX() / scaleY()

缩放元素。

```css
.element {
  transform: scale(1.5);      /* 放大 1.5 倍 */
  transform: scaleX(2);       /* 水平放大 2 倍 */
  transform: scaleY(0.5);     /* 垂直缩小 0.5 倍 */
}
```

#### rotate()

旋转元素。

```css
.element {
  transform: rotate(45deg);     /* 旋转 45 度 */
  transform: rotate(1.57rad);  /* 旋转 90 度（弧度） */
}
```

### 4. 渐变函数

#### linear-gradient()

创建线性渐变。

```css
.element {
  background: linear-gradient(to right, red, blue);
  background: linear-gradient(45deg, red, blue);
  background: linear-gradient(to bottom, red, yellow, blue);
}
```

#### radial-gradient()

创建径向渐变。

```css
.element {
  background: radial-gradient(circle, red, blue);
  background: radial-gradient(ellipse at center, red, blue);
}
```

#### conic-gradient()

创建圆锥渐变。

```css
.element {
  background: conic-gradient(red, yellow, green, blue, red);
}
```

### 5. 图像函数

#### url()

引用外部资源。

```css
.element {
  background-image: url("image.jpg");
  background-image: url("https://example.com/image.png");
}
```

#### image-set()

根据设备像素比选择图像。

```css
.element {
  background-image: image-set(
    "image-1x.jpg" 1x,
    "image-2x.jpg" 2x
  );
}
```

### 6. 其他常用函数

#### var()

引用 CSS 变量。

```css
.element {
  color: var(--primary-color);
  padding: var(--spacing, 10px);  /* 带默认值 */
}
```

#### attr()

获取元素的属性值。

```css
.element::before {
  content: attr(data-label);
}
```

```html
<div class="element" data-label="标签">内容</div>
```

#### counter() / counters()

使用计数器。

```css
ol {
  counter-reset: item;
}

li {
  counter-increment: item;
}

li::before {
  content: counter(item) ". ";
}
```

## 常见用法

### 1. 响应式字体大小

```css
h1 {
  font-size: clamp(24px, 5vw, 48px);
  /* 最小 24px，理想 5vw，最大 48px */
}
```

### 2. 居中定位

```css
.modal {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
```

### 3. 计算间距

```css
.container {
  width: calc(100% - 40px);
  padding: calc(20px + 10px);
  margin: calc(2rem * 2);
}
```

### 4. 动态颜色

```css
.button {
  background-color: hsl(var(--hue), 70%, 50%);
  /* 通过改变 --hue 变量改变颜色 */
}
```

### 5. 渐变背景

```css
.hero {
  background: linear-gradient(
    to bottom,
    rgba(0,0,0,0.5),
    rgba(0,0,0,0.8)
  ),
  url("hero.jpg");
}
```

## 示例

### 示例 1：响应式布局

```css
.container {
  width: min(100%, 1200px);
  margin: 0 auto;
  padding: clamp(10px, 2vw, 20px);
}

.card {
  width: calc(33.333% - 20px);
  margin: 10px;
}

@media (max-width: 768px) {
  .card {
    width: calc(50% - 20px);
  }
}

@media (max-width: 480px) {
  .card {
    width: calc(100% - 20px);
  }
}
```

### 示例 2：动态颜色系统

```css
:root {
  --hue: 210;  /* 蓝色 */
}

.button-primary {
  background-color: hsl(var(--hue), 70%, 50%);
  color: white;
}

.button-primary:hover {
  background-color: hsl(var(--hue), 70%, 40%);
}

/* 通过 JavaScript 改变 --hue 可以改变所有按钮颜色 */
```

### 示例 3：复杂计算

```css
.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(calc(100% / 3 - 20px), 1fr));
  gap: 20px;
}

.element {
  padding: calc(1rem + 2vw);
  margin: calc(20px - 1rem);
}
```

### 示例 4：渐变按钮

```css
.button {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 12px 24px;
  border: none;
  border-radius: 8px;
  transition: transform 0.3s;
}

.button:hover {
  transform: scale(1.05);
}
```

## 注意事项

### 1. calc() 运算符前后必须有空格

```css
/* 正确 */
width: calc(100% - 20px);

/* 错误 */
width: calc(100%-20px);  /* 无效 */
```

### 2. 单位混合

在 `calc()` 中，不同单位可以混合使用：

```css
.element {
  width: calc(100% - 20px);      /* 百分比和像素 */
  font-size: calc(1rem + 2vw);   /* rem 和视口单位 */
}
```

### 3. 嵌套函数

函数可以嵌套使用：

```css
.element {
  color: rgb(calc(255 - 50), 0, 0);
  background: linear-gradient(to right, hsl(0, 100%, 50%), hsl(120, 100%, 50%));
}
```

### 4. 浏览器兼容性

某些新函数可能不支持旧浏览器：

```css
/* 提供降级方案 */
.element {
  width: 100%;  /* 降级方案 */
  width: min(100%, 1200px);  /* 现代浏览器 */
}

/* 使用 @supports 检测 */
@supports (width: min(100%, 1200px)) {
  .element {
    width: min(100%, 1200px);
  }
}
```

### 5. 性能考虑

复杂的计算可能影响性能：

```css
/* 避免过度嵌套 */
.element {
  padding: calc(calc(var(--base) * 2) + calc(var(--offset) * 3));  /* 不推荐 */
}

/* 推荐：简化计算 */
.element {
  padding: calc(var(--base) * 2 + var(--offset) * 3);
}
```

## 小结

CSS 函数提供了强大的计算和转换能力：

- **颜色函数**：`rgb()`、`hsl()`、`color-mix()` 等
- **数学函数**：`calc()`、`min()`、`max()`、`clamp()` 等
- **变换函数**：`translate()`、`scale()`、`rotate()` 等
- **渐变函数**：`linear-gradient()`、`radial-gradient()` 等
- **其他函数**：`var()`、`attr()`、`url()` 等

**使用建议**：
- `calc()` 运算符前后必须有空格
- 注意单位混合
- 函数可以嵌套使用
- 考虑浏览器兼容性
- 注意性能影响

掌握了 CSS 函数，你就能创建更加动态和灵活的样式。在接下来的章节中，我们将学习 CSS 渐变、过渡和动画，了解如何创建流畅的视觉效果。
