---
sidebar_position: 18
---

# jQuery POST 方法

在上一节中，你学习了如何使用 `$.get()` 方法向服务器发送 GET 请求，用来获取一些只读的数据。而在实际开发中，当你需要向服务器提交表单、上传数据或进行数据库写入等操作时，通常会使用 POST 请求。

本节内容将带你了解 jQuery 的 `$.post()` 方法，包括：

- `$.post()` 的基本语法和参数
- 如何使用 POST 向服务器发送数据
- 如何处理返回的数据
- 如何处理请求失败的情况



## 什么是 `$.post()`？

`$.post()` 是 jQuery 提供的一个简洁的 AJAX 方法，它用于向服务器发送 HTTP POST 请求，常用于提交表单数据、添加评论、上传信息等。

POST 请求的特点是：参数放在请求体中，不会显示在地址栏上，更适合传输敏感或大量的数据。



## 基本语法

```javascript
$.post(url, data, successCallback, dataType);
```

参数说明：

- `url`：请求地址
- `data`：发送到服务器的数据（可以是对象或字符串）
- `successCallback`：请求成功后执行的回调函数
- `dataType`（可选）：期望服务器返回的数据类型，比如 `"json"`、`"html"`、`"text"`



## 简单示例：发送评论内容

假设你有一个简单的评论表单：

```html showLineNumbers
<textarea id="comment"></textarea>
<button id="submit">提交评论</button>
<div id="result"></div>
```

你可以使用 `$.post()` 向服务器发送用户输入的内容：

```javascript showLineNumbers
javascript复制编辑  var text = $('#comment').val();

  $.post('submit_comment.php', { comment: text }, function(response) {
    $('#result').html(response);
  });
});
```

这段代码会将 `comment=...` 的数据 POST 到 `submit_comment.php`，服务器可以将内容保存到数据库，并返回一个响应（比如“评论提交成功”），然后将这个响应显示在页面上。



## 发送多个字段

如果你需要发送多个表单字段，比如用户名和密码，你可以像这样写：

```javascript showLineNumbers
$.post('login.php', {
  username: 'tom',
  password: '123456'
}, function(data) {
  console.log('登录结果：', data);
});
```

jQuery 会自动将对象 `{ username: 'tom', password: '123456' }` 序列化为表单格式（`username=tom&password=123456`）发送到服务器。



## 接收 JSON 返回值

如果服务器返回的是 JSON 数据（例如登录状态或错误信息），你可以这样处理：

```javascript showLineNumbers
$.post('login.php', {
  username: 'tom',
  password: '123456'
}, function(data) {
  if (data.success) {
    alert('登录成功');
  } else {
    alert('登录失败：' + data.message);
  }
}, 'json');
```

在这里，第四个参数 `'json'` 告诉 jQuery：你期望返回值是 JSON，它会自动把服务器响应解析为 JavaScript 对象。



## 错误处理

虽然 `$.post()` 没有内置错误回调参数，但你可以使用 `.fail()` 方法处理失败情况，比如服务器宕机或网络出错：

```javascript showLineNumbers
$.post('submit.php', { msg: 'hello' })
  .done(function(data) {
    alert('成功：' + data);
  })
  .fail(function() {
    alert('请求失败，请稍后再试。');
  });
```

这样你就能更好地控制用户体验，即使网络出了问题也不会让页面“静悄悄地挂掉”。



## 小结

在本节中，你学习了 jQuery 的 `$.post()` 方法，它可以帮你轻松地向服务器发送 POST 请求，并获取响应内容。你已经掌握了：

- `$.post()` 的基本语法和参数
- 如何发送单个或多个字段到服务器
- 如何处理服务器返回的 HTML 或 JSON 数据
- 如何添加 `.fail()` 处理请求错误

相比 `$.get()`，`$.post()` 更适合提交表单或需要安全传输的数据。在实际开发中，它是实现用户注册、登录、评论、提交数据等功能的关键工具。
