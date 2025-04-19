---
sidebar_position: 14
---

# HTML 图像

在网页中展示图片，是非常常见的操作。HTML 提供了专门的标签 `<img>` 来嵌入图像。接下来你将学习如何使用它来在网页中显示图片，并设置其大小、替代文本等属性。



## 使用 `<img>` 标签插入图片

在 HTML 中，你可以使用 `<img>` 标签来插入图像。它是一个**空元素**，意思是它没有闭合标签。

```html
<img src="https://static.getiot.tech/Tree-Cotton.jpg" alt="木棉花" width="500" height="333">
```

属性说明：

- `src`：这是图片的路径（source），用于指定图片的位置。
- `alt`：这是替代文本（alternative text），当图片无法加载时，它会显示出来；它也对屏幕阅读器用户很有用，有助于无障碍访问。
- `width` 和 `height`：设置图像的宽度和高度，可以使用像素（px）或百分比（%）单位。

演示效果：

> ![木棉花](https://static.getiot.tech/Tree-Cotton.jpg#center-500)



## alt 属性很重要

`alt` 属性不仅能在图片加载失败时显示文字，还能提升 SEO 和可访问性体验。

```html
<img src="logo.png" alt="人人都懂物联网 Logo">
```

当图片路径写错或网络不通时，`alt` 内容就会出现在网页上。



## 设置图像的大小

你可以通过 `width` 和 `height` 属性来控制图片的大小。如下所示：

```html
<img src="https://static.getiot.tech/Tree-Cotton.jpg" width="250" height="166">
```

⚠️ 建议你在设置图片大小时保持宽高比一致，避免图片被拉伸变形。

当然，你也可以使用 CSS 设置图片的大小：

```html
<img src="pic.jpg" style="width:300px;height:200px;">
```



## 设置图像的样式

你可以用 CSS 给图片加上边框、圆角等效果。例如：

```html
<img src="pic.jpg" style="border:1px solid #000;">
```



## 居中显示图像

在 HTML 中，如果你想让图片在网页中水平居中显示，可以使用 CSS 来实现。下面介绍几种常见的方式：

**方法一：使用块级元素 + `margin: auto`**

你可以通过将图片转换为块级元素（默认是行内元素），再设置左右 `margin` 为 `auto`，实现居中对齐：

```html
<img src="pic.jpg" style="display: block; margin: auto;" alt="示例图片">
```

这种方式简单且语义清晰，推荐使用。

**方法二：使用文本居中的父容器**

你也可以将图片放在一个设置了 `text-align: center` 的容器中：

```html
<div style="text-align: center;">
  <img src="pic.jpg" alt="示例图片">
</div>
```

这个方法尤其适用于快速布局，适合简单页面结构。

**方法三：使用 Flexbox（高级方式）**

如果你熟悉 CSS Flexbox，还可以通过如下方式实现更强大的居中对齐控制：

```html
<div style="display: flex; justify-content: center;">
  <img src="pic.jpg" alt="示例图片">
</div>
```

这种方式不仅可以让图片居中，还能与其他元素组合使用，适合响应式布局。



## 将图片作为链接

你还可以把图片作为超链接的内容，这样点击图片就可以跳转到指定页面：

```html
<a href="https://www.getiot.tech">
  <img src="logo.png" alt="跳转链接">
</a>
```



## 使用图像的最佳实践

以下是一些使用图片时的建议，供你参考：

- 为每张图片添加有意义的 `alt` 文本；
- 优先使用现代格式如 [`.webp`](/fileformat/webp/) 提升加载速度；
- 控制图片大小，避免影响网页性能；
- 使用 CSS 而不是 HTML 属性来设置样式，以便更好地控制页面布局。



## 示例：完整的图像代码

```html showLineNumbers
<!DOCTYPE html>
<html>
  <body>
    <h2>图片展示示例</h2>
    <p>以下是一张图片：</p>
    <img src="https://static.getiot.tech/Tree-Cotton.jpg" alt="木棉花" width="500" height="333">
  </body>
</html>
```



## 小结

通过本章学习，你掌握了如何使用 HTML 的 `<img>` 标签插入图像，如何设置图片大小、替代文本以及将图片作为链接使用。在网页开发中，图片不仅可以美化页面，还能提升用户体验。记得合理使用 `alt` 属性和 CSS 样式，让你的图像更灵活、网页更专业。
