---
sidebar_position: 11
---

# HTML 链接

在 HTML 中，**链接（Links）** 允许你从一个页面跳转到另一个页面，或跳转到同一页面中的某个位置。你可以通过 `<a>` 标签（anchor）来定义一个超链接。



## HTML 链接语法

链接的基本语法如下所示：

```html
<a href="https://www.getiot.tech">人人都懂物联网</a>
```

- `href` 属性指定了链接的目标地址。
- 链接文本会显示在页面上，用户点击它即可跳转。



## 让链接在新窗口打开

你可以使用 `target="_blank"` 属性让链接在新窗口（或新标签页）中打开：

```html
<a href="https://www.getiot.tech" target="_blank">人人都懂物联网</a>
```

这通常用于外部链接，以防止用户离开你的网站。



## 使用图片作为链接

你不仅可以将文本用作链接，也可以使用图片：

```html
<a href="https://www.getiot.tech">
  <img src="https://static.getiot.tech/Tree-Cotton.jpg" alt="木棉花" style="width:400px;height:auto;">
</a>
```

点击图片将跳转到指定链接。

显示效果：

> [![木棉花](https://static.getiot.tech/Tree-Cotton.jpg#center-400)](https://www.getiot.tech)



## 链接到同一页面的某个位置

如果你希望跳转到当前页面的某个具体位置，可以为目标元素添加 `id`，再在链接中使用 `#` 引用它：

```html
<a href="#section2">跳转到第 2 节</a>

<!-- 页面下方 -->
<h2 id="section2">第 2 节内容</h2>
<p>这是你跳转后看到的内容。</p>
```

这在制作目录或“返回顶部”按钮时非常有用。



## 使用邮件链接（mailto）

如果你想让用户点击链接后直接打开邮箱并撰写邮件，可以使用 `mailto:` 协议：

```html
<a href="mailto:someone@example.com">给我发邮件</a>
```

点击后浏览器会打开默认邮件客户端。



## 使用电话链接（tel）

在移动端，`tel:` 协议可让用户点击链接直接拨打电话：

```html
<a href="tel:+123456789">拨打电话</a>
```

这种方式对于移动设备用户来说非常友好。



## HTML 链接颜色

大多数浏览器会用不同的颜色区分不同状态的链接：

- 未访问的链接：通常是蓝色。
- 已访问的链接：通常是紫色。
- 正在点击的链接：通常是红色。

当然，你也可以通过 CSS 自定义链接样式：

```css
a {
  color: green;
  text-decoration: none;
}
```



## 小结

你已经了解了 HTML 中创建超链接的基础知识，包括如何设置目标地址、让链接在新窗口打开、用图片做链接，以及如何实现锚点、邮件和电话跳转功能。掌握这些技能后，你就能在网页中灵活地添加各种跳转和交互功能了。超链接虽然看似简单，但它是连接网页和互联网的核心组件。
