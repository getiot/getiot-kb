---
sidebar_position: 11
slug: /css-at-rules
---

# CSS @ 规则概览

`@` 规则是 CSS 中的“指令”，用于导入样式、定义字体、声明动画、媒体查询等。掌握常见 @ 规则，可以更好地组织和控制样式行为。

## 为什么需要这个特性

1. **模块化**：通过 `@import` 分拆样式  
2. **条件应用**：用 `@media`、`@supports` 针对不同环境  
3. **资源定义**：用 `@font-face` 定义自定义字体  
4. **动画与关键帧**：用 `@keyframes` 定义动画  
5. **层叠层**：用 `@layer` 明确层级顺序  
6. **国际化与页面规则**：用 `@page`、`@charset` 等控制文档级别

## 常见 @ 规则

### @import
导入外部样式，可附带媒体查询。
```css
@import url(\"base.css\");
@import url(\"print.css\") print;
@import url(\"responsive.css\") screen and (max-width: 768px);
```

### @media
媒体查询，根据设备特性条件应用样式。
```css
@media (max-width: 768px) {
  .container { padding: 12px; }
}
```

### @supports
特性查询，检测浏览器是否支持某特性。
```css
@supports (display: grid) {
  .layout { display: grid; }
}
```

### @font-face
定义自定义字体。
```css
@font-face {
  font-family: \"Inter\";
  src: url(\"/fonts/Inter.woff2\") format(\"woff2\");
  font-weight: 400 700;
  font-display: swap;
}
```

### @keyframes
定义 CSS 动画关键帧。
```css
@keyframes fade-in {
  from { opacity: 0; }
  to   { opacity: 1; }
}
```

### @layer
定义层叠层，控制覆盖顺序。
```css
@layer reset, base, components;
```

### @page
控制打印页面的尺寸、页边距等（打印样式）。
```css
@page {
  margin: 1in;
  size: A4 portrait;
}
```

### @counter-style
定义自定义列表编号样式。
```css
@counter-style emoji {
  system: numeric;
  symbols: \"😀\" \"😃\" \"😄\" \"😁\" \"😆\" \"😅\" \"😂\" \"🤣\" \"😊\" \"😇\";
}
ol.emoji { list-style: emoji; }
```

### @namespace
为 XML/MathML/SVG 指定命名空间（较少使用）。

## 示例

### 示例 1：响应式 + 特性查询
```css
@media (max-width: 768px) {
  .grid { display: block; }
}

@supports (display: grid) {
  .grid { display: grid; }
}
```

### 示例 2：字体与动画
```css
@font-face {
  font-family: \"Custom\";
  src: url(\"custom.woff2\") format(\"woff2\");
}

@keyframes pop {
  0%   { transform: scale(0.9); opacity: 0; }
  100% { transform: scale(1);   opacity: 1; }
}

.title {
  font-family: \"Custom\", sans-serif;
  animation: pop 0.4s ease;
}
```

### 示例 3：层叠层与导入
```css
@layer reset, base, theme, components;
@import url(\"reset.css\") layer(reset);
@import url(\"theme.css\") layer(theme);
@import url(\"components.css\") layer(components);
```

## 注意事项

1. **@import 顺序与性能**：`@import` 会阻塞渲染，推荐使用 `<link>` 或打包工具；若使用 `@import`，放在文件顶部，并尽量减少次数。  
2. **@layer 顺序**：层级由首次声明顺序决定，与出现位置无关。  
3. **@media 与 @supports 嵌套**：可以嵌套以细化条件。  
4. **字体加载策略**：`font-display: swap;` 改善首屏渲染；提供多格式。  
5. **打印样式**：`@page` 仅在打印时生效，注意测试。  
6. **兼容性**：`@layer`、部分特性查询在旧浏览器不支持，需要降级策略。  
7. **作用域与优先级**：记住 @ 规则本身不改变特异性，仍遵循层叠与层的顺序。

掌握常见 @ 规则，你可以更有条理地组织样式，针对不同环境提供最佳体验，同时保持代码的可维护性。 
