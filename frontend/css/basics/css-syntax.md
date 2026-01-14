---
sidebar_position: 2
slug: /css-syntax
---

# CSS 语法规则

## CSS 语法基础

CSS 的语法非常简单，主要由三个部分组成：

1. **选择器（Selector）**：选择要应用样式的 HTML 元素
2. **属性（Property）**：定义要修改的样式属性
3. **值（Value）**：为属性设置具体的值

### 基本语法结构

```css
选择器 {
  属性1: 值1;
  属性2: 值2;
  属性3: 值3;
}
```

### 示例

```css
p {
  color: blue;
  font-size: 16px;
  text-align: center;
}
```

这段代码的含义是：
- **选择器**：`p`（选择所有段落元素）
- **属性**：`color`（颜色）、`font-size`（字体大小）、`text-align`（文本对齐）
- **值**：`blue`（蓝色）、`16px`（16 像素）、`center`（居中）

## 选择器详解

选择器用于选择要应用样式的 HTML 元素。常见的选择器类型包括：

### 1. 元素选择器

直接使用 HTML 标签名作为选择器：

```css
p {
  color: red;
}

h1 {
  font-size: 24px;
}

div {
  background-color: yellow;
}
```

### 2. 类选择器

使用 `.` 前缀选择具有特定 class 属性的元素：

```css
.highlight {
  background-color: yellow;
}

.text-center {
  text-align: center;
}
```

对应的 HTML：

```html
<p class="highlight">这段文字会被高亮</p>
<div class="text-center">这段文字会居中</div>
```

### 3. ID 选择器

使用 `#` 前缀选择具有特定 id 属性的元素：

```css
#header {
  background-color: blue;
  color: white;
}

#footer {
  padding: 20px;
}
```

对应的 HTML：

```html
<div id="header">这是页头</div>
<div id="footer">这是页脚</div>
```

**注意**：ID 选择器应该用于唯一的元素，一个页面中同一个 ID 只能出现一次。

### 4. 组合选择器

你可以组合多个选择器来更精确地选择元素：

```css
/* 选择所有 p 标签和 h1 标签 */
p, h1 {
  color: blue;
}

/* 选择 class 为 "container" 的 div 标签 */
div.container {
  padding: 20px;
}

/* 选择 id 为 "main" 的元素下的所有 p 标签 */
#main p {
  font-size: 14px;
}
```

## 属性与值

### 属性

CSS 属性定义了要修改的样式特性，常见的属性包括：

- **颜色相关**：`color`、`background-color`、`border-color`
- **字体相关**：`font-family`、`font-size`、`font-weight`
- **布局相关**：`width`、`height`、`margin`、`padding`
- **定位相关**：`position`、`top`、`left`、`right`、`bottom`
- **显示相关**：`display`、`visibility`、`opacity`

### 值

CSS 值可以是多种类型：

#### 1. 关键字值

```css
text-align: center;    /* 居中 */
display: block;        /* 块级元素 */
position: relative;    /* 相对定位 */
```

#### 2. 数值

```css
font-size: 16px;       /* 像素值 */
width: 50%;            /* 百分比 */
margin: 10px 20px;     /* 多个值 */
```

#### 3. 颜色值

```css
color: red;                    /* 颜色名称 */
color: #ff0000;                /* 十六进制 */
color: rgb(255, 0, 0);         /* RGB */
color: rgba(255, 0, 0, 0.5);   /* RGBA（带透明度） */
color: hsl(0, 100%, 50%);      /* HSL */
```

#### 4. URL 值

```css
background-image: url('image.jpg');
background-image: url('https://example.com/image.png');
```

## CSS 规则集

一个完整的 CSS 规则集包括：

```css
/* 注释：这是选择器 */
选择器 {
  属性1: 值1;    /* 属性声明 */
  属性2: 值2;    /* 属性声明 */
  属性3: 值3;    /* 属性声明 */
}
```

### 多个属性

一个选择器可以包含多个属性：

```css
p {
  color: blue;
  font-size: 16px;
  line-height: 1.5;
  margin: 10px 0;
  padding: 5px;
}
```

### 多个选择器

多个选择器可以共享相同的样式：

```css
h1, h2, h3 {
  color: blue;
  font-family: Arial, sans-serif;
}
```

## CSS 注释

CSS 注释用于解释代码，不会被浏览器执行。注释的语法：

```css
/* 这是单行注释 */

/* 
   这是多行注释
   可以跨越多行
*/

p {
  color: blue; /* 行内注释 */
}
```

**注意**：CSS 注释不支持嵌套，即不能在一个注释内部再写另一个注释。

## 大小写敏感性

CSS 对大小写不敏感，但有一些例外：

- **选择器**：通常不区分大小写（但建议保持一致性）
- **属性名**：不区分大小写
- **属性值**：大多数情况下不区分大小写
- **类名和 ID**：在 HTML 中是区分大小写的，所以 CSS 选择器也要匹配

```css
/* 这些写法是等价的 */
P { color: red; }
p { color: red; }
P { COLOR: RED; }

/* 但类名和 ID 是区分大小写的 */
.MyClass { }  /* 匹配 class="MyClass" */
.myclass { }  /* 匹配 class="myclass" */
```

## 空格和换行

CSS 对空格和换行不敏感，以下写法都是等价的：

```css
/* 写法 1：标准格式 */
p {
  color: blue;
  font-size: 16px;
}

/* 写法 2：单行格式 */
p { color: blue; font-size: 16px; }

/* 写法 3：紧凑格式 */
p{color:blue;font-size:16px;}
```

但为了代码的可读性和维护性，建议使用标准格式（写法 1）。

## 常见错误

### 1. 缺少分号

```css
/* 错误 */
p {
  color: blue
  font-size: 16px;
}

/* 正确 */
p {
  color: blue;
  font-size: 16px;
}
```

### 2. 缺少花括号

```css
/* 错误 */
p
  color: blue;

/* 正确 */
p {
  color: blue;
}
```

### 3. 属性值缺少引号（某些情况下）

```css
/* 错误（当值包含空格时） */
font-family: Times New Roman;

/* 正确 */
font-family: "Times New Roman";
```

### 4. 选择器拼写错误

```css
/* 错误 */
.contaner { }  /* 拼写错误 */

/* 正确 */
.container { }
```

## 实际示例

让我们看一个完整的 CSS 示例：

```css
/* 全局样式 */
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  background-color: #f5f5f5;
}

/* 标题样式 */
h1 {
  color: #333;
  font-size: 32px;
  text-align: center;
  margin: 20px 0;
}

/* 段落样式 */
p {
  color: #666;
  font-size: 16px;
  line-height: 1.6;
  margin: 10px 0;
}

/* 高亮样式 */
.highlight {
  background-color: yellow;
  padding: 2px 4px;
  font-weight: bold;
}

/* 容器样式 */
.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}
```

## 小结

CSS 语法非常简单，主要包括：

- **选择器**：选择要应用样式的元素
- **属性**：定义要修改的样式特性
- **值**：为属性设置具体的值

掌握这些基础知识后，你就可以开始编写 CSS 样式了。在接下来的教程中，你将学习更多选择器类型、CSS 属性以及如何将 CSS 应用到 HTML 文档中。
