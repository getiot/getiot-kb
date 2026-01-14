---
sidebar_position: 7
slug: /cascade-specificity
---

# CSS 层叠、继承与特异性

当你发现样式"不是我写的那样"时，通常是因为层叠（Cascade）、继承（Inheritance）或特异性（Specificity）在起作用。理解这三个概念，是掌握 CSS 的关键。

## 层叠的概念

"层叠"（Cascade）是 CSS 名称中的"C"，它指的是当多个样式规则应用到同一个元素时，浏览器如何决定使用哪个样式。

### 层叠的规则

浏览器按照以下顺序决定样式的优先级：

1. **来源优先级**：用户样式 > 作者样式 > User Agent 样式
2. **特异性**：特异性高的规则覆盖特异性低的规则
3. **出现顺序**：后出现的规则覆盖先出现的规则（如果特异性相同）

```css
/* 规则 1：特异性 = 1 */
p {
  color: black;
}

/* 规则 2：特异性 = 10，后出现，所以覆盖规则 1 */
.highlight {
  color: blue;
}

/* 规则 3：特异性 = 100，最高，所以覆盖规则 2 */
#special {
  color: red;
}
```

```html
<p class="highlight" id="special">这段文字是红色的</p>
```

**结果**：文字显示为红色，因为 `#special` 的特异性最高。

## 继承机制

继承（Inheritance）是指某些 CSS 属性会被子元素自动继承，而不需要为每个子元素单独设置。

### 可继承的属性

以下类型的属性通常会被继承：

- **文本属性**：`color`、`font-family`、`font-size`、`font-weight`、`line-height`、`text-align`、`text-decoration`、`text-indent`、`text-transform`、`letter-spacing`、`word-spacing`、`white-space`
- **列表属性**：`list-style`、`list-style-type`、`list-style-position`
- **表格属性**：`border-collapse`、`border-spacing`
- **其他**：`cursor`、`visibility`

### 不可继承的属性

以下类型的属性通常不会被继承：

- **盒模型属性**：`margin`、`padding`、`border`、`width`、`height`
- **定位属性**：`position`、`top`、`right`、`bottom`、`left`、`z-index`
- **显示属性**：`display`、`float`、`clear`
- **背景属性**：`background-color`、`background-image`
- **其他**：`opacity`、`transform`、`box-shadow`

### 继承示例

```css
body {
  color: #333;           /* 会被继承 */
  font-family: Arial;    /* 会被继承 */
  font-size: 16px;       /* 会被继承 */
  margin: 0;             /* 不会被继承 */
  padding: 0;            /* 不会被继承 */
  background-color: #fff; /* 不会被继承 */
}
```

```html
<body>
  <p>这段文字会继承 body 的 color、font-family 和 font-size</p>
  <!-- 但不会继承 margin、padding 和 background-color -->
</body>
```

### 控制继承

你可以使用以下关键字来控制继承：

#### inherit

强制继承父元素的值：

```css
.child {
  color: inherit;  /* 继承父元素的 color */
}
```

#### initial

使用属性的初始值（浏览器默认值）：

```css
.child {
  color: initial;  /* 使用浏览器默认的 color 值 */
}
```

#### unset

如果是可继承属性，则继承；如果是不可继承属性，则使用初始值：

```css
.child {
  color: unset;  /* 如果是可继承属性，继承；否则使用初始值 */
}
```

#### revert

恢复到用户样式表或浏览器默认样式：

```css
.child {
  color: revert;  /* 恢复到浏览器默认或用户样式 */
}
```

## 特异性的计算规则

特异性（Specificity）是浏览器用来决定哪个 CSS 规则应该被应用的机制。当多个规则匹配同一个元素时，特异性高的规则会覆盖特异性低的规则。

### 特异性计算

特异性由四个部分组成，按优先级从高到低：

1. **内联样式**：特异性 = 1000
2. **ID 选择器**：每个 ID 选择器 = 100
3. **类选择器、属性选择器、伪类**：每个 = 10
4. **元素选择器、伪元素**：每个 = 1

**注意**：通用选择器（`*`）和组合选择器（`>`、`+`、`~`、空格）的特异性为 0。

### 计算示例

让我们通过一些例子来理解特异性的计算：

```css
/* 特异性：1（1 个元素选择器） */
p {
  color: black;
}

/* 特异性：10（1 个类选择器） */
.highlight {
  color: blue;
}

/* 特异性：11（1 个类选择器 + 1 个元素选择器） */
p.highlight {
  color: green;
}

/* 特异性：100（1 个 ID 选择器） */
#special {
  color: red;
}

/* 特异性：111（1 个 ID + 1 个类 + 1 个元素） */
#special p.highlight {
  color: purple;
}

/* 特异性：1000（内联样式） */
/* <p style="color: orange;">内联样式</p> */
```

### 特异性比较

当比较特异性时，从左到右比较每个部分：

```css
/* 特异性：0,1,0,1 = 11 */
div p {
  color: black;
}

/* 特异性：0,1,1,0 = 110 */
div .highlight {
  color: blue;  /* 这个会覆盖上面的 */
}

/* 特异性：0,2,0,1 = 201 */
div p.highlight {
  color: green;  /* 这个会覆盖上面的 */
}
```

**比较规则**：
- 先比较 ID 选择器的数量
- 如果相同，再比较类选择器的数量
- 如果相同，再比较元素选择器的数量
- 如果都相同，后出现的规则覆盖先出现的规则

### 特殊情况

#### !important

`!important` 会覆盖所有其他规则（除了另一个 `!important` 规则）：

```css
p {
  color: black !important;  /* 最高优先级 */
}

#special {
  color: red;  /* 即使特异性更高，也不会覆盖上面的 */
}
```

**注意**：`!important` 应该谨慎使用，因为它会破坏层叠规则，使代码难以维护。

#### 内联样式

内联样式的特异性为 1000，高于所有选择器（除了 `!important`）：

```html
<p style="color: blue;">这段文字是蓝色的</p>
```

```css
/* 即使这个规则的特异性很高，也不会覆盖内联样式 */
#special p.highlight {
  color: red;  /* 无效 */
}
```

## 实际冲突示例分析

让我们通过一些实际例子来分析样式冲突：

### 示例 1：特异性冲突

```html
<div class="container">
  <p class="highlight">这是一段文字</p>
</div>
```

```css
/* 规则 1：特异性 = 1 */
p {
  color: black;
}

/* 规则 2：特异性 = 10 */
.highlight {
  color: blue;  /* 这个会覆盖规则 1 */
}

/* 规则 3：特异性 = 11 */
p.highlight {
  color: green;  /* 这个会覆盖规则 2 */
}
```

**结果**：文字显示为绿色，因为 `p.highlight` 的特异性最高。

### 示例 2：出现顺序冲突

```html
<p class="highlight">这是一段文字</p>
```

```css
/* 规则 1：特异性 = 10 */
.highlight {
  color: blue;
}

/* 规则 2：特异性 = 10（相同），但后出现 */
.highlight {
  color: red;  /* 这个会覆盖规则 1 */
}
```

**结果**：文字显示为红色，因为两个规则的特异性相同，后出现的规则覆盖先出现的规则。

### 示例 3：继承 vs 直接样式

```html
<div class="parent">
  <p>这是子元素</p>
</div>
```

```css
/* 父元素样式 */
.parent {
  color: blue;  /* 会被继承 */
  margin: 20px; /* 不会被继承 */
}

/* 子元素样式 */
p {
  color: red;  /* 直接样式，覆盖继承的蓝色 */
}
```

**结果**：文字显示为红色，因为直接样式覆盖继承样式。

### 示例 4：复杂特异性

```html
<div id="container" class="wrapper">
  <section class="content">
    <p class="highlight">这是一段文字</p>
  </section>
</div>
```

```css
/* 规则 1：特异性 = 0,0,1,1 = 11 */
section p {
  color: black;
}

/* 规则 2：特异性 = 0,0,2,1 = 21 */
section p.highlight {
  color: blue;  /* 这个会覆盖规则 1 */
}

/* 规则 3：特异性 = 0,1,1,1 = 111 */
#container section p {
  color: green;  /* 这个会覆盖规则 2 */
}

/* 规则 4：特异性 = 0,1,2,1 = 121 */
#container section p.highlight {
  color: red;  /* 这个会覆盖规则 3 */
}
```

**结果**：文字显示为红色，因为 `#container section p.highlight` 的特异性最高。

## 调试思路

当样式不符合预期时，可以按照以下思路调试：

### 1. 检查特异性

使用浏览器开发者工具检查哪个规则被应用了：

1. 打开开发者工具（F12）
2. 选择元素
3. 查看"计算样式"面板
4. 查看哪个规则被应用，哪个被覆盖

### 2. 检查继承

确认属性是否被继承，以及继承的值是什么：

```css
/* 检查父元素的样式 */
.parent {
  color: blue;  /* 子元素会继承这个值 */
}

/* 检查子元素是否覆盖了继承 */
.child {
  color: red;  /* 覆盖继承的蓝色 */
}
```

### 3. 检查出现顺序

如果特异性相同，后出现的规则会覆盖先出现的规则：

```css
/* 规则 1 */
.element {
  color: blue;
}

/* 规则 2：后出现，覆盖规则 1 */
.element {
  color: red;
}
```

### 4. 检查 !important

`!important` 会覆盖所有其他规则（除了另一个 `!important`）：

```css
.element {
  color: blue !important;  /* 最高优先级 */
}

#special .element {
  color: red;  /* 即使特异性更高，也不会覆盖 */
}
```

### 5. 使用开发者工具

现代浏览器的开发者工具提供了强大的调试功能：

- **样式面板**：显示所有应用的样式规则
- **计算样式**：显示最终应用的样式值
- **特异性指示器**：显示每个规则的特异性
- **覆盖指示器**：显示哪些规则被覆盖了

## 最佳实践

### 1. 保持低特异性

尽量使用低特异性的选择器，这样更容易覆盖：

```css
/* 推荐：低特异性 */
.button {
  background-color: blue;
}

.button-primary {
  background-color: darkblue;  /* 容易覆盖 */
}

/* 不推荐：高特异性 */
#header .nav .menu .item .button {
  background-color: blue;  /* 难以覆盖 */
}
```

### 2. 避免过度嵌套

过度嵌套会增加特异性，使代码难以维护：

```css
/* 不推荐：过度嵌套 */
div.container section.content article.post header.title h1 {
  color: blue;
}

/* 推荐：使用类选择器 */
.post-title {
  color: blue;
}
```

### 3. 谨慎使用 !important

`!important` 应该作为最后的手段：

```css
/* 不推荐：滥用 !important */
.button {
  background-color: blue !important;
}

/* 推荐：提高特异性 */
.button.button-primary {
  background-color: blue;
}
```

### 4. 利用继承

合理使用继承可以减少重复代码：

```css
/* 推荐：在父元素设置可继承属性 */
body {
  font-family: Arial, sans-serif;
  color: #333;
  line-height: 1.6;
}

/* 子元素自动继承，不需要重复设置 */
```

## 小结

理解层叠、继承和特异性是掌握 CSS 的关键：

- **层叠**：多个规则冲突时，按照来源、特异性、出现顺序决定优先级
- **继承**：某些属性会被子元素自动继承，减少重复代码
- **特异性**：通过计算选择器的特异性来决定哪个规则应该被应用

**调试思路**：
1. 检查特异性
2. 检查继承
3. 检查出现顺序
4. 检查 !important
5. 使用开发者工具

**最佳实践**：
- 保持低特异性
- 避免过度嵌套
- 谨慎使用 !important
- 合理利用继承

掌握了这些概念，你就能理解为什么样式"不是我写的那样"，并能够有效地调试和修复样式问题。在下一章，我们将深入探讨 `!important` 的使用与误区。
