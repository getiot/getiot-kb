---
sidebar_position: 9
---

# jQuery 事件处理

在前面的学习中，你已经掌握了如何使用选择器来选中网页元素。现在，是时候让这些元素“动”起来了。在本节中，你将学习 jQuery 的事件处理机制，也就是如何让网页对用户的各种操作做出响应，比如点击按钮、鼠标悬停、输入内容等等。

:::tip

jQuery 让事件处理变得非常简单，不仅语法简洁，还能很好地兼容各种浏览器。

:::



## 什么是事件？

事件就是用户与网页交互时触发的一种行为。例如：

- 点击按钮是一个事件；
- 鼠标移动是一个事件；
- 键盘输入是一个事件；
- 表单提交也是一个事件。

通过监听这些事件，你可以让网页动态响应用户操作。



## 使用 `.on()` 绑定事件

jQuery 提供了 `.on()` 方法来绑定事件，它是最推荐的写法：

```javascript
$(selector).on(eventType, handler)
```

参数说明：

- `selector`：要绑定事件的元素；
- `eventType`：事件类型，如 `"click"`、`"mouseover"`；
- `handler`：事件发生时要执行的函数。

例子：

```javascript
$('#myBtn').on('click', function () {
  alert('你点击了按钮！');
});
```

当你点击 ID 为 `myBtn` 的按钮时，就会弹出提示框。



## 常见的事件类型

下面是一些常见的事件类型：

|   事件类型   |           描述           |
| :----------: | :----------------------: |
|   `click`    |         鼠标点击         |
|  `dblclick`  |         鼠标双击         |
| `mouseenter` |    鼠标移入（不冒泡）    |
| `mouseleave` |    鼠标移出（不冒泡）    |
| `mouseover`  |    鼠标移入（会冒泡）    |
|  `mouseout`  |    鼠标移出（会冒泡）    |
|  `keydown`   |         键盘按下         |
|   `keyup`    |         键盘松开         |
|   `submit`   |         表单提交         |
|   `change`   | 表单内容改变（如下拉框） |
|   `focus`    |         获取焦点         |
|    `blur`    |         失去焦点         |



## 简写方法绑定事件

为了方便你写代码，jQuery 为常用事件提供了简写方式，比如：

```javascript
$('#myBtn').click(function () {
  alert('点击事件');
});

$('input').focus(function () {
  console.log('输入框获得了焦点');
});
```

这些简写方法其实底层也是调用了 `.on()`，只是让你写得更轻松。



## 解绑事件

有时候你可能不希望一个元素一直响应事件，这时可以用 `.off()` 方法解绑：

```javascript
$('#myBtn').off('click');
```

或者解绑指定的函数：

```javascript
function handler() {
  alert('只执行一次');
}
$('#myBtn').on('click', handler);
$('#myBtn').off('click', handler);
```

如果你想让事件只执行一次，可以用 `.one()` 方法：

```javascript
$('#myBtn').one('click', function () {
  alert('只会执行一次的事件');
});
```



## 事件对象 `event`

每次事件发生时，jQuery 都会传一个事件对象 `event` 给处理函数，它包含了很多有用的信息，比如：

```javascript
$('#myBtn').click(function (event) {
  console.log(event.type);  // "click"
  console.log(event.target); // 被点击的元素
  event.preventDefault();   // 阻止默认行为（比如表单提交）
});
```

你可以通过这个对象判断事件类型、获取目标元素、阻止冒泡或默认行为等。



## 事件委托（推荐技巧）

当你要给大量的子元素绑定事件时，直接给每个元素绑定可能会影响性能。这时候就可以使用 **事件委托**。

事件委托的原理是：你把事件绑定到父元素上，由父元素“代理”子元素的事件。

```javascript
$('#list').on('click', 'li', function () {
  alert('你点击了：' + $(this).text());
});
```

这段代码中，你只给 `#list` 绑定了一次事件，但当任何 `li` 被点击时，都能响应。这种写法非常高效，尤其是在动态添加元素时。



## 小结

在本节中，你学到了 jQuery 的事件处理方法，包括：

- 使用 `.on()` 来绑定事件；
- 常见的事件类型和简写绑定方式；
- 如何解绑事件、绑定一次性事件；
- 如何使用事件对象获取更多信息；
- 如何通过事件委托提高性能和可维护性。

掌握了这些内容后，你就可以让网页对用户的各种操作做出实时响应，实现更丰富的交互效果。
 接下来，你将学到如何使用 jQuery 操作 DOM 元素，比如修改文本、添加新内容、设置属性等。

