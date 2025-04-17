---
sidebar_position: 18
---

# HTML 布局

在构建网页时，良好的**布局结构**是非常关键的。HTML5 提供了一些语义化的布局标签，帮助你更清晰地组织页面内容，也更容易被搜索引擎和开发者理解。



## 网站的基本布局结构

几乎每个网站都包含以下几个基本部分：

- `<header>`：头部区域，通常放 logo、标题或导航菜单。
- `<nav>`：导航区域，专门用于放置链接菜单。
- `<main>`：主内容区，是页面中最核心的内容部分。
- `<section>`：章节区域，用来划分页面内的逻辑段落。
- `<article>`：文章区域，用于展示独立的内容（如博客、新闻等）。
- `<aside>`：侧边栏，通常用于放置广告、相关链接等次要内容。
- `<footer>`：底部区域，一般包含版权信息、联系信息等。



## 示例：一个简单的页面布局

下面是一个简单的 HTML5 页面布局，这个结构能帮助你构建一个逻辑清晰、语义明确的网页布局。

```html showLineNumbers title="index.html"
<!DOCTYPE html>
<html>
  <head>
    <title>HTML5 布局示例</title>
  </head>
  <body>

    <header>
      <h1>我的网站</h1>
    </header>

    <nav>
      <a href="#">首页</a> |
      <a href="#">关于</a> |
      <a href="#">联系</a>
    </nav>

    <main>
      <section>
        <h2>欢迎来到我的网站</h2>
        <p>这是主内容区域。</p>
      </section>
      <article>
        <h2>最新文章</h2>
        <p>这里是文章内容。</p>
      </article>
    </main>

    <aside>
      <h3>侧边内容</h3>
      <p>一些附加信息，比如广告或链接。</p>
    </aside>

    <footer>
      <p>版权所有 &copy; 2025</p>
    </footer>

  </body>
</html>
```



## 不支持语义标签的浏览器怎么办？

虽然现在主流浏览器都支持 HTML5 的语义标签，但为了兼容老版本的 Internet Explorer（如 IE8 及以下），你可以通过 CSS 显式设置这些标签为 `display: block`。

```css
header, section, footer, aside, nav, main, article {
  display: block;
}
```

这样可以确保即便浏览器原生不支持这些标签，也能正常显示网页结构。



## 使用 `<div>` 构建布局

在 HTML5 出现之前，人们主要使用 `<div>` 来构建布局。虽然现在有了语义化标签，但 `<div>` 仍然是布局中不可或缺的通用容器。

下面是一个使用 `<div>` 的传统布局示例：

```html
<div id="header">头部</div>
<div id="nav">导航</div>
<div id="main">主内容</div>
<div id="footer">底部</div>
```

你可以通过 CSS 给这些 `div` 设置样式和位置。



## 语义标签 vs `<div>`

你可能在想：既然有 `<div>` 标签，为什么还需要用语义标签呢？什么时候该用哪个？

- 如果标签具有明确的意义（比如 `<header>`、`<footer>`、`<nav>`），**优先使用语义标签**，这样可以提升可读性和可维护性。
- 如果你只是想用来包裹内容，而没有明确含义，**使用 `<div>` 更合适**。



## 小结

HTML5 提供了一套结构清晰的语义化布局标签，比如 `<header>`、`<nav>`、`<main>` 等，这些标签让你的页面更容易理解和维护。在现代开发中，建议你优先使用这些标签构建布局。同时，旧的 `<div>` 标签依然适合用来做通用容器。掌握语义布局不仅能提升页面结构清晰度，也对 SEO 和可访问性大有帮助。
