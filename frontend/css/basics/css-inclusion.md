---
sidebar_position: 3
slug: /css-inclusion
---

# CSS 引入方式

要将 CSS 样式应用到 HTML 文档中，你需要将 CSS 代码引入到 HTML 中。CSS 有三种主要的引入方式：

1. **内联样式（Inline Styles）**：直接在 HTML 标签中使用 `style` 属性
2. **内部样式表（Internal Style Sheet）**：在 HTML 文档的 `<head>` 标签中使用 `<style>` 标签
3. **外部样式表（External Style Sheet）**：将 CSS 代码保存在独立的 `.css` 文件中，然后在 HTML 中引用

每种方式都有其适用场景，让我们逐一了解。

## 1. 内联样式

内联样式（Inline Styles）是直接在 HTML 标签中使用 `style` 属性来定义样式。

#### 语法

```html
<标签名 style="属性1: 值1; 属性2: 值2;">
```

#### 示例

```html
<p style="color: blue; font-size: 16px;">这是一段蓝色文字</p>

<h1 style="color: red; text-align: center;">这是居中的红色标题</h1>

<div style="background-color: yellow; padding: 20px;">
  这是一个带背景色的容器
</div>
```

#### 优点

- **优先级高**：内联样式的优先级最高，可以覆盖其他样式
- **快速测试**：适合快速测试某个元素的样式效果
- **特定样式**：适合为单个元素设置独特的样式

#### 缺点

- **代码冗余**：每个标签都要重复写样式代码
- **难以维护**：要修改样式需要逐个修改每个标签
- **无法复用**：相同的样式需要重复编写
- **违反分离原则**：内容和样式混在一起

#### 使用建议

内联样式应该**尽量避免使用**，只在以下情况下考虑：

- 需要覆盖其他样式（但更好的方式是提高选择器优先级）
- 动态生成的样式（通过 JavaScript 动态设置）
- 邮件模板（某些邮件客户端只支持内联样式）

## 2. 内部样式表

内部样式表（Internal Style Sheet）是在 HTML 文档的 `<head>` 标签中使用 `<style>` 标签来定义样式。

#### 语法

```html
<!DOCTYPE html>
<html>
<head>
  <style>
    选择器 {
      属性1: 值1;
      属性2: 值2;
    }
  </style>
</head>
<body>
  <!-- HTML 内容 -->
</body>
</html>
```

#### 示例

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>内部样式表示例</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 20px;
      background-color: #f5f5f5;
    }

    h1 {
      color: #333;
      text-align: center;
    }

    p {
      color: #666;
      line-height: 1.6;
    }

    .highlight {
      background-color: yellow;
      padding: 2px 4px;
    }
  </style>
</head>
<body>
  <h1>欢迎来到我的网站</h1>
  <p>这是一段普通文字。</p>
  <p class="highlight">这是一段高亮文字。</p>
</body>
</html>
```

#### 优点

- **集中管理**：所有样式集中在一个地方，便于管理
- **页面特定**：适合为单个页面设置独特的样式
- **无需额外文件**：不需要创建额外的 CSS 文件

#### 缺点

- **无法复用**：样式只能在当前页面使用，其他页面无法共享
- **增加 HTML 文件大小**：样式代码会增加 HTML 文件的大小
- **维护困难**：如果多个页面需要相同样式，需要重复编写

#### 使用建议

内部样式表适合：

- **单页应用**：只有一个 HTML 页面的简单网站
- **页面特定样式**：某个页面独有的样式
- **快速原型**：快速开发原型时使用

## 3. 外部样式表

外部样式表（External Style Sheet）是将 CSS 代码保存在独立的 `.css` 文件中，然后在 HTML 中使用 `<link>` 标签引用。

#### 创建 CSS 文件

首先，创建一个 CSS 文件（例如 `styles.css`）：

```css
/* styles.css */
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 20px;
  background-color: #f5f5f5;
}

h1 {
  color: #333;
  text-align: center;
}

p {
  color: #666;
  line-height: 1.6;
}

.highlight {
  background-color: yellow;
  padding: 2px 4px;
}
```

#### 在 HTML 中引用

在 HTML 文档的 `<head>` 标签中使用 `<link>` 标签引用 CSS 文件：

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>外部样式表示例</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <h1>欢迎来到我的网站</h1>
  <p>这是一段普通文字。</p>
  <p class="highlight">这是一段高亮文字。</p>
</body>
</html>
```

#### `<link>` 标签属性

- **`rel="stylesheet"`**：指定链接的关系类型为样式表
- **`href="styles.css"`**：指定 CSS 文件的路径

#### 路径说明

CSS 文件的路径可以是：

```html
<!-- 相对路径：同一目录 -->
<link rel="stylesheet" href="styles.css">

<!-- 相对路径：子目录 -->
<link rel="stylesheet" href="css/styles.css">

<!-- 相对路径：上级目录 -->
<link rel="stylesheet" href="../styles.css">

<!-- 绝对路径：网站根目录 -->
<link rel="stylesheet" href="/css/styles.css">

<!-- 完整 URL：外部资源 -->
<link rel="stylesheet" href="https://example.com/styles.css">
```

#### 引用多个 CSS 文件

你可以引用多个外部样式表：

```html
<head>
  <link rel="stylesheet" href="reset.css">
  <link rel="stylesheet" href="layout.css">
  <link rel="stylesheet" href="theme.css">
</head>
```

**注意**：多个样式表的加载顺序很重要，后面的样式会覆盖前面的样式（如果选择器优先级相同）。

#### 优点

- **样式复用**：多个页面可以共享同一个 CSS 文件
- **易于维护**：修改一处即可影响所有使用该文件的页面
- **代码分离**：内容和样式完全分离，代码更清晰
- **提高性能**：浏览器会缓存 CSS 文件，提高页面加载速度
- **团队协作**：前端开发者可以专注于 CSS，后端开发者专注于 HTML

#### 缺点

- **需要额外文件**：需要创建和维护额外的 CSS 文件
- **可能增加 HTTP 请求**：如果引用多个 CSS 文件，会增加 HTTP 请求次数（可以通过合并文件解决）

#### 使用建议

外部样式表是**最推荐的方式**，适合：

- **多页面网站**：有多个 HTML 页面的网站
- **大型项目**：需要团队协作的大型项目
- **生产环境**：正式发布的网站

## CSS 引入方式的优先级

当同一个元素被多种方式设置样式时，优先级从高到低为：

1. **内联样式**（最高优先级）
2. **内部样式表**
3. **外部样式表**（最低优先级）

#### 示例

```html
<!DOCTYPE html>
<html>
<head>
  <style>
    p {
      color: blue;  /* 内部样式表 */
    }
  </style>
  <link rel="stylesheet" href="styles.css">
  <!-- styles.css 中：p { color: green; } -->
</head>
<body>
  <p style="color: red;">这段文字是红色的</p>
  <!-- 内联样式优先级最高，所以显示红色 -->
</body>
</html>
```

## 使用 @import 引入 CSS

除了使用 `<link>` 标签，你还可以在 CSS 文件中使用 `@import` 规则来引入其他 CSS 文件。

#### 语法

```css
@import url('styles.css');
@import url('https://example.com/styles.css');
@import 'styles.css';  /* 也可以省略 url() */
```

#### 示例

```css
/* main.css */
@import url('reset.css');
@import url('layout.css');

body {
  font-family: Arial, sans-serif;
}
```

#### 注意事项

- `@import` 必须在 CSS 文件的最前面（除了 `@charset` 规则）
- `@import` 会增加页面加载时间（因为需要等待前一个文件加载完成）
- 建议使用 `<link>` 标签而不是 `@import`

## 最佳实践

#### 1. 优先使用外部样式表

对于多页面网站，优先使用外部样式表：

```html
<link rel="stylesheet" href="styles.css">
```

#### 2. 合理组织 CSS 文件

可以按功能组织 CSS 文件：

```
css/
  ├── reset.css      # 重置样式
  ├── layout.css     # 布局样式
  ├── components.css # 组件样式
  └── theme.css      # 主题样式
```

#### 3. 使用 CSS 预处理器

对于大型项目，可以考虑使用 CSS 预处理器（如 Sass、Less）：

```scss
// styles.scss
@import 'variables';
@import 'mixins';
@import 'components';
```

#### 4. 生产环境优化

在生产环境中，可以：

- **合并 CSS 文件**：减少 HTTP 请求
- **压缩 CSS 文件**：减小文件大小
- **使用 CDN**：加速 CSS 文件加载

## 小结

CSS 有三种引入方式：

1. **内联样式**：直接在标签中使用 `style` 属性（不推荐，除非特殊情况）
2. **内部样式表**：在 `<head>` 中使用 `<style>` 标签（适合单页应用）
3. **外部样式表**：使用 `<link>` 标签引用独立的 CSS 文件（最推荐）

对于大多数项目，应该优先使用**外部样式表**，这样可以：

- 实现样式复用
- 便于维护和管理
- 提高页面加载性能
- 保持代码的清晰和分离

在接下来的教程中，你将学习更多 CSS 选择器和属性，逐步掌握 CSS 的强大功能。
