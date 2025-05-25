---
sidebar_position: 6
slug: /react-components
authors: [luhuadong]
---

# React 组件基础

React 组件是构建 UI 的基本单位。你可以把一个组件理解为一个函数，它接收参数（props），然后返回一段 JSX 结构。在本章中，你将学会创建函数组件和类组件，理解 props 的作用，掌握组件组合与嵌套的用法，并写出属于你自己的组件。



## 什么是组件？

在 React 中，组件可以看作是一个封装了某段 UI 和逻辑的模块，它就像 HTML 中的标签，可以在 JSX 中被复用。

基本的组件有两种写法：

- 函数组件（Function Component）✅ 推荐
- 类组件（Class Component）⚠️ 已逐步被函数组件替代



## 函数组件

函数组件是目前最推荐的写法，它本质上是一个普通的 JavaScript 函数，返回一段 JSX：

```tsx showLineNumbers
function Welcome() {
  return <h1>你好，React！</h1>;
}
```

你也可以用箭头函数写法：

```tsx showLineNumbers
const Welcome = () => <h1>你好，React！</h1>;
```

使用组件时，就像使用标签一样：

```tsx showLineNumbers
<Welcome />
```



## 类组件

类组件使用 ES6 的类来定义，必须继承 `React.Component`：

```tsx showLineNumbers
import React from 'react';

class Welcome extends React.Component {
  render() {
    return <h1>你好，类组件！</h1>;
  }
}
```

现在函数组件配合 Hook 更强大，类组件基本只出现在旧项目中。



## 组件复用与组合

你可以在一个组件中嵌套另一个组件：

```tsx showLineNumbers
function Header() {
  return <h2>这是头部</h2>;
}

function Footer() {
  return <p>这是底部</p>;
}

function App() {
  return (
    <div>
      <Header />
      <p>这是主体内容</p>
      <Footer />
    </div>
  );
}
```

这样的嵌套组合使得页面结构清晰明了。



## 组件中的 props

`props`（属性）是组件之间通信的方式，它让父组件可以向子组件传值。

示例：

```tsx showLineNumbers
// 子组件
function Welcome(props) {
  return <h1>你好，{props.name}！</h1>;
}

// 父组件
function App() {
  return <Welcome name="小明" />;
}
```

你可以把 `props` 看作函数的参数：

```tsx showLineNumbers
const Welcome = ({ name }) => <h1>你好，{name}！</h1>;
```



## 组件必须以大写字母开头

React 使用组件名的首字母区分普通 HTML 标签与自定义组件。

```tsx showLineNumbers
// 正确
const MyComponent = () => <div>内容</div>;

// 错误（会被当作 HTML 标签解析）
const myComponent = () => <div>内容</div>;
```



## 将组件拆分成独立文件（模块化）

你可以将组件写在单独的文件中，便于维护和复用。

**Welcome.jsx**：

```tsx showLineNumbers title="Welcome.jsx"
const Welcome = ({ name }) => <h1>你好，{name}</h1>;

export default Welcome;
```

**App.jsx**：

```tsx showLineNumbers title="App.jsx"
import Welcome from './Welcome';

function App() {
  return <Welcome name="React 用户" />;
}
```



## 小结

组件是 React 的核心，它们让 UI 更加模块化、可组合、易维护。你学会了创建函数组件、传递 props、组件嵌套与组合。后续我们还将深入学习组件状态（state）、生命周期（在函数组件中是 Hook）、事件处理等内容，让你的组件变得更智能、更互动。掌握组件，是你通往 React 高阶之路的第一步。
