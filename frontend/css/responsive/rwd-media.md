---
sidebar_position: 4
slug: /rwd-media
---

# CSS 响应式图片与媒体

在响应式设计中，图片和其他媒体资源是最具挑战性的部分。如何在不同设备上提供合适大小的图片，既保证视觉效果，又兼顾性能和加载速度，是响应式设计的关键问题。

## 为什么图片在响应式中是难点

### 问题 1：尺寸不匹配

- **桌面端**：需要大尺寸、高分辨率图片
- **移动端**：小屏幕，不需要大图片
- **问题**：大图片在小屏幕上浪费带宽和加载时间

### 问题 2：像素密度差异

- **普通屏幕**：1x 像素密度
- **Retina 屏幕**：2x 或 3x 像素密度
- **问题**：需要提供不同分辨率的图片

### 问题 3：网络环境差异

- **桌面**：通常使用 WiFi，带宽充足
- **移动**：可能使用移动网络，带宽有限
- **问题**：需要优化图片大小，减少流量消耗

## CSS 控制图片尺寸的方式

### 1. 使用 max-width

最常用的响应式图片方法：

```css
img {
  max-width: 100%;
  height: auto;
}
```

**说明**：
- `max-width: 100%`：图片最大宽度不超过容器
- `height: auto`：高度自动调整，保持宽高比

### 2. 使用 width: 100%

```css
img {
  width: 100%;
  height: auto;
}
```

**注意**：`width: 100%` 会强制图片填满容器，可能在小容器中显示过大。

### 3. 使用 object-fit

控制图片在容器中的显示方式：

```css
img {
  width: 100%;
  height: 300px;
  object-fit: cover;    /* 覆盖整个容器，可能裁剪 */
  object-fit: contain;  /* 完整显示，可能留白 */
  object-fit: fill;     /* 拉伸填满 */
}
```

### 4. 使用 aspect-ratio

保持图片宽高比：

```css
img {
  width: 100%;
  aspect-ratio: 16 / 9;  /* 保持 16:9 宽高比 */
  object-fit: cover;
}
```

## 不同设备下的图片适配策略

### 策略 1：CSS 媒体查询

使用媒体查询加载不同尺寸的图片：

```css
.hero {
  background-image: url("hero-small.jpg");
  background-size: cover;
}

@media (min-width: 768px) {
  .hero {
    background-image: url("hero-medium.jpg");
  }
}

@media (min-width: 1200px) {
  .hero {
    background-image: url("hero-large.jpg");
  }
}
```

### 策略 2：HTML srcset 和 sizes

使用 HTML 的 `srcset` 和 `sizes` 属性：

```html
<img 
  src="image-small.jpg"
  srcset="
    image-small.jpg 400w,
    image-medium.jpg 800w,
    image-large.jpg 1200w
  "
  sizes="
    (max-width: 400px) 100vw,
    (max-width: 800px) 50vw,
    33vw
  "
  alt="描述"
>
```

**说明**：
- `srcset`：提供不同尺寸的图片
- `sizes`：告诉浏览器在不同屏幕下使用什么尺寸
- 浏览器会自动选择最合适的图片

### 策略 3：picture 元素

使用 `<picture>` 元素提供更灵活的控制：

```html
<picture>
  <source 
    media="(min-width: 1200px)" 
    srcset="image-large.jpg"
  >
  <source 
    media="(min-width: 768px)" 
    srcset="image-medium.jpg"
  >
  <img 
    src="image-small.jpg" 
    alt="描述"
  >
</picture>
```

### 策略 4：高分辨率屏幕适配

为 Retina 屏幕提供高分辨率图片：

```css
.logo {
  background-image: url("logo.png");
  background-size: 100px 100px;
}

@media (-webkit-min-device-pixel-ratio: 2),
       (min-resolution: 192dpi) {
  .logo {
    background-image: url("logo@2x.png");
    background-size: 100px 100px;
  }
}
```

或使用 `image-set()`：

```css
.logo {
  background-image: image-set(
    "logo.png" 1x,
    "logo@2x.png" 2x
  );
}
```

## 背景图片与响应式

### 基础响应式背景

```css
.hero {
  background-image: url("hero-small.jpg");
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
}

@media (min-width: 768px) {
  .hero {
    background-image: url("hero-medium.jpg");
  }
}

@media (min-width: 1200px) {
  .hero {
    background-image: url("hero-large.jpg");
  }
}
```

### 使用 background-size

```css
.hero {
  background-image: url("hero.jpg");
  background-size: cover;      /* 覆盖整个容器 */
  background-size: contain;     /* 完整显示 */
  background-size: 100% auto;   /* 宽度 100%，高度自适应 */
}
```

### 响应式背景位置

```css
.hero {
  background-position: center;
}

@media (min-width: 768px) {
  .hero {
    background-position: top right;
  }
}
```

## 视频等其他媒体的适配思路

### 响应式视频

```css
.video-container {
  position: relative;
  padding-bottom: 56.25%;  /* 16:9 宽高比 */
  height: 0;
  overflow: hidden;
}

.video-container iframe,
.video-container video {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}
```

### HTML5 video 响应式

```html
<video 
  width="100%" 
  height="auto"
  controls
>
  <source src="video.mp4" type="video/mp4">
  <source src="video.webm" type="video/webm">
  您的浏览器不支持视频播放。
</video>
```

```css
video {
  max-width: 100%;
  height: auto;
}
```

### 响应式嵌入内容

```css
.embed-container {
  position: relative;
  padding-bottom: 56.25%;  /* 16:9 */
  height: 0;
  overflow: hidden;
  max-width: 100%;
}

.embed-container iframe,
.embed-container object,
.embed-container embed {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}
```

## 性能与体验的平衡

### 1. 图片格式选择

选择合适的图片格式：

- **JPEG**：适合照片，文件小
- **PNG**：适合图标、透明图片
- **WebP**：现代格式，文件更小，支持透明
- **SVG**：矢量图，可缩放，文件小

```css
/* 使用 WebP（如果支持） */
.hero {
  background-image: url("hero.jpg");
}

@supports (background-image: url("hero.webp")) {
  .hero {
    background-image: url("hero.webp");
  }
}
```

### 2. 懒加载（Lazy Loading）

延迟加载图片，提升初始加载速度：

```html
<img 
  src="placeholder.jpg" 
  data-src="image.jpg" 
  loading="lazy"
  alt="描述"
>
```

```css
img[loading="lazy"] {
  opacity: 0;
  transition: opacity 0.3s;
}

img[loading="lazy"].loaded {
  opacity: 1;
}
```

### 3. 图片压缩

优化图片大小：

- 使用工具压缩图片
- 选择合适的质量
- 使用适当的尺寸

### 4. 占位符

使用占位符改善用户体验：

```css
.image-placeholder {
  background-color: #f0f0f0;
  background-image: 
    linear-gradient(45deg, #ccc 25%, transparent 25%),
    linear-gradient(-45deg, #ccc 25%, transparent 25%),
    linear-gradient(45deg, transparent 75%, #ccc 75%),
    linear-gradient(-45deg, transparent 75%, #ccc 75%);
  background-size: 20px 20px;
  background-position: 0 0, 0 10px, 10px -10px, -10px 0px;
}
```

## 实际示例

### 示例 1：响应式图片

```html
<img 
  class="responsive-image"
  src="image-small.jpg"
  srcset="
    image-small.jpg 400w,
    image-medium.jpg 800w,
    image-large.jpg 1200w
  "
  sizes="(max-width: 400px) 100vw, (max-width: 800px) 50vw, 33vw"
  alt="描述"
>
```

```css
.responsive-image {
  max-width: 100%;
  height: auto;
  display: block;
}
```

### 示例 2：响应式背景图片

```css
.hero {
  background-image: url("hero-small.jpg");
  background-size: cover;
  background-position: center;
  min-height: 300px;
}

@media (min-width: 768px) {
  .hero {
    background-image: url("hero-medium.jpg");
    min-height: 400px;
  }
}

@media (min-width: 1200px) {
  .hero {
    background-image: url("hero-large.jpg");
    min-height: 500px;
  }
}
```

### 示例 3：响应式视频

```html
<div class="video-wrapper">
  <iframe 
    src="https://www.youtube.com/embed/VIDEO_ID" 
    frameborder="0" 
    allowfullscreen
  ></iframe>
</div>
```

```css
.video-wrapper {
  position: relative;
  padding-bottom: 56.25%;  /* 16:9 */
  height: 0;
  overflow: hidden;
}

.video-wrapper iframe {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}
```

## 小结

响应式图片与媒体的处理要点：

- **CSS 控制**：`max-width`、`object-fit`、`aspect-ratio`
- **HTML 方案**：`srcset`、`sizes`、`<picture>`
- **背景图片**：媒体查询、`background-size`
- **视频媒体**：宽高比容器、响应式嵌入
- **性能优化**：格式选择、懒加载、压缩

**关键原则**：
- 提供合适尺寸的图片
- 考虑不同设备的需求
- 优化性能和体验
- 使用现代技术（WebP、懒加载）

掌握了响应式图片和媒体的处理，你就能创建真正高效的响应式网站。在接下来的章节中，我们将进入 CSS 实战部分，学习如何实现常见的 UI 组件。
