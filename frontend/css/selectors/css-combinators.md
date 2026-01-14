---
sidebar_position: 4
sidebar_label: CSS 组合选择器
slug: /css-combinators
---

# CSS 组合选择器（后代/子/兄弟）

组合选择器（Combinators）允许你根据**元素之间的关系**来选择元素。理解 DOM 结构与 CSS 的关系，能够让你创建更精确、更有层次的选择。

## 理解 DOM 结构

在深入学习组合选择器之前，让我们先理解 HTML 的 DOM 结构。HTML 元素之间存在着**父子关系**和**兄弟关系**：

```html
<div class="container">          <!-- 父元素 -->
  <h1>标题</h1>                  <!-- 子元素，也是 <p> 的兄弟 -->
  <p>段落 1</p>                  <!-- 子元素，也是 <h1> 和 <p> 的兄弟 -->
  <p>段落 2</p>                  <!-- 子元素，也是 <h1> 和 <p> 的兄弟 -->
  <section>                      <!-- 子元素，也是 <h1> 和 <p> 的兄弟 -->
    <h2>子标题</h2>              <!-- <section> 的子元素，<p> 的后代 -->
    <p>段落 3</p>                <!-- <section> 的子元素，<div> 的后代 -->
  </section>
</div>
```

在这个结构中：
- `<div>` 是 `<h1>`、`<p>`、`<section>` 的**父元素**
- `<h1>`、`<p>`、`<section>` 是 `<div>` 的**子元素**，它们之间是**兄弟关系**
- `<h2>` 和 `<p>` 是 `<section>` 的**子元素**，也是 `<div>` 的**后代元素**

## 1. 后代选择器（Descendant Combinator）

后代选择器选择**某个元素的所有后代元素**（包括子元素、孙元素等，不限层级）。

### 语法

```css
祖先元素 后代元素 {
  属性: 值;
}
```

注意：两个选择器之间用**空格**分隔。

### 示例

```css
/* 选择 div 中的所有 p 元素（不管嵌套多深） */
div p {
  color: blue;
}

/* 选择 .container 中的所有 a 元素 */
.container a {
  color: #007bff;
  text-decoration: none;
}

/* 选择 article 中的所有 h2 元素 */
article h2 {
  font-size: 24px;
  margin-top: 20px;
}
```

### 结构示意图

```
div.container
├── h1
├── p                    ← 被选中（div 的后代）
├── section
│   ├── h2
│   └── p                ← 被选中（div 的后代，嵌套在 section 中）
└── p                    ← 被选中（div 的后代）
```

### 实际应用

```html
<div class="article">
  <h1>文章标题</h1>
  <p>这是第一段。</p>
  <section>
    <h2>章节标题</h2>
    <p>这是章节中的段落。</p>
    <div>
      <p>这是嵌套很深的段落。</p>  <!-- 也会被选中 -->
    </div>
  </section>
</div>
```

```css
/* 选择 .article 中的所有段落，不管嵌套多深 */
.article p {
  line-height: 1.6;
  margin: 10px 0;
}
```

**结果**：所有三个 `<p>` 元素都会被选中并应用样式。

## 2. 子选择器（Child Combinator）

子选择器选择**某个元素的直接子元素**（只选择一层，不包括孙元素）。

### 语法

```css
父元素 > 子元素 {
  属性: 值;
}
```

注意：两个选择器之间用**大于号（`>`）**分隔。

### 示例

```css
/* 选择 div 的直接子元素 p（不包括嵌套在 section 中的 p） */
div > p {
  color: blue;
}

/* 选择 .menu 的直接子元素 li */
.menu > li {
  display: inline-block;
  margin: 0 10px;
}

/* 选择 ul 的直接子元素 li */
ul > li {
  list-style: none;
}
```

### 结构示意图

```
div.container
├── h1
├── p                    ← 被选中（div 的直接子元素）
├── section
│   ├── h2
│   └── p                ← 不被选中（不是 div 的直接子元素）
└── p                    ← 被选中（div 的直接子元素）
```

### 实际应用

```html
<nav class="menu">
  <ul>
    <li>首页</li>        <!-- 不会被选中（不是 .menu 的直接子元素） -->
    <li>关于</li>
  </ul>
</nav>
```

```css
/* 只选择 .menu 的直接子元素 */
.menu > li {
  display: inline-block;
}

/* 选择 .menu 的直接子元素 ul 的直接子元素 li */
.menu > ul > li {
  display: inline-block;  /* 这个会选中上面的 li */
}
```

**区别**：
- `div p`：选择 div 的所有后代 p（包括嵌套的）
- `div > p`：只选择 div 的直接子元素 p（不包括嵌套的）

## 3. 相邻兄弟选择器（Adjacent Sibling Combinator）

相邻兄弟选择器选择**紧跟在某个元素后面的第一个兄弟元素**。

### 语法

```css
元素1 + 元素2 {
  属性: 值;
}
```

注意：两个选择器之间用**加号（`+`）**分隔。

### 示例

```css
/* 选择紧跟在 h1 后面的第一个 p 元素 */
h1 + p {
  font-size: 18px;
  font-weight: bold;
}

/* 选择紧跟在 .button 后面的第一个 .tooltip */
.button + .tooltip {
  display: block;
}

/* 选择紧跟在 input 后面的第一个 label */
input + label {
  margin-left: 10px;
}
```

### 结构示意图

```
div.container
├── h1
├── p                    ← 被选中（紧跟在 h1 后面）
├── p                    ← 不被选中（不是紧跟在 h1 后面）
└── section
    └── p                ← 不被选中（不是 h1 的兄弟）
```

### 实际应用

```html
<h1>主标题</h1>
<p>这是紧跟在 h1 后面的段落。</p>  <!-- 会被选中 -->
<p>这是第二个段落。</p>              <!-- 不会被选中 -->
<p>这是第三个段落。</p>              <!-- 不会被选中 -->
```

```css
/* 只选择紧跟在 h1 后面的第一个段落 */
h1 + p {
  color: blue;
  font-size: 18px;
}
```

**结果**：只有第一个 `<p>` 元素会被选中。

## 4. 通用兄弟选择器（General Sibling Combinator）

通用兄弟选择器选择**某个元素后面的所有兄弟元素**（不要求紧邻）。

### 语法

```css
元素1 ~ 元素2 {
  属性: 值;
}
```

注意：两个选择器之间用**波浪号（`~`）**分隔。

### 示例

```css
/* 选择 h1 后面的所有 p 元素 */
h1 ~ p {
  color: blue;
}

/* 选择 .active 后面的所有 .item */
.active ~ .item {
  opacity: 0.5;
}

/* 选择 input:checked 后面的所有 label */
input:checked ~ label {
  color: green;
}
```

### 结构示意图

```
div.container
├── h1
├── p                    ← 被选中（h1 的兄弟）
├── section
│   └── p                ← 不被选中（不是 h1 的兄弟）
└── p                    ← 被选中（h1 的兄弟）
```

### 实际应用

```html
<h1>主标题</h1>
<p>这是第一个段落。</p>              <!-- 会被选中 -->
<div>这是一个 div。</div>
<p>这是第二个段落。</p>              <!-- 会被选中 -->
<p>这是第三个段落。</p>              <!-- 会被选中 -->
```

```css
/* 选择 h1 后面的所有段落 */
h1 ~ p {
  color: blue;
  margin-left: 20px;
}
```

**结果**：所有三个 `<p>` 元素都会被选中（因为它们都是 h1 的兄弟）。

## 组合选择器的对比

让我们通过一个完整的例子来对比这四种组合选择器：

```html
<div class="container">
  <h1>标题</h1>
  <p>段落 1</p>
  <section>
    <h2>子标题</h2>
    <p>段落 2</p>
  </section>
  <p>段落 3</p>
</div>
```

```css
/* 1. 后代选择器：选择 .container 中的所有 p */
.container p {
  color: blue;  /* 段落 1、段落 2、段落 3 都会被选中 */
}

/* 2. 子选择器：只选择 .container 的直接子元素 p */
.container > p {
  color: red;  /* 只有段落 1 和段落 3 会被选中 */
}

/* 3. 相邻兄弟选择器：选择紧跟在 h1 后面的第一个 p */
h1 + p {
  font-weight: bold;  /* 只有段落 1 会被选中 */
}

/* 4. 通用兄弟选择器：选择 h1 后面的所有 p */
h1 ~ p {
  text-decoration: underline;  /* 段落 1 和段落 3 会被选中 */
}
```

## 组合选择器的嵌套使用

组合选择器可以嵌套使用，创建更复杂的选择：

```css
/* 选择 .container 的直接子元素 section 中的所有 p */
.container > section p {
  color: green;
}

/* 选择紧跟在 h1 后面的第一个 section 中的所有 p */
h1 + section p {
  font-size: 18px;
}

/* 选择 .menu 的直接子元素 li 后面的所有 li */
.menu > li ~ li {
  border-left: 1px solid #ccc;
  padding-left: 10px;
}
```

## 实际应用场景

### 场景 1：导航菜单

```html
<nav class="menu">
  <ul>
    <li><a href="#">首页</a></li>
    <li><a href="#">关于</a></li>
    <li><a href="#">服务</a></li>
    <li><a href="#">联系</a></li>
  </ul>
</nav>
```

```css
/* 选择 .menu 的直接子元素 ul 的直接子元素 li */
.menu > ul > li {
  display: inline-block;
  margin: 0 10px;
}

/* 选择除了第一个 li 之外的所有 li（添加左边框） */
.menu > ul > li ~ li {
  border-left: 1px solid #ccc;
  padding-left: 10px;
}
```

### 场景 2：文章内容

```html
<article>
  <h1>文章标题</h1>
  <p class="intro">引言段落</p>
  <p>正文段落 1</p>
  <p>正文段落 2</p>
  <section>
    <h2>章节标题</h2>
    <p>章节内容</p>
  </section>
</article>
```

```css
/* 选择紧跟在 h1 后面的第一个段落（引言） */
article h1 + p {
  font-size: 18px;
  font-style: italic;
  color: #666;
}

/* 选择 article 中的所有段落（不包括 section 中的） */
article > p {
  line-height: 1.8;
  margin: 15px 0;
}

/* 选择 article 中所有段落（包括 section 中的） */
article p {
  color: #333;
}
```

### 场景 3：表单布局

```html
<form>
  <div class="form-group">
    <label for="name">姓名</label>
    <input type="text" id="name">
    <span class="error">请输入姓名</span>
  </div>
  <div class="form-group">
    <label for="email">邮箱</label>
    <input type="email" id="email">
    <span class="error">请输入有效邮箱</span>
  </div>
</form>
```

```css
/* 选择紧跟在 input:invalid 后面的 .error */
input:invalid + .error {
  display: block;
  color: red;
}

/* 选择 .form-group 的直接子元素 label */
.form-group > label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
}
```

## 性能考虑

虽然组合选择器很强大，但需要注意性能：

1. **后代选择器**：性能相对较慢，因为需要遍历所有后代元素
2. **子选择器**：性能较好，只检查直接子元素
3. **兄弟选择器**：性能较好，只检查兄弟元素

**建议**：
- 优先使用子选择器（`>`）而不是后代选择器（空格）
- 避免过度嵌套（如 `div > div > div > p`）
- 在可能的情况下，使用类选择器替代组合选择器

```css
/* 推荐：使用类选择器 */
.intro-paragraph {
  font-style: italic;
}

/* 不推荐：过度嵌套的组合选择器 */
div.container > section.content > article.post > p.intro {
  font-style: italic;
}
```

## 小结

组合选择器让你能够根据元素之间的关系精确选择元素：

- **后代选择器**（空格）：选择所有后代元素，不限层级
- **子选择器**（`>`）：只选择直接子元素
- **相邻兄弟选择器**（`+`）：选择紧跟在后面的第一个兄弟元素
- **通用兄弟选择器**（`~`）：选择后面的所有兄弟元素

**使用建议**：
- 理解 DOM 结构，选择合适的组合选择器
- 优先使用子选择器提高性能
- 避免过度嵌套
- 在可能的情况下使用类选择器

掌握了组合选择器，你就能创建更精确、更有层次的选择。在下一章，我们将学习伪类和伪元素，了解如何选择处于特定状态的元素和元素的特定部分。
