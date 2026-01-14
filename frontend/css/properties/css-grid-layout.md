---
sidebar_position: 7
sidebar_label: CSS 网格布局（Grid）
slug: /css-grid-layout
---

# CSS 网格布局（Grid）属性

Grid（网格布局）是 CSS3 引入的另一种强大的布局方式，专门用于在二维空间（行和列）中排列元素。Grid 布局比 Flexbox 更强大，能够创建复杂的网格系统。

## 该类属性解决什么问题

Grid 布局主要解决以下问题：

1. **二维布局**：同时控制行和列的布局
2. **复杂网格**：创建复杂的网格系统
3. **精确控制**：精确控制每个网格项的位置和大小
4. **响应式网格**：轻松创建响应式网格布局
5. **对齐控制**：精确控制网格项的对齐方式

## Grid 基础概念

### 网格容器和网格项

Grid 布局包含两个主要概念：

- **网格容器（Grid Container）**：设置了 `display: grid` 的元素
- **网格项（Grid Item）**：网格容器的直接子元素

```html
<div class="grid-container">  <!-- 网格容器 -->
  <div class="grid-item">项目 1</div>  <!-- 网格项 -->
  <div class="grid-item">项目 2</div>  <!-- 网格项 -->
  <div class="grid-item">项目 3</div>  <!-- 网格项 -->
</div>
```

```css
.grid-container {
  display: grid;  /* 创建网格容器 */
}
```

### 网格线、网格轨道和网格单元格

- **网格线（Grid Line）**：划分网格的线
- **网格轨道（Grid Track）**：两条网格线之间的空间（行或列）
- **网格单元格（Grid Cell）**：行和列的交集
- **网格区域（Grid Area）**：一个或多个网格单元格组成的区域

```
┌─────┬─────┬─────┐
│  1  │  2  │  3  │  ← 网格行（Grid Row）
├─────┼─────┼─────┤
│  4  │  5  │  6  │
├─────┼─────┼─────┤
│  7  │  8  │  9  │
└─────┴─────┴─────┘
 ↑     ↑     ↑
网格列（Grid Column）
```

## 核心属性介绍

### 容器属性

#### grid-template-columns

定义网格的列。

```css
.grid {
  grid-template-columns: 200px 200px 200px;  /* 3 列，每列 200px */
  grid-template-columns: 1fr 1fr 1fr;        /* 3 列，等宽 */
  grid-template-columns: repeat(3, 1fr);     /* 3 列，等宽（简写） */
  grid-template-columns: 1fr 2fr 1fr;        /* 3 列，比例 1:2:1 */
  grid-template-columns: auto 1fr auto;       /* 中间列自适应 */
}
```

**常用函数**：
- `repeat(n, size)`：重复 n 次
- `minmax(min, max)`：最小值和最大值
- `auto-fill` / `auto-fit`：自动填充

```css
.grid {
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  /* 自动填充，每列最小 200px，最大等分 */
}
```

#### grid-template-rows

定义网格的行。

```css
.grid {
  grid-template-rows: 100px 200px 100px;  /* 3 行 */
  grid-template-rows: repeat(3, 1fr);     /* 3 行，等高 */
  grid-template-rows: auto 1fr auto;      /* 中间行自适应 */
}
```

#### grid-template-areas

通过命名区域定义网格布局。

```css
.grid {
  grid-template-areas:
    "header header header"
    "sidebar main main"
    "footer footer footer";
}

.header {
  grid-area: header;
}

.sidebar {
  grid-area: sidebar;
}

.main {
  grid-area: main;
}

.footer {
  grid-area: footer;
}
```

#### grid-template

`grid-template-rows`、`grid-template-columns` 和 `grid-template-areas` 的简写。

```css
.grid {
  grid-template:
    "header header" 60px
    "sidebar main" 1fr
    "footer footer" 40px
    / 200px 1fr;
  /* 行定义 / 列定义 */
}
```

#### gap

设置网格项之间的间距。

```css
.grid {
  gap: 20px;           /* 所有方向 */
  gap: 10px 20px;      /* 行间距 列间距 */
  row-gap: 10px;       /* 行间距 */
  column-gap: 20px;    /* 列间距 */
}
```

#### justify-items

设置网格项在**列轴**上的对齐方式。

```css
.grid {
  justify-items: start;   /* 起始对齐 */
  justify-items: end;     /* 末尾对齐 */
  justify-items: center;  /* 居中对齐 */
  justify-items: stretch; /* 拉伸填满（默认） */
}
```

#### align-items

设置网格项在**行轴**上的对齐方式。

```css
.grid {
  align-items: start;   /* 起始对齐 */
  align-items: end;     /* 末尾对齐 */
  align-items: center;  /* 居中对齐 */
  align-items: stretch;  /* 拉伸填满（默认） */
}
```

#### place-items

`align-items` 和 `justify-items` 的简写。

```css
.grid {
  place-items: center;  /* 水平和垂直都居中 */
}
```

#### justify-content

设置整个网格在**列轴**上的对齐方式（当网格小于容器时）。

```css
.grid {
  justify-content: start;      /* 起始对齐 */
  justify-content: end;        /* 末尾对齐 */
  justify-content: center;     /* 居中对齐 */
  justify-content: space-between; /* 两端对齐 */
  justify-content: space-around;  /* 周围间距相等 */
  justify-content: space-evenly;  /* 间距都相等 */
}
```

#### align-content

设置整个网格在**行轴**上的对齐方式（当网格小于容器时）。

```css
.grid {
  align-content: start;        /* 起始对齐 */
  align-content: end;          /* 末尾对齐 */
  align-content: center;       /* 居中对齐 */
  align-content: space-between; /* 两端对齐 */
  align-content: space-around;  /* 周围间距相等 */
}
```

### 项目属性

#### grid-column

设置网格项占据的列。

```css
.item {
  grid-column: 1 / 3;        /* 从第 1 列到第 3 列 */
  grid-column: 1 / span 2;   /* 从第 1 列开始，跨越 2 列 */
  grid-column-start: 1;      /* 开始列 */
  grid-column-end: 3;        /* 结束列 */
}
```

#### grid-row

设置网格项占据的行。

```css
.item {
  grid-row: 1 / 3;           /* 从第 1 行到第 3 行 */
  grid-row: 1 / span 2;      /* 从第 1 行开始，跨越 2 行 */
  grid-row-start: 1;         /* 开始行 */
  grid-row-end: 3;           /* 结束行 */
}
```

#### grid-area

设置网格项占据的区域。

```css
.item {
  grid-area: 1 / 1 / 3 / 3;  /* row-start / col-start / row-end / col-end */
  grid-area: header;          /* 使用命名区域 */
}
```

#### justify-self

设置单个网格项在**列轴**上的对齐方式。

```css
.item {
  justify-self: start;   /* 起始对齐 */
  justify-self: end;     /* 末尾对齐 */
  justify-self: center;  /* 居中对齐 */
  justify-self: stretch; /* 拉伸填满 */
}
```

#### align-self

设置单个网格项在**行轴**上的对齐方式。

```css
.item {
  align-self: start;    /* 起始对齐 */
  align-self: end;      /* 末尾对齐 */
  align-self: center;   /* 居中对齐 */
  align-self: stretch;   /* 拉伸填满 */
}
```

#### place-self

`align-self` 和 `justify-self` 的简写。

```css
.item {
  place-self: center;  /* 水平和垂直都居中 */
}
```

## 常见组合用法

### 1. 基础网格

```css
.grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
}
```

### 2. 响应式网格

```css
.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 20px;
}
```

### 3. 圣杯布局

```css
.layout {
  display: grid;
  grid-template-areas:
    "header header header"
    "sidebar main aside"
    "footer footer footer";
  grid-template-columns: 200px 1fr 250px;
  grid-template-rows: 60px 1fr 40px;
  gap: 20px;
}
```

### 4. 卡片网格

```css
.card-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 20px;
}
```

## 示例演示

### 示例 1：基础网格布局

```html
<div class="grid">
  <div class="item">1</div>
  <div class="item">2</div>
  <div class="item">3</div>
  <div class="item">4</div>
  <div class="item">5</div>
  <div class="item">6</div>
</div>
```

```css
.grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: repeat(2, 200px);
  gap: 20px;
}

.item {
  background-color: #f0f0f0;
  padding: 20px;
  border-radius: 8px;
}
```

### 示例 2：响应式图片画廊

```html
<div class="gallery">
  <div class="gallery-item">图片 1</div>
  <div class="gallery-item">图片 2</div>
  <div class="gallery-item">图片 3</div>
  <div class="gallery-item">图片 4</div>
  <div class="gallery-item">图片 5</div>
  <div class="gallery-item">图片 6</div>
</div>
```

```css
.gallery {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 20px;
}

.gallery-item {
  aspect-ratio: 4/3;
  background-color: #f0f0f0;
  border-radius: 8px;
  overflow: hidden;
}
```

### 示例 3：复杂布局

```html
<div class="layout">
  <header class="header">头部</header>
  <aside class="sidebar">侧边栏</aside>
  <main class="main">主要内容</main>
  <aside class="aside">右侧栏</aside>
  <footer class="footer">页脚</footer>
</div>
```

```css
.layout {
  display: grid;
  grid-template-areas:
    "header header header"
    "sidebar main aside"
    "footer footer footer";
  grid-template-columns: 200px 1fr 250px;
  grid-template-rows: 60px 1fr 40px;
  gap: 20px;
  min-height: 100vh;
}

.header {
  grid-area: header;
  background-color: #333;
  color: white;
}

.sidebar {
  grid-area: sidebar;
  background-color: #f0f0f0;
}

.main {
  grid-area: main;
  padding: 20px;
}

.aside {
  grid-area: aside;
  background-color: #f0f0f0;
}

.footer {
  grid-area: footer;
  background-color: #333;
  color: white;
}
```

### 示例 4：不对称网格

```html
<div class="grid">
  <div class="item item-large">大项目</div>
  <div class="item">小项目 1</div>
  <div class="item">小项目 2</div>
  <div class="item">小项目 3</div>
  <div class="item">小项目 4</div>
</div>
```

```css
.grid {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr;
  grid-template-rows: repeat(2, 200px);
  gap: 20px;
}

.item-large {
  grid-row: 1 / 3;  /* 跨越 2 行 */
}

.item {
  background-color: #f0f0f0;
  padding: 20px;
  border-radius: 8px;
}
```

### 示例 5：表单布局

```html
<form class="form-grid">
  <label>姓名</label>
  <input type="text">
  <label>邮箱</label>
  <input type="email">
  <label>消息</label>
  <textarea></textarea>
  <button type="submit">提交</button>
</form>
```

```css
.form-grid {
  display: grid;
  grid-template-columns: 100px 1fr;
  gap: 15px;
  max-width: 500px;
}

label {
  align-self: center;
}

textarea {
  grid-column: 1 / -1;  /* 跨越所有列 */
  min-height: 100px;
}

button {
  grid-column: 1 / -1;
  justify-self: start;
}
```

## 使用建议

### 1. 选择合适的布局方式

- **一维布局**：使用 Flexbox（如导航栏、按钮组）
- **二维布局**：使用 Grid（如卡片网格、复杂布局）

### 2. 使用 repeat() 和 minmax()

简化代码，提高可读性：

```css
/* 推荐 */
.grid {
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
}

/* 不推荐 */
.grid {
  grid-template-columns: 250px 250px 250px 250px;
}
```

### 3. 使用命名区域

对于复杂布局，使用命名区域更清晰：

```css
.layout {
  grid-template-areas:
    "header header"
    "sidebar main"
    "footer footer";
}
```

### 4. 结合 Flexbox 使用

Grid 用于整体布局，Flexbox 用于局部布局：

```css
.grid-item {
  display: flex;  /* Grid 项内部使用 Flexbox */
  align-items: center;
  justify-content: center;
}
```

### 5. 响应式设计

使用 `auto-fill` 或 `auto-fit` 实现响应式：

```css
.grid {
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
}
```

## 小结

Grid 布局是强大的二维布局工具：

- **容器属性**：`grid-template-columns`、`grid-template-rows`、`grid-template-areas`、`gap` 等
- **项目属性**：`grid-column`、`grid-row`、`grid-area`、`justify-self`、`align-self` 等
- **解决的核心问题**：二维布局、复杂网格、精确控制

**使用建议**：
- 选择合适的布局方式（Grid vs Flexbox）
- 使用 repeat() 和 minmax() 简化代码
- 使用命名区域提高可读性
- 结合 Flexbox 使用
- 利用 auto-fill/auto-fit 实现响应式

掌握了 Grid 布局，你就能创建各种复杂的二维布局。在下一章，我们将学习视觉效果属性，了解如何为元素添加丰富的视觉效果。
