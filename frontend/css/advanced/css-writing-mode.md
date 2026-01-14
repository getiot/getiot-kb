---
sidebar_position: 9
slug: /css-writing-mode
---

# CSS 书写模式与国际化

书写模式（Writing Mode）决定了文本的流向和块方向。针对中文、日文等竖排需求，以及从右到左的语言（如阿拉伯语、希伯来语），掌握书写模式和相关属性是实现国际化排版的关键。

## 为什么需要这个特性

1. **国际化排版**：支持竖排（top-to-bottom）和 RTL（right-to-left）语言  
2. **文化适配**：符合不同语言的阅读习惯（如杂志式竖排）  
3. **布局灵活**：改变行进方向，影响流动、滚动与对齐  
4. **组件兼容**：在国际化场景下保持组件布局正确  
5. **无障碍与可访问性**：更符合母语阅读体验

## 核心概念解释

### writing-mode
控制文本流向（行的方向）和块方向。
```css
writing-mode: horizontal-tb;   /* 水平，从左到右，从上到下（默认） */
writing-mode: vertical-rl;     /* 竖排，从上到下，每列从右到左 */
writing-mode: vertical-lr;     /* 竖排，从上到下，每列从左到右 */
writing-mode: sideways-rl;     /* 文本方向横向旋转，行从右到左 */
writing-mode: sideways-lr;     /* 文本方向横向旋转，行从左到右 */
```

### direction
控制行内内容的书写方向（主要针对 RTL）。
```css
direction: ltr; /* 从左到右（默认） */
direction: rtl; /* 从右到左（阿拉伯语、希伯来语） */
```

### text-orientation
控制竖排模式下字符的方向（仅竖排生效）。
```css
text-orientation: mixed;      /* 默认，西文横置，东亚文字直立 */
text-orientation: upright;    /* 所有字符直立 */
text-orientation: sideways;   /* 所有字符横置 */
```

## 常见用法

### 1. 竖排中文
```css
.vertical-cn {
  writing-mode: vertical-rl;   /* 竖排，从右到左 */
  text-orientation: mixed;     /* 汉字直立，西文横置 */
  line-height: 1.6;
}
```

### 2. RTL 页面
```css
html[dir=\"rtl\"] {
  direction: rtl;
}
```

### 3. 竖排标题
```css
.vertical-title {
  writing-mode: vertical-rl;
  text-orientation: upright;
  letter-spacing: 0.1em;
}
```

## 示例

### 示例 1：竖排卡片
```css
.card-vertical {
  writing-mode: vertical-rl;
  text-orientation: mixed;
  width: 200px;
  border: 1px solid #ddd;
  padding: 12px;
}
```

### 示例 2：RTL 表单
```css
form[dir=\"rtl\"] {
  direction: rtl;
  text-align: right;
}

form[dir=\"rtl\"] label {
  display: block;
  margin-bottom: 8px;
}
```

## 注意事项

1. **对齐与流动**：改变书写模式会影响 `text-align`、滚动方向和块方向，注意联动。  
2. **混合内容**：竖排时 `text-orientation` 很重要，确保西文和数字显示正常。  
3. **组件适配**：RTL 场景下需要检查导航、箭头、图标方向。  
4. **表单与输入**：输入框在 RTL/竖排下的光标与对齐需测试。  
5. **浏览器兼容**：现代浏览器支持良好，旧版需测试；`sideways-*` 支持度略差。  
6. **打印与导出**：竖排可能影响打印版式，注意测试。  
7. **可访问性**：尊重用户语言/方向设置，避免强制覆盖全局方向。

掌握书写模式与方向属性，你就能为不同语言和文化提供正确的阅读体验，并在竖排、RTL 场景下保持布局与交互的正确性。 
