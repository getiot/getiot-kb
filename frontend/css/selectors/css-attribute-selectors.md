---
sidebar_position: 3
slug: /css-attribute-selectors
---

# CSS 属性选择器

属性选择器允许你根据元素的**属性**和**属性值**来选择元素。这在处理表单元素、链接、图片等具有特定属性的元素时非常有用。

## 属性选择器的基本形式

属性选择器使用方括号 `[]` 来指定要匹配的属性。

### 基本语法

```css
[属性名] {
  属性: 值;
}

[属性名="属性值"] {
  属性: 值;
}
```

## 常见匹配方式

CSS 提供了多种属性匹配方式，让你能够精确选择元素：

### 1. 存在匹配（Presence Match）

选择**具有指定属性**的元素，不管属性值是什么。

```css
/* 选择所有具有 title 属性的元素 */
[title] {
  border: 1px solid blue;
}

/* 选择所有具有 disabled 属性的元素 */
[disabled] {
  opacity: 0.5;
  cursor: not-allowed;
}
```

```html
<!-- 这些元素都会被选中 -->
<p title="提示信息">这段文字有标题</p>
<input type="text" disabled>
<button disabled>禁用按钮</button>
```

### 2. 精确匹配（Exact Match）

选择**属性值完全等于指定值**的元素。

```css
/* 选择 type 属性值为 "text" 的 input 元素 */
input[type="text"] {
  border: 1px solid #ccc;
  padding: 5px;
}

/* 选择 href 属性值为 "https://example.com" 的链接 */
a[href="https://example.com"] {
  color: green;
}
```

```html
<!-- 只有这个 input 会被选中 -->
<input type="text" name="username">

<!-- 这个不会被选中（type 是 "email"） -->
<input type="email" name="email">

<!-- 这个链接会被选中 -->
<a href="https://example.com">示例网站</a>
```

### 3. 开头匹配（Begins With）

选择**属性值以指定字符串开头**的元素。

```css
/* 选择 href 以 "https" 开头的链接 */
a[href^="https"] {
  color: green;
}

/* 选择 id 以 "user-" 开头的元素 */
[id^="user-"] {
  background-color: yellow;
}
```

```html
<!-- 这些链接都会被选中 -->
<a href="https://example.com">安全链接</a>
<a href="https://google.com">Google</a>

<!-- 这个不会被选中（http 不是 https） -->
<a href="http://example.com">不安全链接</a>
```

### 4. 结尾匹配（Ends With）

选择**属性值以指定字符串结尾**的元素。

```css
/* 选择 href 以 ".pdf" 结尾的链接 */
a[href$=".pdf"] {
  color: red;
}

/* 选择 src 以 ".jpg" 结尾的图片 */
img[src$=".jpg"] {
  border: 2px solid blue;
}
```

```html
<!-- 这些链接都会被选中 -->
<a href="document.pdf">PDF 文档</a>
<a href="/files/report.pdf">报告</a>

<!-- 这些图片都会被选中 -->
<img src="photo.jpg" alt="照片">
<img src="/images/logo.jpg" alt="Logo">
```

### 5. 包含匹配（Contains）

选择**属性值包含指定字符串**的元素。

```css
/* 选择 class 包含 "button" 的元素 */
[class*="button"] {
  padding: 10px;
}

/* 选择 href 包含 "example" 的链接 */
a[href*="example"] {
  font-weight: bold;
}
```

```html
<!-- 这些元素都会被选中 -->
<button class="button-primary">按钮</button>
<div class="button-group">按钮组</div>

<!-- 这些链接都会被选中 -->
<a href="https://example.com">示例</a>
<a href="/example-page">示例页面</a>
```

### 6. 单词匹配（Word Match）

选择**属性值包含完整单词**的元素（单词前后必须是空格、连字符或字符串的开始/结束）。

```css
/* 选择 class 包含单词 "button" 的元素 */
[class~="button"] {
  padding: 10px;
}
```

```html
<!-- 这些元素会被选中 -->
<button class="button primary">按钮</button>
<div class="my-button">我的按钮</div>

<!-- 这个不会被选中（"buttons" 不是单词 "button"） -->
<div class="buttons">多个按钮</div>
```

### 7. 语言匹配（Language Match）

选择**lang 属性以指定语言代码开头**的元素。

```css
/* 选择 lang 属性以 "en" 开头的元素 */
[lang|="en"] {
  font-family: Arial, sans-serif;
}
```

```html
<!-- 这些元素都会被选中 -->
<p lang="en">English text</p>
<div lang="en-US">American English</div>

<!-- 这个不会被选中 -->
<p lang="zh">中文</p>
```

## 实际应用示例

### 示例 1：表单样式

属性选择器非常适合为不同类型的表单元素设置样式：

```css
/* 文本输入框 */
input[type="text"],
input[type="email"],
input[type="password"] {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

/* 复选框和单选按钮 */
input[type="checkbox"],
input[type="radio"] {
  width: 20px;
  height: 20px;
  margin-right: 5px;
}

/* 提交按钮 */
input[type="submit"],
button[type="submit"] {
  background-color: #007bff;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

/* 禁用状态 */
input[disabled],
button[disabled] {
  opacity: 0.5;
  cursor: not-allowed;
}
```

```html
<form>
  <input type="text" name="username" placeholder="用户名">
  <input type="email" name="email" placeholder="邮箱">
  <input type="password" name="password" placeholder="密码">
  <input type="checkbox" name="remember"> 记住我
  <button type="submit">提交</button>
  <button type="submit" disabled>禁用按钮</button>
</form>
```

### 示例 2：链接样式

根据链接的类型设置不同的样式：

```css
/* 外部链接（https） */
a[href^="https"] {
  color: green;
}

a[href^="https"]::after {
  content: " 🔒";
}

/* PDF 链接 */
a[href$=".pdf"] {
  color: red;
}

a[href$=".pdf"]::after {
  content: " 📄";
}

/* 邮箱链接 */
a[href^="mailto:"] {
  color: blue;
}

a[href^="mailto:"]::after {
  content: " ✉️";
}

/* 新窗口打开的链接 */
a[target="_blank"] {
  color: orange;
}

a[target="_blank"]::after {
  content: " ↗️";
}
```

```html
<a href="https://example.com">安全链接</a>
<a href="document.pdf">PDF 文档</a>
<a href="mailto:contact@example.com">联系我们</a>
<a href="https://external.com" target="_blank">外部链接</a>
```

### 示例 3：图片样式

根据图片的格式或属性设置样式：

```css
/* JPG 图片 */
img[src$=".jpg"],
img[src$=".jpeg"] {
  border: 2px solid blue;
}

/* PNG 图片 */
img[src$=".png"] {
  border: 2px solid green;
}

/* 有 alt 属性的图片（可访问性） */
img[alt] {
  border: 1px solid #ccc;
}

/* 没有 alt 属性的图片（警告） */
img:not([alt]) {
  border: 2px dashed red;
  opacity: 0.7;
}
```

### 示例 4：数据属性

使用数据属性（data-*）来选择和样式化元素：

```css
/* 选择具有 data-status 属性的元素 */
[data-status] {
  padding: 5px 10px;
  border-radius: 4px;
}

/* 根据 data-status 的值设置不同样式 */
[data-status="success"] {
  background-color: #d4edda;
  color: #155724;
}

[data-status="error"] {
  background-color: #f8d7da;
  color: #721c24;
}

[data-status="warning"] {
  background-color: #fff3cd;
  color: #856404;
}
```

```html
<div data-status="success">操作成功</div>
<div data-status="error">操作失败</div>
<div data-status="warning">请注意</div>
```

## 适用场景与注意点

### 适用场景

属性选择器特别适合以下场景：

1. **表单元素**：根据 `type` 属性为不同类型的输入框设置样式
2. **链接处理**：根据 `href` 属性为不同类型的链接设置样式
3. **图片处理**：根据 `src` 或 `alt` 属性为图片设置样式
4. **数据属性**：使用 `data-*` 属性来标记和样式化元素
5. **状态标记**：根据 `disabled`、`readonly` 等属性设置样式

### 注意点

1. **大小写敏感性**

属性选择器默认是**大小写敏感**的（在 HTML 中）。但在 XML 中，可以通过 `i` 标志来忽略大小写：

```css
/* HTML：大小写敏感 */
[class="Button"] { }  /* 不会匹配 class="button" */

/* XML：可以使用 i 标志忽略大小写 */
[class="Button" i] { }  /* 会匹配 class="button" 或 class="Button" */
```

2. **性能考虑**

属性选择器的性能通常比类选择器稍慢，但在现代浏览器中差异很小。对于大量元素，建议：

```css
/* 推荐：先使用元素选择器缩小范围 */
input[type="text"] { }

/* 不推荐：直接使用属性选择器（如果可能的话） */
[type="text"] { }
```

3. **特异性**

属性选择器的特异性和类选择器相同（都是 10）：

```css
/* 特异性：10 */
.class-name { }

/* 特异性：10（和类选择器相同） */
[class="class-name"] { }
```

4. **组合使用**

属性选择器可以与其他选择器组合使用：

```css
/* 选择具有 disabled 属性的按钮 */
button[disabled] { }

/* 选择 type 为 text 且具有 required 属性的输入框 */
input[type="text"][required] { }

/* 选择 class 包含 "button" 且具有 data-variant 属性的元素 */
[class*="button"][data-variant] { }
```

## 小结

属性选择器让你能够根据元素的属性精确选择元素：

- **存在匹配**：`[attr]` - 选择具有指定属性的元素
- **精确匹配**：`[attr="value"]` - 选择属性值完全等于指定值的元素
- **开头匹配**：`[attr^="value"]` - 选择属性值以指定字符串开头的元素
- **结尾匹配**：`[attr$="value"]` - 选择属性值以指定字符串结尾的元素
- **包含匹配**：`[attr*="value"]` - 选择属性值包含指定字符串的元素
- **单词匹配**：`[attr~="value"]` - 选择属性值包含完整单词的元素
- **语言匹配**：`[attr|="value"]` - 选择属性值以指定语言代码开头的元素

**适用场景**：
- 表单元素样式
- 链接类型区分
- 图片格式处理
- 数据属性标记

**注意点**：
- 大小写敏感性
- 性能考虑
- 特异性计算
- 组合使用

掌握了属性选择器，你就能更精确地选择元素。在下一章，我们将学习组合选择器，了解如何通过元素之间的关系来选择元素。
