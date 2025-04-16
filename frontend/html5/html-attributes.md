---
sidebar_position: 5
---

# HTML 属性

在 HTML 中，你可以使用属性（Attributes）来为元素提供额外的信息。属性总是写在 **开始标签** 中，并且通常以 **键=值（key="value"）** 的形式存在。

这一节将带你了解 HTML 属性的基本语法，以及常用的全局属性和元素专属属性。



## 属性写在开始标签中

属性位于 HTML 元素的起始标签内，用来设置元素的行为或样式。

例如，`<a>` 标签使用 `href` 属性来定义链接地址：

```html
<a href="https://www.getiot.tech">人人都懂物联网</a>
```

在这个例子中：

- `href` 是属性名
- `"https://www.getiot.tech"` 是属性值



## 属性值应该使用引号包裹

在 HTML5 中，属性值通常使用 **双引号** 包裹，例如：

```html
<img src="image.jpg" alt="图片描述">
```

虽然在某些情况下可以省略引号（比如属性值中不包含空格），但为了代码规范和可读性，**你应该始终使用引号**，推荐用双引号。



## 常用属性示例

让我们看几个常见的属性：

### 1. `href` 属性

`href` 用于定义链接的目标地址，常见于 `<a>` 标签中。

```html
<a href="https://www.php.net">访问 PHP 官网</a>
```

### 2. `src` 属性

`src` 用于定义图片、脚本或嵌入资源的路径，常见于 `<img>`、`<script>`、`<iframe>` 等标签中。

```html
<img src="logo.png" alt="网站 Logo">
```

### 3. `alt` 属性

`alt` 提供图片无法显示时的替代文本，便于无障碍浏览和 SEO 优化。

```html
<img src="cat.jpg" alt="一只可爱的猫">
```

### 4. `style` 属性

`style` 用于直接为 HTML 元素设置 CSS 样式。建议你尽量使用外部样式表或 `<style>` 块，这样更利于维护。

```html
<p style="color: red;">这段文字是红色的。</p>
```

### 5. `title` 属性

当用户将鼠标悬停在元素上时，`title` 属性的值会作为提示信息显示出来。

```html
<p title="这是提示文本">鼠标移动到我这里试试看</p>
```



## HTML 的全局属性

HTML5 中定义了一些 **全局属性**（Global Attributes），它们几乎可以用于任何 HTML 元素。以下是常见的全局属性：

|   属性名    | 作用描述                              |
| :---------: | ------------------------------------- |
|    `id`     | 为元素设置唯一标识符                  |
|   `class`   | 为元素指定一个或多个类名（CSS/JS 用） |
|   `style`   | 内联样式                              |
|   `title`   | 鼠标悬停提示                          |
|  `hidden`   | 隐藏元素                              |
|   `lang`    | 定义元素使用的语言                    |
| `draggable` | 指定元素是否可拖动                    |

例如：

```html
<p id="intro" class="highlight" lang="zh-CN">欢迎学习 HTML！</p>
```



## 多个属性可以同时使用

你可以在一个标签中同时使用多个属性，每个属性之间用空格隔开。例如：

```html
<a href="https://getiot.tech" target="_blank" title="在新窗口打开">访问网站</a>
```



## 小结

HTML 属性是你控制元素行为和外观的重要工具，它们总是写在开始标签中，通常以键值对形式存在。你已经学习了常用属性（如 `href`、`src`、`alt`、`title` 和 `style`）以及 HTML5 中的全局属性。掌握属性的用法，是写好 HTML 的关键一步。
