---
sidebar_position: 12
---

# HTML 引用

在 HTML 中，如果你想展示一段引用的文字，比如一段名言、引用某篇文章的内容，或者想注明某个术语的定义，你可以使用 HTML 提供的几个**引用相关标签**来实现。这些标签不仅能帮助你语义化地表达内容，还能提升网页的可访问性（Accessibility）。



## 长引用标签 `<blockquote>`

如果你要引用一段较长的文本，比如一整句话或一段文字，推荐使用 `<blockquote>` 标签。

```html
<blockquote cite="https://www.example.com/article">
  人生最精彩的不是实现梦想的瞬间，而是坚持梦想的过程。
</blockquote>
```

- `<blockquote>` 会默认缩进显示（具体样式由浏览器决定）。
- `cite` 属性可以用来指定引用来源的 URL（虽然不会直接显示在页面上，但对搜索引擎和屏幕阅读器有帮助）。

显示效果：

> <blockquote cite="https://www.example.com/article">
>   人生最精彩的不是实现梦想的瞬间，而是坚持梦想的过程。
> </blockquote>



## 短引用标签 `<q>`

如果只是短小的文字引用（比如一句话中的几字），你可以使用 `<q>` 标签。这个标签通常会自动添加引号。

```html
<p>她说：<q>保持好奇是成长的关键。</q></p>
```

不同浏览器会用不同样式的引号（中文环境下可能使用中文引号）。

显示效果：

> <p>她说：<q>保持好奇是成长的关键。</q></p>



## 缩写词标签 `<abbr>`

当你需要向用户解释一个缩写词时，可以使用 `<abbr>` 标签，并结合 `title` 属性展示完整含义。

```html
<p>HTML 是 <abbr title="HyperText Markup Language">HTML</abbr> 的缩写。</p>
```

当用户将鼠标悬停在缩写上时，会显示完整含义。

显示效果：

> <p>HTML 是 <abbr title="HyperText Markup Language">HTML</abbr> 的缩写。</p>



## 定义联系信息 `<address>`

你可以用 `<address>` 标签表示作者或拥有者的联系信息。

```html
<address>
  联系方式：<br>
  阿基米东<br>
  邮箱：example@gmail.com
</address>
```

浏览器通常会用斜体或特殊样式来显示 `<address>` 标签内容。它适用于网页底部的联系信息或作者署名。

显示效果：

> <address>
>   联系方式：<br/>
>   阿基米东<br/>
>   邮箱：example@gmail.com<br/>
> </address>



## 标示作品标题 `<cite>`

当你引用一部作品，比如一本书、电影、音乐或网页时，可以使用 `<cite>` 标签：

```html
<p><cite>《红楼梦》</cite> 是中国古典小说的巅峰之作。</p>
```

这通常会以斜体显示，具体样式由浏览器决定。

显示效果：

> <p><cite>《红楼梦》</cite> 是中国古典小说的巅峰之作。</p>



## 控制文字方向 `<bdo>`

在某些多语言环境中，你可能需要强制更改文本显示方向，这时可以使用 `<bdo>` 标签：

```html
<bdo dir="rtl">这是从右向左显示的文字</bdo>
```

- `dir="rtl"` 表示从右向左（Right-To-Left）。
- `dir="ltr"` 表示从左向右（默认方向）。

显示效果：

> <bdo dir="rtl">这是从右向左显示的文字</bdo>



## 小结

HTML 提供了多个用于表示引用和语义增强的标签，例如 `<blockquote>`、`<q>`、`<abbr>`、`<cite>` 等，它们不仅能帮助你结构化内容，还能提升网页的可读性和可访问性。在实际开发中，合理使用这些标签能让你的 HTML 页面更专业、更符合标准。掌握这些元素，将对你构建语义清晰、结构良好的页面大有帮助。
