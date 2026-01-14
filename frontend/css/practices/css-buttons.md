---
sidebar_position: 3
slug: /css-buttons
---

# CSS 按钮与交互元素

按钮是用户界面中最常见的交互元素之一。一个设计良好的按钮不仅要有吸引人的外观，还要提供清晰的视觉反馈，让用户知道他们的操作已经被识别。本章将介绍如何创建各种类型的按钮和交互元素。

## 按钮的语义与样式角色

### HTML 语义

按钮应该使用语义化的 HTML 元素：

```html
<!-- 推荐：使用 button 元素 -->
<button type="button">点击我</button>
<button type="submit">提交</button>
<button type="reset">重置</button>

<!-- 也可以使用 a 标签（如果是链接） -->
<a href="#" class="button">链接按钮</a>

<!-- 不推荐：使用 div 或 span -->
<div class="button">不推荐</div>
```

### 按钮类型

- **主要按钮（Primary）**：最重要的操作，通常使用品牌色
- **次要按钮（Secondary）**：次要操作，通常使用灰色或边框样式
- **成功按钮（Success）**：成功相关的操作，通常使用绿色
- **危险按钮（Danger）**：危险操作，通常使用红色
- **警告按钮（Warning）**：警告操作，通常使用黄色
- **信息按钮（Info）**：信息提示，通常使用蓝色

## 不同状态的设计

按钮应该有不同的状态，提供清晰的视觉反馈：

### 1. 默认状态（Default）

```css
.button {
  padding: 10px 20px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
  transition: all 0.3s;
}
```

### 2. 悬停状态（Hover）

```css
.button:hover {
  background-color: #0056b3;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0,123,255,0.3);
}
```

### 3. 激活状态（Active）

```css
.button:active {
  background-color: #004085;
  transform: translateY(0);
  box-shadow: 0 2px 4px rgba(0,123,255,0.2);
}
```

### 4. 焦点状态（Focus）

```css
.button:focus {
  outline: none;
  box-shadow: 0 0 0 3px rgba(0,123,255,0.25);
}
```

### 5. 禁用状态（Disabled）

```css
.button:disabled {
  background-color: #ccc;
  color: #666;
  cursor: not-allowed;
  opacity: 0.6;
  pointer-events: none;
}
```

## 常见按钮样式实现

### 1. 实心按钮（Solid Button）

```css
.btn-primary {
  background-color: #007bff;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.btn-primary:hover {
  background-color: #0056b3;
}
```

### 2. 轮廓按钮（Outline Button）

```css
.btn-outline {
  background-color: transparent;
  color: #007bff;
  border: 2px solid #007bff;
  padding: 8px 18px;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.3s;
}

.btn-outline:hover {
  background-color: #007bff;
  color: white;
}
```

### 3. 文本按钮（Text Button）

```css
.btn-text {
  background-color: transparent;
  color: #007bff;
  border: none;
  padding: 10px 20px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.btn-text:hover {
  background-color: rgba(0,123,255,0.1);
}
```

### 4. 幽灵按钮（Ghost Button）

```css
.btn-ghost {
  background-color: rgba(255,255,255,0.1);
  color: white;
  border: 1px solid rgba(255,255,255,0.3);
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.3s;
}

.btn-ghost:hover {
  background-color: rgba(255,255,255,0.2);
  border-color: rgba(255,255,255,0.5);
}
```

### 5. 图标按钮（Icon Button）

```css
.btn-icon {
  width: 40px;
  height: 40px;
  padding: 0;
  border-radius: 50%;
  background-color: #f0f0f0;
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background-color 0.3s;
}

.btn-icon:hover {
  background-color: #e0e0e0;
}
```

### 6. 渐变按钮（Gradient Button）

```css
.btn-gradient {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
  transition: transform 0.3s, box-shadow 0.3s;
}

.btn-gradient:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(102,126,234,0.4);
}
```

## 可复用按钮的设计思路

### 使用 CSS 变量

```css
:root {
  --btn-padding: 10px 20px;
  --btn-border-radius: 4px;
  --btn-font-size: 16px;
  --btn-transition: all 0.3s;
}

.button {
  padding: var(--btn-padding);
  border-radius: var(--btn-border-radius);
  font-size: var(--btn-font-size);
  transition: var(--btn-transition);
  border: none;
  cursor: pointer;
}
```

### 使用 BEM 命名

```css
/* Block */
.button { }

/* Modifier */
.button--primary { }
.button--secondary { }
.button--large { }
.button--small { }

/* State */
.button:hover { }
.button:active { }
.button:disabled { }
```

### 按钮尺寸变体

```css
.button {
  padding: 10px 20px;
  font-size: 16px;
}

.button--small {
  padding: 6px 12px;
  font-size: 14px;
}

.button--large {
  padding: 14px 28px;
  font-size: 18px;
}
```

## 示例实现

### 完整示例：按钮组件系统

```html
<button class="btn btn--primary">主要按钮</button>
<button class="btn btn--secondary">次要按钮</button>
<button class="btn btn--outline">轮廓按钮</button>
<button class="btn btn--text">文本按钮</button>
<button class="btn btn--gradient">渐变按钮</button>
<button class="btn btn--primary" disabled>禁用按钮</button>
```

```css
/* 基础按钮样式 */
.btn {
  display: inline-block;
  padding: 10px 20px;
  font-size: 16px;
  font-weight: 500;
  text-align: center;
  text-decoration: none;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.3s ease;
  user-select: none;
  line-height: 1.5;
}

/* 主要按钮 */
.btn--primary {
  background-color: #007bff;
  color: white;
}

.btn--primary:hover {
  background-color: #0056b3;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0,123,255,0.3);
}

.btn--primary:active {
  background-color: #004085;
  transform: translateY(0);
}

.btn--primary:focus {
  outline: none;
  box-shadow: 0 0 0 3px rgba(0,123,255,0.25);
}

/* 次要按钮 */
.btn--secondary {
  background-color: #6c757d;
  color: white;
}

.btn--secondary:hover {
  background-color: #5a6268;
}

/* 轮廓按钮 */
.btn--outline {
  background-color: transparent;
  color: #007bff;
  border: 2px solid #007bff;
  padding: 8px 18px;
}

.btn--outline:hover {
  background-color: #007bff;
  color: white;
}

/* 文本按钮 */
.btn--text {
  background-color: transparent;
  color: #007bff;
  padding: 10px 20px;
}

.btn--text:hover {
  background-color: rgba(0,123,255,0.1);
}

/* 渐变按钮 */
.btn--gradient {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.btn--gradient:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(102,126,234,0.4);
}

/* 禁用状态 */
.btn:disabled {
  background-color: #ccc;
  color: #666;
  cursor: not-allowed;
  opacity: 0.6;
  pointer-events: none;
  transform: none;
  box-shadow: none;
}

/* 尺寸变体 */
.btn--small {
  padding: 6px 12px;
  font-size: 14px;
}

.btn--large {
  padding: 14px 28px;
  font-size: 18px;
}

/* 加载状态 */
.btn--loading {
  position: relative;
  color: transparent;
  pointer-events: none;
}

.btn--loading::after {
  content: "";
  position: absolute;
  top: 50%;
  left: 50%;
  width: 16px;
  height: 16px;
  margin: -8px 0 0 -8px;
  border: 2px solid currentColor;
  border-top-color: transparent;
  border-radius: 50%;
  animation: spin 0.6s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}
```

### 按钮组

```html
<div class="btn-group">
  <button class="btn btn--primary">左</button>
  <button class="btn btn--primary">中</button>
  <button class="btn btn--primary">右</button>
</div>
```

```css
.btn-group {
  display: inline-flex;
}

.btn-group .btn {
  border-radius: 0;
  margin-left: -1px;
}

.btn-group .btn:first-child {
  border-top-left-radius: 4px;
  border-bottom-left-radius: 4px;
  margin-left: 0;
}

.btn-group .btn:last-child {
  border-top-right-radius: 4px;
  border-bottom-right-radius: 4px;
}

.btn-group .btn:hover {
  z-index: 1;
}
```

## 可访问性考虑

### 1. 键盘导航

确保按钮可以通过键盘访问：

```css
.button:focus {
  outline: 2px solid #007bff;
  outline-offset: 2px;
}
```

### 2. 触摸目标大小

移动设备上的按钮应该足够大：

```css
.button {
  min-width: 44px;
  min-height: 44px;
}
```

### 3. ARIA 标签

为图标按钮添加标签：

```html
<button aria-label="关闭">
  <span class="icon">×</span>
</button>
```

## 小结

按钮与交互元素的设计要点：

- **语义化**：使用正确的 HTML 元素
- **状态设计**：默认、悬停、激活、焦点、禁用
- **样式变体**：实心、轮廓、文本、渐变等
- **可复用性**：使用 CSS 变量和 BEM 命名
- **可访问性**：键盘导航、触摸目标、ARIA 标签

**关键原则**：
- 提供清晰的视觉反馈
- 保持一致的样式系统
- 考虑不同设备的使用场景
- 确保可访问性

掌握了按钮的实现，你就能创建专业的交互界面。在下一章，我们将学习表单样式的实现。
