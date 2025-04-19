---
sidebar_position: 10
---

# jQuery 设置内容和属性

在上一节中，你学会了如何使用 jQuery 获取页面元素的内容和属性。现在，我们来学习另一个非常重要的部分：如何使用 jQuery 设置（修改）元素的内容和属性。

你将学到：

- 如何设置文本内容；
- 如何设置 HTML 内容；
- 如何设置表单控件的值；
- 如何设置或修改属性；
- 如何设置样式属性。

掌握这些内容后，你就能通过代码动态地修改网页，让页面变得更加交互和灵活。



## 设置文本内容：`text()`

你可以使用 `.text()` 方法设置元素中的文本内容。

示例：

```html showLineNumbers
<p id="welcome"></p>

<script>
  $('#welcome').text('你好，jQuery 世界！');
</script>
```

这段代码会把 `<p>` 标签的内容设置为 `你好，jQuery 世界！`。
 注意，`text()` 会自动转义特殊字符，不会被当作 HTML 解析。



## 设置 HTML 内容：`html()`

如果你想插入 HTML 标签，而不仅仅是文本，那就用 `.html()` 方法。

示例：

```html showLineNumbers
<div id="content"></div>

<script>
  $('#content').html('<strong>加粗内容</strong>，欢迎学习 jQuery！');
</script>
```

这段代码会插入一段 HTML，让 `<div>` 中出现加粗的文字。



## 设置表单值：`val()`

你可以使用 `.val()` 来设置输入框或其他表单元素的值。

示例：

```html showLineNumbers
<input type="text" id="username">

<script>
  $('#username').val('小明');
</script>
```

这会将输入框中的内容设置为“小明”。



## 设置属性：`attr()`

使用 `.attr()` 方法可以设置或修改元素的属性。

示例：

```html showLineNumbers
<img id="logo">

<script>
  $('#logo').attr('src', 'logo.png');
  $('#logo').attr('alt', '网站标志');
</script>
```

你可以同时设置多个属性，也可以只设置一个。属性名作为第一个参数，属性值作为第二个参数。



## 移除属性：`removeAttr()`

有时候你还需要删除某个属性，可以使用 `.removeAttr()`。

示例：

```html showLineNumbers
<input type="text" id="email" disabled>

<script>
  $('#email').removeAttr('disabled'); // 移除禁用属性
</script>
```

这段代码会让输入框重新变得可编辑。



## 设置样式属性：`css()`

你还可以用 `.css()` 设置 CSS 样式。

示例：

```html showLineNumbers
<p id="note">提示信息</p>

<script>
  $('#note').css('color', 'blue');
  $('#note').css('font-size', '20px');
</script>
```

如果你需要一次设置多个样式，可以传一个对象给 `.css()`：

```javascript showLineNumbers
$('#note').css({
  'color': 'blue',
  'font-size': '20px',
  'font-weight': 'bold'
});
```



## 小结

在本节中，你学习了如何使用 jQuery 设置内容和属性：

- `.text()` 设置纯文本内容；
- `.html()` 插入 HTML 内容；
- `.val()` 设置表单控件的值；
- `.attr()` 设置或修改元素属性；
- `.removeAttr()` 删除属性；
- `.css()` 设置样式属性。

这些方法让你可以通过 JavaScript 控制网页的外观和行为，是 jQuery 中最常用的操作之一。下一节，我们将进入 jQuery 中的**元素操作**，比如添加、删除、克隆节点等，让你实现更强大的动态页面效果。
