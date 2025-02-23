---
sidebar_position: 1
---

# HTML 简介

**HTML** 是 HyperText Markup Language 的缩写，即超文本标记语言，它是一种用于创建网页的标准标记语言。简单来说，你可以通过 HTML 来创建你的网页，通过互联网让全世界的人浏览。



## HTML 结构

首先，我们一起来看下面这个简单的 HTML 示例：

```html showLineNumbers
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Demo</title>
</head>
<body>
    <h1>人人都懂物联网</h1>
</body>
</html>
```

在这个示例中，包含了许多标签（Tags），这些标签是构成网页的重要元素，主要分为头部（head）和主体（body）两部分。各部分说明如下：

- **`<!DOCTYPE html>`** 是 **文档声明**，此处将文档声明为 HTML5 文档；
- **`<html>`** 是 HTML 的根元素，表示 HTML 内容从这里开始；
- **`<head>`** 是头部元素，包含了文档的元（meta）数据，这里的内容不会直接显示在网页上；
- **`<title>`** 元素声明了页面的标题；
- **`<body>`** 元素声明了 HTML 主体内容从这里开始，这里的内容会显示在网页上；
- **`<h1>`** 元素定义一个大标题。



## HTML 网页编码

你可能已经发现在 HTML 头部有一行 `<meta charset="UTF-8">`，这行代码的作用是声明网页的编码为 `UTF-8`。

在实践过程中，我们建议你始终使用 `UTF-8` 作为网页编码，除非你知道自己在做什么。尤其是对于中文网页，声明 `UTF-8` 编码非常重要，否则浏览器可能会出现乱码。

需要注意的是，由于历史原因，声明网页编码有几种方式：

- HTML5 标准的声明方式：

  ```html
  <meta charset="UTF-8">
  ```

- HTML4 标准的声明方式：

  ```html
  <meta http-equiv="content-Type" content="text/html; charset=utf-8">
  ```

由于现在普遍使用 HTML5 标准，所以推荐使用第一种声明方式。HTML4 标准的声明方式只要有印象即可，可能会在一些老的项目代码中看到。



## HTML 文件扩展名

HTML 文件通常有两种扩展名（后缀），即 `.html` 和 `.htm`。这两种扩展名没有特殊区别，你都可以使用。不过我们建议你优先使用 `.html`，因为这种扩展名更常见。例如 `index.html`（这个文件通常是网站的首页）。



## 小结

本节我们学习了 HTML 的一些基本概念，包括 HTML 文件的代码结构、`<html>` 等标签的含义，以及网页编码和文件扩展名。虽然这些知识很简单，但是对后面的学习很重要。