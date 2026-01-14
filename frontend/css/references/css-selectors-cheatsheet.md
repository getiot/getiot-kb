---
sidebar_position: 2
slug: /css-selectors-cheatsheet
---

# CSS 选择器速查表

选择器是 CSS 的入口，也是影响样式可维护性的重要因素。本文汇总了常见的 CSS 选择器形式，包括基础选择器、组合选择器、伪类与伪元素。

## 基础选择器

| 选择器 | 语法 | 示例 | 说明 |
|--------|------|------|------|
| 元素选择器 | `element` | `p`, `div` | 选择所有该元素 |
| 类选择器 | `.class` | `.button`, `.card` | 选择具有该类的元素 |
| ID 选择器 | `#id` | `#header`, `#main` | 选择具有该 ID 的元素 |
| 通用选择器 | `*` | `*` | 选择所有元素 |

## 属性选择器

| 选择器 | 语法 | 示例 | 说明 |
|--------|------|------|------|
| 存在 | `[attr]` | `[disabled]` | 选择具有该属性的元素 |
| 精确匹配 | `[attr="value"]` | `[type="text"]` | 属性值精确匹配 |
| 开头匹配 | `[attr^="value"]` | `[href^="http"]` | 属性值以 value 开头 |
| 结尾匹配 | `[attr$="value"]` | `[href$=".pdf"]` | 属性值以 value 结尾 |
| 包含匹配 | `[attr*="value"]` | `[class*="btn"]` | 属性值包含 value |
| 单词匹配 | `[attr~="value"]` | `[class~="active"]` | 属性值包含单词 value |

## 组合选择器

| 选择器 | 语法 | 示例 | 说明 |
|--------|------|------|------|
| 后代选择器 | `A B` | `div p` | 选择 A 内部的所有 B |
| 子选择器 | `A > B` | `div > p` | 选择 A 的直接子元素 B |
| 相邻兄弟 | `A + B` | `h1 + p` | 选择紧接在 A 后面的 B |
| 通用兄弟 | `A ~ B` | `h1 ~ p` | 选择 A 后面的所有 B |
| 链式组合 | `A.B` | `button.primary` | 同时满足 A 和 B |
| 列表组合 | `A, B` | `h1, h2` | 选择 A 或 B |

## 伪类选择器

### 交互伪类

| 选择器 | 语法 | 说明 |
|--------|------|------|
| `:hover` | `a:hover` | 鼠标悬停 |
| `:active` | `button:active` | 激活状态 |
| `:focus` | `input:focus` | 获得焦点 |
| `:focus-within` | `.form:focus-within` | 包含焦点元素 |
| `:focus-visible` | `button:focus-visible` | 键盘焦点 |
| `:visited` | `a:visited` | 已访问链接 |
| `:link` | `a:link` | 未访问链接 |

### 结构伪类

| 选择器 | 语法 | 说明 |
|--------|------|------|
| `:first-child` | `li:first-child` | 第一个子元素 |
| `:last-child` | `li:last-child` | 最后一个子元素 |
| `:nth-child(n)` | `li:nth-child(2)` | 第 n 个子元素 |
| `:nth-last-child(n)` | `li:nth-last-child(2)` | 倒数第 n 个子元素 |
| `:first-of-type` | `p:first-of-type` | 第一个同类型元素 |
| `:last-of-type` | `p:last-of-type` | 最后一个同类型元素 |
| `:nth-of-type(n)` | `p:nth-of-type(2)` | 第 n 个同类型元素 |
| `:only-child` | `div:only-child` | 唯一子元素 |
| `:only-of-type` | `p:only-of-type` | 唯一同类型元素 |

### 表单伪类

| 选择器 | 语法 | 说明 |
|--------|------|------|
| `:checked` | `input:checked` | 选中状态 |
| `:disabled` | `input:disabled` | 禁用状态 |
| `:enabled` | `input:enabled` | 启用状态 |
| `:required` | `input:required` | 必填字段 |
| `:optional` | `input:optional` | 可选字段 |
| `:valid` | `input:valid` | 有效输入 |
| `:invalid` | `input:invalid` | 无效输入 |

### 其他伪类

| 选择器 | 语法 | 说明 |
|--------|------|------|
| `:not(selector)` | `:not(.hidden)` | 不匹配选择器 |
| `:root` | `:root` | 根元素 |
| `:empty` | `div:empty` | 空元素 |
| `:target` | `:target` | 目标元素 |

## 伪元素选择器

| 选择器 | 语法 | 说明 |
|--------|------|------|
| `::before` | `p::before` | 元素内容之前 |
| `::after` | `p::after` | 元素内容之后 |
| `::first-line` | `p::first-line` | 第一行 |
| `::first-letter` | `p::first-letter` | 首字母 |
| `::selection` | `::selection` | 选中文本 |
| `::placeholder` | `input::placeholder` | 占位符 |
| `::marker` | `li::marker` | 列表标记 |

## 特异性计算

| 选择器类型 | 特异性 | 示例 |
|-----------|--------|------|
| 内联样式 | 1000 | `style="..."` |
| ID 选择器 | 100 | `#header` |
| 类/属性/伪类 | 10 | `.button`, `:hover` |
| 元素/伪元素 | 1 | `p`, `::before` |
| 通用选择器 | 0 | `*` |

**计算规则**：
- 从左到右比较
- 数值越大优先级越高
- 相同特异性时，后出现的生效

## 常用选择器模式

### 实用组合

```css
/* 清除最后一个元素的边距 */
.item:last-child {
  margin-bottom: 0;
}

/* 表格斑马纹 */
tr:nth-child(even) {
  background-color: #f5f5f5;
}

/* 禁用状态 */
.button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

/* 必填字段标记 */
input:required + label::after {
  content: " *";
  color: red;
}
```

## 使用建议

- **优先使用类选择器**：灵活、可复用
- **避免过度嵌套**：最多 3-4 层
- **理解特异性**：避免样式冲突
- **合理使用伪类**：提供交互反馈
- **注意性能**：避免过于复杂的选择器

这份速查表帮助你快速查找和确认选择器语法，详细用法请参考教程正文。
