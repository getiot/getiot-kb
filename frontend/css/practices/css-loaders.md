---
sidebar_position: 6
slug: /css-loaders
---

# CSS 加载动画与反馈

加载动画是提升用户体验的重要元素。当页面或内容正在加载时，适当的加载反馈可以让用户知道系统正在工作，减少等待的焦虑感。本章将介绍如何创建各种类型的加载动画和反馈效果。

## 为什么需要加载反馈

### 用户体验问题

- **等待焦虑**：用户不知道系统是否在工作
- **不确定感**：不知道需要等待多久
- **误操作**：可能重复点击或刷新

### 加载反馈的作用

- **提供反馈**：告诉用户系统正在工作
- **减少焦虑**：让等待过程更可接受
- **引导注意力**：吸引用户关注加载区域
- **品牌展示**：展示品牌特色

## 常见加载动画类型

### 1. 旋转加载器（Spinner）

最常见的加载动画，一个旋转的圆圈。

### 2. 进度条（Progress Bar）

显示加载进度的条形动画。

### 3. 骨架屏（Skeleton Screen）

显示内容结构的占位符。

### 4. 脉冲动画（Pulse）

元素大小的脉冲变化。

### 5. 波浪动画（Wave）

波浪式的加载效果。

## 基于 CSS 动画的实现

### 1. 旋转加载器

```html
<div class="spinner"></div>
```

```css
.spinner {
  width: 40px;
  height: 40px;
  border: 4px solid #f3f3f3;
  border-top: 4px solid #007bff;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
```

### 2. 多色旋转加载器

```css
.spinner-multi {
  width: 40px;
  height: 40px;
  border: 4px solid transparent;
  border-top: 4px solid #007bff;
  border-right: 4px solid #28a745;
  border-bottom: 4px solid #ffc107;
  border-left: 4px solid #dc3545;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}
```

### 3. 点状加载器

```html
<div class="dots-loader">
  <span></span>
  <span></span>
  <span></span>
</div>
```

```css
.dots-loader {
  display: flex;
  gap: 8px;
  justify-content: center;
}

.dots-loader span {
  width: 12px;
  height: 12px;
  background-color: #007bff;
  border-radius: 50%;
  animation: bounce 1.4s ease-in-out infinite;
}

.dots-loader span:nth-child(1) {
  animation-delay: 0s;
}

.dots-loader span:nth-child(2) {
  animation-delay: 0.2s;
}

.dots-loader span:nth-child(3) {
  animation-delay: 0.4s;
}

@keyframes bounce {
  0%, 80%, 100% {
    transform: scale(0);
    opacity: 0.5;
  }
  40% {
    transform: scale(1);
    opacity: 1;
  }
}
```

### 4. 进度条

```html
<div class="progress-bar">
  <div class="progress-fill"></div>
</div>
```

```css
.progress-bar {
  width: 100%;
  height: 8px;
  background-color: #f0f0f0;
  border-radius: 4px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background-color: #007bff;
  border-radius: 4px;
  animation: progress 2s ease-in-out infinite;
}

@keyframes progress {
  0% {
    width: 0%;
  }
  50% {
    width: 70%;
  }
  100% {
    width: 100%;
  }
}
```

### 5. 骨架屏

```html
<div class="skeleton">
  <div class="skeleton-avatar"></div>
  <div class="skeleton-content">
    <div class="skeleton-line"></div>
    <div class="skeleton-line"></div>
    <div class="skeleton-line short"></div>
  </div>
</div>
```

```css
.skeleton {
  display: flex;
  gap: 15px;
  padding: 20px;
}

.skeleton-avatar {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 200% 100%;
  animation: loading 1.5s ease-in-out infinite;
}

.skeleton-line {
  height: 12px;
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 200% 100%;
  animation: loading 1.5s ease-in-out infinite;
  margin-bottom: 10px;
  border-radius: 4px;
}

.skeleton-line.short {
  width: 60%;
}

@keyframes loading {
  0% {
    background-position: 200% 0;
  }
  100% {
    background-position: -200% 0;
  }
}
```

### 6. 脉冲动画

```css
.pulse {
  width: 50px;
  height: 50px;
  background-color: #007bff;
  border-radius: 50%;
  animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% {
    transform: scale(1);
    opacity: 1;
  }
  50% {
    transform: scale(1.2);
    opacity: 0.7;
  }
}
```

## 性能与体验考虑

### 1. 性能优化

使用 `transform` 和 `opacity` 进行动画，性能更好：

```css
/* 推荐：性能好 */
.spinner {
  animation: spin 1s linear infinite;
  will-change: transform;
}

/* 不推荐：可能影响性能 */
.spinner {
  animation: spin 1s linear infinite;
  /* 避免改变 width、height 等属性 */
}
```

### 2. 减少动画

尊重用户的偏好设置：

```css
@media (prefers-reduced-motion: reduce) {
  .spinner,
  .progress-bar,
  .skeleton {
    animation: none;
  }
}
```

### 3. 适当的尺寸

加载器不应该太大或太小：

```css
.spinner {
  width: 40px;  /* 合适的尺寸 */
  height: 40px;
}
```

### 4. 颜色选择

使用品牌色或中性色：

```css
.spinner {
  border-top-color: #007bff;  /* 品牌色 */
}
```

## 示例实现

### 完整示例：页面加载器

```html
<div class="page-loader">
  <div class="loader">
    <div class="loader-spinner"></div>
    <p class="loader-text">加载中...</p>
  </div>
</div>
```

```css
.page-loader {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(255,255,255,0.9);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 9999;
}

.loader {
  text-align: center;
}

.loader-spinner {
  width: 50px;
  height: 50px;
  border: 4px solid #f3f3f3;
  border-top: 4px solid #007bff;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin: 0 auto 20px;
}

.loader-text {
  color: #666;
  font-size: 14px;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
```

### 按钮加载状态

```html
<button class="btn btn--loading">
  <span class="btn-spinner"></span>
  提交中...
</button>
```

```css
.btn--loading {
  position: relative;
  color: transparent;
  pointer-events: none;
}

.btn-spinner {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 20px;
  height: 20px;
  margin: -10px 0 0 -10px;
  border: 2px solid rgba(255,255,255,0.3);
  border-top-color: white;
  border-radius: 50%;
  animation: spin 0.6s linear infinite;
}
```

## 小结

加载动画与反馈的实现要点：

- **动画类型**：旋转、进度条、骨架屏、脉冲等
- **CSS 动画**：使用 `@keyframes` 和 `animation`
- **性能优化**：使用 `transform` 和 `opacity`
- **用户体验**：适当的尺寸、颜色、减少动画选项
- **应用场景**：页面加载、按钮状态、内容加载

**关键原则**：
- 提供清晰的视觉反馈
- 优化动画性能
- 尊重用户偏好
- 保持简洁美观

掌握了加载动画的实现，你就能创建更好的用户体验。在下一章，我们将学习工具提示的实现。
