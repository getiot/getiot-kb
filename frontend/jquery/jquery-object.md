---
sidebar_position: 6
---

# jQuery 对象

在学习 jQuery 的过程中，有一个非常重要的概念你必须掌握——那就是“jQuery 对象”。你可能已经注意到，用 jQuery 选中一个元素后，返回的结果跟原生 DOM 元素不太一样。这是因为 jQuery 把这些元素包装成了“jQuery 对象”，它让你可以更加方便地操作网页中的内容。



## 什么是 jQuery 对象？

当你用 jQuery 选择一个页面元素时，比如这样：

```javascript
var $title = $('#title');
```

这个 `$title` 就是一个 jQuery 对象。它内部其实是一个类数组结构，里面包含了你选中的元素（即原生 DOM 元素），但 jQuery 为它封装了很多强大的方法，比如 `.css()`、`.hide()`、`.on()` 等等。

你可以把 jQuery 对象理解为“加了超能力的 DOM 元素”，它让你不需要写一堆复杂的原生 JS 代码，就能轻松搞定网页上的各种操作。



## jQuery 对象和 DOM 对象的区别

了解两者的区别非常关键，尤其是在你需要和其他 JavaScript 函数（比如使用原生 JS 的第三方库）交互时。

| 对象类型    | 特点和用途                                     |
| ----------- | ---------------------------------------------- |
| jQuery 对象 | 用 `$()` 创建，拥有很多链式方法                |
| DOM 对象    | 原生浏览器提供的对象，不能直接使用 jQuery 方法 |

示例对比：

```javascript
var $box = $('#box'); // jQuery 对象
var box = document.getElementById('box'); // DOM 对象
```

你不能这样写：

```javascript
box.hide(); // ❌ 报错：hide 不是函数
```

因为 `.hide()` 是 jQuery 方法，只能用于 jQuery 对象。



## 转换 jQuery 对象和原生 DOM 对象

在实际开发中，你可能会在 jQuery 和原生 JS 之间来回切换，这时你需要知道如何转换对象类型。

### jQuery 对象 → DOM 对象

你可以通过索引（一般是 0）来获取 DOM 对象：

```javascript
var $btn = $('#submit');
var domBtn = $btn[0]; // 或者 $btn.get(0)
```

### DOM 对象 → jQuery 对象

如果你手上已经有一个 DOM 元素，也可以用 `$()` 把它包裹成 jQuery 对象：

```javascript
var domBox = document.getElementById('box');
var $box = $(domBox);
```

这样你就能用 jQuery 的各种方法来操作它了。



## 多元素 jQuery 对象

有些选择器会返回多个匹配的元素，比如：

```javascript
var $items = $('li');
```

这时候 `$items` 是一个 jQuery 对象，内部包含了所有的 `<li>` 元素。你可以直接对它们统一操作：

```javascript
$items.css('color', 'blue');
```

这会把所有的 `<li>` 都变成蓝色。

如果你想分别处理每一个元素，可以使用 `.each()` 方法：

```javascript
$items.each(function (index, element) {
  // 注意：这里的 element 是 DOM 对象
  $(element).text('第 ' + (index + 1) + ' 项');
});
```



## 小结

通过这节内容，你已经了解了：

- jQuery 对象是 jQuery 封装的“类数组”结构，拥有很多链式方法；
- 它和原生 DOM 对象是不同类型的，要注意不能混用；
- 你可以通过 `$()[0]` 或 `.get(0)` 获取 DOM 对象，也可以用 `$()` 包装 DOM 对象；
- jQuery 对象可以包含多个元素，你可以统一操作，也可以用 `.each()` 遍历。

掌握 jQuery 对象的概念，是你深入学习 jQuery 的关键一步。
