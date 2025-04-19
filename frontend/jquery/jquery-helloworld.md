---
sidebar_position: 3
sidebar_label: 第一个 jQuery 程序
---

# 第一个 jQuery 程序 Hello World

在你学习 jQuery 的过程中，写下你的第一个程序是一个重要的起点。就像其他编程语言和框架一样，jQuery 的“Hello World”程序也是最经典的入门示例。通过它，你可以了解 jQuery 是如何加载的、如何操作网页元素的，以及如何响应页面的加载事件。

在本节中，你将学会：

- 如何在 HTML 页面中引入 jQuery；
- 如何使用 jQuery 编写一个简单的“Hello World”程序；
- 如何确保你的 jQuery 代码在网页加载完成后执行。

让我们从零开始，一步一步写出你的第一个 jQuery 程序。



## 准备工作：创建一个 HTML 文件

首先，你需要一个基础的 HTML 文件。可以用任何文本编辑器（如 VS Code、Notepad++ 或系统自带的记事本）新建一个文件，命名为 `index.html`，并填入以下内容：

```html showLineNumbers title="index.html"
<!DOCTYPE html>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <title>Hello jQuery</title>
  <!-- 引入 jQuery -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
  <h1 id="greeting">这是原始的文本</h1>

  <!-- jQuery 脚本 -->
  <script>
    $(document).ready(function () {
      // 修改页面上的 h1 元素内容
      $('#greeting').text('Hello, jQuery!');
    });
  </script>
</body>
</html>
```



## 代码解析

让我们一行一行来看看这些代码到底做了什么。

### 引入 jQuery 库

```html showLineNumbers
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
```

这行代码的作用是从 jQuery 官方 CDN（内容分发网络）加载 jQuery 库。你也可以选择下载 jQuery 文件放到本地使用，但通过 CDN 更方便。

### `$(document).ready(...)` 是什么？

```javascript showLineNumbers
$(document).ready(function () {
  // ...
});
```

这部分的意思是：等网页上的所有 HTML 元素都加载完成后，再执行括号里的函数。你可以把它理解为“文档加载完成后，我再开始干活”。

这是一个非常重要的步骤，因为如果你在网页还没加载完的时候操作元素，很可能会报错。

### 使用 jQuery 操作元素

```javascript showLineNumbers
$('#greeting').text('Hello, jQuery!');
```

- `$('#greeting')`：选中 ID 为 `greeting` 的元素，也就是页面中的 `<h1>` 标签；
- `.text('Hello, jQuery!')`：把这个元素的文字内容改成 `"Hello, jQuery!"`。

这样，原本显示的是“这是原始的文本”，当页面加载完之后，jQuery 会自动将它改为“Hello, jQuery!”。



## 小结

恭喜你！你已经成功编写了自己的第一个 jQuery 程序。

通过这篇文章，你学习了：

- 如何在 HTML 页面中引入 jQuery；
- 什么是 `$(document).ready()`，以及它为什么重要；
- 如何使用 jQuery 选中元素，并修改它的内容。

接下来你可以尝试用 jQuery 做更多的事，比如修改样式、添加事件响应、动态添加元素等。继续加油，jQuery 的世界正在向你敞开大门！



