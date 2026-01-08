---
sidebar_position: 8
sidebar_label: SVG 格式
slug: /svg
---

# SVG 格式（矢量图）

**SVG**（Scalable Vector Graphics，可缩放矢量图形）是 W3C 于 2001 年发布的 XML 格式矢量图像标准。通过路径、形状和滤镜的数学描述实现无损缩放，支持 CSS 动画和 JavaScript 交互，文件体积极小且兼容 Retina 屏幕，是现代 Web 图标和数据可视化的核心格式。



## 格式简介

SVG 是一种基于 XML 的矢量图像格式，用于描述二维图形。SVG 图像由数学定义的路径、形状和效果组成，可以无损缩放而不失真。SVG 是 W3C 标准，被所有现代浏览器支持。

SVG 文件扩展名为 `.svg`，MIME 类型为 `image/svg+xml`。SVG 格式是文本格式，可以直接在代码中嵌入或作为独立文件使用。



## 技术特点

### 核心特性

- **矢量图形**：基于数学描述，可无损缩放
- **XML 格式**：文本格式，人类可读
- **可交互**：支持 CSS 动画和 JavaScript
- **可搜索**：文本内容可以被搜索引擎索引
- **可访问**：支持屏幕阅读器

### 图形元素

SVG 支持多种图形元素：

- **基本形状**：矩形、圆形、椭圆、线条、多边形
- **路径**：复杂曲线和形状
- **文本**：可样式化的文本
- **图像**：嵌入位图图像
- **渐变和滤镜**：视觉效果

### SVG 版本

- **SVG 1.0**：2001 年发布
- **SVG 1.1**：2003 年发布（当前标准）
- **SVG 2.0**：2016 年发布（部分实现）



## 文件结构

SVG 文件是 XML 文档，基本结构：

```xml showLineNumbers
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg"
     width="100" height="100"
     viewBox="0 0 100 100">
  <!-- SVG 内容 -->
  <circle cx="50" cy="50" r="40" fill="blue"/>
  <rect x="10" y="10" width="80" height="80" fill="red" opacity="0.5"/>
</svg>
```

### 关键属性

- **xmlns**：SVG 命名空间
- **width/height**：画布尺寸
- **viewBox**：视图框（定义坐标系统）
- **preserveAspectRatio**：宽高比保持方式



## 使用场景

### 适用场景

- **Web 图标**：网站图标、Logo、UI 元素
- **数据可视化**：图表、图形、示意图
- **响应式设计**：需要适配不同屏幕的设计
- **动画效果**：CSS 或 JavaScript 动画
- **打印设计**：需要高分辨率输出的设计

### 优缺点

**优点：**

- 可无损缩放，适合任何分辨率
- 文件体积小（简单图形）
- 可编辑（文本格式）
- 支持交互和动画
- 广泛支持，所有现代浏览器都支持

**缺点：**

- 不适合复杂照片
- 某些复杂图形可能渲染较慢
- 需要浏览器支持
- 某些旧浏览器支持有限



## 代码示例

### 基本 SVG 示例

```xml showLineNumbers
<svg width="200" height="200" xmlns="http://www.w3.org/2000/svg">
  <!-- 圆形 -->
  <circle cx="100" cy="100" r="50" fill="blue"/>
  
  <!-- 矩形 -->
  <rect x="50" y="50" width="100" height="100" fill="red" opacity="0.5"/>
  
  <!-- 路径 -->
  <path d="M 10 10 L 50 50 L 10 50 Z" fill="green"/>
  
  <!-- 文本 -->
  <text x="100" y="150" text-anchor="middle" fill="black">Hello SVG</text>
</svg>
```

### Python 创建 SVG

```python showLineNumbers
from svgwrite import Drawing

# 创建 SVG 文档
dwg = Drawing('output.svg', size=('200', '200'))

# 添加图形
dwg.add(dwg.circle(center=(100, 100), r=50, fill='blue'))
dwg.add(dwg.rect(insert=(50, 50), size=(100, 100), fill='red', opacity=0.5))
dwg.add(dwg.text('Hello SVG', insert=(100, 150), text_anchor='middle'))

# 保存
dwg.save()
```

### JavaScript 操作 SVG

```javascript showLineNumbers
// 创建 SVG 元素
const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
svg.setAttribute('width', '200');
svg.setAttribute('height', '200');

// 添加圆形
const circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
circle.setAttribute('cx', '100');
circle.setAttribute('cy', '100');
circle.setAttribute('r', '50');
circle.setAttribute('fill', 'blue');
svg.appendChild(circle);

// 添加到页面
document.body.appendChild(svg);
```

### CSS 动画 SVG

```css showLineNumbers
/* SVG 动画 */
@keyframes rotate {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.circle {
  animation: rotate 2s linear infinite;
}
```

```xml showLineNumbers
<svg width="200" height="200">
  <circle class="circle" cx="100" cy="100" r="50" fill="blue"/>
</svg>
```



## 相关工具

- **编辑器**：
  - Inkscape：开源 SVG 编辑器
  - Adobe Illustrator：专业矢量图形编辑器
  - Figma：在线设计工具
- **在线工具**：
  - SVG-Edit：在线 SVG 编辑器
  - SVGOMG：SVG 优化工具
- **优化工具**：
  - SVGO：SVG 优化工具
  - svgcleaner：SVG 清理工具
- **编程库**：
  - Python: `svgwrite`、`cairosvg`
  - JavaScript: `Snap.svg`、`D3.js`、`Raphael.js`
  - Java: `Batik`



## 相关链接

- [SVG 标准 (W3C)](https://www.w3.org/TR/SVG11/)
- [SVG 教程 (MDN)](https://developer.mozilla.org/zh-CN/docs/Web/SVG)
- [SVG 参考](https://developer.mozilla.org/zh-CN/docs/Web/SVG/Element)



## 参考

- [SVG - Wikipedia](https://en.wikipedia.org/wiki/Scalable_Vector_Graphics)
- [SVG 1.1 规范](https://www.w3.org/TR/SVG11/)
- [SVG 教程](https://www.w3schools.com/graphics/svg_intro.asp)

