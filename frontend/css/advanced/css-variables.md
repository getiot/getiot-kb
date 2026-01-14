---
sidebar_position: 1
slug: /css-variables
---

# CSS 变量（自定义属性）

CSS 变量（也称为自定义属性）是 CSS3 引入的强大特性，它允许你在 CSS 中定义可复用的值，并在整个样式表中使用。CSS 变量让样式管理变得更加灵活和可维护。

## 为什么需要这个特性

在 CSS 变量出现之前，如果你想要在整个网站中使用相同的颜色、字体大小等值，你需要：

1. **重复定义**：在每个需要的地方重复写相同的值
2. **难以维护**：要修改时需要在多个地方修改
3. **容易出错**：可能遗漏某些地方，导致样式不一致

```css
/* 没有 CSS 变量时 */
.button-primary {
  background-color: #007bff;
  color: white;
}

.link {
  color: #007bff;
}

.border {
  border-color: #007bff;
}

/* 要修改主色，需要在多个地方修改 */
```

有了 CSS 变量，你可以：

1. **集中管理**：在一个地方定义值
2. **易于维护**：修改一处即可影响所有使用的地方
3. **动态更新**：可以通过 JavaScript 动态修改
4. **作用域控制**：可以在不同作用域定义不同的值

```css
/* 使用 CSS 变量 */
:root {
  --primary-color: #007bff;
}

.button-primary {
  background-color: var(--primary-color);
}

.link {
  color: var(--primary-color);
}

/* 只需修改一处 */
```

## 核心概念解释

### 定义变量

CSS 变量以两个连字符（`--`）开头，定义在某个选择器中：

```css
:root {
  --primary-color: #007bff;
  --font-size-base: 16px;
  --spacing-unit: 8px;
}
```

**命名规范**：
- 使用两个连字符（`--`）开头
- 使用有意义的名称
- 使用 kebab-case（短横线命名）

### 使用变量

使用 `var()` 函数来引用变量：

```css
.element {
  color: var(--primary-color);
  font-size: var(--font-size-base);
  padding: var(--spacing-unit);
}
```

### 变量作用域

CSS 变量有作用域，遵循 CSS 的层叠规则：

```css
/* 全局变量（根元素） */
:root {
  --color: blue;
}

/* 局部变量（特定元素） */
.container {
  --color: red;  /* 覆盖全局变量 */
}

/* 使用变量 */
.element {
  color: var(--color);  /* 在 .container 内是红色，其他地方是蓝色 */
}
```

### 默认值

`var()` 函数可以接受第二个参数作为默认值：

```css
.element {
  color: var(--primary-color, blue);  /* 如果变量不存在，使用 blue */
  padding: var(--spacing, 10px);      /* 如果变量不存在，使用 10px */
}
```

## 常见用法

### 1. 颜色系统

建立统一的颜色系统：

```css
:root {
  /* 主色 */
  --color-primary: #007bff;
  --color-primary-dark: #0056b3;
  --color-primary-light: #66b3ff;
  
  /* 辅助色 */
  --color-success: #28a745;
  --color-danger: #dc3545;
  --color-warning: #ffc107;
  
  /* 中性色 */
  --color-text: #333;
  --color-text-light: #666;
  --color-text-lighter: #999;
  --color-bg: #fff;
  --color-bg-light: #f5f5f5;
}
```

### 2. 间距系统

建立统一的间距系统：

```css
:root {
  --spacing-unit: 8px;
  --spacing-xs: calc(var(--spacing-unit) * 0.5);  /* 4px */
  --spacing-sm: var(--spacing-unit);              /* 8px */
  --spacing-md: calc(var(--spacing-unit) * 2);    /* 16px */
  --spacing-lg: calc(var(--spacing-unit) * 3);    /* 24px */
  --spacing-xl: calc(var(--spacing-unit) * 4);    /* 32px */
}
```

### 3. 字体系统

建立统一的字体系统：

```css
:root {
  --font-family-base: "Helvetica Neue", Arial, sans-serif;
  --font-family-heading: "Georgia", serif;
  --font-family-code: "Courier New", monospace;
  
  --font-size-base: 16px;
  --font-size-sm: 14px;
  --font-size-lg: 18px;
  --font-size-xl: 20px;
  
  --line-height-base: 1.6;
  --line-height-heading: 1.2;
}
```

### 4. 响应式变量

使用媒体查询创建响应式变量：

```css
:root {
  --container-width: 1200px;
  --font-size-base: 16px;
}

@media (max-width: 768px) {
  :root {
    --container-width: 100%;
    --font-size-base: 14px;
  }
}
```

### 5. 主题切换

使用 CSS 变量实现主题切换：

```css
/* 亮色主题 */
:root {
  --bg-color: #fff;
  --text-color: #333;
  --border-color: #ddd;
}

/* 暗色主题 */
[data-theme="dark"] {
  --bg-color: #1a1a1a;
  --text-color: #fff;
  --border-color: #444;
}

/* 使用变量 */
body {
  background-color: var(--bg-color);
  color: var(--text-color);
}
```

## 示例

### 示例 1：设计系统

```css
:root {
  /* 颜色 */
  --color-primary: #007bff;
  --color-secondary: #6c757d;
  --color-success: #28a745;
  --color-danger: #dc3545;
  
  /* 间距 */
  --spacing-xs: 4px;
  --spacing-sm: 8px;
  --spacing-md: 16px;
  --spacing-lg: 24px;
  
  /* 字体 */
  --font-size-base: 16px;
  --font-size-h1: 2.5rem;
  --font-size-h2: 2rem;
  
  /* 其他 */
  --border-radius: 4px;
  --box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.button {
  background-color: var(--color-primary);
  padding: var(--spacing-sm) var(--spacing-md);
  border-radius: var(--border-radius);
  box-shadow: var(--box-shadow);
  font-size: var(--font-size-base);
}

.card {
  padding: var(--spacing-lg);
  border-radius: var(--border-radius);
  box-shadow: var(--box-shadow);
}
```

### 示例 2：动态主题

```html
<button onclick="toggleTheme()">切换主题</button>
<div class="card">卡片内容</div>
```

```css
:root {
  --bg-color: #fff;
  --text-color: #333;
  --card-bg: #f5f5f5;
}

[data-theme="dark"] {
  --bg-color: #1a1a1a;
  --text-color: #fff;
  --card-bg: #2a2a2a;
}

body {
  background-color: var(--bg-color);
  color: var(--text-color);
  transition: background-color 0.3s, color 0.3s;
}

.card {
  background-color: var(--card-bg);
  padding: 20px;
  border-radius: 8px;
}
```

```javascript
function toggleTheme() {
  const html = document.documentElement;
  const currentTheme = html.getAttribute('data-theme');
  const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
  html.setAttribute('data-theme', newTheme);
}
```

### 示例 3：组件变体

```css
:root {
  --button-padding: 10px 20px;
  --button-radius: 4px;
}

.button {
  padding: var(--button-padding);
  border-radius: var(--button-radius);
}

.button-large {
  --button-padding: 15px 30px;
  --button-radius: 8px;
}

.button-small {
  --button-padding: 5px 10px;
  --button-radius: 2px;
}
```

### 示例 4：计算值

```css
:root {
  --base-size: 16px;
  --spacing: 8px;
}

.element {
  font-size: var(--base-size);
  padding: calc(var(--spacing) * 2);  /* 16px */
  margin: calc(var(--spacing) * 3);   /* 24px */
}
```

## 注意事项

### 1. 变量名区分大小写

CSS 变量名是区分大小写的：

```css
:root {
  --color: blue;
  --Color: red;  /* 这是不同的变量 */
}
```

### 2. 变量值可以是任何 CSS 值

变量值可以是颜色、长度、字符串等：

```css
:root {
  --color: #007bff;
  --size: 16px;
  --font: "Arial", sans-serif;
  --shadow: 0 2px 4px rgba(0,0,0,0.1);
}
```

### 3. 变量可以继承

CSS 变量会继承，子元素可以使用父元素的变量：

```css
.container {
  --color: blue;
}

.container .element {
  color: var(--color);  /* 可以使用父元素的变量 */
}
```

### 4. 变量不能用于属性名

变量只能用于属性值，不能用于属性名：

```css
/* 错误 */
:root {
  --prop: color;
}
.element {
  var(--prop): blue;  /* 无效 */
}

/* 正确 */
:root {
  --color: blue;
}
.element {
  color: var(--color);  /* 有效 */
}
```

### 5. 浏览器兼容性

CSS 变量在现代浏览器中支持良好，但旧版浏览器不支持：

```css
/* 提供降级方案 */
.element {
  color: blue;  /* 降级方案 */
  color: var(--primary-color, blue);  /* 使用变量 */
}
```

### 6. 性能考虑

CSS 变量的性能很好，但过度使用可能影响性能：

```css
/* 合理使用 */
:root {
  --primary-color: #007bff;
}

/* 避免过度嵌套计算 */
.element {
  padding: calc(calc(var(--base) * 2) + calc(var(--offset) * 3));  /* 不推荐 */
}
```

## 小结

CSS 变量是强大的样式管理工具：

- **定义**：使用 `--变量名: 值;` 定义
- **使用**：使用 `var(--变量名)` 引用
- **作用域**：遵循 CSS 层叠规则
- **默认值**：`var(--变量名, 默认值)`

**优势**：
- 集中管理样式值
- 易于维护和修改
- 支持动态更新
- 实现主题切换

**注意事项**：
- 变量名区分大小写
- 变量值可以是任何 CSS 值
- 变量可以继承
- 变量不能用于属性名
- 考虑浏览器兼容性

掌握了 CSS 变量，你就能创建更加灵活和可维护的样式系统。在下一章，我们将学习 CSS 函数，了解如何使用各种 CSS 函数来创建动态样式。
