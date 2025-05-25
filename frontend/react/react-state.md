---
sidebar_position: 8
sidebar_label: React 状态 State
slug: /react-state
authors: [luhuadong]
---

# React 状态 State（组件状态）

在上一节中你了解了组件的 Props 是如何传参的，但组件不仅能接收外部数据，也能管理**内部自己的数据**，这就是 `State` 的作用。在这篇文章中，你将学会什么是 State、如何使用 `useState` 钩子创建和更新状态，并通过一个计数器的例子来直观理解 React 中状态的用法。

:::tip

React 是“响应式”的，组件的界面会根据数据变化自动更新。而这些“会变的数据”就是组件的状态（State）。

:::



## 什么是 State？

State 就是组件内部的数据容器。和 Props 不同，State 是组件**私有的**，组件可以在不依赖外部的情况下自由更新自己的 State，从而触发界面重新渲染。

在函数组件中，你通常使用 `useState` 这个 React Hook 来管理状态。



## 创建状态

在 React 中，你可以使用 `useState` 创建状态，例如：

```tsx showLineNumbers
import { useState } from 'react';

function Counter() {
  // count 是当前状态值，setCount 是用于更新状态的函数
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>你点击了 {count} 次</p>
      <button onClick={() => setCount(count + 1)}>点击我</button>
    </div>
  );
}
```

代码说明：

- `useState(0)`：定义一个初始值为 0 的状态 `count`。
- `setCount`：是更新状态的函数，每次调用都会引发组件重新渲染。
- 当你点击按钮，`setCount(count + 1)` 就会将 count 加 1，并更新界面。



## 多个状态

你可以在一个组件中使用多个 `useState` 来分别管理不同的数据：

```tsx showLineNumbers
function UserInfo() {
  const [name, setName] = useState('小明');
  const [age, setAge] = useState(18);

  return (
    <div>
      <p>姓名：{name}</p>
      <p>年龄：{age}</p>
      <button onClick={() => setAge(age + 1)}>生日 +1</button>
    </div>
  );
}
```

在 React 中，字符串、布尔值、对象、数组都可以作为状态：

```tsx showLineNumbers
const [name, setName] = useState('React');                   // 字符串
const [visible, setVisible] = useState(true);                // 布尔值
const [user, setUser] = useState({ name: 'Tom', age: 20 });  // 对象
const [list, setList] = useState([]);                        // 数组
```



## 注意事项

#### 1. 状态更新是异步的

调用 `setState` 不会立刻改变 `state` 的值，而是会在下一次渲染中生效。如果你需要依赖当前值进行更新，建议用函数式写法：

```tsx showLineNumbers
setCount(prevCount => prevCount + 1);
```

这种方式能避免在高频更新时出现值错误的问题。

#### 2. 状态改变会自动更新页面

React 会在状态更新后自动“重新渲染”组件，这样你就不需要手动操作 DOM，非常符合“声明式 UI”的设计理念。



## 小结

State 是组件中最核心的概念之一，它让你的组件拥有自己的“记忆”，根据状态变化动态渲染界面。在函数组件中，使用 `useState` 就能轻松实现状态管理，是构建交互式应用的第一步。

