---
sidebar_position: 2
slug: /sass-scss
---

# SASS / SCSS 简介

SASS（Syntactically Awesome Style Sheets）是最流行的 CSS 预处理器，它提供了强大的功能来扩展 CSS。SASS 支持两种语法：SASS（缩进语法）和 SCSS（类似 CSS 的语法）。本章将介绍 SASS/SCSS 的核心特性和使用方法。

## SASS 与 SCSS 的关系

### 两种语法

**SASS（缩进语法）**：
- 使用缩进代替大括号
- 不使用分号
- 更简洁，但学习曲线较陡

```sass
.button
  background-color: #007bff
  color: white
  
  &:hover
    background-color: #0056b3
```

**SCSS（Sassy CSS）**：
- 语法类似 CSS
- 使用大括号和分号
- 更容易从 CSS 迁移

```scss
.button {
  background-color: #007bff;
  color: white;
  
  &:hover {
    background-color: #0056b3;
  }
}
```

### 选择建议

- **SCSS**：推荐使用，更容易学习和迁移
- **SASS**：如果你喜欢简洁的语法

## 核心能力概览

### 1. 变量（Variables）

```scss
// 定义变量
$primary-color: #007bff;
$font-size-base: 16px;
$spacing-unit: 8px;

// 使用变量
.button {
  background-color: $primary-color;
  font-size: $font-size-base;
  padding: $spacing-unit * 2;
}
```

### 2. 嵌套（Nesting）

```scss
.navbar {
  background-color: white;
  
  .menu {
    display: flex;
    
    .item {
      padding: 10px;
      
      a {
        color: #333;
        text-decoration: none;
        
        &:hover {
          color: #007bff;
        }
      }
    }
  }
}
```

### 3. 混合（Mixins）

```scss
// 定义混合
@mixin button-style($bg-color, $text-color: white) {
  background-color: $bg-color;
  color: $text-color;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  
  &:hover {
    background-color: darken($bg-color, 10%);
  }
}

// 使用混合
.button-primary {
  @include button-style(#007bff);
}

.button-secondary {
  @include button-style(#6c757d);
}
```

### 4. 继承（Inheritance）

```scss
// 基础样式
%button-base {
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

// 继承
.button-primary {
  @extend %button-base;
  background-color: #007bff;
  color: white;
}

.button-secondary {
  @extend %button-base;
  background-color: #6c757d;
  color: white;
}
```

### 5. 函数（Functions）

```scss
// 内置函数
.button {
  background-color: darken(#007bff, 10%);
  color: lighten(#333, 20%);
  width: percentage(2/3);
}

// 自定义函数
@function spacing($multiplier) {
  @return $spacing-unit * $multiplier;
}

.container {
  padding: spacing(2);  // 16px
  margin: spacing(3);   // 24px
}
```

### 6. 运算（Operations）

```scss
$base-size: 16px;

.text {
  font-size: $base-size * 1.5;  // 24px
  margin: $base-size / 2;        // 8px
  width: 100% - 40px;
}
```

### 7. 导入（Import）

```scss
// variables.scss
$primary-color: #007bff;

// mixins.scss
@mixin button-style { }

// main.scss
@import 'variables';
@import 'mixins';

.button {
  @include button-style;
  background-color: $primary-color;
}
```

### 8. 条件语句（Control Directives）

```scss
$theme: dark;

.button {
  @if $theme == dark {
    background-color: #333;
    color: white;
  } @else {
    background-color: #007bff;
    color: white;
  }
}
```

## 示例对比（CSS vs SCSS）

### 示例 1：按钮样式

**CSS**：

```css
.button-primary {
  background-color: #007bff;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
}

.button-primary:hover {
  background-color: #0056b3;
}

.button-secondary {
  background-color: #6c757d;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
}

.button-secondary:hover {
  background-color: #5a6268;
}
```

**SCSS**：

```scss
$primary-color: #007bff;
$secondary-color: #6c757d;

@mixin button-base {
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  color: white;
}

.button-primary {
  @include button-base;
  background-color: $primary-color;
  
  &:hover {
    background-color: darken($primary-color, 10%);
  }
}

.button-secondary {
  @include button-base;
  background-color: $secondary-color;
  
  &:hover {
    background-color: darken($secondary-color, 10%);
  }
}
```

### 示例 2：响应式布局

**CSS**：

```css
.container {
  width: 100%;
  padding: 10px;
}

@media (min-width: 768px) {
  .container {
    padding: 20px;
  }
}

.card {
  width: 100%;
  margin-bottom: 20px;
}

@media (min-width: 768px) {
  .card {
    width: calc(50% - 20px);
  }
}
```

**SCSS**：

```scss
$breakpoint-md: 768px;

@mixin respond-to($breakpoint) {
  @media (min-width: $breakpoint) {
    @content;
  }
}

.container {
  width: 100%;
  padding: 10px;
  
  @include respond-to($breakpoint-md) {
    padding: 20px;
  }
}

.card {
  width: 100%;
  margin-bottom: 20px;
  
  @include respond-to($breakpoint-md) {
    width: calc(50% - 20px);
  }
}
```

## 使用场景

### 适合使用的场景

1. **大型项目**：需要更好的代码组织
2. **设计系统**：需要统一的变量和混合
3. **团队协作**：需要一致的代码风格
4. **复杂样式**：需要函数和逻辑处理

### 使用工具

**编译工具**：
- **Node.js**：使用 `sass` 或 `node-sass` 包
- **命令行**：`sass input.scss output.css`
- **构建工具**：Webpack、Gulp、Vite 等

**安装**：

```bash
npm install -g sass
sass input.scss output.css
```

## 学习建议

### 学习路径

1. **基础语法**：变量、嵌套、混合
2. **高级特性**：函数、继承、条件语句
3. **项目实践**：在实际项目中应用
4. **工具集成**：与构建工具集成

### 最佳实践

1. **组织文件**：按功能模块组织
2. **命名规范**：使用有意义的变量名
3. **避免过度嵌套**：最多 3-4 层
4. **使用混合**：复用常用样式模式

## 小结

SASS/SCSS 是最流行的 CSS 预处理器：

- **两种语法**：SASS（缩进）和 SCSS（类似 CSS）
- **核心特性**：变量、嵌套、混合、函数等
- **使用场景**：大型项目、设计系统、团队协作
- **学习建议**：从基础语法开始，逐步实践

**关键要点**：
- SCSS 语法更容易学习
- 变量和混合提高代码复用
- 嵌套要适度，避免过深
- 结合构建工具使用

掌握了 SASS/SCSS，你就能更高效地编写和维护 CSS。在下一章，我们将了解 Less 预处理器。
