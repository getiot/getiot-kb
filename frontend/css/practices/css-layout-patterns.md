---
sidebar_position: 1
slug: /css-layout-patterns
---

# CSS 常见布局模式

在实际开发中，我们经常会遇到一些常见的布局模式。掌握这些布局模式的实现方法，能够大大提高开发效率。本章将介绍几种最常用的布局模式及其实现方式。

## 常见布局模式概览

### 1. 单栏布局（Single Column）

最简单的布局，内容垂直排列，适合移动端和内容型网站。

### 2. 双栏布局（Two Column）

左右分栏，通常左侧是导航或侧边栏，右侧是主要内容。

### 3. 三栏布局（Three Column）

左中右三栏，通常用于复杂的网站布局。

### 4. 圣杯布局（Holy Grail）

经典的布局模式：头部、页脚、主内容区，以及左右侧边栏。

### 5. 网格布局（Grid）

卡片、商品列表等需要网格排列的内容。

## 单栏布局

单栏布局是最基础的布局，内容垂直排列。

```html
<div class="container">
  <header>头部</header>
  <main>主要内容</main>
  <footer>页脚</footer>
</div>
```

```css
.container {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

header, main, footer {
  width: 100%;
  margin-bottom: 20px;
}
```

## 双栏 / 多栏布局

### 方法 1：使用 Flexbox

```html
<div class="two-column">
  <aside class="sidebar">侧边栏</aside>
  <main class="content">主要内容</main>
</div>
```

```css
.two-column {
  display: flex;
  gap: 20px;
}

.sidebar {
  width: 250px;
  flex-shrink: 0;
}

.content {
  flex: 1;
}
```

### 方法 2：使用 Grid

```css
.two-column {
  display: grid;
  grid-template-columns: 250px 1fr;
  gap: 20px;
}
```

### 方法 3：使用 Float（传统方法）

```css
.sidebar {
  float: left;
  width: 250px;
}

.content {
  margin-left: 270px;
}

.two-column::after {
  content: "";
  display: table;
  clear: both;
}
```

### 响应式双栏布局

```css
.two-column {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

@media (min-width: 768px) {
  .two-column {
    flex-direction: row;
  }
  
  .sidebar {
    width: 250px;
    flex-shrink: 0;
  }
  
  .content {
    flex: 1;
  }
}
```

## 圣杯布局与双飞翼布局（概念级）

### 圣杯布局（Holy Grail）

经典的布局模式：头部、页脚固定，中间三栏（左右侧边栏 + 主内容）。

```html
<div class="holy-grail">
  <header>头部</header>
  <div class="main-wrapper">
    <main>主要内容</main>
    <aside class="left">左侧栏</aside>
    <aside class="right">右侧栏</aside>
  </div>
  <footer>页脚</footer>
</div>
```

#### 使用 Flexbox 实现

```css
.holy-grail {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.main-wrapper {
  display: flex;
  flex: 1;
  gap: 20px;
}

main {
  flex: 1;
  order: 2;
}

.left {
  width: 200px;
  order: 1;
}

.right {
  width: 250px;
  order: 3;
}
```

#### 使用 Grid 实现

```css
.holy-grail {
  display: grid;
  grid-template-areas:
    "header header header"
    "left main right"
    "footer footer footer";
  grid-template-columns: 200px 1fr 250px;
  grid-template-rows: auto 1fr auto;
  min-height: 100vh;
  gap: 20px;
}

header { grid-area: header; }
.left { grid-area: left; }
main { grid-area: main; }
.right { grid-area: right; }
footer { grid-area: footer; }
```

### 双飞翼布局

双飞翼布局是圣杯布局的改进版，通过在主内容区添加内层容器来实现。

```html
<div class="double-wing">
  <header>头部</header>
  <div class="container">
    <main>
      <div class="main-content">主要内容</div>
    </main>
    <aside class="left">左侧栏</aside>
    <aside class="right">右侧栏</aside>
  </div>
  <footer>页脚</footer>
</div>
```

```css
.container {
  display: flex;
  gap: 20px;
}

main {
  flex: 1;
  margin: 0 20px;
}

.left, .right {
  width: 200px;
  flex-shrink: 0;
}
```

## 现代布局的实现方式

### 使用 Flexbox

Flexbox 适合一维布局（行或列）：

```css
.container {
  display: flex;
  flex-direction: row;  /* 或 column */
  justify-content: space-between;
  align-items: center;
  gap: 20px;
}
```

### 使用 Grid

Grid 适合二维布局（行和列）：

```css
.container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: auto 1fr auto;
  gap: 20px;
}
```

### 混合使用

在实际项目中，通常混合使用 Flexbox 和 Grid：

```css
/* 整体布局使用 Grid */
.page {
  display: grid;
  grid-template-areas:
    "header"
    "main"
    "footer";
  min-height: 100vh;
}

/* 局部布局使用 Flexbox */
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
```

## 布局选择建议

### 选择 Flexbox 的场景

- 一维布局（行或列）
- 元素对齐
- 导航栏
- 表单布局
- 居中布局

### 选择 Grid 的场景

- 二维布局（行和列）
- 复杂网格系统
- 卡片网格
- 页面整体布局
- 需要精确控制位置

### 选择传统布局的场景

- 简单的单栏布局
- 需要兼容旧浏览器
- 简单的双栏布局（float）

## 实际示例

### 示例 1：响应式三栏布局

```html
<div class="three-column">
  <aside class="left">左侧栏</aside>
  <main>主要内容</main>
  <aside class="right">右侧栏</aside>
</div>
```

```css
.three-column {
  display: grid;
  grid-template-columns: 1fr;
  gap: 20px;
}

@media (min-width: 768px) {
  .three-column {
    grid-template-columns: 200px 1fr;
  }
  
  .right {
    display: none;
  }
}

@media (min-width: 1200px) {
  .three-column {
    grid-template-columns: 200px 1fr 250px;
  }
  
  .right {
    display: block;
  }
}
```

### 示例 2：卡片网格布局

```html
<div class="card-grid">
  <div class="card">卡片 1</div>
  <div class="card">卡片 2</div>
  <div class="card">卡片 3</div>
  <div class="card">卡片 4</div>
</div>
```

```css
.card-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
}

.card {
  background-color: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
```

### 示例 3：完整页面布局

```html
<div class="page-layout">
  <header class="header">头部</header>
  <nav class="navbar">导航</nav>
  <div class="main-area">
    <aside class="sidebar">侧边栏</aside>
    <main class="content">主要内容</main>
  </div>
  <footer class="footer">页脚</footer>
</div>
```

```css
.page-layout {
  display: grid;
  grid-template-areas:
    "header"
    "navbar"
    "main"
    "footer";
  min-height: 100vh;
}

.header { grid-area: header; }
.navbar { grid-area: navbar; }
.main-area { grid-area: main; }
.footer { grid-area: footer; }

.main-area {
  display: grid;
  grid-template-columns: 1fr;
  gap: 20px;
}

@media (min-width: 768px) {
  .page-layout {
    grid-template-areas:
      "header header"
      "navbar sidebar"
      "main sidebar"
      "footer footer";
    grid-template-columns: 1fr 250px;
  }
  
  .main-area {
    grid-template-columns: 1fr;
  }
}
```

## 小结

常见布局模式的实现要点：

- **单栏布局**：最简单的垂直布局
- **双栏/多栏布局**：使用 Flexbox 或 Grid
- **圣杯布局**：经典的头部-三栏-页脚布局
- **现代布局**：优先使用 Flexbox 和 Grid
- **布局选择**：根据需求选择合适的布局方式

**关键建议**：
- 优先使用现代布局（Flexbox、Grid）
- 考虑响应式设计
- 根据需求选择布局方式
- 混合使用不同布局技术

掌握了常见布局模式，你就能快速构建各种页面结构。在下一章，我们将学习导航栏与菜单的实现。
