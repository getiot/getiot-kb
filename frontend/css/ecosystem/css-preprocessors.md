---
sidebar_position: 1
slug: /css-preprocessors
---

# 了解 CSS 预处理器

CSS 预处理器是扩展 CSS 功能的工具，它们允许你使用变量、嵌套、函数等编程特性来编写 CSS，然后编译成标准的 CSS。虽然现代 CSS 已经支持很多特性（如变量、函数），但预处理器仍然有其价值。本章将介绍 CSS 预处理器的概念、作用和常见工具。

## 什么是 CSS 预处理器

CSS 预处理器是一种脚本语言，它扩展了 CSS 的功能，添加了变量、嵌套、混合（Mixins）、函数等特性。预处理器代码需要编译成标准 CSS 才能在浏览器中运行。

### 工作流程

```
预处理器代码（.scss/.less/.styl）
    ↓
编译工具
    ↓
标准 CSS 代码（.css）
    ↓
浏览器
```

## 预处理器解决的问题

### 1. 代码复用

**问题**：需要重复写相同的样式值

```css
/* 原生 CSS */
.button-primary {
  background-color: #007bff;
  color: white;
}

.button-secondary {
  background-color: #6c757d;
  color: white;
}
```

**解决方案**：使用变量

```scss
// Sass
$primary-color: #007bff;
$secondary-color: #6c757d;

.button-primary {
  background-color: $primary-color;
  color: white;
}

.button-secondary {
  background-color: $secondary-color;
  color: white;
}
```

### 2. 嵌套结构

**问题**：需要重复写选择器

```css
/* 原生 CSS */
.navbar {
  background-color: white;
}

.navbar .menu {
  display: flex;
}

.navbar .menu .item {
  padding: 10px;
}
```

**解决方案**：使用嵌套

```scss
// Sass
.navbar {
  background-color: white;
  
  .menu {
    display: flex;
    
    .item {
      padding: 10px;
    }
  }
}
```

### 3. 代码组织

**问题**：大型项目中 CSS 文件难以管理

**解决方案**：使用导入和模块化

```scss
// main.scss
@import 'variables';
@import 'mixins';
@import 'components/button';
@import 'components/card';
```

### 4. 计算和函数

**问题**：需要手动计算值

```css
/* 原生 CSS */
.container {
  width: calc(100% - 40px);
  padding: calc(20px / 2);
}
```

**解决方案**：使用函数和运算

```scss
// Sass
$spacing: 20px;

.container {
  width: 100% - 40px;
  padding: $spacing / 2;
}
```

## 常见预处理器概览

### 1. Sass / SCSS

**特点**：
- 最流行的预处理器
- 功能强大，社区活跃
- 支持两种语法：Sass（缩进语法）和 SCSS（类似 CSS）

**示例**：

```scss
// SCSS 语法
$primary-color: #007bff;

.button {
  background-color: $primary-color;
  
  &:hover {
    background-color: darken($primary-color, 10%);
  }
}
```

### 2. Less

**特点**：
- 语法接近 CSS，学习曲线平缓
- 可以在浏览器中编译
- 被 Bootstrap 早期版本使用

**示例**：

```less
@primary-color: #007bff;

.button {
  background-color: @primary-color;
  
  &:hover {
    background-color: darken(@primary-color, 10%);
  }
}
```

### 3. Stylus

**特点**：
- 语法最灵活，可以省略大括号和分号
- 功能强大
- 使用相对较少

**示例**：

```styl
primary-color = #007bff

.button
  background-color primary-color
  
  &:hover
    background-color darken(primary-color, 10%)
```

## 预处理器与原生 CSS 的关系

### 原生 CSS 的发展

现代 CSS 已经支持很多预处理器特性：

- **CSS 变量**：`--variable: value;`
- **calc()**：数学计算
- **@import**：导入文件
- **嵌套**：CSS Nesting（新特性）

### 何时使用预处理器

**适合使用预处理器的情况**：
- 需要复杂的函数和混合
- 团队已经熟悉预处理器
- 需要强大的工具生态
- 处理大型项目

**可能不需要预处理器的情况**：
- 小型项目
- 现代 CSS 已满足需求
- 不想增加构建复杂度
- 团队不熟悉预处理器

### 混合使用

可以同时使用预处理器和现代 CSS：

```scss
// Sass 中使用 CSS 变量
:root {
  --primary-color: #{$primary-color};  // Sass 变量转为 CSS 变量
}

.button {
  background-color: var(--primary-color);  // 使用 CSS 变量
}
```

## 是否需要学习的判断标准

### 建议学习的情况

1. **大型项目**：需要更好的代码组织
2. **团队协作**：统一使用预处理器
3. **现有项目**：项目已经使用预处理器
4. **深入学习**：想了解 CSS 工具生态

### 可以不学习的情况

1. **小型项目**：现代 CSS 已足够
2. **个人项目**：不想增加复杂度
3. **现代框架**：使用 CSS-in-JS 或其他方案
4. **时间有限**：优先掌握核心 CSS

### 学习建议

如果决定学习预处理器：

1. **选择一种**：Sass/SCSS 最流行，推荐学习
2. **理解概念**：变量、嵌套、混合、函数
3. **实践项目**：在实际项目中应用
4. **了解工具**：编译工具、构建工具集成

## 小结

CSS 预处理器是扩展 CSS 功能的工具：

- **作用**：提供变量、嵌套、函数等特性
- **常见工具**：Sass/SCSS、Less、Stylus
- **与原生 CSS**：现代 CSS 已支持很多特性
- **选择标准**：根据项目需求和团队情况

**关键建议**：
- 了解预处理器的概念和作用
- 根据项目需求决定是否使用
- 如果使用，推荐学习 Sass/SCSS
- 可以混合使用预处理器和现代 CSS

理解了预处理器的概念，你就能更好地选择适合项目的工具。在下一章，我们将深入学习 Sass/SCSS。
