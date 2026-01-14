---
sidebar_position: 3
slug: /css-units-functions
---

# CSS 单位与函数参考

CSS 中的单位和函数在不同场景下有着截然不同的表现和适用性。本文集中整理了常见长度单位、相对单位、时间单位，以及常用 CSS 函数。

## 长度单位

### 绝对单位

| 单位 | 说明 | 示例 | 适用场景 |
|------|------|------|----------|
| `px` | 像素 | `16px` | 精确控制，固定尺寸 |
| `pt` | 点 | `12pt` | 打印媒体 |
| `in` | 英寸 | `1in` | 打印媒体 |
| `cm` | 厘米 | `2.54cm` | 打印媒体 |
| `mm` | 毫米 | `10mm` | 打印媒体 |

### 相对单位

| 单位 | 说明 | 示例 | 适用场景 |
|------|------|------|----------|
| `%` | 百分比 | `50%` | 相对于父元素 |
| `em` | 相对字体大小 | `1.5em` | 相对于当前元素字体 |
| `rem` | 根字体大小 | `1.5rem` | 相对于根元素字体 |
| `vw` | 视口宽度 | `50vw` | 响应式宽度 |
| `vh` | 视口高度 | `100vh` | 全屏高度 |
| `vmin` | 视口较小值 | `50vmin` | 响应式设计 |
| `vmax` | 视口较大值 | `50vmax` | 响应式设计 |
| `ch` | 字符宽度 | `80ch` | 文本宽度 |
| `ex` | 字符高度 | `2ex` | 排版 |

## 角度单位

| 单位 | 说明 | 示例 | 换算 |
|------|------|------|------|
| `deg` | 度 | `45deg` | 360deg = 1圈 |
| `rad` | 弧度 | `1.57rad` | 2π rad = 1圈 |
| `grad` | 梯度 | `100grad` | 400grad = 1圈 |
| `turn` | 转 | `0.25turn` | 1turn = 1圈 |

## 时间单位

| 单位 | 说明 | 示例 | 换算 |
|------|------|------|------|
| `s` | 秒 | `0.3s` | 1s = 1000ms |
| `ms` | 毫秒 | `300ms` | 1000ms = 1s |

## CSS 函数

### 数学函数

| 函数 | 语法 | 示例 | 说明 |
|------|------|------|------|
| `calc()` | `calc(expression)` | `calc(100% - 40px)` | 数学计算 |
| `min()` | `min(value1, value2)` | `min(100%, 1200px)` | 取最小值 |
| `max()` | `max(value1, value2)` | `max(300px, 50%)` | 取最大值 |
| `clamp()` | `clamp(min, val, max)` | `clamp(14px, 4vw, 24px)` | 限制范围 |

### 颜色函数

| 函数 | 语法 | 示例 | 说明 |
|------|------|------|------|
| `rgb()` | `rgb(r, g, b)` | `rgb(255, 0, 0)` | RGB 颜色 |
| `rgba()` | `rgba(r, g, b, a)` | `rgba(255, 0, 0, 0.5)` | 带透明度 |
| `hsl()` | `hsl(h, s%, l%)` | `hsl(0, 100%, 50%)` | HSL 颜色 |
| `hsla()` | `hsla(h, s%, l%, a)` | `hsla(0, 100%, 50%, 0.5)` | 带透明度 |
| `color-mix()` | `color-mix(mode, c1, c2)` | `color-mix(in srgb, blue 50%, white)` | 混合颜色 |

### 渐变函数

| 函数 | 语法 | 示例 | 说明 |
|------|------|------|------|
| `linear-gradient()` | `linear-gradient(direction, colors)` | `linear-gradient(to right, red, blue)` | 线性渐变 |
| `radial-gradient()` | `radial-gradient(shape, colors)` | `radial-gradient(circle, red, blue)` | 径向渐变 |
| `conic-gradient()` | `conic-gradient(colors)` | `conic-gradient(red, blue)` | 圆锥渐变 |

### 变换函数

| 函数 | 语法 | 示例 | 说明 |
|------|------|------|------|
| `translate()` | `translate(x, y)` | `translate(50px, 100px)` | 移动 |
| `translateX()` | `translateX(x)` | `translateX(50px)` | 水平移动 |
| `translateY()` | `translateY(y)` | `translateY(100px)` | 垂直移动 |
| `scale()` | `scale(x, y)` | `scale(1.5)` | 缩放 |
| `rotate()` | `rotate(angle)` | `rotate(45deg)` | 旋转 |
| `skew()` | `skew(x, y)` | `skew(10deg, 5deg)` | 倾斜 |

### 其他函数

| 函数 | 语法 | 示例 | 说明 |
|------|------|------|------|
| `var()` | `var(--variable)` | `var(--primary-color)` | CSS 变量 |
| `url()` | `url(path)` | `url("image.jpg")` | 资源路径 |
| `attr()` | `attr(attribute)` | `attr(data-label)` | 属性值 |
| `counter()` | `counter(name)` | `counter(list-item)` | 计数器 |

## 单位选择建议

### 响应式设计

- **宽度**：`%`, `vw`, `calc()`
- **字体大小**：`rem`, `clamp()`
- **间距**：`rem`, `em`
- **固定尺寸**：`px`

### 布局

- **容器宽度**：`%`, `max-width: px`
- **高度**：`vh`, `%`, `auto`
- **间距**：`rem`, `gap`

### 动画

- **时间**：`s`, `ms`
- **角度**：`deg`
- **变换**：使用 `transform` 函数

## 函数使用建议

### calc() 使用

```css
/* 运算符前后必须有空格 */
width: calc(100% - 40px);  /* ✅ 正确 */
width: calc(100%-40px);    /* ❌ 错误 */
```

### clamp() 使用

```css
/* 响应式字体 */
font-size: clamp(14px, 4vw, 24px);
/* 最小值 14px，理想值 4vw，最大值 24px */
```

### var() 使用

```css
/* 定义变量 */
:root {
  --primary-color: #007bff;
}

/* 使用变量 */
.button {
  background-color: var(--primary-color, blue);
  /* 第二个参数是默认值 */
}
```

## 小结

CSS 单位与函数的选择要点：

- **绝对单位**：固定尺寸，精确控制
- **相对单位**：响应式设计，灵活适配
- **数学函数**：动态计算，响应式布局
- **颜色函数**：颜色处理，渐变效果
- **变换函数**：元素变换，动画效果

**关键建议**：
- 响应式设计优先使用相对单位
- 字体大小使用 `rem` 或 `clamp()`
- 布局使用 `%`、`vw`、`calc()`
- 动画使用 `transform` 函数

这份参考帮助你理解不同单位和函数的适用场景，实际使用时请根据具体需求选择。
