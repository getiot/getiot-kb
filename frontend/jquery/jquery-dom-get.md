---
sidebar_position: 10
---

# jQuery 获取内容和属性

在前面的章节中，你已经学会了如何选中页面中的元素，也了解了如何处理事件。现在，你将进一步学习如何使用 jQuery 获取 HTML 元素的内容和属性。这对你操作网页和实现交互效果非常重要。

在本节中，你将学到：

- 如何获取元素中的文本内容；
- 如何获取元素中的 HTML 内容；
- 如何获取输入框的值；
- 如何获取元素的属性；
- 如何获取元素的样式属性。



## 获取文本内容：`text()`

如果你想获取一个元素中纯文本的内容，可以使用 `.text()` 方法。

示例：

```html showLineNumbers
<p id="intro">欢迎来到 jQuery 教程！</p>

<script>
  var content = $('#intro').text();
  console.log(content);  // 输出：欢迎来到 jQuery 教程！
</script>
```

注意：`text()` 会忽略 HTML 标签，只获取文字部分。



## 获取 HTML 内容：`html()`

如果你想获取元素中的 HTML 结构，可以使用 `.html()` 方法。

示例：

```html showLineNumbers
<div id="info"><strong>加粗文本</strong> 其他内容</div>

<script>
  var htmlContent = $('#info').html();
  console.log(htmlContent);  // 输出：<strong>加粗文本</strong> 其他内容
</script>
```

和 `.text()` 不同，`.html()` 会保留所有 HTML 标签。



## 获取表单值：`val()`

对于输入框、下拉框等表单元素，你可以使用 `.val()` 来获取它们的值。

示例：

```html showLineNumbers
<input type="text" id="username" value="Alice">

<script>
  var username = $('#username').val();
  console.log(username);  // 输出：Alice
</script>
```

`.val()` 是获取表单控件值的常用方法。



## 获取属性值：`attr()`

如果你想获取元素的某个属性（比如 `href`、`src`、`title` 等），可以使用 `.attr()` 方法。

示例：

```html showLineNumbers
<a id="link" href="https://example.com" title="示例网站">点击访问</a>

<script>
  var href = $('#link').attr('href');
  var title = $('#link').attr('title');
  console.log(href);   // 输出：https://example.com
  console.log(title);  // 输出：示例网站
</script>
```

你可以把属性名作为参数传给 `.attr()`，就能获取对应的属性值。



## 获取样式属性：`css()`

你还可以使用 `.css()` 方法来获取元素的 CSS 样式值。

示例：

```html showLineNumbers
<p id="color-text" style="color: red;">红色文字</p>

<script>
  var color = $('#color-text').css('color');
  console.log(color);  // 输出：rgb(255, 0, 0) 或 red（取决于浏览器）
</script>
```

`.css()` 的参数是 CSS 属性名，你可以获取元素当前的样式值。



## 小结

在本节中，你学习了如何使用 jQuery 获取网页中的各种信息：

- 使用 `.text()` 获取纯文本；
- 使用 `.html()` 获取 HTML 结构；
- 使用 `.val()` 获取输入框或表单控件的值；
- 使用 `.attr()` 获取元素的属性；
- 使用 `.css()` 获取元素的样式属性。

这些方法是你操作网页内容的重要工具，无论是做表单验证、构建交互页面，还是实现动态效果，它们都是基础中的基础。下一节，我们将继续学习如何使用 jQuery **设置和修改**这些内容和属性，让你的页面变得更加灵活和强大。
