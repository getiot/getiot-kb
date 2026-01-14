---
sidebar_position: 7
slug: /css-tooltips
---

# CSS 工具提示 (Tooltips)

工具提示（Tooltip）是一种轻量级的提示组件，当用户悬停在元素上时显示额外的信息。工具提示通常用于提供简短的说明、解释或补充信息，不会打断用户的主要操作流程。本章将介绍如何使用纯 CSS 实现工具提示。

## 工具提示的使用场景

### 适用场景

- **图标说明**：解释图标或按钮的功能
- **表单帮助**：提供输入字段的提示信息
- **缩写解释**：解释缩写词的含义
- **补充信息**：提供额外的上下文信息

### 不适用场景

- **大量文本**：工具提示应该简短
- **关键信息**：重要信息不应该隐藏在工具提示中
- **移动设备**：触摸设备没有悬停状态

## 基础结构设计

### HTML 结构

```html
<!-- 方法 1：使用 data 属性 -->
<button data-tooltip="这是提示信息">悬停我</button>

<!-- 方法 2：使用伪元素 -->
<span class="tooltip-trigger">
  悬停我
  <span class="tooltip">这是提示信息</span>
</span>
```

### CSS 实现

```css
.tooltip-trigger {
  position: relative;
  display: inline-block;
}

.tooltip {
  position: absolute;
  bottom: 100%;
  left: 50%;
  transform: translateX(-50%);
  margin-bottom: 8px;
  padding: 6px 12px;
  background-color: #333;
  color: white;
  font-size: 14px;
  white-space: nowrap;
  border-radius: 4px;
  opacity: 0;
  visibility: hidden;
  transition: opacity 0.3s, visibility 0.3s;
  pointer-events: none;
  z-index: 1000;
}

.tooltip::after {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  transform: translateX(-50%);
  border: 6px solid transparent;
  border-top-color: #333;
}

.tooltip-trigger:hover .tooltip {
  opacity: 1;
  visibility: visible;
}
```

## 悬停触发机制

### 基础悬停

```css
.tooltip-trigger:hover .tooltip {
  opacity: 1;
  visibility: visible;
}
```

### 延迟显示

```css
.tooltip {
  transition: opacity 0.3s 0.5s, visibility 0.3s 0.5s;
  /* 延迟 0.5 秒显示 */
}
```

### 使用 data 属性

```html
<button data-tooltip="提示信息">按钮</button>
```

```css
[data-tooltip] {
  position: relative;
}

[data-tooltip]::before {
  content: attr(data-tooltip);
  position: absolute;
  bottom: 100%;
  left: 50%;
  transform: translateX(-50%);
  margin-bottom: 8px;
  padding: 6px 12px;
  background-color: #333;
  color: white;
  font-size: 14px;
  white-space: nowrap;
  border-radius: 4px;
  opacity: 0;
  visibility: hidden;
  transition: opacity 0.3s, visibility 0.3s;
  pointer-events: none;
  z-index: 1000;
}

[data-tooltip]::after {
  content: "";
  position: absolute;
  bottom: 100%;
  left: 50%;
  transform: translateX(-50%);
  margin-bottom: 2px;
  border: 6px solid transparent;
  border-top-color: #333;
  opacity: 0;
  visibility: hidden;
  transition: opacity 0.3s, visibility 0.3s;
  pointer-events: none;
  z-index: 1000;
}

[data-tooltip]:hover::before,
[data-tooltip]:hover::after {
  opacity: 1;
  visibility: visible;
}
```

## 定位与样式技巧

### 不同方向的工具提示

```css
/* 上方（默认） */
.tooltip--top {
  bottom: 100%;
  top: auto;
  left: 50%;
  transform: translateX(-50%);
  margin-bottom: 8px;
}

.tooltip--top::after {
  top: 100%;
  bottom: auto;
  border-top-color: #333;
  border-bottom-color: transparent;
}

/* 下方 */
.tooltip--bottom {
  top: 100%;
  bottom: auto;
  left: 50%;
  transform: translateX(-50%);
  margin-top: 8px;
}

.tooltip--bottom::after {
  bottom: 100%;
  top: auto;
  border-bottom-color: #333;
  border-top-color: transparent;
}

/* 左侧 */
.tooltip--left {
  right: 100%;
  left: auto;
  top: 50%;
  transform: translateY(-50%);
  margin-right: 8px;
}

.tooltip--left::after {
  left: 100%;
  right: auto;
  top: 50%;
  transform: translateY(-50%);
  border-left-color: #333;
  border-right-color: transparent;
}

/* 右侧 */
.tooltip--right {
  left: 100%;
  right: auto;
  top: 50%;
  transform: translateY(-50%);
  margin-left: 8px;
}

.tooltip--right::after {
  right: 100%;
  left: auto;
  top: 50%;
  transform: translateY(-50%);
  border-right-color: #333;
  border-left-color: transparent;
}
```

### 样式变体

```css
/* 浅色主题 */
.tooltip--light {
  background-color: white;
  color: #333;
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
}

.tooltip--light::after {
  border-top-color: white;
}

/* 大尺寸 */
.tooltip--large {
  padding: 10px 16px;
  font-size: 16px;
  max-width: 300px;
  white-space: normal;
}
```

## 示例实现

### 完整示例：多功能工具提示

```html
<div class="tooltip-container">
  <button data-tooltip="这是上方提示" data-tooltip-position="top">上方</button>
  <button data-tooltip="这是下方提示" data-tooltip-position="bottom">下方</button>
  <button data-tooltip="这是左侧提示" data-tooltip-position="left">左侧</button>
  <button data-tooltip="这是右侧提示" data-tooltip-position="right">右侧</button>
</div>
```

```css
[data-tooltip] {
  position: relative;
  padding: 10px 20px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

[data-tooltip]::before {
  content: attr(data-tooltip);
  position: absolute;
  padding: 6px 12px;
  background-color: #333;
  color: white;
  font-size: 14px;
  white-space: nowrap;
  border-radius: 4px;
  opacity: 0;
  visibility: hidden;
  transition: opacity 0.3s, visibility 0.3s, transform 0.3s;
  pointer-events: none;
  z-index: 1000;
}

[data-tooltip]::after {
  content: "";
  position: absolute;
  border: 6px solid transparent;
  opacity: 0;
  visibility: hidden;
  transition: opacity 0.3s, visibility 0.3s;
  pointer-events: none;
  z-index: 1000;
}

/* 上方 */
[data-tooltip-position="top"]::before {
  bottom: 100%;
  left: 50%;
  transform: translateX(-50%) translateY(-5px);
  margin-bottom: 8px;
}

[data-tooltip-position="top"]::after {
  bottom: 100%;
  left: 50%;
  transform: translateX(-50%);
  margin-bottom: 2px;
  border-top-color: #333;
  border-bottom-color: transparent;
}

/* 下方 */
[data-tooltip-position="bottom"]::before {
  top: 100%;
  left: 50%;
  transform: translateX(-50%) translateY(5px);
  margin-top: 8px;
}

[data-tooltip-position="bottom"]::after {
  top: 100%;
  left: 50%;
  transform: translateX(-50%);
  margin-top: 2px;
  border-bottom-color: #333;
  border-top-color: transparent;
}

/* 左侧 */
[data-tooltip-position="left"]::before {
  right: 100%;
  top: 50%;
  transform: translateY(-50%) translateX(-5px);
  margin-right: 8px;
}

[data-tooltip-position="left"]::after {
  right: 100%;
  top: 50%;
  transform: translateY(-50%);
  margin-right: 2px;
  border-left-color: #333;
  border-right-color: transparent;
}

/* 右侧 */
[data-tooltip-position="right"]::before {
  left: 100%;
  top: 50%;
  transform: translateY(-50%) translateX(5px);
  margin-left: 8px;
}

[data-tooltip-position="right"]::after {
  left: 100%;
  top: 50%;
  transform: translateY(-50%);
  margin-left: 2px;
  border-right-color: #333;
  border-left-color: transparent;
}

[data-tooltip]:hover::before,
[data-tooltip]:hover::after {
  opacity: 1;
  visibility: visible;
  transform: translateX(-50%) translateY(0);
}

[data-tooltip-position="bottom"]:hover::before {
  transform: translateX(-50%) translateY(0);
}

[data-tooltip-position="left"]:hover::before {
  transform: translateY(-50%) translateX(0);
}

[data-tooltip-position="right"]:hover::before {
  transform: translateY(-50%) translateX(0);
}
```

## 小结

工具提示的实现要点：

- **基础结构**：使用伪元素或独立元素
- **触发机制**：悬停显示，使用 `:hover`
- **定位技巧**：上下左右四个方向
- **样式设计**：简洁、清晰、不干扰
- **用户体验**：延迟显示、平滑过渡

**关键原则**：
- 保持内容简短
- 提供清晰的视觉反馈
- 不干扰主要操作
- 考虑移动设备的限制

掌握了工具提示的实现，你就能为用户提供更好的交互体验。在下一章，我们将学习 CSS 箭头的实现。
