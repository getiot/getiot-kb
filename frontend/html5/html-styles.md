---
sidebar_position: 9
---

# HTML 样式

在 HTML 页面中，**样式**（Style） 控制着内容的外观，比如字体颜色、背景色、字号等等。虽然你可以使用外部或内部的 CSS（Cascading Style Sheets，层叠样式表）来统一管理样式，但有时候你也会想给某个特定的 HTML 元素加上一点快速的样式。

这时候，你就可以使用 `style` 属性来为元素添加内联样式。



## 使用 `style` 属性

`style` 是 HTML 元素的全局属性之一。你可以在任何元素上添加 `style` 属性来设置它的样式，比如：

```html
<p style="color:red;">这是一段红色文字。</p>
```

上面这段代码使用 `style` 属性，把这段文字设置成了红色。



## CSS 语法回顾

HTML 中的 `style` 属性其实是直接写了一段内联 CSS。它的语法格式是这样的：

```css
属性名: 属性值;
```

多个样式之间用分号隔开：

```html
<p style="color:blue; font-size:20px;">蓝色文字，字号为 20px</p>
```

在这个例子中：

- `color` 是 CSS 的颜色属性；
- `font-size` 是字体大小；
- 每个属性值后面都用英文分号结尾（最后一个分号可省略，但强烈建议保留，方便后续维护）。



## 常见样式属性

你可能会经常用到以下几种样式属性：

### 字体颜色：`color`

```html
<h1 style="color:green;">绿色标题</h1>
```

### 背景颜色：`background-color`

```html
<p style="background-color:yellow;">有黄色背景的段落</p>
```

### 字体大小：`font-size`

```html
<p style="font-size:18px;">字体大小为 18px</p>
```

### 字体类型：`font-family`

```html
<p style="font-family:Arial;">使用 Arial 字体</p>
```

### 文本对齐：`text-align`

```html
<p style="text-align:center;">居中文本</p>
```



## 组合多个样式

你可以把多个样式属性写在同一个 `style` 属性中，用英文分号隔开：

```html
<h2 style="color:white; background-color:black; text-align:center;">黑底白字居中标题</h2>
```



## 尽量避免滥用内联样式

虽然使用 `style` 属性很方便，但当你给大量元素都加上内联样式时，HTML 代码会变得非常混乱，而且不利于维护。

更推荐的做法是：使用外部 CSS 文件或 `<style>` 标签统一管理样式，这样可以让结构和样式分离，提高代码的可读性和复用性。

例如，你可以在 HTML 的 `<head>` 部分添加如下代码：

```html
<head>
  <link rel="stylesheet" href="styles.css">
</head>
```

这个标签的含义是：将当前页面与一个名为 `styles.css` 的外部样式表关联起来。

这个 `styles.css` 文件应该和你的 HTML 文件放在同一个目录下（当然你也可以通过路径控制它的位置），内容示例如下：

```css
p {
  color: blue;
  font-size: 16px;
}

h1 {
  text-align: center;
  background-color: lightgray;
}
```

这样，你的页面中所有的 `<p>` 和 `<h1>` 元素就会自动应用这些样式。使用外部 CSS 文件可以让你更清晰地分离内容与表现，便于维护和复用样式。



## 小结

HTML 的 `style` 属性允许你直接为元素设置样式，例如颜色、字号、字体等。在学习初期，这种方式简单直观，适合快速尝试样式效果。但在实际项目中，你应该学会用 CSS 来集中管理样式，做到内容与表现分离，这才是更专业的做法。掌握好这些基本样式知识，为你后续学习 CSS 打下坚实的基础。
