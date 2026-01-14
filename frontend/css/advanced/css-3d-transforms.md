---
sidebar_position: 6
slug: /css-3d-transforms
---

# CSS 3D 变换

3D 变换让元素可以在三维空间中进行移动、旋转和缩放，创造更具沉浸感的视觉效果。它是高级交互和动效的基础，常用于翻转卡片、立体动画等场景。

## 为什么需要这个特性

1. **立体效果**：在三维空间中旋转、移动元素，营造立体感  
2. **高级动效**：实现翻转、旋转、透视等复杂动画  
3. **不影响布局**：与 2D 变换一样，不会影响文档流  
4. **性能优势**：GPU 加速，动画更流畅  
5. **沉浸交互**：提升界面质感和用户体验

## 核心概念解释

### transform
使用 `transform` 应用 3D 变换，可组合多个函数。

### transform-style
控制子元素是否保留 3D 空间。
```css
transform-style: flat;      /* 默认，不保留 3D */
transform-style: preserve-3d; /* 保留 3D（需要设置在父元素上） */
```

### perspective（透视）
设置观察距离，数值越小，透视越强。可作用在父元素或 transform 函数中。
```css
.scene { perspective: 800px; }
.item { transform: perspective(800px) rotateY(45deg); }
```

### perspective-origin
设置视角原点（观察点），影响透视方向。
```css
.scene {
  perspective: 800px;
  perspective-origin: 50% 50%; /* 默认居中 */
  /* 也可用 top/left/像素值/百分比 */
}
```

### backface-visibility
控制元素背面是否可见。
```css
backface-visibility: visible;   /* 可见（默认） */
backface-visibility: hidden;    /* 隐藏背面 */
```

## 常见 3D 变换函数

### 1. translate3d / translateZ
在三维空间中移动元素。
```css
.box {
  transform: translate3d(50px, 20px, 100px);
  /* 或单独使用 */
  transform: translateZ(120px);
}
```

### 2. scale3d / scaleZ
在三维空间中缩放元素。
```css
.box {
  transform: scale3d(1.2, 1.2, 1.2);
  transform: scaleZ(1.5);
}
```

### 3. rotate3d / rotateX / rotateY / rotateZ
围绕三维坐标轴旋转元素。
```css
.box {
  transform: rotateX(45deg); /* 围绕 X 轴 */
  transform: rotateY(60deg); /* 围绕 Y 轴 */
  transform: rotateZ(30deg); /* 围绕 Z 轴（等同 2D rotate） */
  transform: rotate3d(1, 1, 0, 45deg); /* 自定义轴 */
}
```

### 4. matrix3d
使用 4x4 矩阵进行复杂 3D 变换（较少手写）。

## 常见组合用法

### 1. 透视 + 旋转
```css
.scene {
  perspective: 800px;
}
.card {
  transform: rotateY(30deg);
  transform-style: preserve-3d;
}
```

### 2. 3D 翻转卡片
```css
.flip-card {
  width: 300px;
  height: 200px;
  perspective: 1000px;
}
.flip-card-inner {
  position: relative;
  width: 100%;
  height: 100%;
  transform-style: preserve-3d;
  transition: transform 0.6s;
}
.flip-card:hover .flip-card-inner {
  transform: rotateY(180deg);
}
.flip-card-front,
.flip-card-back {
  position: absolute;
  width: 100%;
  height: 100%;
  backface-visibility: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 12px;
  overflow: hidden;
}
.flip-card-back {
  transform: rotateY(180deg);
}
```

### 3. 3D 轮播切换
```css
.carousel {
  perspective: 1200px;
}
.slide {
  transform: translateZ(0) rotateY(-30deg);
  transition: transform 0.5s;
}
.slide.active {
  transform: translateZ(120px) rotateY(0deg);
}
```

## 示例

### 示例 1：立体卡片悬停
```css
.card {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.15);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  transform-style: preserve-3d;
}
.card:hover {
  transform: perspective(800px) rotateX(6deg) rotateY(-6deg) translateZ(10px);
  box-shadow: 0 20px 40px rgba(0,0,0,0.2);
}
```

### 示例 2：3D 菜单展开
```css
.menu {
  perspective: 800px;
}
.menu-item {
  transform: rotateX(-90deg);
  transform-origin: top;
  transition: transform 0.4s ease;
}
.menu.open .menu-item {
  transform: rotateX(0deg);
}
```

### 示例 3：3D 立方体（简化示例）
```css
.scene { perspective: 800px; }
.cube {
  position: relative;
  width: 200px;
  height: 200px;
  transform-style: preserve-3d;
  animation: spin 6s infinite linear;
}
.cube__face {
  position: absolute;
  width: 200px;
  height: 200px;
  backface-visibility: hidden;
}
.cube__face--front  { transform: rotateY(  0deg) translateZ(100px); }
.cube__face--back   { transform: rotateY(180deg) translateZ(100px); }
.cube__face--right  { transform: rotateY( 90deg) translateZ(100px); }
.cube__face--left   { transform: rotateY(-90deg) translateZ(100px); }
.cube__face--top    { transform: rotateX( 90deg) translateZ(100px); }
.cube__face--bottom { transform: rotateX(-90deg) translateZ(100px); }

@keyframes spin {
  from { transform: rotateX(0deg) rotateY(0deg); }
  to   { transform: rotateX(360deg) rotateY(360deg); }
}
```

## 注意事项

1. **添加透视**：没有透视，3D 效果会显得“平”。在父元素设置 `perspective`，或在 transform 中使用 `perspective()`。  
2. **保留 3D**：子元素需要 `transform-style: preserve-3d` 才能在 3D 空间中显示。  
3. **隐藏背面**：翻转类效果时常用 `backface-visibility: hidden;`，避免背面闪烁。  
4. **性能优化**：过渡/动画时优先使用 `transform` 和 `opacity`，避免频繁修改布局。  
5. **变换顺序**：多个变换按从左到右顺序执行，顺序不同效果不同。  
6. **透视单位**：`perspective` 接受长度单位，数值越小透视越强；通常 600px~1200px 之间效果较自然。  
7. **降级方案**：旧浏览器可能不支持 3D 变换，应确保基本功能不依赖 3D。

掌握 3D 变换，你就能在三维空间中自由地移动和旋转元素，为页面带来立体化的动效体验。接下来可以结合过渡和动画，实现更丰富的 3D 互动。
