---
sidebar_position: 6
sidebar_label: CSS 弹性布局（Flexbox）
slug: /css-flexbox
---

# CSS 弹性布局（Flexbox）属性

Flexbox（弹性布局）是 CSS3 引入的一种强大的布局方式，专门用于在一维空间（行或列）中排列元素。它解决了传统布局方式的许多痛点，让布局变得更加简单和灵活。

## 该类属性解决什么问题

Flexbox 主要解决以下问题：

1. **垂直居中**：轻松实现元素的垂直居中
2. **等分布局**：让子元素等宽或等高分布
3. **响应式布局**：自动适应不同屏幕尺寸
4. **对齐控制**：精确控制元素的对齐方式
5. **顺序控制**：通过 CSS 改变元素的显示顺序

## Flexbox 基础概念

### 容器和项目

Flexbox 布局包含两个主要概念：

- **Flex 容器（Flex Container）**：设置了 `display: flex` 的元素
- **Flex 项目（Flex Item）**：Flex 容器的直接子元素

```html
<div class="container">  <!-- Flex 容器 -->
  <div class="item">项目 1</div>  <!-- Flex 项目 -->
  <div class="item">项目 2</div>  <!-- Flex 项目 -->
  <div class="item">项目 3</div>  <!-- Flex 项目 -->
</div>
```

```css
.container {
  display: flex;  /* 创建 Flex 容器 */
}
```

### 主轴和交叉轴

Flexbox 布局基于两个轴：

- **主轴（Main Axis）**：Flex 项目排列的主要方向
- **交叉轴（Cross Axis）**：垂直于主轴的方向

```
主轴方向（flex-direction: row）
┌─────────────────────────────────┐
│  [项目1] [项目2] [项目3]         │
└─────────────────────────────────┘
         ↑
      交叉轴方向
```

## 核心属性介绍

### 容器属性

#### flex-direction

设置主轴的方向（Flex 项目的排列方向）。

```css
.container {
  flex-direction: row;         /* 水平排列（默认） */
  flex-direction: row-reverse; /* 水平反向排列 */
  flex-direction: column;      /* 垂直排列 */
  flex-direction: column-reverse; /* 垂直反向排列 */
}
```

#### flex-wrap

设置 Flex 项目是否换行。

```css
.container {
  flex-wrap: nowrap;  /* 不换行（默认） */
  flex-wrap: wrap;     /* 换行 */
  flex-wrap: wrap-reverse; /* 反向换行 */
}
```

#### flex-flow

`flex-direction` 和 `flex-wrap` 的简写。

```css
.container {
  flex-flow: row wrap;  /* 水平排列，允许换行 */
}
```

#### justify-content

设置 Flex 项目在**主轴**上的对齐方式。

```css
.container {
  justify-content: flex-start;   /* 起始对齐（默认） */
  justify-content: flex-end;     /* 末尾对齐 */
  justify-content: center;       /* 居中对齐 */
  justify-content: space-between; /* 两端对齐，项目之间间距相等 */
  justify-content: space-around;  /* 项目周围间距相等 */
  justify-content: space-evenly;  /* 项目之间和周围间距都相等 */
}
```

**视觉效果**：

```
flex-start:    [1][2][3]--------
flex-end:      --------[1][2][3]
center:        ----[1][2][3]----
space-between: [1]----[2]----[3]
space-around:  -[1]---[2]---[3]-
space-evenly:  --[1]--[2]--[3]--
```

#### align-items

设置 Flex 项目在**交叉轴**上的对齐方式。

```css
.container {
  align-items: stretch;    /* 拉伸填满（默认） */
  align-items: flex-start; /* 起始对齐 */
  align-items: flex-end;   /* 末尾对齐 */
  align-items: center;     /* 居中对齐 */
  align-items: baseline;   /* 基线对齐 */
}
```

#### align-content

设置多行 Flex 项目在**交叉轴**上的对齐方式（只有多行时有效）。

```css
.container {
  align-content: stretch;      /* 拉伸填满（默认） */
  align-content: flex-start;   /* 起始对齐 */
  align-content: flex-end;     /* 末尾对齐 */
  align-content: center;       /* 居中对齐 */
  align-content: space-between; /* 两端对齐 */
  align-content: space-around;  /* 周围间距相等 */
}
```

#### gap

设置 Flex 项目之间的间距。

```css
.container {
  gap: 20px;           /* 所有方向 */
  gap: 10px 20px;      /* 行间距 列间距 */
  row-gap: 10px;      /* 行间距 */
  column-gap: 20px;    /* 列间距 */
}
```

### 项目属性

#### flex-grow

设置 Flex 项目的放大比例。

```css
.item {
  flex-grow: 0;  /* 不放大（默认） */
  flex-grow: 1;  /* 等比例放大 */
  flex-grow: 2;  /* 放大比例是其他项目的 2 倍 */
}
```

#### flex-shrink

设置 Flex 项目的缩小比例。

```css
.item {
  flex-shrink: 1;  /* 可以缩小（默认） */
  flex-shrink: 0;  /* 不缩小 */
  flex-shrink: 2;  /* 缩小比例是其他项目的 2 倍 */
}
```

#### flex-basis

设置 Flex 项目在分配多余空间之前的主轴空间。

```css
.item {
  flex-basis: auto;  /* 自动（默认） */
  flex-basis: 200px; /* 固定宽度 */
  flex-basis: 30%;   /* 百分比 */
}
```

#### flex（简写属性）

`flex-grow`、`flex-shrink` 和 `flex-basis` 的简写。

```css
.item {
  flex: 1;              /* flex: 1 1 0% */
  flex: 0 1 auto;       /* 默认值 */
  flex: 2 1 200px;      /* grow shrink basis */
  flex: none;           /* flex: 0 0 auto */
  flex: auto;           /* flex: 1 1 auto */
}
```

**常用值**：
- `flex: 1`：等分剩余空间
- `flex: 0 1 auto`：默认值，不放大，可以缩小
- `flex: none`：不放大也不缩小
- `flex: auto`：自动调整

#### align-self

设置单个 Flex 项目在交叉轴上的对齐方式（覆盖容器的 `align-items`）。

```css
.item {
  align-self: auto;      /* 继承容器的 align-items */
  align-self: flex-start; /* 起始对齐 */
  align-self: flex-end;   /* 末尾对齐 */
  align-self: center;     /* 居中对齐 */
  align-self: stretch;    /* 拉伸填满 */
}
```

#### order

设置 Flex 项目的显示顺序。

```css
.item {
  order: 0;  /* 默认顺序 */
  order: 1;  /* 数字越大，越靠后 */
  order: -1; /* 数字越小，越靠前 */
}
```

## 常见组合用法

### 1. 水平居中

```css
.container {
  display: flex;
  justify-content: center;
}
```

### 2. 垂直居中

```css
.container {
  display: flex;
  align-items: center;
  height: 100vh;
}
```

### 3. 完全居中

```css
.container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}
```

### 4. 等分布局

```css
.container {
  display: flex;
}

.item {
  flex: 1;  /* 等分空间 */
}
```

### 5. 响应式导航

```css
.nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.nav-menu {
  display: flex;
  gap: 20px;
}

@media (max-width: 768px) {
  .nav {
    flex-direction: column;
  }
}
```

## 示例演示

### 示例 1：卡片布局

```html
<div class="card-container">
  <div class="card">卡片 1</div>
  <div class="card">卡片 2</div>
  <div class="card">卡片 3</div>
</div>
```

```css
.card-container {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  justify-content: center;
}

.card {
  flex: 1 1 300px;  /* 最小宽度 300px，可以放大和缩小 */
  max-width: 400px;
  padding: 20px;
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
```

### 示例 2：导航栏

```html
<nav class="navbar">
  <div class="logo">Logo</div>
  <ul class="nav-menu">
    <li><a href="#">首页</a></li>
    <li><a href="#">关于</a></li>
    <li><a href="#">服务</a></li>
  </ul>
  <button class="btn">登录</button>
</nav>
```

```css
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 20px;
  background-color: white;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.nav-menu {
  display: flex;
  list-style: none;
  gap: 30px;
  margin: 0;
  padding: 0;
}

.btn {
  padding: 8px 16px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
```

### 示例 3：表单布局

```html
<form class="form">
  <div class="form-group">
    <label>用户名</label>
    <input type="text">
  </div>
  <div class="form-group">
    <label>密码</label>
    <input type="password">
  </div>
  <button type="submit">提交</button>
</form>
```

```css
.form {
  display: flex;
  flex-direction: column;
  gap: 20px;
  max-width: 400px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.form-group label {
  font-weight: bold;
}

.form-group input {
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

button {
  align-self: flex-start;
  padding: 10px 20px;
}
```

### 示例 4：圣杯布局

```html
<div class="layout">
  <header>头部</header>
  <div class="content-wrapper">
    <aside class="sidebar-left">左侧栏</aside>
    <main>主要内容</main>
    <aside class="sidebar-right">右侧栏</aside>
  </div>
  <footer>页脚</footer>
</div>
```

```css
.layout {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.content-wrapper {
  display: flex;
  flex: 1;
}

.sidebar-left {
  width: 200px;
  background-color: #f0f0f0;
}

main {
  flex: 1;
  padding: 20px;
}

.sidebar-right {
  width: 250px;
  background-color: #f0f0f0;
}
```

### 示例 5：响应式图片画廊

```html
<div class="gallery">
  <div class="gallery-item">图片 1</div>
  <div class="gallery-item">图片 2</div>
  <div class="gallery-item">图片 3</div>
  <div class="gallery-item">图片 4</div>
</div>
```

```css
.gallery {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}

.gallery-item {
  flex: 1 1 calc(33.333% - 20px);  /* 每行 3 个 */
  min-width: 250px;
  aspect-ratio: 4/3;
  background-color: #f0f0f0;
  border-radius: 8px;
}

@media (max-width: 768px) {
  .gallery-item {
    flex: 1 1 calc(50% - 20px);  /* 每行 2 个 */
  }
}

@media (max-width: 480px) {
  .gallery-item {
    flex: 1 1 100%;  /* 每行 1 个 */
  }
}
```

## 使用建议

### 1. 理解主轴和交叉轴

理解主轴和交叉轴的概念，有助于正确使用 Flexbox 属性：

- `justify-content` 控制主轴对齐
- `align-items` 控制交叉轴对齐
- `flex-direction` 改变主轴方向

### 2. 合理使用 flex 简写

使用 `flex` 简写属性，代码更简洁：

```css
/* 推荐 */
.item {
  flex: 1;  /* 等分空间 */
}

/* 不推荐 */
.item {
  flex-grow: 1;
  flex-shrink: 1;
  flex-basis: 0%;
}
```

### 3. 使用 gap 代替 margin

使用 `gap` 属性设置间距，更简洁：

```css
/* 推荐 */
.container {
  display: flex;
  gap: 20px;
}

/* 不推荐 */
.container {
  display: flex;
}
.item {
  margin-right: 20px;
}
.item:last-child {
  margin-right: 0;
}
```

### 4. 注意 flex-basis 和 width 的区别

- `flex-basis` 是 Flexbox 的属性，用于计算弹性空间
- `width` 是普通 CSS 属性，可能被 `flex-basis` 覆盖

```css
.item {
  flex-basis: 200px;  /* 推荐在 Flexbox 中使用 */
  width: 200px;        /* 可能被 flex-basis 覆盖 */
}
```

### 5. 响应式设计

结合媒体查询，实现响应式布局：

```css
.container {
  display: flex;
  flex-direction: row;
}

@media (max-width: 768px) {
  .container {
    flex-direction: column;
  }
}
```

## 小结

Flexbox 是强大的布局工具：

- **容器属性**：`flex-direction`、`flex-wrap`、`justify-content`、`align-items`、`gap` 等
- **项目属性**：`flex`、`align-self`、`order` 等
- **解决的核心问题**：垂直居中、等分布局、响应式设计

**使用建议**：
- 理解主轴和交叉轴
- 合理使用 flex 简写
- 使用 gap 代替 margin
- 注意 flex-basis 和 width 的区别
- 结合媒体查询实现响应式

掌握了 Flexbox，你就能轻松创建各种一维布局。在下一章，我们将学习 Grid 布局，了解如何创建更复杂的二维布局。
