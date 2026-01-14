---
sidebar_position: 3
slug: /less
---

# LESS 简介

LESS（Leaner Style Sheets）是另一种流行的 CSS 预处理器，它的语法更接近原生 CSS，学习曲线相对平缓。虽然 SASS/SCSS 现在更流行，但 LESS 仍然有其使用场景和优势。本章将介绍 LESS 的特点和使用方法。

## LESS 的设计理念

### 核心理念

LESS 的设计目标是：
- **接近 CSS**：语法尽可能接近原生 CSS
- **易于学习**：从 CSS 迁移成本低
- **功能完整**：提供预处理器所需的核心功能

### 语法特点

LESS 的语法非常接近 CSS，只需要学习一些额外的特性：

```less
// 变量使用 @ 符号
@primary-color: #007bff;

.button {
  background-color: @primary-color;
}
```

## 与 SASS / SCSS 的区别

### 语法差异

| 特性 | LESS | SASS/SCSS |
|------|------|-----------|
| 变量符号 | `@` | `$` |
| 混合定义 | `.mixin()` | `@mixin mixin()` |
| 混合使用 | `.mixin()` | `@include mixin()` |
| 嵌套 | 支持 | 支持 |
| 函数 | 内置函数 | 内置+自定义函数 |

### 功能对比

**LESS 的优势**：
- 语法更接近 CSS
- 可以在浏览器中编译（开发时）
- 学习曲线平缓

**SASS/SCSS 的优势**：
- 功能更强大
- 社区更活跃
- 工具生态更完善
- 更多高级特性

## 核心特性

### 1. 变量

```less
@primary-color: #007bff;
@font-size-base: 16px;
@spacing-unit: 8px;

.button {
  background-color: @primary-color;
  font-size: @font-size-base;
  padding: @spacing-unit * 2;
}
```

### 2. 嵌套

```less
.navbar {
  background-color: white;
  
  .menu {
    display: flex;
    
    .item {
      padding: 10px;
      
      a {
        color: #333;
        
        &:hover {
          color: @primary-color;
        }
      }
    }
  }
}
```

### 3. 混合（Mixins）

```less
// 定义混合
.button-style(@bg-color, @text-color: white) {
  background-color: @bg-color;
  color: @text-color;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  
  &:hover {
    background-color: darken(@bg-color, 10%);
  }
}

// 使用混合
.button-primary {
  .button-style(#007bff);
}

.button-secondary {
  .button-style(#6c757d);
}
```

### 4. 函数

```less
.button {
  background-color: darken(#007bff, 10%);
  color: lighten(#333, 20%);
  width: percentage(2/3);
}
```

### 5. 运算

```less
@base-size: 16px;

.text {
  font-size: @base-size * 1.5;
  margin: @base-size / 2;
  width: 100% - 40px;
}
```

### 6. 导入

```less
// variables.less
@primary-color: #007bff;

// mixins.less
.button-style() { }

// main.less
@import 'variables';
@import 'mixins';

.button {
  .button-style();
  background-color: @primary-color;
}
```

## 使用场景

### 适合使用的场景

1. **Bootstrap 项目**：Bootstrap 早期版本使用 LESS
2. **团队熟悉 LESS**：团队已经使用 LESS
3. **简单项目**：不需要复杂功能
4. **浏览器编译**：开发时在浏览器中编译

### 使用工具

**编译工具**：
- **Node.js**：使用 `less` 包
- **命令行**：`lessc input.less output.css`
- **浏览器**：使用 `less.js` 在浏览器中编译（仅开发）

**安装**：

```bash
npm install -g less
lessc input.less output.css
```

## 是否推荐使用

### 推荐情况

- 项目已经使用 LESS
- 团队熟悉 LESS
- 使用 Bootstrap（早期版本）

### 不推荐情况

- 新项目（推荐 SASS/SCSS）
- 需要复杂功能
- 需要活跃的社区支持

### 迁移建议

如果项目使用 LESS，可以考虑：

1. **继续使用**：如果项目运行良好
2. **迁移到 SCSS**：如果需要更多功能
3. **混合使用**：逐步迁移

## 示例说明

### 完整示例

```less
// variables.less
@primary-color: #007bff;
@secondary-color: #6c757d;
@spacing-unit: 8px;
@breakpoint-md: 768px;

// mixins.less
.button-base() {
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.3s;
}

.respond-to(@breakpoint) {
  @media (min-width: @breakpoint) {
    @content;
  }
}

// main.less
@import 'variables';
@import 'mixins';

.button-primary {
  .button-base();
  background-color: @primary-color;
  color: white;
  
  &:hover {
    background-color: darken(@primary-color, 10%);
  }
}

.container {
  width: 100%;
  padding: @spacing-unit;
  
  .respond-to(@breakpoint-md) {
    padding: @spacing-unit * 2;
  }
}
```

## 小结

LESS 是另一种 CSS 预处理器：

- **设计理念**：接近 CSS，易于学习
- **核心特性**：变量、嵌套、混合、函数
- **与 SASS 区别**：语法差异，功能对比
- **使用场景**：Bootstrap 项目、团队熟悉 LESS
- **推荐建议**：新项目推荐 SASS/SCSS

**关键要点**：
- LESS 语法更接近 CSS
- 功能相对简单但足够使用
- 适合已有 LESS 项目
- 新项目推荐使用 SASS/SCSS

了解了 LESS，你就能根据项目需求选择合适的预处理器。在下一章，我们将学习 PostCSS 与现代 CSS 工作流。
