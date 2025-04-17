---
sidebar_position: 20
---

# HTML 内嵌框架

在开发网页时，你可能希望在当前页面中嵌入其他网页内容。比如，你想在你的页面中展示一段来自其他网站的视频、地图，甚至是另一个网页的整体内容，这时候就可以使用 **`<iframe>`（内嵌框架）**。



## 什么是 `<iframe>`？

`<iframe>` 标签用于在网页中嵌入另一个 HTML 页面。被嵌入的网页会显示在一个指定区域内，就像你在页面中“开了一个小窗口”。

基本语法如下：

```html
<iframe src="https://www.example.com" width="600" height="400"></iframe>
```

属性说明：

- `src`：设置要嵌入页面的 URL。
- `width`：设置 iframe 的宽度。
- `height`：设置 iframe 的高度。



## 示例：嵌入一个网页

下面这个例子会在当前页面中嵌入 GetIoT.tech 的首页：

```html
<iframe src="https://getiot.tech" width="100%" height="400"></iframe>
```

你可以把 `src` 替换为任意你想要嵌入的网址，前提是对方网站允许 iframe 加载（有的网站会通过 HTTP 头阻止这种嵌入行为）。

显示效果：

> <iframe src="https://getiot.tech" width="100%" height="400"></iframe>



## 设置边框

你可以通过 CSS 来控制 iframe 的边框。比如下面这个例子移除了边框：

```html
<iframe src="https://getiot.tech" style="border:none;" width="600" height="400"></iframe>
```

你也可以添加边框样式：

```html
<iframe src="https://getiot.tech" style="border:2px solid #ccc;" width="600" height="400"></iframe>
```



## 使用 `title` 提升无障碍性

建议你为每个 `<iframe>` 添加 `title` 属性，这样可以让使用屏幕阅读器的用户知道 iframe 的作用。例如：

```html
<iframe src="https://getiot.tech" title="人人都懂物联网" width="600" height="400"></iframe>
```



## 防止 iframe 滚动条

你可以使用 CSS 或 HTML 属性来控制 iframe 是否显示滚动条。

**方法一：通过 `scrolling` 属性（已废弃，不推荐）**

```html
<iframe src="https://getiot.tech" width="600" height="400" scrolling="no"></iframe>
```

虽然 `scrolling` 依然可用，但它已经不被 HTML5 推荐，最好使用 CSS 来控制。

**方法二：使用 CSS `overflow` 属性（推荐）**

```html
<iframe src="https://getiot.tech" width="600" height="400" style="overflow:hidden;"></iframe>
```

注意：你无法控制被嵌入页面的真实滚动行为，除非该页面允许你控制（同源或跨域开放权限）。



## 设置 iframe 内容加载时的替代文字

你可以在 `<iframe>` 标签对之间插入文字，作为 iframe 无法加载时的备用内容，例如：

```html
<iframe src="no-such-page.html" width="600" height="400">
  很抱歉，您的浏览器不支持 iframe 标签，或页面加载失败。
</iframe>
```



## 安全性提示：使用 `sandbox` 属性

为了增强安全性，HTML5 提供了 `sandbox` 属性，它可以限制 iframe 内部页面的行为。

```html
<iframe src="https://getiot.tech" sandbox></iframe>
```

你也可以指定一些例外权限，例如：

```html
<iframe src="https://getiot.tech" sandbox="allow-scripts allow-same-origin"></iframe>
```

常见的 sandbox 权限包括：

- `allow-same-origin`：允许 iframe 与当前页面处于同源策略。
- `allow-scripts`：允许执行 JavaScript 脚本。
- `allow-forms`：允许提交表单。
- `allow-popups`：允许弹出窗口。



## 小结

`<iframe>` 是一个非常实用的 HTML 标签，可以让你在页面中嵌入其他网站或页面内容。你可以通过 src 设置嵌入地址，通过 CSS 控制样式，还可以使用 sandbox 来提升安全性。虽然 iframe 功能强大，但使用时也要注意跨域限制和性能问题。掌握了这些基础知识后，你就可以灵活地在网页中嵌入地图、视频、工具页等各种资源啦。
