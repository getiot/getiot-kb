---
sidebar_position: 5
slug: /css-layout-position
---

# CSS 布局与定位属性

布局与定位属性是 CSS 中最核心的属性类别之一。它们控制着元素在页面中的位置、显示方式和层叠关系。掌握这些属性，你就能创建各种复杂的页面布局。

## 该类属性解决什么问题

布局与定位属性主要解决以下问题：

1. **元素定位**：精确控制元素在页面中的位置
2. **布局方式**：选择不同的布局方式（块级、行内、弹性、网格等）
3. **层叠关系**：控制元素的层叠顺序（z-index）
4. **溢出处理**：处理内容超出容器的情况
5. **浮动布局**：实现文字环绕和传统布局

## 核心属性介绍

### 显示属性

#### display

设置元素的显示方式，这是最重要的布局属性。

```css
div {
  display: block;        /* 块级元素 */
  display: inline;       /* 行内元素 */
  display: inline-block; /* 行内块元素 */
  display: flex;         /* 弹性布局 */
  display: grid;         /* 网格布局 */
  display: none;         /* 隐藏元素 */
  display: table;        /* 表格布局 */
}
```

**常用值说明**：

- **block**：块级元素，独占一行，可以设置宽高
- **inline**：行内元素，不独占一行，不能设置宽高
- **inline-block**：行内块元素，不独占一行，可以设置宽高
- **flex**：弹性布局容器
- **grid**：网格布局容器
- **none**：隐藏元素，不占用空间

### 定位属性

#### position

设置元素的定位方式。

```css
div {
  position: static;    /* 静态定位（默认） */
  position: relative;  /* 相对定位 */
  position: absolute;   /* 绝对定位 */
  position: fixed;      /* 固定定位 */
  position: sticky;     /* 粘性定位 */
}
```

**定位方式说明**：

1. **static**（静态定位）：
   - 默认值，元素按照正常文档流排列
   - `top`、`right`、`bottom`、`left`、`z-index` 无效

2. **relative**（相对定位）：
   - 相对于元素原来的位置进行偏移
   - 元素仍占据原来的空间
   - 可以使用 `top`、`right`、`bottom`、`left` 进行偏移

3. **absolute**（绝对定位）：
   - 相对于最近的定位父元素（`position` 不为 `static`）进行定位
   - 如果没有定位父元素，则相对于 `<html>` 定位
   - 元素脱离文档流，不占据空间

4. **fixed**（固定定位）：
   - 相对于视口（viewport）进行定位
   - 元素脱离文档流，不占据空间
   - 滚动页面时，元素位置不变

5. **sticky**（粘性定位）：
   - 在滚动到指定位置前，表现为 `relative`
   - 滚动到指定位置后，表现为 `fixed`
   - 需要指定 `top`、`right`、`bottom` 或 `left` 之一

#### top / right / bottom / left

设置定位元素的偏移量。

```css
div {
  position: relative;
  top: 20px;      /* 向下偏移 20px */
  right: 10px;    /* 向左偏移 10px */
  bottom: 0;      /* 向上偏移 0 */
  left: 50px;     /* 向右偏移 50px */
}
```

**注意**：这些属性只对 `position` 不为 `static` 的元素有效。

#### z-index

设置元素的层叠顺序。

```css
div {
  z-index: 1;     /* 数字越大，越在上层 */
  z-index: auto;   /* 自动（默认） */
  z-index: -1;     /* 可以在负值 */
}
```

**规则**：
- 只对定位元素（`position` 不为 `static`）有效
- 数值越大，越在上层
- 相同 `z-index` 时，后出现的元素在上层
- 子元素的 `z-index` 只在父元素的层叠上下文中有效

### 浮动属性

#### float

设置元素的浮动方式。

```css
div {
  float: left;    /* 左浮动 */
  float: right;   /* 右浮动 */
  float: none;    /* 不浮动（默认） */
}
```

**特点**：
- 浮动元素脱离文档流
- 其他元素会围绕浮动元素排列
- 常用于实现文字环绕效果

#### clear

清除浮动的影响。

```css
div {
  clear: left;    /* 清除左浮动 */
  clear: right;   /* 清除右浮动 */
  clear: both;     /* 清除所有浮动 */
  clear: none;     /* 不清除（默认） */
}
```

### 溢出属性

#### overflow

设置元素内容溢出时的处理方式。

```css
div {
  overflow: visible;  /* 可见（默认） */
  overflow: hidden;   /* 隐藏 */
  overflow: scroll;   /* 显示滚动条 */
  overflow: auto;     /* 自动（需要时显示滚动条） */
}
```

#### overflow-x / overflow-y

分别设置水平和垂直方向的溢出处理。

```css
div {
  overflow-x: hidden;  /* 水平方向隐藏 */
  overflow-y: scroll;  /* 垂直方向显示滚动条 */
}
```

## 常见组合用法

### 1. 居中布局

#### 水平居中

```css
/* 方法 1：使用 margin */
.container {
  width: 1200px;
  margin: 0 auto;
}

/* 方法 2：使用 flexbox */
.container {
  display: flex;
  justify-content: center;
}

/* 方法 3：使用 grid */
.container {
  display: grid;
  place-items: center;
}

/* 方法 4：使用绝对定位 */
.container {
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
}
```

#### 垂直居中

```css
/* 方法 1：使用 flexbox */
.container {
  display: flex;
  align-items: center;
  height: 100vh;
}

/* 方法 2：使用 grid */
.container {
  display: grid;
  place-items: center;
  height: 100vh;
}

/* 方法 3：使用绝对定位 */
.container {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
}

/* 方法 4：使用绝对定位（完全居中） */
.container {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
```

### 2. 固定头部

```css
.header {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1000;
  background-color: white;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.main {
  margin-top: 80px;  /* 为固定头部留出空间 */
}
```

### 3. 粘性导航

```css
.nav {
  position: sticky;
  top: 0;
  z-index: 100;
  background-color: white;
  padding: 10px 0;
}
```

### 4. 模态框

```css
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0,0,0,0.5);
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal {
  position: relative;
  background-color: white;
  padding: 20px;
  border-radius: 8px;
  max-width: 500px;
  max-height: 80vh;
  overflow-y: auto;
}
```

### 5. 清除浮动

```css
/* 方法 1：使用 clear */
.clearfix::after {
  content: "";
  display: table;
  clear: both;
}

/* 方法 2：使用 overflow */
.container {
  overflow: hidden;
}

/* 方法 3：使用 flexbox（推荐） */
.container {
  display: flex;
}
```

## 示例演示

### 示例 1：三栏布局

```html
<div class="layout">
  <aside class="sidebar-left">左侧栏</aside>
  <main class="content">主要内容</main>
  <aside class="sidebar-right">右侧栏</aside>
</div>
```

```css
.layout {
  display: flex;
  min-height: 100vh;
}

.sidebar-left {
  width: 200px;
  background-color: #f0f0f0;
}

.content {
  flex: 1;
  padding: 20px;
}

.sidebar-right {
  width: 250px;
  background-color: #f0f0f0;
}
```

### 示例 2：卡片网格

```html
<div class="card-grid">
  <div class="card">卡片 1</div>
  <div class="card">卡片 2</div>
  <div class="card">卡片 3</div>
</div>
```

```css
.card-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
  padding: 20px;
}

.card {
  background-color: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
```

### 示例 3：固定侧边栏

```html
<div class="page">
  <aside class="sidebar">侧边栏</aside>
  <main class="main-content">主要内容</main>
</div>
```

```css
.page {
  display: flex;
  min-height: 100vh;
}

.sidebar {
  position: fixed;
  left: 0;
  top: 0;
  bottom: 0;
  width: 250px;
  background-color: #333;
  color: white;
  overflow-y: auto;
}

.main-content {
  margin-left: 250px;
  flex: 1;
  padding: 20px;
}
```

### 示例 4：响应式导航

```html
<nav class="navbar">
  <div class="nav-brand">Logo</div>
  <ul class="nav-menu">
    <li><a href="#">首页</a></li>
    <li><a href="#">关于</a></li>
    <li><a href="#">服务</a></li>
  </ul>
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
  position: sticky;
  top: 0;
  z-index: 100;
}

.nav-menu {
  display: flex;
  list-style: none;
  gap: 20px;
}

@media (max-width: 768px) {
  .nav-menu {
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    flex-direction: column;
    background-color: white;
    display: none;  /* 默认隐藏 */
  }
  
  .nav-menu.active {
    display: flex;  /* 显示菜单 */
  }
}
```

## 使用建议

### 1. 优先使用现代布局

优先使用 Flexbox 和 Grid，而不是 float：

```css
/* 推荐：使用 Flexbox */
.container {
  display: flex;
  gap: 20px;
}

/* 不推荐：使用 float */
.container::after {
  content: "";
  display: table;
  clear: both;
}
.item {
  float: left;
}
```

### 2. 理解定位上下文

理解不同定位方式的使用场景：

- **relative**：用于微调元素位置，或作为绝对定位的参考
- **absolute**：用于相对于父元素的精确定位
- **fixed**：用于固定头部、导航等
- **sticky**：用于粘性导航、表格头部等

### 3. 合理使用 z-index

建立 z-index 层级系统：

```css
:root {
  --z-dropdown: 1000;
  --z-sticky: 1020;
  --z-fixed: 1030;
  --z-modal-backdrop: 1040;
  --z-modal: 1050;
  --z-popover: 1060;
  --z-tooltip: 1070;
}
```

### 4. 注意 overflow 的性能

`overflow: scroll` 会创建滚动上下文，可能影响性能：

```css
/* 只在需要时使用 */
.scrollable {
  overflow-y: auto;  /* 自动，需要时才显示滚动条 */
  max-height: 400px;
}
```

### 5. 响应式定位

考虑不同设备上的定位效果：

```css
.modal {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 90%;
  max-width: 500px;
}

@media (max-width: 768px) {
  .modal {
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    transform: none;
    width: 100%;
    max-width: none;
  }
}
```

## 小结

布局与定位属性控制元素的位置和显示方式：

- **显示属性**：`display` 控制元素的显示方式
- **定位属性**：`position`、`top`、`right`、`bottom`、`left` 控制元素位置
- **层叠属性**：`z-index` 控制元素的层叠顺序
- **浮动属性**：`float`、`clear` 实现传统布局
- **溢出属性**：`overflow` 处理内容溢出

**使用建议**：
- 优先使用现代布局（Flexbox、Grid）
- 理解不同定位方式的使用场景
- 合理使用 z-index
- 注意 overflow 的性能
- 考虑响应式设计

掌握了布局与定位属性，你就能创建各种复杂的页面布局。在接下来的章节中，我们将深入学习 Flexbox 和 Grid 布局，了解现代 CSS 布局的强大功能。
