---
sidebar_position: 2
slug: /css-text-font
---

# CSS 文本与字体属性

文本与字体属性是 CSS 中最基础、最常用的属性类别。它们控制着网页中文字的外观、排版和可读性。掌握这些属性，你就能创建美观、易读的文本内容。

## 该类属性解决什么问题

文本与字体属性主要解决以下问题：

1. **文本的可读性**：通过字体、大小、行高等属性，确保文本易于阅读
2. **视觉层次**：通过不同的字体大小、粗细、颜色，创建清晰的视觉层次
3. **文本排版**：通过对齐、间距、装饰等属性，控制文本的排版效果
4. **品牌一致性**：通过统一的字体和样式，保持品牌视觉一致性

## 核心属性介绍

### 字体属性

#### font-family

指定元素的字体族（字体列表）。

```css
/* 单个字体 */
p {
  font-family: Arial;
}

/* 字体列表（备用字体） */
p {
  font-family: "Helvetica Neue", Arial, sans-serif;
}

/* 通用字体族 */
p {
  font-family: serif;      /* 衬线字体 */
  font-family: sans-serif; /* 无衬线字体 */
  font-family: monospace;  /* 等宽字体 */
  font-family: cursive;     /* 手写字体 */
  font-family: fantasy;     /* 装饰字体 */
}
```

**最佳实践**：
- 提供多个备用字体
- 使用通用字体族作为最后的备用
- 字体名包含空格时使用引号

#### font-size

设置字体大小。

```css
/* 绝对单位 */
p {
  font-size: 16px;
  font-size: 1em;
  font-size: 1rem;
}

/* 相对单位 */
h1 {
  font-size: 2em;  /* 相对于父元素 */
  font-size: 2rem; /* 相对于根元素 */
}

/* 关键字 */
p {
  font-size: small;
  font-size: medium;
  font-size: large;
}
```

**推荐**：使用 `rem` 单位，便于统一管理和响应式设计。

#### font-weight

设置字体粗细。

```css
p {
  font-weight: normal;  /* 400 */
  font-weight: bold;    /* 700 */
  font-weight: 100;     /* 最细 */
  font-weight: 900;     /* 最粗 */
}
```

**常用值**：
- `normal`（400）：正常
- `bold`（700）：粗体
- `lighter`：比父元素更细
- `bolder`：比父元素更粗

#### font-style

设置字体样式。

```css
p {
  font-style: normal;  /* 正常 */
  font-style: italic;   /* 斜体 */
  font-style: oblique; /* 倾斜 */
}
```

#### font-variant

设置字体变体。

```css
p {
  font-variant: normal;
  font-variant: small-caps;  /* 小型大写字母 */
}
```

#### font（简写属性）

`font` 是多个字体属性的简写。

```css
/* 完整语法 */
p {
  font: [font-style] [font-variant] [font-weight] font-size [/line-height] font-family;
}

/* 示例 */
p {
  font: italic bold 16px/1.5 Arial, sans-serif;
}

/* 只设置部分属性 */
p {
  font: 16px Arial;  /* 只设置大小和字体族 */
}
```

### 文本属性

#### color

设置文本颜色。

```css
p {
  color: red;
  color: #ff0000;
  color: rgb(255, 0, 0);
  color: rgba(255, 0, 0, 0.5);
  color: hsl(0, 100%, 50%);
}
```

#### line-height

设置行高（行间距）。

```css
p {
  line-height: 1.5;      /* 无单位，相对于字体大小 */
  line-height: 24px;     /* 固定值 */
  line-height: 150%;     /* 百分比 */
}
```

**推荐**：使用无单位的值（如 `1.5`），它会相对于字体大小计算。

#### text-align

设置文本的水平对齐方式。

```css
p {
  text-align: left;    /* 左对齐（默认） */
  text-align: right;   /* 右对齐 */
  text-align: center;  /* 居中 */
  text-align: justify; /* 两端对齐 */
}
```

#### text-decoration

设置文本装饰线。

```css
a {
  text-decoration: none;        /* 无装饰 */
  text-decoration: underline;    /* 下划线 */
  text-decoration: overline;     /* 上划线 */
  text-decoration: line-through; /* 删除线 */
}

/* 可以组合使用 */
a {
  text-decoration: underline overline;
}
```

#### text-transform

设置文本的大小写转换。

```css
p {
  text-transform: none;       /* 不转换 */
  text-transform: uppercase;  /* 大写 */
  text-transform: lowercase;  /* 小写 */
  text-transform: capitalize; /* 首字母大写 */
}
```

#### text-indent

设置文本的首行缩进。

```css
p {
  text-indent: 2em;   /* 缩进 2 个字符 */
  text-indent: 20px;  /* 固定缩进 */
}
```

#### letter-spacing

设置字符间距。

```css
h1 {
  letter-spacing: 2px;   /* 增加间距 */
  letter-spacing: -1px;  /* 减少间距 */
  letter-spacing: normal; /* 正常 */
}
```

#### word-spacing

设置单词间距。

```css
p {
  word-spacing: 5px;    /* 增加间距 */
  word-spacing: normal;  /* 正常 */
}
```

#### text-shadow

设置文本阴影。

```css
h1 {
  text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
  /* 语法：x偏移 y偏移 模糊半径 颜色 */
}

/* 多个阴影 */
h1 {
  text-shadow: 
    2px 2px 4px rgba(0,0,0,0.3),
    0 0 10px rgba(255,0,0,0.5);
}
```

#### white-space

设置如何处理元素内的空白字符。

```css
p {
  white-space: normal;   /* 正常（合并空白，自动换行） */
  white-space: nowrap;   /* 不换行 */
  white-space: pre;      /* 保留空白，不自动换行 */
  white-space: pre-wrap; /* 保留空白，自动换行 */
  white-space: pre-line; /* 合并空白，保留换行 */
}
```

#### word-wrap / overflow-wrap

设置长单词的换行方式。

```css
p {
  word-wrap: break-word;     /* 旧语法 */
  overflow-wrap: break-word; /* 新语法 */
}
```

#### word-break

设置单词的换行规则。

```css
p {
  word-break: normal;    /* 正常换行 */
  word-break: break-all; /* 允许在任意字符间换行 */
  word-break: keep-all;  /* 只能在半角空格或连字符处换行 */
}
```

## 常见组合用法

### 1. 基础文本样式

```css
/* 文章正文 */
.article-body {
  font-family: "Helvetica Neue", Arial, sans-serif;
  font-size: 16px;
  line-height: 1.6;
  color: #333;
}
```

### 2. 标题样式

```css
/* 主标题 */
h1 {
  font-family: "Georgia", serif;
  font-size: 2.5rem;
  font-weight: bold;
  line-height: 1.2;
  color: #222;
  letter-spacing: -0.5px;
}

/* 副标题 */
h2 {
  font-size: 2rem;
  font-weight: 600;
  line-height: 1.3;
  margin-top: 2em;
  margin-bottom: 1em;
}
```

### 3. 链接样式

```css
/* 链接基础样式 */
a {
  color: #007bff;
  text-decoration: none;
  transition: color 0.3s;
}

/* 链接悬停 */
a:hover {
  color: #0056b3;
  text-decoration: underline;
}

/* 已访问链接 */
a:visited {
  color: #6c757d;
}
```

### 4. 代码样式

```css
/* 行内代码 */
code {
  font-family: "Courier New", monospace;
  font-size: 0.9em;
  background-color: #f4f4f4;
  padding: 2px 6px;
  border-radius: 3px;
}

/* 代码块 */
pre {
  font-family: "Courier New", monospace;
  font-size: 14px;
  line-height: 1.5;
  background-color: #f8f8f8;
  padding: 15px;
  border-radius: 5px;
  overflow-x: auto;
  white-space: pre;
}
```

### 5. 引用样式

```css
blockquote {
  font-style: italic;
  font-size: 1.1em;
  line-height: 1.6;
  color: #666;
  border-left: 4px solid #007bff;
  padding-left: 20px;
  margin: 20px 0;
}
```

## 示例演示

### 示例 1：文章排版

```html
<article class="article">
  <h1>文章标题</h1>
  <p class="lead">这是文章的引言段落，需要突出显示。</p>
  <p>这是正文段落，包含大量的文字内容。文本需要具有良好的可读性，包括合适的字体大小、行高和颜色。</p>
  <h2>章节标题</h2>
  <p>这是另一个段落，展示了文本的排版效果。</p>
</article>
```

```css
.article {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.article h1 {
  font-family: "Georgia", serif;
  font-size: 2.5rem;
  font-weight: bold;
  line-height: 1.2;
  color: #222;
  margin-bottom: 1rem;
}

.article .lead {
  font-size: 1.25rem;
  font-weight: 300;
  line-height: 1.6;
  color: #555;
  margin-bottom: 1.5rem;
}

.article p {
  font-family: "Helvetica Neue", Arial, sans-serif;
  font-size: 1rem;
  line-height: 1.8;
  color: #333;
  margin-bottom: 1.5rem;
  text-align: justify;
}

.article h2 {
  font-size: 1.75rem;
  font-weight: 600;
  line-height: 1.3;
  color: #333;
  margin-top: 2rem;
  margin-bottom: 1rem;
}
```

### 示例 2：按钮文字

```html
<button class="btn btn-primary">主要按钮</button>
<button class="btn btn-secondary">次要按钮</button>
```

```css
.btn {
  font-family: Arial, sans-serif;
  font-size: 16px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 1px;
  padding: 12px 24px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.3s;
}

.btn-primary {
  background-color: #007bff;
  color: white;
}

.btn-secondary {
  background-color: #6c757d;
  color: white;
}
```

### 示例 3：价格显示

```html
<div class="price">
  <span class="currency">¥</span>
  <span class="amount">99</span>
  <span class="decimal">.00</span>
</div>
```

```css
.price {
  font-family: Arial, sans-serif;
  font-weight: bold;
  color: #e74c3c;
}

.price .currency {
  font-size: 1.2em;
  vertical-align: top;
}

.price .amount {
  font-size: 2em;
  line-height: 1;
}

.price .decimal {
  font-size: 1.2em;
  opacity: 0.7;
}
```

## 使用建议

### 1. 建立字体系统

在项目开始时，建立统一的字体系统：

```css
:root {
  /* 字体族 */
  --font-family-base: "Helvetica Neue", Arial, sans-serif;
  --font-family-heading: "Georgia", serif;
  --font-family-code: "Courier New", monospace;
  
  /* 字体大小 */
  --font-size-base: 16px;
  --font-size-sm: 14px;
  --font-size-lg: 18px;
  --font-size-xl: 20px;
  
  /* 行高 */
  --line-height-base: 1.6;
  --line-height-heading: 1.2;
  
  /* 颜色 */
  --color-text: #333;
  --color-text-light: #666;
  --color-text-lighter: #999;
}

body {
  font-family: var(--font-family-base);
  font-size: var(--font-size-base);
  line-height: var(--line-height-base);
  color: var(--color-text);
}
```

### 2. 使用相对单位

优先使用相对单位（`rem`、`em`），便于响应式设计：

```css
/* 推荐 */
h1 {
  font-size: 2rem;  /* 相对于根元素 */
}

p {
  font-size: 1em;   /* 相对于父元素 */
  line-height: 1.5; /* 相对于字体大小 */
}
```

### 3. 注意可读性

确保文本具有良好的可读性：

- **字体大小**：正文至少 16px
- **行高**：1.5-1.8 之间
- **颜色对比度**：文本与背景的对比度至少 4.5:1
- **行宽**：每行 45-75 个字符

### 4. 合理使用字体粗细

使用不同的字体粗细创建视觉层次：

```css
h1 { font-weight: 700; }  /* 最粗 */
h2 { font-weight: 600; }
h3 { font-weight: 500; }
p  { font-weight: 400; }  /* 正常 */
```

### 5. 避免过度装饰

不要过度使用文本装饰：

```css
/* 不推荐：过度装饰 */
h1 {
  text-decoration: underline overline;
  text-shadow: 5px 5px 10px rgba(0,0,0,0.5);
  letter-spacing: 5px;
  text-transform: uppercase;
}

/* 推荐：适度装饰 */
h1 {
  font-weight: bold;
  letter-spacing: -0.5px;
}
```

## 小结

文本与字体属性是 CSS 的基础：

- **字体属性**：`font-family`、`font-size`、`font-weight`、`font-style` 等
- **文本属性**：`color`、`line-height`、`text-align`、`text-decoration` 等
- **组合使用**：合理组合这些属性，创建美观、易读的文本

**使用建议**：
- 建立统一的字体系统
- 使用相对单位
- 注意可读性
- 合理使用字体粗细
- 避免过度装饰

掌握了文本与字体属性，你就能创建专业、美观的文本内容。在下一章，我们将学习背景与边框属性，了解如何为元素添加视觉装饰。
