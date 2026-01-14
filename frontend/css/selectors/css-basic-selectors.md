---
sidebar_position: 2
sidebar_label: CSS 基础选择器
slug: /css-basic-selectors
---

# CSS 基础选择器（元素/类/ID/通用）

基础选择器是 CSS 中最常用、最重要的选择器类型。掌握这四类基础选择器，你就能够处理大部分日常的样式需求。让我们逐一学习它们。

## 1. 元素选择器（Element Selector）

元素选择器是最简单的选择器，它选择**特定类型的 HTML 元素**。

### 语法

```css
元素名 {
  属性: 值;
}
```

### 示例

```css
/* 选择所有段落 */
p {
  color: blue;
  font-size: 16px;
}

/* 选择所有标题 */
h1 {
  font-size: 32px;
  font-weight: bold;
}

/* 选择所有链接 */
a {
  color: #007bff;
  text-decoration: none;
}

/* 选择所有列表项 */
li {
  margin: 5px 0;
}
```

### 特点

- **简单直接**：直接使用 HTML 标签名
- **全局应用**：会选择页面上所有匹配的元素
- **优先级较低**：容易被其他选择器覆盖

### 使用场景

元素选择器适合用于：

- **重置样式**：为所有元素设置基础样式
- **全局样式**：为特定类型的元素设置通用样式
- **浏览器兼容**：统一不同浏览器的默认样式

```css
/* 重置所有段落的默认样式 */
p {
  margin: 0;
  padding: 0;
}

/* 为所有链接设置统一样式 */
a {
  color: #333;
  text-decoration: none;
}
```

## 2. 类选择器（Class Selector）

类选择器选择**具有特定 class 属性的元素**。这是最灵活、最常用的选择器。

### 语法

```css
.类名 {
  属性: 值;
}
```

注意：类选择器以点号（`.`）开头。

### 示例

```css
/* 选择所有具有 highlight 类的元素 */
.highlight {
  background-color: yellow;
  font-weight: bold;
}

/* 选择所有具有 button 类的元素 */
.button {
  padding: 10px 20px;
  background-color: blue;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

/* 选择所有具有 container 类的元素 */
.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}
```

### HTML 中的使用

```html
<!-- 单个类 -->
<p class="highlight">这是高亮文字</p>

<!-- 多个类（用空格分隔） -->
<button class="button primary">主要按钮</button>

<!-- 同一个类可以用于多个元素 -->
<div class="container">容器 1</div>
<div class="container">容器 2</div>
```

### 特点

- **高度可复用**：同一个类可以用于多个元素
- **语义化**：类名可以表达元素的用途或状态
- **灵活性高**：一个元素可以有多个类
- **优先级适中**：比元素选择器优先级高，但比 ID 选择器低

### 使用场景

类选择器适合用于：

- **组件样式**：为可复用的组件定义样式
- **状态样式**：为元素的不同状态定义样式
- **工具类**：创建通用的工具类（如 `.text-center`、`.hidden`）

```css
/* 组件样式 */
.card {
  border: 1px solid #ccc;
  border-radius: 8px;
  padding: 20px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

/* 状态样式 */
.button.active {
  background-color: green;
}

.button.disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

/* 工具类 */
.text-center {
  text-align: center;
}

.hidden {
  display: none;
}
```

## 3. ID 选择器（ID Selector）

ID 选择器选择**具有特定 id 属性的元素**。

### 语法

```css
#ID名 {
  属性: 值;
}
```

注意：ID 选择器以井号（`#`）开头。

### 示例

```css
/* 选择 id 为 header 的元素 */
#header {
  background-color: #333;
  color: white;
  padding: 20px;
}

/* 选择 id 为 main 的元素 */
#main {
  max-width: 1200px;
  margin: 0 auto;
}

/* 选择 id 为 footer 的元素 */
#footer {
  background-color: #f5f5f5;
  padding: 20px;
  text-align: center;
}
```

### HTML 中的使用

```html
<!-- 每个 ID 在页面中应该是唯一的 -->
<header id="header">页头</header>
<main id="main">主要内容</main>
<footer id="footer">页脚</footer>
```

### 特点

- **唯一性**：每个 ID 在页面中应该是唯一的
- **高优先级**：优先级比类选择器和元素选择器都高
- **不可复用**：一个 ID 只能用于一个元素
- **JavaScript 关联**：ID 常用于 JavaScript 中定位元素

### 使用场景

ID 选择器适合用于：

- **页面结构**：为页面的主要结构元素设置样式（如 `#header`、`#main`、`#footer`）
- **唯一元素**：为页面中唯一的元素设置样式
- **JavaScript 目标**：为需要通过 JavaScript 操作的元素设置样式

```css
/* 页面结构 */
#header {
  position: fixed;
  top: 0;
  width: 100%;
  z-index: 1000;
}

#main {
  margin-top: 80px; /* 为固定头部留出空间 */
}

/* 唯一元素 */
#login-modal {
  display: none;
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
```

### 注意事项

**重要**：虽然技术上可以在多个元素上使用相同的 ID，但这是**不推荐的做法**：

```html
<!-- 不推荐：多个元素使用相同的 ID -->
<p id="special">段落 1</p>
<p id="special">段落 2</p>

<!-- 推荐：使用类选择器 -->
<p class="special">段落 1</p>
<p class="special">段落 2</p>
```

## 4. 通用选择器（Universal Selector）

通用选择器选择**所有元素**。

### 语法

```css
* {
  属性: 值;
}
```

注意：通用选择器使用星号（`*`）表示。

### 示例

```css
/* 选择所有元素，重置默认样式 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

/* 选择所有元素，设置字体 */
* {
  font-family: Arial, sans-serif;
}
```

### 特点

- **全局应用**：会选择页面上所有元素
- **优先级最低**：容易被其他选择器覆盖
- **性能考虑**：在大型页面中使用可能影响性能

### 使用场景

通用选择器适合用于：

- **CSS 重置**：重置所有元素的默认样式
- **全局设置**：为所有元素设置通用样式（如字体、盒模型）

```css
/* CSS 重置示例 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

/* 全局字体设置 */
* {
  font-family: 'Helvetica Neue', Arial, sans-serif;
}
```

### 与其他选择器组合

通用选择器可以与其他选择器组合使用：

```css
/* 选择所有 div 元素的所有子元素 */
div * {
  color: blue;
}

/* 选择所有具有 container 类的元素的所有后代元素 */
.container * {
  margin: 10px;
}
```

## 选择器的优先级

当多个选择器匹配同一个元素时，浏览器会根据优先级来决定应用哪个样式。基础选择器的优先级从低到高为：

1. **通用选择器**（`*`）：优先级最低
2. **元素选择器**（`p`、`div` 等）
3. **类选择器**（`.class`）
4. **ID 选择器**（`#id`）：优先级最高

```css
/* 优先级：1（元素选择器） */
p {
  color: black;
}

/* 优先级：10（类选择器） */
.highlight {
  color: blue;  /* 这个会覆盖上面的黑色 */
}

/* 优先级：100（ID 选择器） */
#special {
  color: red;  /* 这个会覆盖上面的蓝色 */
}
```

```html
<p class="highlight" id="special">这段文字是红色的</p>
```

## 使用建议与常见误区

### 1. 优先使用类选择器

类选择器是最灵活、最可复用的选择器，应该作为首选：

```css
/* 推荐：使用类选择器 */
.button {
  padding: 10px 20px;
}

/* 不推荐：使用 ID 选择器（除非确实需要） */
#button {
  padding: 10px 20px;
}
```

### 2. 避免过度使用 ID 选择器

ID 选择器优先级高，难以覆盖，应该谨慎使用：

```css
/* 不推荐：使用 ID 选择器设置样式 */
#header {
  background-color: blue;
}

/* 推荐：使用类选择器 */
.header {
  background-color: blue;
}
```

### 3. 合理使用通用选择器

通用选择器应该主要用于重置样式，避免用于设置具体样式：

```css
/* 推荐：用于重置 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

/* 不推荐：用于设置具体样式 */
* {
  color: blue;  /* 这会影响所有元素，包括按钮、链接等 */
}
```

### 4. 类名的命名规范

使用有意义的类名，遵循命名规范（如 BEM）：

```css
/* 推荐：语义化的类名 */
.button { }
.button-primary { }
.button-secondary { }

/* 不推荐：无意义的类名 */
.red { }
.big { }
.box1 { }
```

### 5. 避免内联样式

虽然内联样式优先级很高，但应该避免使用，因为它破坏了样式与内容的分离：

```html
<!-- 不推荐：使用内联样式 -->
<p style="color: blue;">段落</p>

<!-- 推荐：使用类选择器 -->
<p class="highlight">段落</p>
```

## 实际示例

让我们看一个完整的例子，综合使用这四类基础选择器：

```html
<!DOCTYPE html>
<html>
<head>
  <style>
    /* 通用选择器：重置样式 */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    /* 元素选择器：设置基础样式 */
    body {
      font-family: Arial, sans-serif;
      line-height: 1.6;
      color: #333;
    }

    h1 {
      font-size: 32px;
      margin-bottom: 20px;
    }

    /* 类选择器：可复用的组件 */
    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 20px;
    }

    .button {
      padding: 10px 20px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    .button:hover {
      background-color: #0056b3;
    }

    /* ID 选择器：页面结构 */
    #header {
      background-color: #333;
      color: white;
      padding: 20px;
    }

    #footer {
      background-color: #f5f5f5;
      padding: 20px;
      text-align: center;
    }
  </style>
</head>
<body>
  <header id="header">
    <h1>我的网站</h1>
  </header>
  
  <main class="container">
    <p>这是主要内容区域。</p>
    <button class="button">点击我</button>
  </main>
  
  <footer id="footer">
    <p>© 2024 我的网站</p>
  </footer>
</body>
</html>
```

## 小结

基础选择器是 CSS 的基石：

- **元素选择器**：选择特定类型的 HTML 元素，适合全局样式
- **类选择器**：选择具有特定 class 的元素，最灵活、最常用
- **ID 选择器**：选择具有特定 id 的元素，用于唯一元素
- **通用选择器**：选择所有元素，主要用于重置样式

**使用建议**：
- 优先使用类选择器
- 谨慎使用 ID 选择器
- 合理使用通用选择器
- 遵循命名规范

掌握了这四类基础选择器，你就能够处理大部分日常的样式需求。在接下来的章节中，我们将学习更强大的选择器——属性选择器、组合选择器、伪类和伪元素。
