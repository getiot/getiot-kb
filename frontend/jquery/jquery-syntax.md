---
sidebar_position: 7
---

# jQuery 语法

这一节我们将一起深入学习 jQuery 的基础语法。这些语法构成了你编写 jQuery 程序的基本骨架，也是你使用各种功能的起点。你将会学到 jQuery 的基本结构、方法调用的语法、链式调用的概念，以及 `$(document).ready()` 的作用。学会这些语法后，你就能更自信地写出自己的 jQuery 程序了。



## jQuery 的基本语法结构

jQuery 的基本语法格式非常简洁，通常由三部分组成：

```javascript
$(selector).action();
```

- `$`：是 jQuery 的入口函数；
- `selector`：选择器，用来选中页面中的元素；
- `action()`：要对选中元素执行的操作（方法）。

比如：

```javascript
$('#title').hide();
```

这句代码的意思是：找到 ID 为 `title` 的元素，然后把它隐藏。



## 选择器的用法

选择器是 jQuery 的核心之一，它决定了你操作哪些元素。jQuery 的选择器和 CSS 选择器几乎一致，非常灵活：

### ID 选择器

选择某个特定 ID 的元素：

```javascript
$('#box') // 相当于 document.getElementById('box')
```

### 类选择器

选择所有拥有指定 class 的元素：

```javascript
$('.item') // 相当于 document.getElementsByClassName('item')
```

### 标签选择器

选择某一类标签元素：

```javascript
$('p') // 所有 <p> 元素
```

### 组合选择器

你还可以组合多个选择器：

```javascript
$('div, p, .highlight')
```

表示选中所有 `div`、`p` 元素和带有 `.highlight` 类的元素。



## 方法调用

选中元素之后，你就可以使用 jQuery 提供的方法来操作这些元素了。

常用的方法有：

- `.hide()`：隐藏元素；
- `.show()`：显示元素；
- `.css()`：设置或获取 CSS 样式；
- `.text()`：设置或获取文本内容；
- `.html()`：设置或获取 HTML 内容；
- `.val()`：设置或获取表单值；
- `.addClass()` / `.removeClass()`：添加或移除类。

示例：

```javascript
$('#info').text('欢迎来到 jQuery 世界！');
$('#box').css('background-color', 'lightblue');
```



## 链式调用

jQuery 支持链式调用，也就是说你可以连续调用多个方法，写在一行里，这让代码更简洁：

```javascript
$('#box')
  .addClass('active')
  .css('color', 'red')
  .fadeIn();
```

这表示先给 `#box` 添加一个类，然后设置字体颜色为红色，最后让它淡入显示。

链式调用的前提是这些方法返回的还是 jQuery 对象。大部分操作方法都是这样的。



## `$(document).ready()` 的作用

你可能注意到很多 jQuery 程序是这样开始的：

```javascript
$(document).ready(function () {
  // 你的 jQuery 代码写在这里
});
```

或者简写成：

```javascript
$(function () {
  // 你的 jQuery 代码写在这里
});
```

这段代码的意思是：等整个页面（包括 DOM 元素）加载完成之后再执行里面的 jQuery 代码。这样做可以确保你操作的元素已经存在，避免报错。



## 小结

这一节你学习了 jQuery 的基础语法，包括：

- 基本结构是 `$(selector).action()`；
- 选择器的类型和用法（ID、类、标签、组合）；
- 常用方法如 `.hide()`、`.css()`、`.text()` 等；
- 支持链式调用，让代码更简洁；
- 使用 `$(document).ready()` 确保代码在页面加载后再执行。

掌握这些基本语法，你就可以开始写出一些简单而实用的 jQuery 程序了。
