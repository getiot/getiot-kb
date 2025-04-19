---
sidebar_position: 15
---

# jQuery 获取和设置尺寸

在网页开发中，元素的尺寸（宽度和高度）是非常常见的操作，尤其是在需要动态调整元素大小或获取元素的实际尺寸时。通过 jQuery，你可以非常方便地获取和设置元素的尺寸，包括宽度、高度、内边距、外边距等。

本节将介绍以下内容：

- 获取元素的宽度和高度
- 设置元素的宽度和高度
- 获取和设置元素的内外边距（padding 和 margin）

掌握这些方法后，你将能够灵活地控制页面中元素的尺寸，以适应不同的需求。



## 获取元素的尺寸

### 获取元素的宽度和高度

你可以使用 `.width()` 和 `.height()` 方法来**获取元素的宽度和高度**。这些方法会返回元素的**内容区域**的宽度和高度，不包括边框和内边距。

示例：

```html showLineNumbers
<div id="box" style="width: 200px; height: 100px;">内容</div>
<button id="getSize">获取尺寸</button>

<script>
  $('#getSize').click(function () {
    var width = $('#box').width();  // 获取宽度
    var height = $('#box').height();  // 获取高度
    console.log('宽度:', width, '高度:', height);
  });
</script>
```

当你点击按钮时，控制台会输出 `#box` 元素的宽度和高度，单位是像素。

### 获取元素的完整尺寸

如果你需要包括元素的**边框**、**内边距**，以及**外边距**，你可以使用 `.outerWidth()` 和 `.outerHeight()` 方法。

示例：

```javascript showLineNumbers
var outerWidth = $('#box').outerWidth();  // 包括边框和内边距的宽度
var outerHeight = $('#box').outerHeight();  // 包括边框和内边距的高度
console.log('完整宽度:', outerWidth, '完整高度:', outerHeight);
```

如果你想获取包括**外边距**的尺寸，可以在 `.outerWidth()` 和 `.outerHeight()` 中传递 `true` 作为参数。

```javascript showLineNumbers
var outerWithMargin = $('#box').outerWidth(true);  // 包括外边距
var outerHeightWithMargin = $('#box').outerHeight(true);  // 包括外边距
```



## 设置元素的尺寸

### 设置元素的宽度和高度

你可以使用 `.width()` 和 `.height()` 方法来设置元素的宽度和高度。这些方法会直接修改元素的**内容区域**的宽度和高度。

示例：

```javascript showLineNumbers
$('#box').width(300);  // 设置宽度为300px
$('#box').height(150);  // 设置高度为150px
```

### 设置元素的完整尺寸

如果你希望同时设置元素的**内边距**、**边框**和**外边距**，你可以通过 `.css()` 方法来进行设置。通过 `.css()` 方法，你可以设置更多的样式属性，包括宽度、高度、内外边距等。

示例：

```javascript showLineNumbers
$('#box').css({
  'width': '400px',
  'height': '200px',
  'padding': '20px',
  'border': '5px solid black'
});
```

这种方法适合一次性修改多个样式属性。



## 获取和设置内外边距

除了内容区域的宽高，元素的内边距（padding）和外边距（margin）也是网页布局中常常需要操作的部分。通过 jQuery，你可以轻松地获取和设置这些值。

### 获取内外边距

你可以使用 `.css()` 方法获取元素的内外边距。

示例：

```javascript showLineNumbers
var padding = $('#box').css('padding');  // 获取内边距
var margin = $('#box').css('margin');  // 获取外边距
console.log('内边距:', padding, '外边距:', margin);
```

### 设置内外边距

通过 `.css()` 方法，你可以设置元素的内外边距。你可以分别设置每个方向的边距（上、右、下、左），或者一次性设置所有方向。

示例：

```javascript showLineNumbers
$('#box').css('padding', '30px');  // 设置所有方向的内边距
$('#box').css('margin', '15px');  // 设置所有方向的外边距
```

你也可以单独设置某个方向的边距：

```javascript showLineNumbers
$('#box').css('padding-top', '10px');  // 设置上边距
$('#box').css('margin-left', '20px');  // 设置左边距
```



## 小结

在本节中，你学习了如何使用 jQuery 获取和设置元素的尺寸，主要方法包括：

- `.width()` 和 `.height()`：获取或设置元素的宽度和高度（不包括边框和内边距）；
- `.outerWidth()` 和 `.outerHeight()`：获取或设置元素的宽度和高度（包括边框和内边距）；
- `.css()`：设置和获取更多样式属性，包括内外边距、边框等。

通过这些方法，你可以灵活地控制页面元素的尺寸，从而实现更加动态和灵活的布局。
