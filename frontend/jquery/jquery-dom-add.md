---
sidebar_position: 11
---

# jQuery 添加元素

在网页开发中，你经常需要动态添加新的内容，比如点击按钮后生成新的列表项、表格行，或是提示信息等。在本节中，你将学习如何使用 jQuery 把新的 HTML 元素添加到现有页面中。



## 在元素内部添加内容（前面或后面）

想要向某个元素内部添加子元素，可以使用 `.append()` 和 `.prepend()` 这两个方法。

- `.append()`：把新元素添加到目标元素的**内容末尾**；
- `.prepend()`：把新元素添加到目标元素的**内容开头**。

示例：

```html showLineNumbers
<ul id="list">
  <li>已有项</li>
</ul>

<script>
  $('#list').append('<li>这是 append 添加的项</li>');
  $('#list').prepend('<li>这是 prepend 添加的项</li>');
</script>
```

运行后，你会看到列表中多了两项，分别插入到了开头和结尾。



## 在元素外部添加内容（前面或后面）

如果你想**在某个元素的前面或后面添加新元素**，可以使用 `.after()` 和 `.before()` 这两个方法。

- `.after()`：添加到目标元素的后面；
- `.before()`：添加到目标元素的前面。

示例：

```html showLineNumbers
<p id="text">原始段落</p>

<script>
  $('#text').after('<p>这是 after 添加的段落</p>');
  $('#text').before('<p>这是 before 添加的段落</p>');
</script>
```

这段代码会在原段落前后插入两个新段落。



## 将元素添加到其他地方

如果你想将元素添加到其他地方，可以使用 `.appendTo()` 和 `.prependTo()`，它们是 `.append()` 和 `.prepend()` 的“反转写法”。它们的语法顺序不同，但效果一样：

- `A.appendTo(B)`：把 A 添加到 B 的内容末尾；
- `A.prependTo(B)`：把 A 添加到 B 的内容开头。

示例：

```html showLineNumbers
<div id="container"></div>

<script>
  $('<p>你好，世界！</p>').appendTo('#container');
</script>
```

这段代码创建了一个新的段落，并把它添加到 `#container` 中。



## 添加的内容类型

你可以添加的内容类型很多，可以是字符串、jQuery 对象或原生 DOM 元素。

**1. 直接添加 HTML 字符串：**

```javascript showLineNumbers
$('#box').append('<span>我是字符串</span>');
```

**2. 使用 jQuery 对象：**

```javascript showLineNumbers
const $item = $('<li>我是 jQuery 对象</li>');
$('#list').append($item);
```

**3. 使用原生 DOM 元素：**

```javascript showLineNumbers
const el = document.createElement('div');
el.textContent = '我是原生 DOM 元素';
$('#container').append(el);
```

jQuery 会自动处理这些情况，不用担心兼容性。



## 小结

在本节中，你学习了如何使用 jQuery 向页面中添加元素。主要方法包括：

- `.append()`：添加到元素内容的结尾；
- `.prepend()`：添加到元素内容的开头；
- `.after()`：在元素后面插入；
- `.before()`：在元素前面插入；
- `.appendTo()` / `.prependTo()`：反转写法，语义清晰；
- 添加内容可以是字符串、jQuery 对象或原生 DOM 元素。

这些方法非常常用，能帮你实现很多交互式网页的效果，比如动态生成评论、消息通知、数据列表等。下一节，我们将介绍 jQuery 删除元素，让你学会如何清理和移除不需要的内容。继续加油！💪
