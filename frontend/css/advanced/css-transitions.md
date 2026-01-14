---
sidebar_position: 4
slug: /css-transitions
---

# CSS 过渡

CSS 过渡（Transition）允许你在 CSS 属性值发生变化时，创建平滑的动画效果。过渡是创建流畅用户界面的基础，它让状态变化看起来更自然、更专业。

## 为什么需要这个特性

过渡解决了以下问题：

1. **平滑变化**：让属性值的变化变得平滑，而不是突然跳变
2. **用户体验**：提供视觉反馈，让用户知道发生了什么
3. **专业感**：让界面看起来更加精致和专业
4. **引导注意力**：通过动画引导用户注意到重要的变化
5. **减少突兀感**：避免突然的变化带来的视觉冲击

## 核心概念解释

过渡定义了当 CSS 属性值改变时，如何平滑地从旧值过渡到新值。

### 过渡的组成部分

一个完整的过渡包含四个部分：

1. **属性（property）**：要过渡的 CSS 属性
2. **持续时间（duration）**：过渡持续的时间
3. **时间函数（timing function）**：过渡的速度曲线
4. **延迟（delay）**：过渡开始前的延迟时间

### 基本语法

```css
transition: property duration timing-function delay;
```

## 核心属性介绍

### transition-property

指定要过渡的属性。

```css
.element {
  transition-property: width;        /* 只过渡 width */
  transition-property: width, height; /* 过渡多个属性 */
  transition-property: all;          /* 过渡所有可过渡属性 */
  transition-property: none;        /* 不过渡 */
}
```

### transition-duration

指定过渡的持续时间。

```css
.element {
  transition-duration: 0.3s;        /* 0.3 秒 */
  transition-duration: 300ms;       /* 300 毫秒 */
  transition-duration: 1s, 0.5s;     /* 多个属性不同的持续时间 */
}
```

### transition-timing-function

指定过渡的时间函数（速度曲线）。

```css
.element {
  transition-timing-function: ease;         /* 慢-快-慢（默认） */
  transition-timing-function: linear;      /* 匀速 */
  transition-timing-function: ease-in;     /* 慢-快 */
  transition-timing-function: ease-out;     /* 快-慢 */
  transition-timing-function: ease-in-out;  /* 慢-快-慢 */
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1); /* 自定义曲线 */
}
```

**常用时间函数**：
- `ease`：默认，慢-快-慢
- `linear`：匀速
- `ease-in`：加速
- `ease-out`：减速
- `ease-in-out`：加速然后减速

### transition-delay

指定过渡开始前的延迟时间。

```css
.element {
  transition-delay: 0s;      /* 无延迟（默认） */
  transition-delay: 0.5s;    /* 延迟 0.5 秒 */
  transition-delay: 1s, 0.5s; /* 多个属性不同的延迟 */
}
```

### transition（简写属性）

`transition` 是以上所有属性的简写。

```css
.element {
  transition: property duration timing-function delay;
}

/* 示例 */
.element {
  transition: width 0.3s ease 0s;
  transition: all 0.3s ease;
  transition: width 0.3s, height 0.5s ease;
}
```

## 可过渡的属性

并非所有 CSS 属性都可以过渡。一般来说，可以过渡的属性包括：

- **颜色属性**：`color`、`background-color`、`border-color` 等
- **尺寸属性**：`width`、`height`、`padding`、`margin` 等
- **位置属性**：`top`、`right`、`bottom`、`left` 等
- **变换属性**：`transform`、`opacity` 等
- **其他**：`opacity`、`visibility`、`box-shadow` 等

**不能过渡的属性**：
- `display`
- `font-family`
- `z-index`（某些情况下）

## 常见用法

### 1. 基础过渡

```css
.button {
  background-color: blue;
  transition: background-color 0.3s ease;
}

.button:hover {
  background-color: red;
}
```

### 2. 多个属性过渡

```css
.card {
  transform: scale(1);
  opacity: 1;
  transition: transform 0.3s ease, opacity 0.3s ease;
}

.card:hover {
  transform: scale(1.05);
  opacity: 0.9;
}
```

### 3. 不同持续时间

```css
.element {
  transition:
    width 0.3s ease,
    height 0.5s ease,
    background-color 0.2s ease;
}
```

### 4. 延迟过渡

```css
.menu-item {
  opacity: 0;
  transform: translateY(20px);
  transition: opacity 0.3s ease 0.1s, transform 0.3s ease 0.1s;
}

.menu-item.show {
  opacity: 1;
  transform: translateY(0);
}
```

### 5. 所有属性过渡

```css
.element {
  transition: all 0.3s ease;
}

/* 注意：all 可能影响性能，建议明确指定属性 */
```

## 示例

### 示例 1：按钮悬停效果

```html
<button class="btn">悬停我</button>
```

```css
.btn {
  background-color: #007bff;
  color: white;
  padding: 12px 24px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.2s ease;
}

.btn:hover {
  background-color: #0056b3;
  transform: translateY(-2px);
}

.btn:active {
  transform: translateY(0);
}
```

### 示例 2：卡片悬停效果

```html
<div class="card">
  <h3>卡片标题</h3>
  <p>卡片内容</p>
</div>
```

```css
.card {
  background-color: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.15);
}
```

### 示例 3：淡入淡出

```html
<div class="fade-element">内容</div>
```

```css
.fade-element {
  opacity: 0;
  transition: opacity 0.5s ease;
}

.fade-element.show {
  opacity: 1;
}
```

### 示例 4：展开折叠

```html
<div class="accordion">
  <button class="accordion-header">标题</button>
  <div class="accordion-content">内容</div>
</div>
```

```css
.accordion-content {
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.3s ease;
}

.accordion.open .accordion-content {
  max-height: 500px;
}
```

### 示例 5：加载动画

```html
<div class="loader"></div>
```

```css
.loader {
  width: 40px;
  height: 40px;
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

## 注意事项

### 1. 性能优化

优先使用 `transform` 和 `opacity` 进行过渡，它们性能最好：

```css
/* 推荐：性能好 */
.element {
  transition: transform 0.3s, opacity 0.3s;
}

/* 不推荐：可能影响性能 */
.element {
  transition: width 0.3s, height 0.3s;
}
```

### 2. 避免过渡所有属性

使用 `transition: all` 可能影响性能：

```css
/* 不推荐 */
.element {
  transition: all 0.3s;
}

/* 推荐：明确指定属性 */
.element {
  transition: transform 0.3s, opacity 0.3s;
}
```

### 3. 合理设置持续时间

过渡时间不宜过长或过短：

- **快速反馈**：0.1s - 0.2s（按钮点击、悬停）
- **标准过渡**：0.3s - 0.5s（大多数情况）
- **慢速过渡**：0.5s - 1s（页面切换、复杂动画）

### 4. 使用合适的时间函数

选择合适的时间函数让动画更自然：

```css
/* 推荐：ease-out 用于进入动画 */
.element-enter {
  transition: transform 0.3s ease-out;
}

/* 推荐：ease-in 用于退出动画 */
.element-exit {
  transition: transform 0.3s ease-in;
}
```

### 5. 提供降级方案

对于不支持过渡的浏览器，确保功能仍然可用：

```css
.button {
  background-color: blue;
}

.button:hover {
  background-color: red;  /* 即使没有过渡，颜色也会改变 */
}

/* 现代浏览器添加过渡 */
@supports (transition: background-color 0.3s) {
  .button {
    transition: background-color 0.3s ease;
  }
}
```

## 小结

CSS 过渡让属性变化变得平滑：

- **属性**：`transition-property` 指定要过渡的属性
- **持续时间**：`transition-duration` 指定过渡时间
- **时间函数**：`transition-timing-function` 指定速度曲线
- **延迟**：`transition-delay` 指定延迟时间
- **简写**：`transition` 是以上属性的简写

**使用建议**：
- 优先使用 `transform` 和 `opacity`
- 避免过渡所有属性
- 合理设置持续时间
- 使用合适的时间函数
- 提供降级方案

掌握了 CSS 过渡，你就能创建流畅的用户界面。在下一章，我们将学习 CSS 变换，了解如何移动、旋转和缩放元素。
