---
sidebar_position: 6
slug: /css-pseudo-elements
---

# CSS 伪元素

伪元素（Pseudo-element）允许你选择并样式化元素的**特定部分**，而不是整个元素。伪元素让你能够在不需要修改 HTML 结构的情况下，为元素添加装饰性的内容或样式。

## 什么是伪元素

伪元素是一个以双冒号（`::`）开头的关键字，用于选择元素的特定部分。

### 语法

```css
选择器::伪元素 {
  属性: 值;
}
```

**注意**：CSS3 规范推荐使用双冒号（`::`）来区分伪元素和伪类。虽然单冒号（`:`）在旧版本中也能工作，但为了代码的清晰性和未来的兼容性，建议使用双冒号。

## 常见伪元素介绍

### 1. ::before

在元素**内容之前**插入一个伪元素。

```css
/* 在段落前添加引号 */
p::before {
  content: """;
  font-size: 24px;
  color: #999;
}

/* 在链接前添加图标 */
a::before {
  content: "🔗 ";
}

/* 在标题前添加装饰线 */
h2::before {
  content: "";
  display: block;
  width: 50px;
  height: 3px;
  background-color: #007bff;
  margin-bottom: 10px;
}
```

**重要**：`::before` 伪元素必须设置 `content` 属性才能显示，即使 `content` 是空字符串。

### 2. ::after

在元素**内容之后**插入一个伪元素。

```css
/* 在链接后添加外部链接图标 */
a[href^="http"]::after {
  content: " ↗";
  color: #999;
}

/* 在必填字段后添加星号 */
.required::after {
  content: " *";
  color: red;
}

/* 在引用后添加引号 */
blockquote::after {
  content: """";
  font-size: 24px;
  color: #999;
}
```

### 3. ::first-line

选择元素的**第一行文本**。

```css
/* 段落的第一行 */
p::first-line {
  font-weight: bold;
  font-size: 1.2em;
  color: #333;
}

/* 标题的第一行 */
h1::first-line {
  text-transform: uppercase;
  letter-spacing: 2px;
}
```

**限制**：`::first-line` 只能应用以下属性：
- 字体属性（font-*）
- 颜色属性（color）
- 背景属性（background-*）
- 文本属性（text-*、line-height、word-spacing、letter-spacing）
- 文本装饰（text-decoration、text-shadow）

### 4. ::first-letter

选择元素的**第一个字母**（或第一个字符）。

```css
/* 段落的首字母 */
p::first-letter {
  font-size: 3em;
  font-weight: bold;
  float: left;
  line-height: 1;
  margin-right: 5px;
  color: #007bff;
}

/* 标题的首字母 */
h1::first-letter {
  font-size: 2em;
  color: red;
}
```

**限制**：`::first-letter` 只能应用以下属性：
- 字体属性
- 颜色属性
- 背景属性
- 文本属性
- 文本装饰
- 布局属性（margin、padding、border、float 等）

### 5. ::selection

选择用户**选中的文本**。

```css
/* 选中文本的样式 */
::selection {
  background-color: #007bff;
  color: white;
}

/* 特定元素的选中文本 */
p::selection {
  background-color: yellow;
  color: black;
}
```

**限制**：`::selection` 只能应用以下属性：
- `color`
- `background-color`
- `text-shadow`

### 6. ::placeholder

选择**输入框的占位符文本**。

```css
/* 占位符样式 */
input::placeholder {
  color: #999;
  font-style: italic;
}

textarea::placeholder {
  color: #ccc;
  opacity: 0.7;
}
```

### 7. ::marker

选择**列表项的标记**（项目符号或数字）。

```css
/* 列表标记样式 */
li::marker {
  color: #007bff;
  font-weight: bold;
}

/* 有序列表的标记 */
ol li::marker {
  content: counter(list-item) ". ";
  color: red;
}
```

## 与真实元素的区别

伪元素和真实元素有重要区别：

### 1. 不在 DOM 中

伪元素不会出现在 HTML 的 DOM 树中，它们是通过 CSS 创建的"虚拟"元素。

```html
<!-- HTML -->
<p>这是一段文字</p>
```

```css
/* CSS 创建的伪元素不会出现在 DOM 中 */
p::before {
  content: "前缀";
}
```

**结果**：视觉上会显示"前缀这是一段文字"，但 DOM 中仍然只有一个 `<p>` 元素。

### 2. 必须设置 content

`::before` 和 `::after` 伪元素必须设置 `content` 属性才能显示：

```css
/* 正确：设置了 content */
.element::before {
  content: "文本";
}

/* 错误：没有设置 content，伪元素不会显示 */
.element::before {
  color: red;  /* 无效 */
}
```

### 3. 默认是行内元素

伪元素默认是行内元素，可以通过 `display` 属性改变：

```css
.element::before {
  content: "";
  display: block;  /* 改为块级元素 */
  width: 100px;
  height: 100px;
  background-color: blue;
}
```

### 4. 不能选择

伪元素不能通过 JavaScript 直接选择（虽然可以通过 `getComputedStyle` 获取样式）：

```javascript
// 不能直接选择伪元素
document.querySelector('::before');  // 无效

// 但可以获取伪元素的样式
const style = window.getComputedStyle(element, '::before');
console.log(style.content);  // 可以获取
```

## 实际示例

### 示例 1：装饰性引号

```css
blockquote {
  position: relative;
  padding: 20px;
  margin: 20px 0;
  background-color: #f8f9fa;
  border-left: 4px solid #007bff;
}

blockquote::before {
  content: """;
  position: absolute;
  top: -10px;
  left: 10px;
  font-size: 60px;
  color: #007bff;
  opacity: 0.3;
}

blockquote::after {
  content: """";
  position: absolute;
  bottom: -30px;
  right: 10px;
  font-size: 60px;
  color: #007bff;
  opacity: 0.3;
}
```

### 示例 2：工具提示

```css
.tooltip {
  position: relative;
  display: inline-block;
}

.tooltip::after {
  content: attr(data-tooltip);
  position: absolute;
  bottom: 100%;
  left: 50%;
  transform: translateX(-50%);
  padding: 5px 10px;
  background-color: #333;
  color: white;
  border-radius: 4px;
  white-space: nowrap;
  opacity: 0;
  pointer-events: none;
  transition: opacity 0.3s;
}

.tooltip:hover::after {
  opacity: 1;
}
```

```html
<span class="tooltip" data-tooltip="这是提示信息">悬停我</span>
```

### 示例 3：清除浮动

```css
.clearfix::after {
  content: "";
  display: table;
  clear: both;
}
```

### 示例 4：自定义列表标记

```css
.custom-list {
  list-style: none;
  padding-left: 0;
}

.custom-list li {
  position: relative;
  padding-left: 30px;
  margin-bottom: 10px;
}

.custom-list li::before {
  content: "✓";
  position: absolute;
  left: 0;
  color: green;
  font-weight: bold;
}
```

### 示例 5：首字下沉

```css
.dropcap::first-letter {
  float: left;
  font-size: 4em;
  line-height: 1;
  margin-right: 10px;
  margin-top: 5px;
  color: #007bff;
  font-weight: bold;
}
```

```html
<p class="dropcap">这是一段文字，首字母会下沉显示。</p>
```

### 示例 6：输入框图标

```css
.input-wrapper {
  position: relative;
}

.input-wrapper::before {
  content: "🔍";
  position: absolute;
  left: 10px;
  top: 50%;
  transform: translateY(-50%);
  pointer-events: none;
}

.input-wrapper input {
  padding-left: 35px;
}
```

### 示例 7：链接状态指示

```css
/* 外部链接 */
a[href^="http"]::after {
  content: " ↗";
  font-size: 0.8em;
  opacity: 0.7;
}

/* PDF 链接 */
a[href$=".pdf"]::after {
  content: " 📄";
  font-size: 0.8em;
}

/* 邮箱链接 */
a[href^="mailto:"]::after {
  content: " ✉";
  font-size: 0.8em;
}
```

### 示例 8：进度条

```css
.progress-bar {
  width: 100%;
  height: 20px;
  background-color: #e9ecef;
  border-radius: 10px;
  overflow: hidden;
  position: relative;
}

.progress-bar::after {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 60%;  /* 进度百分比 */
  background-color: #007bff;
  transition: width 0.3s;
}
```

### 示例 9：必填字段标记

```css
.required-field::after {
  content: " *";
  color: red;
  font-weight: bold;
}
```

### 示例 10：选中文本样式

```css
/* 全局选中文本样式 */
::selection {
  background-color: #007bff;
  color: white;
}

/* 特定元素的选中文本 */
.highlight::selection {
  background-color: yellow;
  color: black;
}
```

## 伪元素的组合使用

伪元素可以与其他选择器组合使用：

```css
/* 伪元素 + 伪类 */
a:hover::after {
  content: " (点击访问)";
  color: #999;
}

/* 伪元素 + 属性选择器 */
input[type="text"]::placeholder {
  color: #999;
}

/* 多个伪元素 */
.element::before {
  content: "前缀";
}

.element::after {
  content: "后缀";
}
```

## 注意事项

### 1. content 属性的值

`content` 属性可以接受多种类型的值：

```css
/* 文本 */
.element::before {
  content: "文本";
}

/* 空字符串（用于创建装饰性元素） */
.element::before {
  content: "";
  display: block;
  width: 100px;
  height: 100px;
}

/* 属性值 */
.element::before {
  content: attr(data-label);
}

/* 计数器 */
.element::before {
  content: counter(list-item);
}

/* URL（图片） */
.element::before {
  content: url("icon.png");
}

/* 引号 */
.element::before {
  content: open-quote;  /* 开始引号 */
}

.element::after {
  content: close-quote;  /* 结束引号 */
}
```

### 2. 可访问性

伪元素的内容通常不会被屏幕阅读器读取，所以不要用伪元素来添加重要的内容：

```css
/* 不推荐：重要内容用伪元素 */
.button::before {
  content: "提交";  /* 屏幕阅读器可能读不到 */
}

/* 推荐：重要内容放在 HTML 中 */
<button>提交</button>
```

### 3. 性能考虑

过度使用伪元素可能影响性能，特别是在动画中：

```css
/* 谨慎使用：大量动画的伪元素 */
.element::before {
  content: "";
  animation: spin 1s infinite;  /* 可能影响性能 */
}
```

## 小结

伪元素让你能够选择并样式化元素的特定部分：

- **::before** 和 **::after**：在元素前后插入内容
- **::first-line** 和 **::first-letter**：选择文本的第一行或首字母
- **::selection**：选择用户选中的文本
- **::placeholder**：选择输入框的占位符
- **::marker**：选择列表项的标记

**特点**：
- 不在 DOM 中
- `::before` 和 `::after` 必须设置 `content`
- 默认是行内元素
- 不能通过 JavaScript 直接选择

**使用建议**：
- 用于装饰性内容
- 不要用于重要内容（可访问性）
- 合理使用，避免过度
- 注意浏览器兼容性

掌握了伪元素，你就能在不修改 HTML 的情况下，为元素添加丰富的视觉效果。在下一章，我们将深入学习层叠、继承和特异性，理解 CSS 优先级的工作原理。
