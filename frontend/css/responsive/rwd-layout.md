---
sidebar_position: 3
slug: /rwd-layout
---

# CSS 响应式布局实践

响应式布局是响应式设计的核心实践。通过结合现代布局技术（Flexbox、Grid）和响应式思维，我们可以创建能够适应不同屏幕尺寸的灵活布局。

## 响应式布局常见模式

### 1. 单栏布局

单栏布局是最简单的响应式布局，内容垂直排列。

```css
.container {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}
```

### 2. 多栏布局

多栏布局在桌面端显示多列，在移动端显示单列。

```css
/* 移动优先：单列 */
.content {
  width: 100%;
}

/* 桌面：多列 */
@media (min-width: 768px) {
  .content {
    display: grid;
    grid-template-columns: 2fr 1fr;
    gap: 20px;
  }
}
```

### 3. 卡片网格

卡片网格根据屏幕大小自动调整列数。

```css
.card-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 20px;
}

@media (min-width: 768px) {
  .card-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 1200px) {
  .card-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}
```

## 基于 Flexbox 的响应式布局

Flexbox 非常适合创建响应式布局，因为它具有自动换行和弹性调整的特性。

### 基础响应式 Flexbox

```css
.container {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}

.item {
  flex: 1 1 300px;  /* 最小宽度 300px，可以放大和缩小 */
}
```

### 响应式导航

```css
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
}

.nav-menu {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
}

@media (max-width: 768px) {
  .nav-menu {
    width: 100%;
    flex-direction: column;
    display: none;
  }
  
  .nav-menu.active {
    display: flex;
  }
}
```

### 响应式表单

```css
.form {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.form-group {
  display: flex;
  flex-direction: column;
}

@media (min-width: 768px) {
  .form-group {
    flex-direction: row;
    align-items: center;
  }
  
  .form-group label {
    width: 150px;
  }
  
  .form-group input {
    flex: 1;
  }
}
```

## 基于 Grid 的响应式布局

Grid 布局提供了更强大的响应式能力，特别是 `auto-fill` 和 `auto-fit` 关键字。

### 自动填充网格

```css
.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 20px;
}
```

**说明**：
- `auto-fill`：自动填充尽可能多的列
- `minmax(250px, 1fr)`：每列最小 250px，最大等分剩余空间

### 响应式网格区域

```css
.layout {
  display: grid;
  grid-template-areas:
    "header"
    "main"
    "sidebar"
    "footer";
  gap: 20px;
}

.header { grid-area: header; }
.main { grid-area: main; }
.sidebar { grid-area: sidebar; }
.footer { grid-area: footer; }

@media (min-width: 768px) {
  .layout {
    grid-template-areas:
      "header header"
      "sidebar main"
      "footer footer";
    grid-template-columns: 200px 1fr;
  }
}
```

### 响应式列数

```css
.grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 20px;
}

@media (min-width: 600px) {
  .grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 900px) {
  .grid {
    grid-template-columns: repeat(3, 1fr);
  }
}

@media (min-width: 1200px) {
  .grid {
    grid-template-columns: repeat(4, 1fr);
  }
}
```

## 断点（Breakpoint）的设计思路

### 内容驱动断点

断点应该根据内容决定，而不是固定的设备尺寸。

```css
/* 不推荐：固定断点 */
@media (min-width: 768px) { }

/* 推荐：根据内容决定 */
.card {
  width: 100%;
}

/* 当两个卡片可以并排显示时 */
@media (min-width: 600px) {
  .card {
    width: calc(50% - 20px);
  }
}

/* 当三个卡片可以并排显示时 */
@media (min-width: 900px) {
  .card {
    width: calc(33.333% - 20px);
  }
}
```

### 常用断点系统

虽然断点应该根据内容决定，但可以参考这些常用断点：

```css
/* 手机（小） */
@media (max-width: 575px) { }

/* 手机（大） */
@media (min-width: 576px) and (max-width: 767px) { }

/* 平板 */
@media (min-width: 768px) and (max-width: 991px) { }

/* 桌面（小） */
@media (min-width: 992px) and (max-width: 1199px) { }

/* 桌面（大） */
@media (min-width: 1200px) { }
```

### 使用 CSS 变量管理断点

```css
:root {
  --breakpoint-sm: 576px;
  --breakpoint-md: 768px;
  --breakpoint-lg: 992px;
  --breakpoint-xl: 1200px;
}

@media (min-width: var(--breakpoint-md)) {
  .container {
    max-width: 750px;
  }
}
```

## 示例：从桌面到移动端的布局演进

### 完整示例：响应式网站布局

```html
<div class="page">
  <header class="header">头部</header>
  <nav class="navbar">导航</nav>
  <main class="main">
    <aside class="sidebar">侧边栏</aside>
    <article class="content">主要内容</article>
  </main>
  <footer class="footer">页脚</footer>
</div>
```

```css
/* 移动优先：基础样式 */
.page {
  display: grid;
  grid-template-areas:
    "header"
    "navbar"
    "main"
    "footer";
  gap: 20px;
}

.header { grid-area: header; }
.navbar { grid-area: navbar; }
.main { grid-area: main; }
.footer { grid-area: footer; }

.main {
  display: grid;
  grid-template-areas: "content";
  gap: 20px;
}

.sidebar { grid-area: sidebar; display: none; }
.content { grid-area: content; }

/* 平板：显示侧边栏 */
@media (min-width: 768px) {
  .main {
    grid-template-areas: "sidebar content";
    grid-template-columns: 200px 1fr;
  }
  
  .sidebar {
    display: block;
  }
}

/* 桌面：调整布局 */
@media (min-width: 1200px) {
  .page {
    grid-template-areas:
      "header header"
      "navbar sidebar"
      "main sidebar"
      "footer footer";
    grid-template-columns: 1fr 250px;
  }
  
  .main {
    grid-template-areas: "content";
  }
}
```

## 实战建议与经验总结

### 1. 移动优先

始终从移动设备开始设计，然后逐步增强：

```css
/* 移动优先 */
.container {
  width: 100%;
  padding: 10px;
}

/* 逐步增强 */
@media (min-width: 768px) {
  .container {
    padding: 20px;
  }
}
```

### 2. 使用弹性单位

优先使用相对单位，减少媒体查询：

```css
/* 推荐 */
.container {
  width: 100%;
  max-width: 1200px;
  padding: clamp(10px, 2vw, 20px);
  font-size: clamp(14px, 2vw, 18px);
}
```

### 3. 利用现代布局

使用 Flexbox 和 Grid 简化响应式布局：

```css
/* 使用 Grid 自动填充 */
.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 20px;
}
```

### 4. 测试不同设备

在不同设备上测试布局：

- 真实设备测试
- 浏览器开发者工具
- 不同方向（横屏/竖屏）

### 5. 性能优化

响应式布局也要考虑性能：

```css
/* 使用 transform 代替改变尺寸 */
.element {
  transition: transform 0.3s;
}

.element:hover {
  transform: scale(1.05);  /* 性能更好 */
}
```

### 6. 可访问性

确保响应式布局不影响可访问性：

```css
/* 确保触摸目标足够大 */
.button {
  min-width: 44px;
  min-height: 44px;
}

/* 确保文本可读 */
.text {
  font-size: clamp(16px, 2vw, 18px);
  line-height: 1.6;
}
```

## 小结

响应式布局实践要点：

- **布局模式**：单栏、多栏、网格
- **Flexbox**：自动换行、弹性调整
- **Grid**：自动填充、响应式区域
- **断点设计**：内容驱动，移动优先
- **实战建议**：测试、优化、可访问性

**关键原则**：
- 移动优先
- 使用弹性单位
- 利用现代布局
- 内容驱动断点
- 测试和优化

掌握了响应式布局实践，你就能创建适应各种设备的布局。在下一章，我们将学习响应式图片和媒体的处理。
