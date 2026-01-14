---
sidebar_position: 8
slug: /css-multi-columns
---

# CSS 多列布局

多列布局（Multi-column）让文本像报纸排版一样分成多列，自动分栏、流动和对齐，适合长文、多段落内容的阅读场景。

## 为什么需要这个特性

1. **提高可读性**：长文分栏减少视线移动距离  
2. **自动分配**：内容自动在列间流动，无需手写列宽与浮动  
3. **简单语法**：少量属性即可完成分栏  
4. **兼容性良好**：主流浏览器普遍支持  
5. **独立于布局**：不影响整体布局结构，可局部使用

## 核心概念解释

### column-count
设置列数。
```css
.article { column-count: 3; }
```

### column-width
设置列的理想宽度（浏览器会在宽度和列数之间取舍）。
```css
.article { column-width: 240px; }
```

### column-gap
设置列间距。
```css
.article { column-gap: 24px; }
```

### column-rule
设置列间分隔线（类似 border，需至少指定 style）。
```css
.article {
  column-rule: 1px solid #e0e0e0;
}
```

### column-span
元素跨列显示（常用于标题）。
```css
.article h2 {
  column-span: all;
}
```

### columns（简写）
`column-count` 与 `column-width` 的简写。
```css
.article {
  columns: 3 240px; /* 列数 3，理想宽 240px */
}
```

## 常见用法

### 1. 指定列数
```css
.article {
  column-count: 3;
  column-gap: 24px;
}
```

### 2. 指定列宽
```css
.article {
  column-width: 280px;
  column-gap: 24px;
}
```

### 3. 分隔线
```css
.article {
  column-count: 2;
  column-rule: 1px solid #ddd;
}
```

### 4. 标题跨列
```css
.article h2 {
  column-span: all;
  margin-top: 1.5em;
}
```

## 示例

### 示例 1：新闻分栏
```css
.news {
  column-count: 3;
  column-gap: 20px;
  column-rule: 1px solid #eee;
}

.news h2 {
  column-span: all;
  margin: 0 0 1em;
}
```

### 示例 2：宽度优先
```css
.content {
  column-width: 260px;
  column-gap: 24px;
}
```

## 注意事项

1. **内容流动**：列高不一致时，内容按顺序流入下一列，无法轻易“平衡”高度。  
2. **跨列限制**：`column-span` 仅作用于块级元素，不是所有元素都支持。  
3. **与分页不同**：多列只是视觉分栏，不会分页。  
4. **不要用于复杂布局**：多列主要适合长文本，不适合复杂组件网格，复杂布局请用 Grid/Flex。  
5. **打印与可访问性**：分栏可能影响打印与阅读顺序，注意测试。  
6. **降级方案**：旧浏览器可保持单列显示，内容仍可阅读。

掌握多列布局，你可以在长文本场景下快速实现报纸式分栏，提升可读性，而无需编写复杂的网格或浮动样式。 
