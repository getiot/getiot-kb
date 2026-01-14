---
sidebar_position: 3
slug: /css-background-border
---

# CSS 背景与边框属性

背景与边框属性用于控制元素的视觉装饰，包括背景颜色、背景图片、边框样式等。这些属性让你能够为元素添加丰富的视觉效果，提升页面的美观性和用户体验。

## 该类属性解决什么问题

背景与边框属性主要解决以下问题：

1. **视觉装饰**：为元素添加背景和边框，增强视觉效果
2. **内容区分**：通过不同的背景和边框，区分不同的内容区域
3. **品牌识别**：使用品牌色彩和样式，保持视觉一致性
4. **用户体验**：通过视觉反馈（如悬停效果），提升交互体验

## 核心属性介绍

### 背景属性

#### background-color

设置元素的背景颜色。

```css
div {
  background-color: red;
  background-color: #ff0000;
  background-color: rgb(255, 0, 0);
  background-color: rgba(255, 0, 0, 0.5);  /* 带透明度 */
  background-color: transparent;  /* 透明 */
}
```

#### background-image

设置元素的背景图片。

```css
div {
  background-image: url("image.jpg");
  background-image: url("https://example.com/image.png");
  background-image: linear-gradient(to bottom, #fff, #000);  /* 渐变 */
  background-image: none;  /* 无背景图片 */
}
```

**注意**：可以设置多个背景图片，用逗号分隔。

```css
div {
  background-image: 
    url("image1.jpg"),
    url("image2.jpg");
}
```

#### background-position

设置背景图片的位置。

```css
div {
  background-position: center;        /* 居中 */
  background-position: top left;     /* 左上角 */
  background-position: 50% 50%;      /* 百分比 */
  background-position: 20px 30px;    /* 像素值 */
  background-position: center top;    /* 水平居中，垂直顶部 */
}
```

#### background-size

设置背景图片的大小。

```css
div {
  background-size: cover;      /* 覆盖整个元素 */
  background-size: contain;    /* 完整显示图片 */
  background-size: 100% 100%;  /* 拉伸到元素大小 */
  background-size: 200px 150px; /* 固定大小 */
  background-size: auto;        /* 原始大小 */
}
```

#### background-repeat

设置背景图片的重复方式。

```css
div {
  background-repeat: repeat;    /* 重复（默认） */
  background-repeat: no-repeat; /* 不重复 */
  background-repeat: repeat-x;  /* 水平重复 */
  background-repeat: repeat-y;  /* 垂直重复 */
  background-repeat: space;     /* 重复并留空间 */
  background-repeat: round;     /* 重复并缩放 */
}
```

#### background-attachment

设置背景图片的附着方式。

```css
div {
  background-attachment: scroll;  /* 随内容滚动（默认） */
  background-attachment: fixed;   /* 固定（视口固定） */
  background-attachment: local;   /* 随元素内容滚动 */
}
```

#### background-clip

设置背景的绘制区域。

```css
div {
  background-clip: border-box;   /* 延伸到边框（默认） */
  background-clip: padding-box;  /* 延伸到内边距 */
  background-clip: content-box;  /* 只在内容区域 */
}
```

#### background-origin

设置背景图片的定位原点。

```css
div {
  background-origin: padding-box;  /* 从内边距开始（默认） */
  background-origin: border-box;   /* 从边框开始 */
  background-origin: content-box;  /* 从内容开始 */
}
```

#### background（简写属性）

`background` 是多个背景属性的简写。

```css
div {
  background: color image position/size repeat attachment origin clip;
}

/* 示例 */
div {
  background: #fff url("image.jpg") center/cover no-repeat;
}
```

### 边框属性

#### border-width

设置边框宽度。

```css
div {
  border-width: 1px;
  border-width: thin;    /* 细边框 */
  border-width: medium; /* 中等边框 */
  border-width: thick;   /* 粗边框 */
  border-width: 2px 4px; /* 上下 左右 */
  border-width: 1px 2px 3px 4px; /* 上 右 下 左 */
}
```

#### border-style

设置边框样式。

```css
div {
  border-style: solid;   /* 实线 */
  border-style: dashed;  /* 虚线 */
  border-style: dotted;   /* 点线 */
  border-style: double;  /* 双线 */
  border-style: groove;  /* 3D 凹槽 */
  border-style: ridge;   /* 3D 凸起 */
  border-style: inset;   /* 3D 内嵌 */
  border-style: outset;  /* 3D 外凸 */
  border-style: none;    /* 无边框 */
}
```

#### border-color

设置边框颜色。

```css
div {
  border-color: red;
  border-color: #ff0000;
  border-color: rgb(255, 0, 0);
  border-color: red blue;  /* 上下 左右 */
  border-color: red blue green yellow;  /* 上 右 下 左 */
}
```

#### border（简写属性）

`border` 是边框宽度、样式和颜色的简写。

```css
div {
  border: width style color;
}

/* 示例 */
div {
  border: 1px solid #ccc;
}
```

#### border-radius

设置边框圆角。

```css
div {
  border-radius: 4px;              /* 所有角 */
  border-radius: 4px 8px;          /* 左上右下 右上左下 */
  border-radius: 4px 8px 12px 16px; /* 左上 右上 右下 左下 */
  border-radius: 50%;              /* 圆形 */
}
```

#### border-image

使用图片作为边框。

```css
div {
  border-image: url("border.png") 30 round;
  /* 语法：source slice width outset repeat */
}
```

#### box-shadow

设置元素的阴影。

```css
div {
  box-shadow: 2px 2px 4px rgba(0,0,0,0.3);
  /* 语法：x偏移 y偏移 模糊半径 扩散半径 颜色 */
}

/* 多个阴影 */
div {
  box-shadow: 
    2px 2px 4px rgba(0,0,0,0.3),
    0 0 10px rgba(255,0,0,0.5);
}

/* 内阴影 */
div {
  box-shadow: inset 2px 2px 4px rgba(0,0,0,0.3);
}
```

### 轮廓属性

#### outline

设置元素的轮廓（不占用空间）。

```css
input {
  outline: 2px solid #007bff;
  outline: none;  /* 移除轮廓 */
}
```

**与 border 的区别**：
- `border` 占用空间，影响布局
- `outline` 不占用空间，不影响布局
- `outline` 不能设置圆角

## 常见组合用法

### 1. 卡片样式

```css
.card {
  background-color: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  padding: 20px;
}

.card:hover {
  box-shadow: 0 4px 8px rgba(0,0,0,0.15);
  border-color: #007bff;
}
```

### 2. 按钮样式

```css
.button {
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  padding: 10px 20px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.button:hover {
  background-color: #0056b3;
}

.button:active {
  box-shadow: inset 0 2px 4px rgba(0,0,0,0.2);
}
```

### 3. 输入框样式

```css
.input {
  background-color: white;
  border: 2px solid #ccc;
  border-radius: 4px;
  padding: 10px;
  outline: none;
  transition: border-color 0.3s;
}

.input:focus {
  border-color: #007bff;
  box-shadow: 0 0 0 3px rgba(0,123,255,0.25);
}
```

### 4. 背景图片覆盖

```css
.hero {
  background-image: url("hero.jpg");
  background-position: center;
  background-size: cover;
  background-repeat: no-repeat;
  background-attachment: fixed;
  height: 100vh;
  position: relative;
}

.hero::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0,0,0,0.5);  /* 半透明遮罩 */
}
```

### 5. 渐变背景

```css
.gradient-bg {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.radial-bg {
  background: radial-gradient(circle, #ff6b6b, #4ecdc4);
}
```

## 示例演示

### 示例 1：卡片组件

```html
<div class="card">
  <img src="image.jpg" alt="图片">
  <h3>卡片标题</h3>
  <p>这是卡片的内容描述。</p>
</div>
```

```css
.card {
  background-color: white;
  border: 1px solid #e0e0e0;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  overflow: hidden;
  transition: transform 0.3s, box-shadow 0.3s;
}

.card:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 16px rgba(0,0,0,0.15);
}

.card img {
  width: 100%;
  height: 200px;
  object-fit: cover;
  background-color: #f5f5f5;
}

.card h3 {
  padding: 15px 20px 0;
  margin: 0;
}

.card p {
  padding: 10px 20px 20px;
  margin: 0;
  color: #666;
}
```

### 示例 2：按钮组

```html
<button class="btn btn-primary">主要按钮</button>
<button class="btn btn-outline">轮廓按钮</button>
<button class="btn btn-ghost">幽灵按钮</button>
```

```css
.btn {
  padding: 10px 20px;
  border-radius: 4px;
  border: none;
  cursor: pointer;
  font-size: 16px;
  transition: all 0.3s;
}

.btn-primary {
  background-color: #007bff;
  color: white;
  box-shadow: 0 2px 4px rgba(0,123,255,0.3);
}

.btn-primary:hover {
  background-color: #0056b3;
  box-shadow: 0 4px 8px rgba(0,123,255,0.4);
}

.btn-outline {
  background-color: transparent;
  border: 2px solid #007bff;
  color: #007bff;
}

.btn-outline:hover {
  background-color: #007bff;
  color: white;
}

.btn-ghost {
  background-color: transparent;
  color: #007bff;
}

.btn-ghost:hover {
  background-color: rgba(0,123,255,0.1);
}
```

### 示例 3：图片画廊

```html
<div class="gallery">
  <div class="gallery-item" style="background-image: url('image1.jpg')"></div>
  <div class="gallery-item" style="background-image: url('image2.jpg')"></div>
  <div class="gallery-item" style="background-image: url('image3.jpg')"></div>
</div>
```

```css
.gallery {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
}

.gallery-item {
  aspect-ratio: 4/3;
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  transition: transform 0.3s, box-shadow 0.3s;
  cursor: pointer;
}

.gallery-item:hover {
  transform: scale(1.05);
  box-shadow: 0 4px 16px rgba(0,0,0,0.2);
}
```

### 示例 4：输入框组

```html
<div class="input-group">
  <input type="text" placeholder="请输入内容">
  <button>搜索</button>
</div>
```

```css
.input-group {
  display: flex;
  border: 2px solid #ccc;
  border-radius: 4px;
  overflow: hidden;
}

.input-group input {
  flex: 1;
  border: none;
  padding: 10px;
  outline: none;
  background-color: white;
}

.input-group:focus-within {
  border-color: #007bff;
  box-shadow: 0 0 0 3px rgba(0,123,255,0.25);
}

.input-group button {
  background-color: #007bff;
  color: white;
  border: none;
  padding: 10px 20px;
  cursor: pointer;
}
```

## 使用建议

### 1. 使用 CSS 变量

建立统一的颜色和样式系统：

```css
:root {
  --color-primary: #007bff;
  --color-border: #e0e0e0;
  --border-radius: 8px;
  --shadow-sm: 0 2px 4px rgba(0,0,0,0.1);
  --shadow-md: 0 4px 8px rgba(0,0,0,0.15);
}

.card {
  background-color: white;
  border: 1px solid var(--color-border);
  border-radius: var(--border-radius);
  box-shadow: var(--shadow-sm);
}
```

### 2. 合理使用阴影

阴影可以增加层次感，但不要过度使用：

```css
/* 推荐：适度使用 */
.card {
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

/* 不推荐：过度使用 */
.card {
  box-shadow: 
    0 2px 4px rgba(0,0,0,0.1),
    0 4px 8px rgba(0,0,0,0.1),
    0 8px 16px rgba(0,0,0,0.1);
}
```

### 3. 注意性能

背景图片和复杂的阴影可能影响性能：

```css
/* 优化：使用 will-change */
.animated-element {
  will-change: transform, box-shadow;
}

/* 优化：使用 transform 代替 box-shadow 动画 */
.element {
  transition: transform 0.3s;
}
```

### 4. 响应式背景

确保背景图片在不同设备上都能正常显示：

```css
.hero {
  background-image: url("hero-large.jpg");
  background-size: cover;
  background-position: center;
}

@media (max-width: 768px) {
  .hero {
    background-image: url("hero-small.jpg");
  }
}
```

### 5. 可访问性

确保背景和文本有足够的对比度：

```css
/* 推荐：足够的对比度 */
.card {
  background-color: white;
  color: #333;  /* 对比度足够 */
}

/* 不推荐：对比度不足 */
.card {
  background-color: #f0f0f0;
  color: #f5f5f5;  /* 对比度不足 */
}
```

## 小结

背景与边框属性用于控制元素的视觉装饰：

- **背景属性**：`background-color`、`background-image`、`background-position` 等
- **边框属性**：`border`、`border-radius`、`border-image` 等
- **阴影属性**：`box-shadow` 用于创建深度感
- **轮廓属性**：`outline` 用于焦点指示

**使用建议**：
- 使用 CSS 变量统一管理
- 合理使用阴影
- 注意性能优化
- 确保响应式设计
- 注意可访问性

掌握了背景与边框属性，你就能为元素添加丰富的视觉效果。在下一章，我们将学习盒模型与尺寸属性，理解元素大小和间距的控制。
