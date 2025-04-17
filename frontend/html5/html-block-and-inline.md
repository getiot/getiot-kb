---
sidebar_position: 17
---

# HTML 逻辑区块

在 HTML 中，元素通常分为两种类型：**块级元素**（Block-level elements）和 **行内元素**（Inline elements）。

理解这两种元素的区别，对于你排版网页结构非常重要。接下来我会带你逐步了解块级元素的概念和使用方式。



## 什么是块级元素？

块级元素（Block-level elements）通常会：

- **从新行开始**，并且
- **占据整行的宽度（即使你只写了很少内容）**

也就是说，一个块级元素会在页面上以“整块”的形式呈现，它的前后会自动换行。

常见的块级元素包括：

```html showLineNumbers
<address>
<article>
<aside>
<blockquote>
<canvas>
<div>
<dl>
<fieldset>
<figcaption>
<figure>
<footer>
<form>
<h1> 到 <h6>
<header>
<hr>
<li>
<main>
<nav>
<noscript>
<ol>
<p>
<pre>
<section>
<table>
<tfoot>
<ul>
<video>
```



## 什么是行内元素？

相对地，**行内元素**（Inline elements）通常不会从新行开始，它们只会占据所需的最小空间。

比如你在一个段落中加粗或加链接时，就用到了行内元素。

常见的行内元素包括：

```html showLineNumbers
<a>
<abbr>
<b>
<bdo>
<br>
<button>
<cite>
<code>
<dfn>
<em>
<i>
<img>
<input>
<kbd>
<label>
<map>
<object>
<output>
<q>
<samp>
<script>
<select>
<small>
<span>
<strong>
<sub>
<sup>
<textarea>
<time>
<var>
```



## 示例

### 示例 1：块级元素中的段落

下面是一个使用块级元素 `<p>` 创建两个段落的示例：

```html
<p>这是第一个段落。</p>
<p>这是第二个段落。</p>
```

渲染后，每个段落都会单独占据一行。

显示效果：

> <p>这是第一个段落。</p>
> <p>这是第二个段落。</p>



### 示例 2：行内元素 `<strong>` 与 `<em>`

```html
<p>这是 <strong>加粗</strong> 的文字。</p>
<p>这是 <em>强调</em> 的文字。</p>
```

这些标签不会导致换行，只是在原有文字中修改样式。

显示效果：

> <p>这是 <strong>加粗</strong> 的文字。</p>
> <p>这是 <em>强调</em> 的文字。</p>



### 示例 3：通用的块级容器 `<div>`

你可以把 `<div>` 看作是 HTML 中的“通用容器”。当你需要对一大段内容分组处理时，`<div>` 是非常好用的标签。

```html
<div>
  <h2>标题</h2>
  <p>这是一个段落。</p>
</div>
```

这个 `<div>` 把标题和段落打包在一起，方便你使用 CSS 为它们整体设置样式或布局。



### 示例 4：通用的行内容器 `<span>`

与 `<div>` 类似，`<span>` 是一个通用的 **行内容器**。你可以用它来选中并操作一小段文本或内容。

```html
<p>这是一段带有 <span style="color:red">红色文字</span> 的段落。</p>
```

显示效果：

> 这是一段带有 <span class="text-red">红色文字</span> 的段落。

:::tip

`<span>` 不会换行，只会影响它包裹的部分内容。

:::



## 小结

HTML 中的块级元素和行内元素是网页结构的基石。块级元素用于构建大结构，比如段落、列表、区块；而行内元素用于修饰小细节，比如强调、链接或内嵌表单项。在开发网页时，你需要根据内容的结构和展示需求，合理选择使用块级元素或行内元素。同时，熟练运用 `<div>` 和 `<span>` 这两个通用容器标签，也能帮助你更灵活地组织网页内容结构。
