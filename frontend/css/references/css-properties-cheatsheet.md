---
sidebar_position: 1
slug: /css-properties-cheatsheet
---

# CSS 属性速查表

CSS 属性数量众多，且分布在不同的功能领域中。本文以"分类速查"的方式整理常用 CSS 属性，帮助你在实际开发中快速找到合适的属性。

## 文本与字体

| 属性 | 说明 | 常用值 |
|------|------|--------|
| `color` | 文本颜色 | `#333`, `rgb()`, `hsl()` |
| `font-family` | 字体族 | `Arial`, `"Helvetica Neue"` |
| `font-size` | 字体大小 | `16px`, `1rem`, `1em` |
| `font-weight` | 字体粗细 | `normal`, `bold`, `100-900` |
| `font-style` | 字体样式 | `normal`, `italic` |
| `line-height` | 行高 | `1.5`, `24px`, `150%` |
| `text-align` | 文本对齐 | `left`, `center`, `right`, `justify` |
| `text-decoration` | 文本装饰 | `none`, `underline`, `line-through` |
| `text-transform` | 文本转换 | `none`, `uppercase`, `lowercase` |
| `text-indent` | 首行缩进 | `2em`, `20px` |
| `letter-spacing` | 字符间距 | `normal`, `2px` |
| `word-spacing` | 单词间距 | `normal`, `5px` |
| `white-space` | 空白处理 | `normal`, `nowrap`, `pre` |
| `text-overflow` | 文本溢出 | `clip`, `ellipsis` |

## 背景与边框

| 属性 | 说明 | 常用值 |
|------|------|--------|
| `background-color` | 背景颜色 | `#fff`, `transparent` |
| `background-image` | 背景图片 | `url()`, `linear-gradient()` |
| `background-position` | 背景位置 | `center`, `top left`, `50% 50%` |
| `background-size` | 背景大小 | `cover`, `contain`, `100% 100%` |
| `background-repeat` | 背景重复 | `repeat`, `no-repeat` |
| `background-attachment` | 背景附着 | `scroll`, `fixed` |
| `border` | 边框（简写） | `1px solid #ccc` |
| `border-width` | 边框宽度 | `1px`, `thin`, `medium` |
| `border-style` | 边框样式 | `solid`, `dashed`, `dotted` |
| `border-color` | 边框颜色 | `#ccc`, `transparent` |
| `border-radius` | 圆角 | `4px`, `50%` |
| `box-shadow` | 盒子阴影 | `0 2px 4px rgba(0,0,0,0.1)` |
| `outline` | 轮廓 | `2px solid #007bff`, `none` |

## 盒模型与尺寸

| 属性 | 说明 | 常用值 |
|------|------|--------|
| `width` | 宽度 | `100%`, `300px`, `auto` |
| `height` | 高度 | `100%`, `200px`, `auto` |
| `min-width` | 最小宽度 | `300px`, `50%` |
| `max-width` | 最大宽度 | `1200px`, `100%` |
| `min-height` | 最小高度 | `200px`, `100vh` |
| `max-height` | 最大高度 | `600px`, `100%` |
| `margin` | 外边距 | `20px`, `10px 20px`, `auto` |
| `padding` | 内边距 | `20px`, `10px 20px` |
| `box-sizing` | 盒模型 | `content-box`, `border-box` |

## 布局与定位

| 属性 | 说明 | 常用值 |
|------|------|--------|
| `display` | 显示方式 | `block`, `inline`, `flex`, `grid` |
| `position` | 定位方式 | `static`, `relative`, `absolute`, `fixed` |
| `top` | 顶部偏移 | `0`, `50%`, `20px` |
| `right` | 右侧偏移 | `0`, `50%`, `20px` |
| `bottom` | 底部偏移 | `0`, `50%`, `20px` |
| `left` | 左侧偏移 | `0`, `50%`, `20px` |
| `z-index` | 层叠顺序 | `1`, `100`, `auto` |
| `float` | 浮动 | `left`, `right`, `none` |
| `clear` | 清除浮动 | `left`, `right`, `both` |
| `overflow` | 溢出处理 | `visible`, `hidden`, `scroll`, `auto` |

## Flexbox

| 属性 | 说明 | 常用值 |
|------|------|--------|
| `flex-direction` | 主轴方向 | `row`, `column` |
| `flex-wrap` | 换行 | `nowrap`, `wrap` |
| `justify-content` | 主轴对齐 | `flex-start`, `center`, `space-between` |
| `align-items` | 交叉轴对齐 | `flex-start`, `center`, `stretch` |
| `align-content` | 多行对齐 | `flex-start`, `center`, `space-between` |
| `gap` | 间距 | `20px`, `10px 20px` |
| `flex` | 弹性（简写） | `1`, `0 1 auto` |
| `flex-grow` | 放大比例 | `0`, `1`, `2` |
| `flex-shrink` | 缩小比例 | `1`, `0` |
| `flex-basis` | 基础大小 | `auto`, `200px`, `0` |
| `order` | 顺序 | `0`, `1`, `-1` |

## Grid

| 属性 | 说明 | 常用值 |
|------|------|--------|
| `grid-template-columns` | 列定义 | `1fr 1fr`, `repeat(3, 1fr)` |
| `grid-template-rows` | 行定义 | `100px 1fr`, `repeat(2, 1fr)` |
| `grid-template-areas` | 区域定义 | `"header header"` |
| `gap` | 网格间距 | `20px`, `10px 20px` |
| `grid-column` | 列位置 | `1 / 3`, `span 2` |
| `grid-row` | 行位置 | `1 / 3`, `span 2` |
| `grid-area` | 区域 | `header`, `1 / 1 / 3 / 3` |
| `justify-items` | 项目列对齐 | `start`, `center`, `stretch` |
| `align-items` | 项目行对齐 | `start`, `center`, `stretch` |

## 视觉效果

| 属性 | 说明 | 常用值 |
|------|------|--------|
| `opacity` | 透明度 | `0`, `0.5`, `1` |
| `visibility` | 可见性 | `visible`, `hidden` |
| `filter` | 滤镜 | `blur()`, `brightness()`, `grayscale()` |
| `backdrop-filter` | 背景滤镜 | `blur(10px)` |
| `transform` | 变换 | `translate()`, `rotate()`, `scale()` |
| `transform-origin` | 变换原点 | `center`, `top left` |
| `transition` | 过渡 | `all 0.3s`, `transform 0.3s` |
| `animation` | 动画 | `fade 1s infinite` |
| `text-shadow` | 文本阴影 | `2px 2px 4px rgba(0,0,0,0.3)` |

## 交互与行为

| 属性 | 说明 | 常用值 |
|------|------|--------|
| `cursor` | 鼠标指针 | `pointer`, `default`, `not-allowed` |
| `pointer-events` | 指针事件 | `auto`, `none` |
| `user-select` | 用户选择 | `none`, `text`, `all` |
| `resize` | 调整大小 | `none`, `both`, `vertical` |
| `scroll-behavior` | 滚动行为 | `auto`, `smooth` |

## 使用建议

- **按分类查找**：根据功能需求查找对应分类
- **理解属性值**：了解常用值的含义
- **组合使用**：多个属性配合实现效果
- **参考文档**：复杂属性查阅详细文档

这份速查表帮助你快速定位需要的属性，但深入学习仍需参考完整的教程内容。
