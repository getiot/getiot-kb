---
sidebar_position: 17
---

# jQuery AJAX 加载

在上一节中，你已经初步了解了 jQuery 的 AJAX 功能，知道如何使用 `$.get()`、`$.post()` 和 `$.ajax()` 来与服务器进行通信。在这一节中，我们会专注讲解 jQuery 提供的一个更方便的 AJAX 方法 —— `.load()`，它可以让你快速加载服务器上的 HTML 内容并插入到指定的页面元素中。



## `.load()` 是什么？

`.load()` 是 jQuery 提供的快捷方法，用来**从服务器加载 HTML 内容，并将其插入到当前页面的某个元素中**。你只需要一行代码，就可以完成 AJAX 请求和 DOM 操作，非常适合初学者使用。



## 基本语法

```javascript
$(selector).load(url, data, callback);
```

参数说明：

- `selector`：你想把内容插入到的 DOM 元素。
- `url`：要加载的服务器地址（可以是 `.html`、`.php`、`.jsp` 等）。
- `data`（可选）：要发送到服务器的数据（对象或查询字符串）。
- `callback`（可选）：加载完成后执行的函数。



## 加载整个 HTML 页面

如果你只想把整个 HTML 页面加载进来，可以这样做：

```javascript showLineNumbers
$('#content').load('about.html');
```

这行代码会将 `about.html` 的全部 HTML 内容加载到 ID 为 `content` 的元素中。



## 只加载页面中的某一部分

有时候你并不想加载整个页面，而只想加载某个部分，比如一个 `div`。你可以在 `url` 后加一个空格和选择器：

```javascript showLineNumbers
$('#content').load('about.html #main');
```

这表示只加载 `about.html` 中 ID 为 `main` 的部分。

这个语法非常实用，尤其当你只需要远程页面中的某个区域时。



## 传递参数

你也可以通过 `.load()` 发送参数到服务器。比如你想加载一条评论，可以这样写：

```javascript showLineNumbers
$('#commentBox').load('getComment.php', {
  commentId: 123
});
```

这个请求会向服务器发送参数 `commentId=123`，服务器可以根据这个参数返回对应的评论内容。



## 使用回调函数处理加载结果

你可以给 `.load()` 传一个回调函数，用来处理加载完成后的逻辑，比如显示提示信息或处理错误。

```javascript showLineNumbers
$('#result').load('data.html', function(response, status, xhr) {
  if (status === 'success') {
    console.log('内容加载成功');
  } else {
    console.log('发生错误：' + xhr.status);
  }
});
```

**回调函数的三个参数**：

- `response`：服务器返回的内容
- `status`：请求状态（比如 `success`、`error`、`timeout`）
- `xhr`：XMLHttpRequest 对象（可获取状态码等）



## 示例：点击按钮加载内容

你可以结合 `.load()` 和事件绑定来实现更有趣的功能，比如点击按钮后动态加载内容：

```html showLineNumbers
<button id="loadBtn">加载更多</button>
<div id="article"></div>
$('#loadBtn').on('click', function() {
  $('#article').load('more-article.html');
});
```

用户点击按钮后，文章内容就会自动加载进来，是不是很方便？



## 小结

通过本节学习，你掌握了 jQuery 的 `.load()` 方法，包括：

- 如何加载整个页面或部分 HTML 内容
- 如何向服务器传递参数
- 如何使用回调函数处理成功或错误情况
- 如何结合事件实现点击加载功能

`.load()` 是 jQuery 中最简单好用的 AJAX 方法，非常适合快速开发原型页面，也常用于分页加载、模块化加载等场景。
