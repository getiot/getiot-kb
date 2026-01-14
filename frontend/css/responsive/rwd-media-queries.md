---
sidebar_position: 2
sidebar_label: CSS 视口与媒体查询
slug: /rwd-media-queries
---

# CSS 视口与媒体查询（@media）

媒体查询是响应式设计的核心技术，它允许你根据设备的特性（如屏幕宽度、分辨率、方向等）应用不同的 CSS 样式。理解视口和媒体查询，是掌握响应式设计的关键。

## 什么是视口（Viewport）

视口（Viewport）是用户可见的网页区域。在不同设备上，视口的大小和行为是不同的。

### 桌面视口

在桌面浏览器中：
- 视口大小 = 浏览器窗口大小
- 用户可以调整窗口大小
- 视口可以小于屏幕分辨率

### 移动视口

在移动设备上：
- 有两个视口概念：**视觉视口**和**布局视口**
- 视觉视口：用户当前看到的区域
- 布局视口：浏览器用于布局的虚拟视口（通常比屏幕大）

## 视觉视口与布局视口

### 视觉视口（Visual Viewport）

视觉视口是用户当前看到的网页区域，会随着用户缩放而改变。

### 布局视口（Layout Viewport）

布局视口是浏览器用于布局的虚拟视口，通常是 980px 或设备宽度（取较大值）。

### 问题与解决

在移动设备上，如果不设置视口 meta 标签，浏览器会使用默认的布局视口（通常是 980px），导致页面显示很小，用户需要缩放才能看清。

**解决方案**：设置视口 meta 标签

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

## 视口相关 meta 标签说明

### viewport meta 标签

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

**属性说明**：

- `width=device-width`：设置布局视口宽度为设备宽度
- `initial-scale=1.0`：设置初始缩放比例为 1.0（不缩放）
- `maximum-scale=1.0`：设置最大缩放比例（可选）
- `user-scalable=no`：禁止用户缩放（不推荐，影响可访问性）

### 推荐配置

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
```

**最佳实践**：
- 允许用户缩放（可访问性要求）
- 设置合理的最大缩放比例
- 不要禁用缩放功能

## 媒体查询的基本语法

### 基本语法

```css
@media media-type and (media-feature) {
  /* CSS 规则 */
}
```

### 媒体类型（Media Type）

```css
@media screen { }      /* 屏幕设备 */
@media print { }       /* 打印设备 */
@media all { }         /* 所有设备（默认） */
```

### 媒体特性（Media Feature）

```css
@media (min-width: 768px) { }  /* 最小宽度 */
@media (max-width: 1024px) { } /* 最大宽度 */
@media (orientation: portrait) { } /* 竖屏 */
@media (orientation: landscape) { } /* 横屏 */
```

### 组合使用

```css
/* 使用 and 连接多个条件 */
@media screen and (min-width: 768px) and (max-width: 1024px) {
  /* 屏幕设备，宽度在 768px 到 1024px 之间 */
}

/* 使用逗号连接多个查询（或的关系） */
@media (max-width: 768px), (orientation: portrait) {
  /* 宽度小于 768px 或竖屏 */
}

/* 使用 not 否定 */
@media not screen {
  /* 非屏幕设备 */
}

/* 使用 only（用于旧浏览器兼容） */
@media only screen and (min-width: 768px) {
  /* 仅屏幕设备 */
}
```

## 常见媒体特性

### 宽度和高度

#### min-width / max-width

```css
/* 最小宽度 768px（平板及以上） */
@media (min-width: 768px) {
  .container {
    width: 750px;
  }
}

/* 最大宽度 767px（手机） */
@media (max-width: 767px) {
  .container {
    width: 100%;
  }
}

/* 宽度范围 */
@media (min-width: 768px) and (max-width: 1024px) {
  .container {
    width: 960px;
  }
}
```

#### min-height / max-height

```css
/* 最小高度 */
@media (min-height: 600px) {
  .sidebar {
    position: sticky;
    top: 0;
  }
}
```

### 设备方向

#### orientation

```css
/* 竖屏 */
@media (orientation: portrait) {
  .layout {
    flex-direction: column;
  }
}

/* 横屏 */
@media (orientation: landscape) {
  .layout {
    flex-direction: row;
  }
}
```

### 分辨率

#### resolution

```css
/* 高分辨率屏幕 */
@media (min-resolution: 2dppx) {
  .logo {
    background-image: url("logo@2x.png");
  }
}

/* 使用 dpi */
@media (min-resolution: 192dpi) {
  .logo {
    background-image: url("logo@2x.png");
  }
}
```

### 其他媒体特性

#### aspect-ratio

```css
/* 宽高比 */
@media (min-aspect-ratio: 16/9) {
  .video {
    width: 100%;
  }
}
```

#### prefers-color-scheme

```css
/* 暗色模式 */
@media (prefers-color-scheme: dark) {
  body {
    background-color: #1a1a1a;
    color: #fff;
  }
}

/* 亮色模式 */
@media (prefers-color-scheme: light) {
  body {
    background-color: #fff;
    color: #333;
  }
}
```

#### prefers-reduced-motion

```css
/* 减少动画（可访问性） */
@media (prefers-reduced-motion: reduce) {
  * {
    animation: none !important;
    transition: none !important;
  }
}
```

## 媒体查询的组织方式

### 方式 1：在 CSS 文件中分散组织

```css
/* styles.css */
.button {
  padding: 10px;
}

@media (min-width: 768px) {
  .button {
    padding: 12px 24px;
  }
}

.card {
  width: 100%;
}

@media (min-width: 768px) {
  .card {
    width: 50%;
  }
}
```

**优点**：相关代码在一起，易于维护
**缺点**：媒体查询分散，难以统一管理

### 方式 2：在文件末尾集中组织

```css
/* styles.css */
.button {
  padding: 10px;
}

.card {
  width: 100%;
}

/* 媒体查询集中在一起 */
@media (min-width: 768px) {
  .button {
    padding: 12px 24px;
  }
  
  .card {
    width: 50%;
  }
}
```

**优点**：媒体查询集中，易于管理
**缺点**：相关代码分离，查找不便

### 方式 3：使用 CSS 变量

```css
:root {
  --container-width: 100%;
  --font-size-base: 16px;
}

@media (min-width: 768px) {
  :root {
    --container-width: 750px;
    --font-size-base: 18px;
  }
}

.container {
  width: var(--container-width);
  font-size: var(--font-size-base);
}
```

**优点**：集中管理，易于维护
**缺点**：需要理解 CSS 变量

## 常见断点（Breakpoints）

### 标准断点

虽然断点应该根据内容决定，但有一些常用的标准断点：

```css
/* 手机（小屏幕） */
@media (max-width: 575px) { }

/* 手机（大屏幕）和平板（小屏幕） */
@media (min-width: 576px) and (max-width: 767px) { }

/* 平板 */
@media (min-width: 768px) and (max-width: 991px) { }

/* 桌面（小） */
@media (min-width: 992px) and (max-width: 1199px) { }

/* 桌面（大） */
@media (min-width: 1200px) { }
```

### 移动优先的断点

```css
/* 基础样式（移动设备） */
.container {
  width: 100%;
}

/* 平板 */
@media (min-width: 768px) {
  .container {
    width: 750px;
  }
}

/* 桌面 */
@media (min-width: 1200px) {
  .container {
    width: 1200px;
  }
}
```

## 常见误区与调试建议

### 误区 1：过度使用媒体查询

```css
/* 不推荐：为每个小变化都写媒体查询 */
@media (min-width: 320px) { }
@media (min-width: 360px) { }
@media (min-width: 375px) { }
@media (min-width: 414px) { }

/* 推荐：使用弹性单位，减少媒体查询 */
.container {
  width: 100%;
  max-width: 1200px;
  padding: clamp(10px, 2vw, 20px);
}
```

### 误区 2：固定断点

断点应该根据内容决定，而不是固定的设备尺寸：

```css
/* 不推荐：固定断点 */
@media (min-width: 768px) { }

/* 推荐：根据内容决定 */
/* 当内容需要换行时，调整布局 */
.card {
  width: 100%;
}

@media (min-width: 600px) {  /* 根据卡片宽度决定 */
  .card {
    width: calc(50% - 20px);
  }
}
```

### 误区 3：忽略方向变化

考虑设备方向的变化：

```css
/* 推荐：考虑方向 */
@media (orientation: landscape) {
  .sidebar {
    width: 300px;
  }
}
```

### 调试建议

1. **使用浏览器开发者工具**：
   - Chrome DevTools 的设备模拟器
   - 响应式设计模式
   - 调整视口大小测试

2. **测试真实设备**：
   - 在不同设备上测试
   - 测试不同浏览器
   - 测试不同方向

3. **使用断点调试**：
   ```css
   /* 临时添加边框，查看断点是否生效 */
   @media (min-width: 768px) {
     body {
       border: 2px solid red;  /* 调试用 */
     }
   }
   ```

## 实际示例

### 示例 1：响应式导航

```html
<nav class="navbar">
  <div class="logo">Logo</div>
  <ul class="nav-menu">
    <li><a href="#">首页</a></li>
    <li><a href="#">关于</a></li>
    <li><a href="#">服务</a></li>
  </ul>
  <button class="menu-toggle">菜单</button>
</nav>
```

```css
/* 移动优先：基础样式 */
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
}

.nav-menu {
  display: none;  /* 默认隐藏 */
  list-style: none;
  gap: 20px;
}

.menu-toggle {
  display: block;  /* 显示菜单按钮 */
}

/* 平板及以上：显示菜单 */
@media (min-width: 768px) {
  .nav-menu {
    display: flex;
  }
  
  .menu-toggle {
    display: none;  /* 隐藏菜单按钮 */
  }
}
```

### 示例 2：响应式网格

```css
/* 移动优先 */
.grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 20px;
}

/* 平板：2 列 */
@media (min-width: 768px) {
  .grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

/* 桌面：3 列 */
@media (min-width: 1200px) {
  .grid {
    grid-template-columns: repeat(3, 1fr);
  }
}
```

### 示例 3：响应式字体

```css
/* 移动优先 */
h1 {
  font-size: 24px;
}

/* 平板 */
@media (min-width: 768px) {
  h1 {
    font-size: 32px;
  }
}

/* 桌面 */
@media (min-width: 1200px) {
  h1 {
    font-size: 48px;
  }
}

/* 或使用 clamp */
h1 {
  font-size: clamp(24px, 5vw, 48px);
}
```

## 小结

媒体查询是响应式设计的核心技术：

- **视口**：理解视觉视口和布局视口
- **meta 标签**：设置正确的视口配置
- **基本语法**：`@media media-type and (media-feature)`
- **常见特性**：宽度、高度、方向、分辨率等
- **组织方式**：分散、集中或使用变量
- **断点设计**：根据内容决定，移动优先

**调试建议**：
- 使用开发者工具
- 测试真实设备
- 避免过度使用媒体查询
- 根据内容决定断点

掌握了媒体查询，你就能创建真正的响应式设计。在下一章，我们将学习响应式布局的实践技巧。
