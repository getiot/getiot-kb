---
sidebar_position: 7
slug: /css-animations
---

# CSS 动画

CSS 动画（Animation）允许你在浏览器中创建丰富的逐帧动画效果，无需 JavaScript。通过定义关键帧和动画属性，你可以让元素平滑地改变样式，提升交互体验。

## 为什么需要这个特性

1. **丰富动效**：实现逐帧动画、复杂的状态变化  
2. **性能更好**：浏览器优化，通常由 GPU 加速  
3. **易于维护**：纯 CSS 描述动画逻辑，结构清晰  
4. **减少 JS 依赖**：简单动效无需 JS，降低复杂度  
5. **可复用**：关键帧可在多个元素间复用

## 核心概念解释

### @keyframes
定义动画的关键帧（状态和时间节点）。
```css
@keyframes fade-in {
  0%   { opacity: 0; }
  100% { opacity: 1; }
}
```

### animation 属性族
控制动画的播放方式，可分别设置或使用简写。
```css
animation-name: fade-in;        /* 关键帧名称 */
animation-duration: 0.8s;       /* 持续时间 */
animation-timing-function: ease; /* 时间函数 */
animation-delay: 0s;            /* 延迟 */
animation-iteration-count: 1;   /* 次数，或 infinite */
animation-direction: normal;    /* normal | reverse | alternate | alternate-reverse */
animation-fill-mode: none;      /* none | forwards | backwards | both */
animation-play-state: running;  /* running | paused */
```

### animation（简写）
```css
.fade {
  animation: fade-in 0.8s ease 0s 1 normal forwards;
  /* name duration timing delay iteration direction fill */
}
```

## 常见用法

### 1. 淡入淡出
```css
@keyframes fade-in {
  from { opacity: 0; }
  to   { opacity: 1; }
}
.fade-in {
  animation: fade-in 0.6s ease forwards;
}
```

### 2. 位移动画
```css
@keyframes slide-up {
  from { transform: translateY(20px); opacity: 0; }
  to   { transform: translateY(0);    opacity: 1; }
}
.slide-up {
  animation: slide-up 0.5s ease-out forwards;
}
```

### 3. 循环动画（加载指示）
```css
@keyframes spin {
  to { transform: rotate(360deg); }
}
.spinner {
  width: 40px; height: 40px;
  border: 4px solid #eee;
  border-top-color: #3498db;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}
```

### 4. 交错动画
```css
.item {
  opacity: 0;
  animation: slide-up 0.5s ease forwards;
}
.item:nth-child(1) { animation-delay: 0.0s; }
.item:nth-child(2) { animation-delay: 0.1s; }
.item:nth-child(3) { animation-delay: 0.2s; }
```

### 5. 组合动画
```css
.pulse {
  animation: fade-in 0.4s ease forwards,
             scale-up 1.2s ease-in-out infinite alternate;
}
```

## 示例

### 示例 1：卡片进入动画
```css
@keyframes card-in {
  0%   { transform: translateY(20px); opacity: 0; }
  100% { transform: translateY(0);    opacity: 1; }
}
.card {
  animation: card-in 0.6s ease forwards;
}
```

### 示例 2：按钮点击波纹（简化版）
```css
@keyframes ripple {
  from { transform: scale(0); opacity: 0.6; }
  to   { transform: scale(4); opacity: 0; }
}
.btn {
  position: relative;
  overflow: hidden;
}
.btn::after {
  content: \"\";
  position: absolute;
  top: 50%; left: 50%;
  width: 10px; height: 10px;
  background: rgba(255,255,255,0.6);
  border-radius: 50%;
  transform: translate(-50%, -50%) scale(0);
  animation: ripple 0.6s ease-out;
}
```

### 示例 3：数字跳动
```css
@keyframes bounce {
  0%, 100% { transform: translateY(0); }
  50%      { transform: translateY(-10px); }
}
.badge {
  animation: bounce 1s ease-in-out infinite;
}
```

## 注意事项

1. **性能优先**：优先动画 `transform`、`opacity`，避免频繁动画布局属性（如 width/height）。  
2. **填充模式**：需要保持动画结束状态时使用 `forwards` 或 `both`。  
3. **可访问性**：尊重用户“减少动态效果”偏好：  
```css
@media (prefers-reduced-motion: reduce) {
  * { animation: none !important; transition: none !important; }
}
```  
4. **过渡 vs 动画**：过渡用于“状态切换”，动画用于“自主播放”。  
5. **避免滥用**：动画过多会分散注意力，控制数量和时长。  
6. **多动画顺序**：多个动画按声明顺序同时播放，可通过 `animation-delay` 交错。  
7. **浏览器支持**：现代浏览器普遍支持，旧环境注意前缀或降级方案。

掌握 CSS 动画，你就能在无需 JS 的情况下制作丰富的动效。结合过渡、变换和关键帧，可以构建专业的交互体验。 
