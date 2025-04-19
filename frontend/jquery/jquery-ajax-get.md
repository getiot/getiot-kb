---
sidebar_position: 18
---

# jQuery GET 方法

在前面的学习中，你已经了解了 jQuery 支持通过 AJAX 和服务器进行数据交互，而 `.get()` 方法就是其中最常用的方式之一。本节将带你详细了解 jQuery 的 `$.get()` 方法，它可以让你通过 HTTP GET 请求从服务器获取数据，并在页面中进行动态处理。

你将学会：

- `$.get()` 的基本语法和参数
- 如何从服务器获取 HTML 或文本内容
- 如何处理返回的 JSON 数据
- 如何使用回调函数处理响应和错误



## 什么是 `$.get()`？

`$.get()` 是 jQuery 提供的一个简洁方法，用于向服务器发送 GET 请求。它适用于从服务器获取内容或数据，不会对服务器产生副作用（比如修改数据库）。

GET 请求的特点是：**参数包含在 URL 中，适合请求只读数据**。



## 基本语法

```javascript
$.get(url, data, successCallback, dataType);
```

参数说明：

- `url`：你要请求的服务器地址（比如 `data.php` 或 `https://api.example.com/data`）
- `data`（可选）：要发送给服务器的查询参数（可以是对象，也可以是查询字符串）
- `successCallback`（可选）：请求成功时执行的回调函数
- `dataType`（可选）：预期的返回数据类型（如 `"text"`、`"html"`、`"json"`）



## 简单示例：获取一段文本

假设你有一个按钮，点击后从服务器获取一段文本并显示：

```html showLineNumbers
<button id="loadText">加载文本</button>
<div id="result"></div>
$('#loadText').on('click', function() {
  $.get('text.txt', function(data) {
    $('#result').text(data);
  });
});
```

这段代码的意思是：当点击按钮时，发送 GET 请求到 `text.txt`，并将返回的数据填入 ID 为 `result` 的元素中。



## 发送参数到服务器

你可以向服务器发送一些参数，比如请求一篇特定的文章：

```javascript showLineNumbers
$.get('article.php', { id: 123 }, function(data) {
  $('#articleBox').html(data);
});
```

这相当于请求了：`article.php?id=123`，服务器收到后可以返回这篇文章的内容。



## 获取 JSON 数据并处理

现在很多接口返回的都是 JSON 格式的数据，比如：

```json showLineNumbers
{
  "title": "jQuery 入门教程",
  "author": "小明"
}
```

你可以像这样使用 `$.get()` 获取并处理：

```javascript showLineNumbers
$.get('info.json', function(data) {
  $('#title').text(data.title);
  $('#author').text(data.author);
}, 'json');
```

记得加上第四个参数 `'json'`，这样 jQuery 会自动将返回的字符串转换为 JavaScript 对象。



## 错误处理

虽然 `$.get()` 默认只提供成功回调，但你可以搭配 `.fail()` 方法处理错误：

```javascript showLineNumbers
$.get('data.json')
  .done(function(data) {
    console.log('请求成功', data);
  })
  .fail(function() {
    alert('请求失败，请稍后再试！');
  });
```

这让你在请求失败（比如网络中断或找不到文件）时也能有良好的用户反馈。



## 小结

通过本节的学习，你掌握了 jQuery 中 `$.get()` 方法的用法，包括：

- 使用 `$.get()` 发送简单的 GET 请求
- 向服务器传递参数
- 加载 HTML 或文本内容
- 获取并解析 JSON 数据
- 使用 `.fail()` 方法处理请求失败

`$.get()` 是构建动态网页的一个非常实用的工具，适合从服务器获取内容、配置数据或文章详情等信息。下一节，我们将继续学习 jQuery 的 `$.post()` 方法，用来发送 POST 请求，处理表单等更复杂的场景。
