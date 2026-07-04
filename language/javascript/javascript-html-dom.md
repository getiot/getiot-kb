---
sidebar_position: 30
---

# JavaScript DOM 模型



**DOM** 是 Document Object Model 的缩写，即文档对象模型，它是针对 XML 但经过扩展用于 HTML 的应用程序编程接口（API）。DOM 把整个 HTML 页面映射为一个多层节点结构，页面中的每个组成部分都是某种类型的节点，而这些节点又包含着不同类型的数据。

一个网页的显示需要用到 HTML、CSS 和 JavaScript 三种技术，下面我们来看看网页加载背后的工作，以及神秘的 DOM 模型。



## HTML 页面幕后

浏览器加载并显示一个 HTML 页面，需要多种技术的配合，大致过程如下：

1. 浏览器加载一个文档，其中包括用 HTML 写的标记和用 CSS 写的样式；
2. 浏览器加载页面的同时，会为文档创建一个内部模型，其中包含 HTML 标记的所有元素，称为文档对象模型（Document Object Model），即 DOM；
3. 通常还会加载 JavaScript 代码，并在页面加载之后开始执行这些代码。

实际上，JavaScript 就是通过 DOM 与 HTML 页面交互的，这样就可以对用户或浏览器生成的事件做出响应，或者使用 API 访问音频和视频、使用画布完成 2D 绘图、访问本地存储等等。

HTML 页面完全加载之后再执行 JavaScript 代码是有好处的，因为如果在 DOM 还没完全创建就执行 JavaScript 代码，可能会出错。另外，过早执行 JavaScript 代码也会影响页面加载速度，对用户体验不友好。



## DOM 的基本操作

下面演示一些 JavaScript 操作 DOM 对象动态修改 HTML 页面的示例。

### 查找 HTML 元素

#### 1) 通过 id 找到 HTML 元素

使用方法 `document.getElementById()` 通过元素 id 查找，是在 DOM 中查找 HTML 元素的最简单的方法。

示例：

```html
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Demo</title>
</head>
<body>
    <p id="intro">Hello World</p>
    <script>
        var x = document.getElementById("intro");
        x.innerHTML = "人人都懂物联网";
    </script>
</body>
</html>
```

#### 2) 通过标签名找到 HTML 元素

方法 `document.getElementsByTagName()` 用于通过标签名查找 HTML 元素。

示例：先查找 id="main" 的元素，然后再查找该元素中的所有 `<p>` 元素

```javascript showLineNumbers
var x = document.getElementById("main");
var y = x.getElementsByTagName("p");
```

#### 3) 通过类名找到 HTML 元素

方法 `document.getElementById()` 用于通过类名查找 HTML 元素。

示例：

```html
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Demo</title>
</head>
<body>
    <p class="intro">Hello World</p>
    <script>
        var x = document.getElementById("intro");
        x.innerHTML = "人人都懂物联网";
    </script>
</body>
</html>
```

