---
sidebar_position: 15
---

# HTML 表格

在 HTML 中，表格用于以行和列的形式展示结构化数据。通过 `<table>` 元素，你可以创建一个包含多个单元格的表格，每个单元格由行（`<tr>`）和列（`<td>` 或 `<th>`）组成。



## 表格的基本结构

一个简单的 HTML 表格结构如下：

```html showLineNumbers
<table>
  <tr>
    <th>月份</th>
    <th>收入</th>
    <th>支出</th>
  </tr>
  <tr>
    <td>一月</td>
    <td>￥3000</td>
    <td>￥3200</td>
  </tr>
  <tr>
    <td>二月</td>
    <td>￥3500</td>
    <td>￥2800</td>
  </tr>
</table>
```

在上述示例中：

- `<table>`：定义表格的开始和结束。
- `<tr>`：定义表格中的一行。
- `<th>`：定义表头单元格，内容通常加粗并居中。
- `<td>`：定义数据单元格，显示普通数据。

显示效果：

> <table>
>   <tr>
>     <th>月份</th>
>     <th>收入</th>
>     <th>支出</th>
>   </tr>
>   <tr>
>     <td>一月</td>
>     <td>￥3000</td>
>     <td>￥3200</td>
>   </tr>
>   <tr>
>     <td>二月</td>
>     <td>￥3500</td>
>     <td>￥2800</td>
>   </tr>
> </table>



## 表格标题元素

HTML 提供了 `<caption>` 元素为表格添加标题。在使用上，它必须紧跟在 `<table>` 标签后。并且每个表格只能设置一个标题。

默认情况下，表格标题将在表格上方居中对齐，你可以通过 CSS 属性 `text-align` 和 `caption-side` 进行调整。

示例：为表格增加标题

```html showLineNumbers
<table>
  <caption>资产负债表</caption>
  <tr>
    <th>月份</th>
    <th>收入</th>
    <th>支出</th>
  </tr>
  <tr>
    <td>一月</td>
    <td>￥3000</td>
    <td>￥3200</td>
  </tr>
  <tr>
    <td>二月</td>
    <td>￥3500</td>
    <td>￥2800</td>
  </tr>
</table>
```

显示效果：

> <table>
>   <caption>资产负债表</caption>
>   <tr>
>     <th>月份</th>
>     <th>收入</th>
>     <th>支出</th>
>   </tr>
>   <tr>
>     <td>一月</td>
>     <td>￥3000</td>
>     <td>￥3200</td>
>   </tr>
>   <tr>
>     <td>二月</td>
>     <td>￥3500</td>
>     <td>￥2800</td>
>   </tr>
> </table>



## 表格的增强语义元素

除了 `<caption>`，HTML 还提供了其他一些元素，用于增强表格的语义和可读性：

- `<thead>`：定义表格的表头部分。
- `<tbody>`：定义表格的主体部分。
- `<tfoot>`：定义表格的页脚部分。

这些元素有助于结构化表格内容，特别是在处理大型数据表时。

示例：为表格增加语义信息

```html showLineNumbers
<table>
  <caption>资产负债表</caption>
  <thead>
    <tr>
      <th>月份</th>
      <th>收入</th>
      <th>支出</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>一月</td>
      <td>￥3000</td>
      <td>￥3200</td>
    </tr>
    <tr>
      <td>二月</td>
      <td>￥3500</td>
      <td>￥2800</td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td>总计</td>
      <td>￥6500</td>
      <td>￥6000</td>
    </tr>
  </tfoot>
</table>
```

显示效果：

> <table>
>   <caption>资产负债表</caption>
>   <thead>
>     <tr>
>       <th>月份</th>
>       <th>收入</th>
>       <th>支出</th>
>     </tr>
>   </thead>
>   <tbody>
>     <tr>
>       <td>一月</td>
>       <td>￥3000</td>
>       <td>￥3200</td>
>     </tr>
>     <tr>
>       <td>二月</td>
>       <td>￥3500</td>
>       <td>￥2800</td>
>     </tr>
>   </tbody>
>   <tfoot>
>     <tr>
>       <td>总计</td>
>       <td>￥6500</td>
>       <td>￥6000</td>
>     </tr>
>   </tfoot>
> </table>



## 表格的样式设置

你可以使用 CSS 来美化表格，例如添加边框、设置单元格间距、背景颜色等：

```html showLineNumbers
<style>
  table {
    border-collapse: collapse;
    width: 100%;
  }
  th, td {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
  }
  th {
    background-color: #f2f2f2;
  }
</style>
```

上述样式将表格的边框合并，设置了单元格的边框、对齐方式和内边距，并为表头添加了背景色。



## 合并单元格

有时，你可能需要让一个单元格横跨多列或多行，可以使用 `colspan` 和 `rowspan` 属性：

```html showLineNumbers
<table>
  <tr>
    <th colspan="2">姓名</th>
    <th>年龄</th>
  </tr>
  <tr>
    <td>张</td>
    <td>三</td>
    <td>28</td>
  </tr>
</table>
```

在这个示例中，第一个表头单元格横跨了两列。

显示效果：

> <table>
>   <tr>
>     <th colspan="2">姓名</th>
>     <th>年龄</th>
>   </tr>
>   <tr>
>     <td>张</td>
>     <td>三</td>
>     <td>28</td>
>   </tr>
> </table>



## 表格的可访问性

为了提高表格的可访问性，建议：

- 为表格添加 `<caption>`，提供简要描述。
- 使用 `<th>` 定义表头，并结合 `scope` 属性明确关联关系。
- 对于复杂的表格，使用 `<thead>`、`<tbody>` 和 `<tfoot>` 分隔不同部分。

这些做法有助于屏幕阅读器更好地解析表格内容，提升用户体验。



## 小结

通过本节的学习，你掌握了 HTML 表格的基本结构和常用元素（`<table>`、`<tr>`、`<td>` 和 `<th>`），以及增强语义元素（`<caption>`、`<thead>`、`<tbody>` 和 `<tfoot>` ）的使用，还了解了如何使用 CSS 美化表格，以及横跨多行多列的表格控制。在实际开发中，合理使用表格可以有效地展示结构化数据，提升网页的可读性和用户体验。
