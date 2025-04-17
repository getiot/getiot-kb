---
sidebar_position: 22
---

# HTML CSS

在 HTML 中，你可以通过 **CSS（Cascading Style Sheets，层叠样式表）** 来美化页面的内容。CSS 可以让你控制网页元素的样式，比如颜色、字体、布局等等。它是前端开发中不可或缺的一部分。



## 什么是 CSS？

CSS 是用来设置 HTML 元素样式的语言。通过 CSS，你可以统一控制整个网站的外观风格，而不需要在每个标签上反复设置属性。

举个简单的例子：

```html
<p style="color:blue;">这是一个蓝色的段落。</p>
```

这段代码通过内联样式将文字颜色设为蓝色。

显示效果：

> <p class="text-blue">这是一个蓝色的段落。</p>



## 使用 CSS 的三种方式

你可以通过三种方式在 HTML 中使用 CSS：

### 1. 内联样式（Inline CSS）

直接在 HTML 标签的 `style` 属性中写样式。

```html showLineNumbers
<h1 style="color:green;">标题</h1>
```

这种方式只对当前标签生效，优先级最高，但不利于维护。



### 2. 内部样式表（Internal CSS）

将 CSS 写在 HTML 文件的 `<head>` 标签中，使用 `<style>` 标签包裹。

```html showLineNumbers
<!DOCTYPE html>
<html>
<head>
  <style>
    body {
      background-color: lightgray;
    }
    h1 {
      color: navy;
    }
    p {
      color: red;
    }
  </style>
</head>
<body>

<h1>这是一个标题</h1>
<p>这是一个段落。</p>

</body>
</html>
```

适合页面量不大或仅需要单独设置某个页面样式的场景。



### 3. 外部样式表（External CSS）

将样式写在一个单独的 `.css` 文件中，然后通过 `<link>` 标签引入。

HTML 文件：

```html showLineNumbers title="index.html"
<head>
  <link rel="stylesheet" href="styles.css">
</head>
```

`styles.css` 文件内容：

```css showLineNumbers title="styles.css"
body {
  background-color: lightblue;
}
h1 {
  color: navy;
}
p {
  color: green;
}
```

外部样式是最推荐的方式，它可以让你在多个页面之间复用样式，提高效率和可维护性。



## CSS 语法简介

CSS 由选择器和声明块组成。格式如下：

```css
selector {
  property: value;
}
```

示例：

```css
p {
  color: red;
  text-align: center;
}
```

这段代码会将所有 `<p>` 元素的文字颜色设为红色，并居中对齐。

:::tip

关于 CSS 语法的详细介绍，请参考《[CSS 教程](/css)》。

:::



## CSS 样式的优先级

既然 CSS 样式可以通过多种方式设置，那如果有多重样式来源时，到底哪个样式生效呢？

这其实就是 **CSS 的“层叠性”**：当多个样式同时作用于同一个元素时，CSS 会根据优先级决定使用哪一个。

从优先级由高到低为：

1. 内联样式（`style` 属性）
2. 内部样式表（`<style>` 标签）
3. 外部样式表（`.css` 文件）

如果样式冲突，浏览器会根据这个顺序进行覆盖。



:::tip 推荐的做法

- 对于正式项目，**强烈建议你使用外部样式表**。
- 使用内联样式只适合快速测试。
- 保持样式与结构分离，可以让你的 HTML 更简洁，CSS 更容易维护。

:::



## 小结

通过 CSS，你可以控制 HTML 页面中各种元素的显示样式。掌握 CSS 的基本用法，包括内联样式、内部样式表和外部样式表，是前端开发的必修课。建议你养成将样式统一写入外部 CSS 文件的习惯，这样更符合现代 Web 开发的最佳实践。接下来你可以深入学习 CSS 选择器、盒模型和布局系统，让网页更具专业水准。
