---
sidebar_position: 4
---

# jQuery 代码风格

写代码不仅仅是让程序能跑起来，还要让代码清晰易读、方便维护。特别是在多人协作或者过一段时间你自己回头看的时候，一个统一、规范的代码风格显得尤为重要。

本篇文章会告诉你，在使用 jQuery 编程时应该遵循哪些代码风格和最佳实践，让你的代码更简洁、更专业，也更容易调试和维护。



## 统一使用 `$` 作为入口

在 jQuery 中，`$` 是最常用的函数入口。你应该统一使用 `$` 而不是 `jQuery` 来调用 jQuery 的方法：

✅ 推荐写法：

```javascript
$('#menu').hide();
```

⛔ 不推荐写法：

```javascript
jQuery('#menu').hide();
```

虽然两者功能相同，但 `$` 更简洁，也更常见。



## 变量命名规范

变量名应该清晰表达它的含义，避免随意命名。对于保存 jQuery 对象的变量，建议加上 `$` 前缀，以便和普通 DOM 对象区分。

✅ 推荐写法：

```javascript
var $btnSubmit = $('#submit-button');
```

⛔ 不推荐写法：

```javascript
var btnSubmit = $('#submit-button'); // 看不出这是 jQuery 对象
```

这样做可以让你一眼看出哪些变量是 jQuery 对象，避免误用。



## 链式调用要注意换行和缩进

jQuery 的很多方法支持链式调用，但当链太长时，为了可读性，你应该适当换行，并缩进对齐：

✅ 推荐写法：

```javascript
$('#profile')
  .addClass('active')
  .css('color', 'red')
  .fadeIn();
```

⛔ 不推荐写法：

```javascript
$('#profile').addClass('active').css('color', 'red').fadeIn();
```

一行太长会影响阅读，换行之后也方便日后调试。



## 事件绑定用 `.on()` 代替老式写法

早期版本的 jQuery 支持 `.click()`、`.hover()` 等方法，但为了统一和灵活，建议你使用 `.on()` 来绑定事件。

✅ 推荐写法：

```javascript
$('#btn').on('click', function () {
  alert('按钮被点击了');
});
```

⛔ 不推荐写法：

```javascript
$('#btn').click(function () {
  alert('按钮被点击了');
});
```

`.on()` 的优势是可以绑定多个事件、支持事件委托，功能更强大。



## 避免重复选择元素

如果你在多处使用相同的 jQuery 选择器，应该把它缓存到变量中，避免重复查找：

✅ 推荐写法：

```javascript
var $box = $('#box');
$box.addClass('highlight');
$box.fadeIn();
```

⛔ 不推荐写法：

```javascript
$('#box').addClass('highlight');
$('#box').fadeIn();
```

每次调用选择器都会查找一次 DOM，影响性能，特别是当页面很复杂时。



## 合理使用注释

在你的 jQuery 代码中适当地添加注释，能帮助别人（包括未来的你）理解代码的意图。

✅ 推荐写法：

```javascript
// 显示提示信息
$('#message').fadeIn();
```

注释应该简洁明了，说明“为什么”这么写，而不是“做了什么”（代码本身已经说明了做什么）。



## 保持一致的缩进和括号风格

缩进建议使用 2 个空格或 4 个空格，不要混用；代码块的花括号也应风格一致：

```javascript
$(function () {
  $('#nav').slideDown();
});
```

不要写成：

```javascript
$(function(){
$('#nav').slideDown();
});
```

良好的缩进让代码更容易阅读和调试。



## 小结

这一节你学习了 jQuery 编码中常见的风格规范，包括：

- 使用 `$` 作为统一入口；
- 给 jQuery 对象加 `$` 前缀；
- 使用链式调用时注意换行和缩进；
- 用 `.on()` 替代老式事件绑定方法；
- 避免重复选择 DOM 元素；
- 写清晰的注释；
- 保持一致的代码格式。

掌握这些风格规范能帮助你写出更专业、更清晰的 jQuery 代码。
