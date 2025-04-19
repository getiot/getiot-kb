---
sidebar_position: 13
---

# jQuery 操作 CSS 样式

在网页开发中，CSS 样式是决定页面外观的重要部分。而通过 jQuery，你可以非常方便地动态地**修改元素的样式**，实现交互效果和动态展示。本节将介绍如何使用 jQuery 操作元素的 CSS 样式，让你能够轻松地调整页面元素的外观。

我们会讲解以下几个常用方法：

- `.css()`：获取或设置元素的 CSS 样式
- 动态添加/删除类
- 更改元素的多个 CSS 属性

掌握这些方法后，你就能在网页中实现更多的动态样式变化，提升用户体验。



## 获取和设置元素的样式

### 获取 CSS 样式

你可以使用 `.css()` 方法来**获取某个元素的 CSS 样式**。如果你只传递一个参数，它会返回该元素指定的 CSS 属性值。

示例：

```html showLineNumbers
<p id="text" style="color: red;">这是一个红色的段落</p>

<script>
  var color = $('#text').css('color');
  console.log(color);  // 输出: red
</script>
```

在上面的示例中，我们通过 `.css('color')` 获取了 `#text` 元素的字体颜色。

### 设置 CSS 样式

除了获取样式，你还可以使用 `.css()` 来**设置元素的 CSS 样式**。你只需要传递一个属性和一个值，或者传递一个包含多个属性和值的对象。

示例：

```html showLineNumbers
<p id="text">这段文字的颜色会改变</p>

<script>
  $('#text').css('color', 'blue');  // 设置颜色为蓝色
</script>
```

如果你想设置多个样式，可以传递一个对象，包含多个属性和值：

```javascript showLineNumbers
$('#text').css({
  'color': 'blue',
  'font-size': '20px',
  'font-weight': 'bold'
});
```

这样你就可以一次性设置多个样式属性。



## 动态添加和删除 CSS 类

除了直接操作样式属性外，你还可以通过**添加或删除 CSS 类**来改变元素的样式。这样可以更灵活地控制元素的外观，尤其适用于需要频繁变化的样式。

### 添加 CSS 类：`.addClass()`

使用 `.addClass()` 方法，你可以给元素添加一个或多个 CSS 类。

示例：

```html showLineNumbers
<p id="text">这是一个段落</p>

<script>
  $('#text').addClass('highlight');
</script>
```

假设你已经在 CSS 中定义了 `.highlight` 类：

```css showLineNumbers
.highlight {
  background-color: yellow;
}
```

运行后，`#text` 元素就会拥有 `.highlight` 类，背景变为黄色。

### 删除 CSS 类：`.removeClass()`

如果你不再需要某个类了，可以使用 `.removeClass()` 方法删除它。

示例：

```javascript showLineNumbers
$('#text').removeClass('highlight');
```

这会从 `#text` 元素中移除 `.highlight` 类。

### 切换 CSS 类：`.toggleClass()`

你还可以使用 `.toggleClass()` 来**切换类**，如果元素已经有该类，它就会被删除；如果没有，它就会被添加。

示例：

```javascript showLineNumbers
$('#text').toggleClass('highlight');
```

每次点击时，`#text` 元素都会在 `.highlight` 类和没有该类之间切换。



## 动态更改多个样式属性

在某些情况下，你可能需要动态改变多个样式。通过 `.css()` 方法，你可以一次性设置多个属性，或者通过 `.addClass()` 和 `.removeClass()` 动态切换包含多个样式的类。

示例：

```html showLineNumbers
<p id="text">我会变换样式</p>

<script>
  $('#text').css({
    'color': 'green',
    'font-size': '18px',
    'line-height': '1.5'
  });
</script>
```

这段代码一次性设置了 `#text` 元素的颜色、字体大小和行高。



## 小结

在本节中，你学习了如何使用 jQuery 操作元素的 CSS 样式。主要方法包括：

- `.css()`：用于获取或设置元素的 CSS 样式；
- `.addClass()`：向元素添加一个或多个 CSS 类；
- `.removeClass()`：删除元素的某个 CSS 类；
- `.toggleClass()`：切换元素的 CSS 类；
- 你还可以通过 `.css()` 一次性设置多个样式。

这些方法为你提供了强大的功能，帮助你动态控制网页元素的外观，使页面更具互动性和动态性。
