---
sidebar_position: 14
slug: /react-styling
authors: [luhuadong]
---

# React 样式处理

在 Web 前端开发中，样式是一个绕不开的话题。React 提供了多种样式处理方式，你既可以使用最基本的 CSS 文件，也可以选择更现代的方式，比如 CSS Module、CSS-in-JS（如 styled-components）或类库（如 Tailwind CSS）。这一节内容将带你全面了解 React 中几种常见的样式处理方式，帮助你根据项目需求做出合理选择。



## 传统 CSS 样式表

你可以像在 HTML 项目中一样，直接在 React 项目中引入 `.css` 文件。

**文件结构：**

```bash showLineNumbers
src/
├── App.js
└── App.css
```

**App.css：**

```css showLineNumbers title="App.css"
.title {
  color: blue;
  font-size: 24px;
}
```

**App.js：**

```tsx showLineNumbers title="App.js"
import './App.css';

function App() {
  return <h1 className="title">Hello React</h1>;
}
```

注意：这里使用的是 `className`，而不是 `class`，因为 `class` 是 JavaScript 中的关键字。



## CSS Module（模块化样式）

CSS Module 是一种作用域隔离的样式方案，可以避免类名冲突，非常适合中大型项目。

**App.module.css：**

```css showLineNumbers title="App.module.css"
.title {
  color: green;
  font-weight: bold;
}
```

**App.js：**

```tsx showLineNumbers title="App.js"
import styles from './App.module.css';

function App() {
  return <h1 className={styles.title}>模块化样式</h1>;
}
```

每个 `.module.css` 文件生成的 `styles` 对象都会将类名编译成唯一值，确保样式不会冲突。



## 行内样式（Inline Style）

直接在元素中写 `style` 属性，适合简单样式控制。

```tsx showLineNumbers
function App() {
  const titleStyle = {
    color: 'red',
    fontSize: '20px',
  };

  return <h1 style={titleStyle}>行内样式</h1>;
}
```

注意：style 对象中是驼峰命名的属性（如 `fontSize` 而不是 `font-size`）。



## CSS-in-JS（styled-components 等）

使用 JavaScript 写 CSS，是近年非常流行的一种方式，支持动态样式、主题等特性。

你需要先安装 `styled-components`：

```tsx showLineNumbers
npm install styled-components
```

然后这样写：

```tsx showLineNumbers
import styled from 'styled-components';

const Title = styled.h1`
  color: purple;
  font-size: 28px;
`;

function App() {
  return <Title>Styled Components</Title>;
}
```

除了 styled-components，还有 Emotion、JSS 等其他类似方案。



## 实用类库（Tailwind CSS）

Tailwind CSS 是一个原子化 CSS 框架，使用类名直接控制样式，极大提高开发效率。

```tsx showLineNumbers
function App() {
  return <h1 className="text-blue-500 text-xl font-bold">Hello Tailwind</h1>;
}
```

你需要通过 PostCSS 或 Vite/CRA 插件集成 Tailwind，具体配置略复杂，但对效率非常友好。



## 各方式对比

|       方式        |                  特点优点                  |                 缺点或注意事项                 |
| :---------------: | :----------------------------------------: | :--------------------------------------------: |
|     传统 CSS      |             简单易用，快速上手             |           样式容易全局污染，类名冲突           |
|    CSS Module     |          样式隔离，适合组件化项目          | 文件命名需要加 `.module.css`，类名使用不够直观 |
|     行内样式      |             简洁、适合动态样式             |         不支持伪类和媒体查询，无法重用         |
| styled-components |             动态样式、组件化强             |            文件增大，运行时性能略低            |
|   Tailwind CSS    | 极致效率、类名即样式，特别适合 UI 原型开发 |    类名冗长，可读性较低，需要学习一套新语法    |



## 小结

React 提供了多种灵活的样式处理方案，你可以根据项目规模、团队偏好和使用场景自由选择。初学者建议从传统 CSS 或 CSS Module 入手，逐步了解 styled-components 和 Tailwind 等现代方案。在组件化开发的世界里，选择合适的样式策略和统一的规范，将极大提升你的开发体验和代码可维护性。
