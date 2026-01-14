---
sidebar_position: 5
slug: /css-pseudo-classes
---

# CSS 伪类

伪类（Pseudo-class）允许你根据元素的**状态**来选择元素，而不是根据元素的类型、属性或内容。伪类让你能够为元素的不同状态（如悬停、焦点、激活等）设置不同的样式。

## 什么是伪类

伪类是一个以冒号（`:`）开头的关键字，用于选择处于特定状态的元素。

### 语法

```css
选择器:伪类 {
  属性: 值;
}
```

### 示例

```css
/* 选择处于悬停状态的链接 */
a:hover {
  color: red;
}

/* 选择第一个子元素 */
li:first-child {
  font-weight: bold;
}

/* 选择获得焦点的输入框 */
input:focus {
  border-color: blue;
}
```

## 常见交互伪类

交互伪类根据用户的交互行为来选择元素：

### 1. :hover

选择**鼠标悬停**时的元素。

```css
/* 链接悬停效果 */
a:hover {
  color: red;
  text-decoration: underline;
}

/* 按钮悬停效果 */
.button:hover {
  background-color: #0056b3;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.2);
}

/* 卡片悬停效果 */
.card:hover {
  box-shadow: 0 8px 16px rgba(0,0,0,0.2);
  transform: scale(1.02);
}
```

**注意**：在触摸设备上，`:hover` 可能不会按预期工作，因为触摸设备没有"悬停"状态。

### 2. :active

选择**被激活**（正在被点击）时的元素。

```css
/* 按钮点击效果 */
.button:active {
  background-color: #004085;
  transform: translateY(0);
}

/* 链接点击效果 */
a:active {
  color: darkred;
}
```

**特点**：`:active` 只在元素被点击的瞬间生效，松开鼠标后恢复。

### 3. :focus

选择**获得焦点**时的元素（通常用于表单元素和链接）。

```css
/* 输入框获得焦点 */
input:focus {
  outline: none;
  border-color: #007bff;
  box-shadow: 0 0 0 3px rgba(0,123,255,0.25);
}

/* 链接获得焦点（通过 Tab 键） */
a:focus {
  outline: 2px solid #007bff;
  outline-offset: 2px;
}
```

**可访问性提示**：`:focus` 样式对于键盘导航非常重要，不要移除焦点样式。

### 4. :focus-within

选择**包含获得焦点元素**的父元素。

```css
/* 当输入框获得焦点时，整个表单组高亮 */
.form-group:focus-within {
  background-color: #f8f9fa;
  border-left: 3px solid #007bff;
}
```

```html
<div class="form-group">
  <label>用户名</label>
  <input type="text">  <!-- 当这个输入框获得焦点时，整个 .form-group 会被选中 -->
</div>
```

### 5. :focus-visible

选择**通过键盘导航获得焦点**时的元素（不包括鼠标点击）。

```css
/* 只有通过键盘导航时才显示焦点样式 */
button:focus-visible {
  outline: 2px solid #007bff;
}

/* 鼠标点击时不显示焦点样式 */
button:focus:not(:focus-visible) {
  outline: none;
}
```

### 6. :visited

选择**已访问过的链接**。

```css
/* 已访问的链接 */
a:visited {
  color: purple;
}
```

**安全限制**：出于隐私考虑，浏览器对 `:visited` 伪类的样式有严格限制，只能设置颜色相关的属性。

### 7. :link

选择**未访问过的链接**。

```css
/* 未访问的链接 */
a:link {
  color: blue;
}
```

## 结构相关伪类

结构伪类根据元素在 DOM 中的位置来选择元素：

### 1. :first-child

选择**作为父元素第一个子元素**的元素。

```css
/* 选择第一个列表项 */
li:first-child {
  font-weight: bold;
}

/* 选择第一个段落 */
p:first-child {
  margin-top: 0;
}
```

```html
<ul>
  <li>第一项</li>      <!-- 被选中 -->
  <li>第二项</li>
  <li>第三项</li>
</ul>
```

### 2. :last-child

选择**作为父元素最后一个子元素**的元素。

```css
/* 选择最后一个列表项 */
li:last-child {
  border-bottom: none;
}

/* 选择最后一个段落 */
p:last-child {
  margin-bottom: 0;
}
```

### 3. :nth-child(n)

选择**作为父元素第 n 个子元素**的元素。

```css
/* 选择第 2 个子元素 */
li:nth-child(2) {
  color: red;
}

/* 选择所有偶数位置的子元素 */
li:nth-child(even) {
  background-color: #f5f5f5;
}

/* 选择所有奇数位置的子元素 */
li:nth-child(odd) {
  background-color: white;
}

/* 选择每 3 个元素（3, 6, 9...） */
li:nth-child(3n) {
  border-top: 1px solid #ccc;
}

/* 选择前 3 个元素 */
li:nth-child(-n+3) {
  font-weight: bold;
}
```

**nth-child 公式**：
- `nth-child(2)`：第 2 个
- `nth-child(even)`：偶数位置
- `nth-child(odd)`：奇数位置
- `nth-child(3n)`：每 3 个（3, 6, 9...）
- `nth-child(3n+1)`：每 3 个中的第 1 个（1, 4, 7...）
- `nth-child(-n+3)`：前 3 个

### 4. :nth-last-child(n)

选择**从后往前数第 n 个子元素**。

```css
/* 选择倒数第 2 个子元素 */
li:nth-last-child(2) {
  color: blue;
}

/* 选择最后 3 个元素 */
li:nth-last-child(-n+3) {
  background-color: yellow;
}
```

### 5. :first-of-type

选择**同类型元素中的第一个**。

```css
/* 选择第一个段落（即使前面有其他元素） */
p:first-of-type {
  font-size: 20px;
}
```

```html
<div>
  <h1>标题</h1>
  <p>第一个段落</p>    <!-- 被选中 -->
  <p>第二个段落</p>
</div>
```

### 6. :last-of-type

选择**同类型元素中的最后一个**。

```css
/* 选择最后一个段落 */
p:last-of-type {
  margin-bottom: 0;
}
```

### 7. :nth-of-type(n)

选择**同类型元素中的第 n 个**。

```css
/* 选择每 2 个段落 */
p:nth-of-type(2n) {
  background-color: #f5f5f5;
}
```

### 8. :only-child

选择**作为父元素唯一子元素**的元素。

```css
/* 选择唯一的子元素 */
.only-child {
  text-align: center;
}
```

### 9. :only-of-type

选择**同类型元素中唯一的元素**。

```css
/* 选择唯一的段落 */
p:only-of-type {
  font-size: 18px;
}
```

## 表单相关伪类

表单伪类用于选择处于特定状态的表单元素：

### 1. :checked

选择**被选中的复选框、单选按钮或选项**。

```css
/* 选中的复选框 */
input[type="checkbox"]:checked {
  background-color: #007bff;
}

/* 选中的单选按钮 */
input[type="radio"]:checked + label {
  font-weight: bold;
  color: #007bff;
}
```

### 2. :disabled

选择**被禁用的表单元素**。

```css
/* 禁用的输入框 */
input:disabled {
  background-color: #e9ecef;
  cursor: not-allowed;
  opacity: 0.6;
}
```

### 3. :enabled

选择**未被禁用的表单元素**。

```css
/* 启用的输入框 */
input:enabled {
  border-color: #007bff;
}
```

### 4. :required

选择**必填的表单元素**。

```css
/* 必填的输入框 */
input:required {
  border-left: 3px solid red;
}

input:required + label::after {
  content: " *";
  color: red;
}
```

### 5. :optional

选择**可选的表单元素**。

```css
/* 可选的输入框 */
input:optional {
  border-left: 3px solid green;
}
```

### 6. :valid

选择**通过验证的表单元素**。

```css
/* 有效的输入 */
input:valid {
  border-color: green;
}

input:valid + .error-message {
  display: none;
}
```

### 7. :invalid

选择**未通过验证的表单元素**。

```css
/* 无效的输入 */
input:invalid {
  border-color: red;
}

input:invalid + .error-message {
  display: block;
  color: red;
}
```

### 8. :in-range

选择**值在指定范围内的输入元素**。

```css
/* 值在范围内的输入 */
input[type="number"]:in-range {
  border-color: green;
}
```

### 9. :out-of-range

选择**值超出指定范围的输入元素**。

```css
/* 值超出范围的输入 */
input[type="number"]:out-of-range {
  border-color: red;
}
```

## 其他常用伪类

### 1. :not(selector)

选择**不匹配指定选择器**的元素。

```css
/* 选择不是第一个的段落 */
p:not(:first-child) {
  margin-top: 20px;
}

/* 选择没有 disabled 属性的按钮 */
button:not([disabled]) {
  cursor: pointer;
}

/* 选择不是 .highlight 的段落 */
p:not(.highlight) {
  color: #666;
}
```

### 2. :root

选择**文档的根元素**（通常是 `<html>`）。

```css
/* 在根元素上定义 CSS 变量 */
:root {
  --primary-color: #007bff;
  --font-size-base: 16px;
}
```

### 3. :empty

选择**没有任何子元素**的元素（包括文本节点）。

```css
/* 空元素 */
.empty-box:empty {
  display: none;
}

.empty-box:empty::before {
  content: "暂无内容";
  color: #999;
}
```

### 4. :target

选择**当前活动的目标元素**（URL 中的锚点）。

```css
/* 当前活动的目标元素 */
:target {
  background-color: yellow;
  padding: 10px;
}
```

```html
<a href="#section1">跳转到章节 1</a>
<section id="section1">
  <h2>章节 1</h2>  <!-- 当 URL 是 #section1 时，这个元素会被选中 -->
</section>
```

## 使用场景示例

### 示例 1：导航菜单

```css
/* 导航菜单样式 */
.nav-menu li {
  display: inline-block;
  margin: 0 10px;
}

/* 第一个和最后一个菜单项 */
.nav-menu li:first-child {
  margin-left: 0;
}

.nav-menu li:last-child {
  margin-right: 0;
}

/* 悬停效果 */
.nav-menu a:hover {
  color: #007bff;
  border-bottom: 2px solid #007bff;
}

/* 当前页面 */
.nav-menu a.active {
  color: #007bff;
  font-weight: bold;
}
```

### 示例 2：表格样式

```css
/* 表格行样式 */
table tr {
  border-bottom: 1px solid #ddd;
}

/* 偶数行背景 */
table tr:nth-child(even) {
  background-color: #f8f9fa;
}

/* 第一行样式 */
table tr:first-child {
  background-color: #333;
  color: white;
  font-weight: bold;
}

/* 悬停效果 */
table tr:hover {
  background-color: #e9ecef;
}
```

### 示例 3：表单验证

```css
/* 输入框基础样式 */
input {
  padding: 10px;
  border: 2px solid #ccc;
  border-radius: 4px;
}

/* 获得焦点 */
input:focus {
  outline: none;
  border-color: #007bff;
  box-shadow: 0 0 0 3px rgba(0,123,255,0.25);
}

/* 必填字段 */
input:required {
  border-left: 3px solid orange;
}

/* 有效输入 */
input:valid {
  border-color: green;
}

/* 无效输入 */
input:invalid {
  border-color: red;
}

input:invalid + .error {
  display: block;
  color: red;
  font-size: 12px;
}

/* 禁用状态 */
input:disabled {
  background-color: #e9ecef;
  cursor: not-allowed;
}
```

### 示例 4：卡片列表

```css
/* 卡片基础样式 */
.card {
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 20px;
  margin-bottom: 20px;
}

/* 第一个卡片 */
.card:first-child {
  margin-top: 0;
}

/* 最后一个卡片 */
.card:last-child {
  margin-bottom: 0;
}

/* 每 3 个卡片添加特殊样式 */
.card:nth-child(3n) {
  border-color: #007bff;
}

/* 悬停效果 */
.card:hover {
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  transform: translateY(-2px);
}

/* 空卡片 */
.card:empty {
  display: none;
}
```

## 与伪元素的区别

伪类和伪元素都使用冒号，但它们有重要区别：

| 特性 | 伪类 | 伪元素 |
|------|------|--------|
| 语法 | 单冒号 `:` | 双冒号 `::`（CSS3） |
| 作用 | 选择处于特定状态的元素 | 选择元素的特定部分 |
| 示例 | `:hover`、`:first-child` | `::before`、`::after` |
| 选择 | 选择整个元素 | 选择元素的一部分 |

```css
/* 伪类：选择处于悬停状态的链接 */
a:hover {
  color: red;
}

/* 伪元素：选择链接的第一行 */
a::first-line {
  font-weight: bold;
}
```

**注意**：为了兼容性，CSS3 之前的伪元素也支持单冒号（如 `:before`），但推荐使用双冒号（`::before`）。

## 小结

伪类让你能够根据元素的状态来选择元素：

- **交互伪类**：`:hover`、`:active`、`:focus` 等，响应用户交互
- **结构伪类**：`:first-child`、`:nth-child()` 等，根据位置选择
- **表单伪类**：`:checked`、`:disabled`、`:valid` 等，处理表单状态
- **其他伪类**：`:not()`、`:root`、`:empty`、`:target` 等

**使用建议**：
- 合理使用交互伪类提升用户体验
- 使用结构伪类创建有规律的样式
- 使用表单伪类改善表单体验
- 注意可访问性，不要移除焦点样式

掌握了伪类，你就能为元素的不同状态设置不同的样式。在下一章，我们将学习伪元素，了解如何选择元素的特定部分。
