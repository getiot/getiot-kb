---
sidebar_position: 9
slug: /css-interaction
---

# CSS 交互与行为属性

交互与行为属性控制着用户与页面元素交互时的体验，包括鼠标指针样式、用户选择行为、滚动行为等。这些属性虽然看似简单，但对用户体验有着重要影响。

## 该类属性解决什么问题

交互与行为属性主要解决以下问题：

1. **交互反馈**：通过鼠标指针样式提供视觉反馈
2. **用户体验**：控制用户的选择、拖拽等行为
3. **可访问性**：改善键盘导航和屏幕阅读器的体验
4. **滚动体验**：优化页面滚动行为
5. **交互控制**：精确控制哪些元素可以交互

## 核心属性介绍

### 指针属性

#### cursor

设置鼠标指针的样式。

```css
.element {
  cursor: default;      /* 默认指针 */
  cursor: pointer;      /* 手型指针（链接） */
  cursor: text;        /* 文本选择指针 */
  cursor: move;         /* 移动指针 */
  cursor: not-allowed;  /* 禁止指针 */
  cursor: wait;         /* 等待指针 */
  cursor: help;         /* 帮助指针 */
  cursor: crosshair;    /* 十字准线 */
  cursor: grab;         /* 抓取指针 */
  cursor: grabbing;     /* 抓取中指针 */
}
```

**自定义指针**：

```css
.element {
  cursor: url("custom-cursor.png"), auto;
  /* 自定义图片，如果加载失败则使用 auto */
}
```

### 指针事件属性

#### pointer-events

设置元素是否响应指针事件。

```css
.element {
  pointer-events: auto;    /* 响应指针事件（默认） */
  pointer-events: none;    /* 不响应指针事件 */
}
```

**使用场景**：
- 禁用元素的点击
- 让元素"穿透"点击
- 创建遮罩层

```css
/* 禁用按钮 */
.button.disabled {
  pointer-events: none;
  opacity: 0.5;
}

/* 遮罩层（不阻止点击） */
.overlay {
  pointer-events: none;
}

/* 遮罩层内容（可以点击） */
.overlay .content {
  pointer-events: auto;
}
```

### 用户选择属性

#### user-select

设置用户是否可以选择文本。

```css
.element {
  user-select: auto;     /* 自动（默认） */
  user-select: none;     /* 不可选择 */
  user-select: text;     /* 可以选择文本 */
  user-select: all;      /* 点击时选择所有文本 */
}
```

**使用场景**：

```css
/* 按钮文字不可选择 */
.button {
  user-select: none;
}

/* 代码块可以选择 */
.code-block {
  user-select: text;
}
```

### 调整大小属性

#### resize

设置元素是否可以被用户调整大小。

```css
.element {
  resize: none;      /* 不可调整（默认） */
  resize: both;      /* 可以调整宽度和高度 */
  resize: horizontal; /* 只能调整宽度 */
  resize: vertical;   /* 只能调整高度 */
}
```

**注意**：只对设置了 `overflow` 的元素有效。

```css
.textarea {
  resize: vertical;  /* 只能垂直调整 */
  overflow: auto;
}
```

### 滚动属性

#### scroll-behavior

设置滚动容器内滚动时的行为。

```css
html {
  scroll-behavior: smooth;  /* 平滑滚动 */
  scroll-behavior: auto;    /* 立即滚动（默认） */
}
```

**使用场景**：

```html
<a href="#section1">跳转到章节 1</a>
<section id="section1">章节 1 内容</section>
```

```css
html {
  scroll-behavior: smooth;
}
```

#### scroll-margin

设置滚动到元素时的外边距。

```css
.section {
  scroll-margin-top: 80px;  /* 滚动时距离顶部 80px */
}
```

#### scroll-padding

设置滚动容器的内边距。

```css
.scroll-container {
  scroll-padding-top: 80px;  /* 滚动时距离顶部 80px */
}
```

### 轮廓属性

#### outline

设置元素的轮廓（不占用空间）。

```css
.element {
  outline: 2px solid #007bff;
  outline: none;  /* 移除轮廓 */
  outline-offset: 2px;  /* 轮廓偏移 */
}
```

**与 border 的区别**：
- `outline` 不占用空间，不影响布局
- `outline` 不能设置圆角
- `outline` 通常用于焦点指示

**可访问性提示**：不要移除焦点轮廓，除非提供替代方案：

```css
/* 不推荐：直接移除 */
.button:focus {
  outline: none;
}

/* 推荐：提供替代方案 */
.button:focus {
  outline: none;
  box-shadow: 0 0 0 3px rgba(0,123,255,0.25);
}
```

### 触摸操作属性

#### touch-action

设置元素的触摸操作行为。

```css
.element {
  touch-action: auto;        /* 自动（默认） */
  touch-action: none;        /* 禁用所有触摸操作 */
  touch-action: pan-x;       /* 允许水平平移 */
  touch-action: pan-y;       /* 允许垂直平移 */
  touch-action: manipulation; /* 只允许平移和缩放 */
}
```

## 常见组合用法

### 1. 按钮交互

```css
.button {
  cursor: pointer;
  user-select: none;
  transition: all 0.3s;
}

.button:hover {
  background-color: #0056b3;
}

.button:active {
  transform: scale(0.98);
}

.button:focus {
  outline: none;
  box-shadow: 0 0 0 3px rgba(0,123,255,0.25);
}

.button.disabled {
  cursor: not-allowed;
  pointer-events: none;
  opacity: 0.5;
}
```

### 2. 可拖拽元素

```css
.draggable {
  cursor: grab;
  user-select: none;
}

.draggable:active {
  cursor: grabbing;
}
```

### 3. 代码块

```css
.code-block {
  user-select: text;  /* 允许选择文本 */
  cursor: text;
  overflow-x: auto;
  resize: vertical;    /* 可以调整高度 */
}
```

### 4. 平滑滚动

```css
html {
  scroll-behavior: smooth;
}

.section {
  scroll-margin-top: 80px;  /* 为固定头部留出空间 */
}
```

### 5. 禁用交互

```css
.disabled {
  pointer-events: none;
  cursor: not-allowed;
  opacity: 0.5;
  user-select: none;
}
```

## 示例演示

### 示例 1：交互式卡片

```html
<div class="card">
  <h3>卡片标题</h3>
  <p>卡片内容</p>
  <button class="card-button">点击我</button>
</div>
```

```css
.card {
  background-color: white;
  border-radius: 8px;
  padding: 20px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  transition: transform 0.3s, box-shadow 0.3s;
  cursor: pointer;
}

.card:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.15);
}

.card-button {
  cursor: pointer;
  user-select: none;
  padding: 10px 20px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  transition: background-color 0.3s;
}

.card-button:hover {
  background-color: #0056b3;
}

.card-button:focus {
  outline: none;
  box-shadow: 0 0 0 3px rgba(0,123,255,0.25);
}

.card-button:active {
  transform: scale(0.98);
}
```

### 示例 2：可调整大小的文本区域

```html
<textarea class="resizable-textarea" placeholder="输入内容..."></textarea>
```

```css
.resizable-textarea {
  width: 100%;
  min-height: 100px;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;  /* 只能垂直调整 */
  overflow: auto;
  font-family: inherit;
}
```

### 示例 3：平滑滚动导航

```html
<nav class="smooth-nav">
  <a href="#section1">章节 1</a>
  <a href="#section2">章节 2</a>
  <a href="#section3">章节 3</a>
</nav>
<section id="section1">章节 1 内容</section>
<section id="section2">章节 2 内容</section>
<section id="section3">章节 3 内容</section>
```

```css
html {
  scroll-behavior: smooth;
}

section {
  scroll-margin-top: 80px;  /* 为固定导航留出空间 */
  min-height: 100vh;
  padding: 20px;
}
```

### 示例 4：禁用状态

```html
<button class="button" disabled>禁用按钮</button>
<input type="text" class="input" disabled>
```

```css
.button:disabled,
.input:disabled {
  pointer-events: none;
  cursor: not-allowed;
  opacity: 0.5;
  user-select: none;
}
```

### 示例 5：遮罩层交互

```html
<div class="modal-overlay">
  <div class="modal">
    <h2>模态框标题</h2>
    <p>模态框内容</p>
    <button class="close">关闭</button>
  </div>
</div>
```

```css
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0,0,0,0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  pointer-events: auto;  /* 可以点击遮罩关闭 */
}

.modal {
  background-color: white;
  padding: 20px;
  border-radius: 8px;
  max-width: 500px;
  pointer-events: auto;  /* 模态框内容可以交互 */
}
```

## 使用建议

### 1. 提供视觉反馈

通过 `cursor` 属性提供清晰的交互反馈：

```css
/* 可点击元素 */
.clickable {
  cursor: pointer;
}

/* 可拖拽元素 */
.draggable {
  cursor: grab;
}

.draggable:active {
  cursor: grabbing;
}

/* 禁用元素 */
.disabled {
  cursor: not-allowed;
}
```

### 2. 保持可访问性

不要移除焦点样式，除非提供替代方案：

```css
/* 推荐：提供替代焦点样式 */
.button:focus {
  outline: none;
  box-shadow: 0 0 0 3px rgba(0,123,255,0.25);
}

/* 不推荐：直接移除 */
.button:focus {
  outline: none;  /* 键盘用户无法看到焦点 */
}
```

### 3. 合理使用 user-select

只在必要时禁用文本选择：

```css
/* 推荐：按钮文字不可选择 */
.button {
  user-select: none;
}

/* 不推荐：禁用所有文本选择 */
* {
  user-select: none;  /* 影响用户体验 */
}
```

### 4. 优化滚动体验

使用平滑滚动提升用户体验：

```css
html {
  scroll-behavior: smooth;
}

/* 为固定头部留出空间 */
.section {
  scroll-margin-top: 80px;
}
```

### 5. 移动端优化

考虑移动端的触摸体验：

```css
/* 优化触摸目标大小 */
.button {
  min-width: 44px;  /* 最小触摸目标 */
  min-height: 44px;
  touch-action: manipulation;  /* 优化触摸响应 */
}
```

## 小结

交互与行为属性控制用户的交互体验：

- **指针属性**：`cursor` 提供视觉反馈
- **指针事件**：`pointer-events` 控制交互响应
- **用户选择**：`user-select` 控制文本选择
- **调整大小**：`resize` 控制元素大小调整
- **滚动行为**：`scroll-behavior` 优化滚动体验
- **轮廓**：`outline` 提供焦点指示

**使用建议**：
- 提供清晰的视觉反馈
- 保持可访问性
- 合理使用 user-select
- 优化滚动体验
- 考虑移动端体验

掌握了交互与行为属性，你就能创建更好的用户体验。在接下来的章节中，我们将学习高级 CSS 特性，包括变量、函数、动画等。
