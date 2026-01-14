---
sidebar_position: 8
slug: /css-arrows
---

# CSS 箭头 (Arrows)

在 Web 开发中，箭头是常见的 UI 元素，用于指示方向、展开/收起状态、导航等。使用 CSS 创建箭头比使用图片更灵活、更易维护，而且可以轻松改变颜色、大小和方向。本章将介绍如何使用纯 CSS 创建各种箭头效果。

## 为什么用 CSS 画箭头

### 优势

- **灵活性**：可以轻松改变颜色、大小、方向
- **性能**：不需要加载图片资源
- **可维护性**：修改样式即可，无需替换图片
- **响应式**：可以随容器大小自适应
- **可访问性**：可以通过 CSS 控制，支持主题切换

### 适用场景

- **下拉菜单**：指示菜单方向
- **轮播图**：左右导航箭头
- **折叠面板**：展开/收起指示
- **分页导航**：上一页/下一页
- **返回按钮**：返回箭头

## 常见实现方式

### 1. 使用边框（Border）

最常用的方法，利用边框的透明特性创建三角形。

```css
.arrow {
  width: 0;
  height: 0;
  border: 10px solid transparent;
}

/* 向右箭头 */
.arrow-right {
  border-left-color: #333;
  border-right: none;
}

/* 向左箭头 */
.arrow-left {
  border-right-color: #333;
  border-left: none;
}

/* 向上箭头 */
.arrow-up {
  border-bottom-color: #333;
  border-top: none;
}

/* 向下箭头 */
.arrow-down {
  border-top-color: #333;
  border-bottom: none;
}
```

### 2. 使用伪元素

结合伪元素创建更复杂的箭头。

```css
.arrow-element {
  position: relative;
  padding-right: 20px;
}

.arrow-element::after {
  content: "";
  position: absolute;
  right: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 0;
  height: 0;
  border: 6px solid transparent;
  border-left-color: #333;
}
```

### 3. 使用 Unicode 字符

使用 Unicode 箭头字符（简单但灵活性较低）。

```css
.arrow-unicode::after {
  content: "→";
  font-size: 20px;
}
```

### 4. 使用 SVG

使用内联 SVG（最灵活，但需要 SVG 知识）。

```css
.arrow-svg {
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%23333' d='M8.59 16.59L13.17 12 8.59 7.41 10 6l6 6-6 6z'/%3E%3C/svg%3E");
  width: 24px;
  height: 24px;
}
```

## 不同方向箭头

### 基础方向箭头

```css
/* 向右 */
.arrow-right {
  width: 0;
  height: 0;
  border-top: 8px solid transparent;
  border-bottom: 8px solid transparent;
  border-left: 12px solid #333;
}

/* 向左 */
.arrow-left {
  width: 0;
  height: 0;
  border-top: 8px solid transparent;
  border-bottom: 8px solid transparent;
  border-right: 12px solid #333;
}

/* 向上 */
.arrow-up {
  width: 0;
  height: 0;
  border-left: 8px solid transparent;
  border-right: 8px solid transparent;
  border-bottom: 12px solid #333;
}

/* 向下 */
.arrow-down {
  width: 0;
  height: 0;
  border-left: 8px solid transparent;
  border-right: 8px solid transparent;
  border-top: 12px solid #333;
}
```

### 旋转箭头

使用 `transform: rotate()` 创建不同方向的箭头。

```css
.arrow {
  width: 0;
  height: 0;
  border-top: 8px solid transparent;
  border-bottom: 8px solid transparent;
  border-left: 12px solid #333;
  transition: transform 0.3s;
}

.arrow-up {
  transform: rotate(-90deg);
}

.arrow-down {
  transform: rotate(90deg);
}

.arrow-left {
  transform: rotate(180deg);
}
```

## 实际应用场景

### 1. 下拉菜单箭头

```html
<button class="dropdown-toggle">
  菜单
  <span class="arrow arrow-down"></span>
</button>
```

```css
.dropdown-toggle {
  display: flex;
  align-items: center;
  gap: 8px;
}

.arrow-down {
  width: 0;
  height: 0;
  border-left: 6px solid transparent;
  border-right: 6px solid transparent;
  border-top: 8px solid #333;
  transition: transform 0.3s;
}

.dropdown-toggle.active .arrow-down {
  transform: rotate(180deg);
}
```

### 2. 轮播图导航

```html
<button class="carousel-prev">
  <span class="arrow arrow-left"></span>
</button>
<button class="carousel-next">
  <span class="arrow arrow-right"></span>
</button>
```

```css
.carousel-prev,
.carousel-next {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: rgba(0,0,0,0.5);
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background-color 0.3s;
}

.carousel-prev:hover,
.carousel-next:hover {
  background-color: rgba(0,0,0,0.7);
}

.arrow-left,
.arrow-right {
  width: 0;
  height: 0;
  border-top: 8px solid transparent;
  border-bottom: 8px solid transparent;
}

.arrow-left {
  border-right: 12px solid white;
}

.arrow-right {
  border-left: 12px solid white;
}
```

### 3. 返回按钮

```html
<a href="#" class="back-button">
  <span class="arrow arrow-left"></span>
  返回
</a>
```

```css
.back-button {
  display: flex;
  align-items: center;
  gap: 8px;
  color: #007bff;
  text-decoration: none;
}

.arrow-left {
  width: 0;
  height: 0;
  border-top: 6px solid transparent;
  border-bottom: 6px solid transparent;
  border-right: 10px solid #007bff;
}
```

### 4. 折叠面板指示器

```html
<button class="accordion-header">
  <span>标题</span>
  <span class="arrow arrow-down"></span>
</button>
```

```css
.accordion-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  padding: 15px;
  background: none;
  border: none;
  cursor: pointer;
}

.arrow-down {
  width: 0;
  height: 0;
  border-left: 6px solid transparent;
  border-right: 6px solid transparent;
  border-top: 8px solid #333;
  transition: transform 0.3s;
}

.accordion-header.active .arrow-down {
  transform: rotate(180deg);
}
```

### 5. 分页导航

```html
<nav class="pagination">
  <button class="page-prev">
    <span class="arrow arrow-left"></span>
    上一页
  </button>
  <button class="page-next">
    下一页
    <span class="arrow arrow-right"></span>
  </button>
</nav>
```

```css
.page-prev,
.page-next {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 16px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.arrow-left,
.arrow-right {
  width: 0;
  height: 0;
  border-top: 6px solid transparent;
  border-bottom: 6px solid transparent;
}

.arrow-left {
  border-right: 8px solid white;
}

.arrow-right {
  border-left: 8px solid white;
}
```

## 高级技巧

### 1. 双线箭头

```css
.arrow-double {
  position: relative;
  width: 20px;
  height: 20px;
}

.arrow-double::before,
.arrow-double::after {
  content: "";
  position: absolute;
  width: 10px;
  height: 2px;
  background-color: #333;
  top: 50%;
}

.arrow-double::before {
  left: 0;
  transform: translateY(-50%) rotate(45deg);
  transform-origin: left center;
}

.arrow-double::after {
  right: 0;
  transform: translateY(-50%) rotate(-45deg);
  transform-origin: right center;
}
```

### 2. 圆角箭头

```css
.arrow-rounded {
  width: 20px;
  height: 20px;
  border-top: 3px solid #333;
  border-right: 3px solid #333;
  transform: rotate(45deg);
  border-radius: 2px;
}
```

### 3. 动画箭头

```css
.arrow-animated {
  width: 0;
  height: 0;
  border-top: 8px solid transparent;
  border-bottom: 8px solid transparent;
  border-left: 12px solid #333;
  animation: bounce 1s ease-in-out infinite;
}

@keyframes bounce {
  0%, 100% {
    transform: translateX(0);
  }
  50% {
    transform: translateX(5px);
  }
}
```

## 示例演示

### 完整示例：多功能箭头组件

```html
<div class="arrow-examples">
  <div class="arrow-box">
    <span class="arrow arrow-right"></span>
    <span>向右</span>
  </div>
  <div class="arrow-box">
    <span class="arrow arrow-left"></span>
    <span>向左</span>
  </div>
  <div class="arrow-box">
    <span class="arrow arrow-up"></span>
    <span>向上</span>
  </div>
  <div class="arrow-box">
    <span class="arrow arrow-down"></span>
    <span>向下</span>
  </div>
</div>
```

```css
.arrow-examples {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
}

.arrow-box {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
  padding: 20px;
  border: 1px solid #ddd;
  border-radius: 8px;
}

.arrow {
  width: 0;
  height: 0;
}

.arrow-right {
  border-top: 10px solid transparent;
  border-bottom: 10px solid transparent;
  border-left: 15px solid #007bff;
}

.arrow-left {
  border-top: 10px solid transparent;
  border-bottom: 10px solid transparent;
  border-right: 15px solid #007bff;
}

.arrow-up {
  border-left: 10px solid transparent;
  border-right: 10px solid transparent;
  border-bottom: 15px solid #007bff;
}

.arrow-down {
  border-left: 10px solid transparent;
  border-right: 10px solid transparent;
  border-top: 15px solid #007bff;
}
```

## 小结

CSS 箭头的实现要点：

- **实现方式**：边框、伪元素、Unicode、SVG
- **方向控制**：上下左右四个方向
- **应用场景**：下拉菜单、轮播图、返回按钮、折叠面板
- **高级技巧**：双线箭头、圆角箭头、动画箭头
- **优势**：灵活、性能好、易维护

**关键原则**：
- 使用边框方法最常用
- 结合伪元素创建复杂效果
- 使用 transform 旋转改变方向
- 保持简洁和可维护

掌握了 CSS 箭头的实现，你就能创建各种方向的指示器。在接下来的章节中，我们将学习 CSS 生态与扩展，了解现代 CSS 开发工具。
