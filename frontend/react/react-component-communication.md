---
sidebar_position: 12
slug: /react-component-communication
authors: [luhuadong]
---

# React 组件间通信

在 React 中，你会经常把页面拆分为一个个组件。随着项目越来越复杂，不同组件之间需要“对话”——这就涉及到了“组件间通信”。这篇文章将带你了解组件间通信的几种常见方式，包括父子组件通信、兄弟组件通信、跨层级通信等，帮助你构建结构清晰、功能完善的组件系统。



## 父子组件通信：通过 Props

最常见的方式就是通过 `props` 从父组件向子组件传递数据或函数。

### 示例：父组件向子组件传值

```tsx showLineNumbers
// 子组件
function Child({ message }) {
  return <p>收到的消息：{message}</p>;
}

// 父组件
function Parent() {
  return <Child message="你好，我是父组件" />;
}
```

父组件通过 `message` prop 将字符串传给子组件，子组件通过 `props.message` 读取。

:::tip

这段代码没有使用 `props.message`，而是通过 **解构赋值的语法** 直接从 `props` 中取出 `message` 属性。这是 React 中一种常见、推荐的写法。

等价于：

```tsx showLineNumbers
function Child(props) {
  return <p>收到的消息：{props.message}</p>;
}
```

那为什么推荐解构这种写法？因为：

- **简洁**：可以直接使用属性名，不用每次都写 `props.xxx`。
- **清晰**：在函数参数中就能看到组件依赖了哪些 `props`。
- **解构语法是 ES6 的一部分**，React 组件函数其实就是普通的 JavaScript 函数，支持这种语法。

:::

### 示例：子组件向父组件传值

通过回调函数可以实现从子组件向父组件传值。在下面示例中，子组件通过调用父组件传进来的 `onSend` 函数，实现“反向通信”。

```tsx showLineNumbers
// 子组件
function Child({ onSend }) {
  return (
    <button onClick={() => onSend('你好，父组件')}>
      向父组件发送消息
    </button>
  );
}

// 父组件
function Parent() {
  const handleReceive = (msg) => {
    console.log('收到子组件消息：', msg);
  };

  return <Child onSend={handleReceive} />;
}
```



## 兄弟组件通信：借助父组件中转

兄弟组件之间没有直接的联系，通常通过**提升状态到最近的共同父组件**，让它来协调数据传递。

示例：

```tsx showLineNumbers
function SiblingA({ onChange }) {
  return <button onClick={() => onChange('A 发来的消息')}>发送</button>;
}

function SiblingB({ message }) {
  return <p>收到：{message}</p>;
}

function Parent() {
  const [msg, setMsg] = useState('');

  return (
    <>
      <SiblingA onChange={setMsg} />
      <SiblingB message={msg} />
    </>
  );
}
```

`SiblingA` 通过 `onChange` 将信息传递给父组件，父组件再将数据传给 `SiblingB`。



## 跨层级通信：Context 上下文

当你需要在组件树中传递全局信息（例如主题、语言、用户信息）时，React 的 `Context` 是一个更合适的方案。

示例：

```tsx showLineNumbers
import { createContext, useContext } from 'react';

const ThemeContext = createContext('light');

function ThemedButton() {
  const theme = useContext(ThemeContext);
  return <button>当前主题：{theme}</button>;
}

function App() {
  return (
    <ThemeContext.Provider value="dark">
      <ThemedButton />
    </ThemeContext.Provider>
  );
}
```

在这个例子中，`ThemeContext` 提供了全局的 `theme` 值，`ThemedButton` 无需通过层层 props，就能直接访问。



## 状态管理工具：Redux、Zustand

当项目变得更大、状态越来越多时，你可能需要引入第三方状态管理工具（如 Redux、Zustand、Jotai 等）来集中管理数据。这类工具可以在任意组件中读写共享状态，实现复杂的组件通信和数据流。

这类工具的学习成本相对更高，建议你先熟练掌握 `props` 和 `Context`。



## 小结

组件间通信是 React 项目中的核心能力之一。你可以通过 `props` 实现父子通信，通过“状态提升”解决兄弟组件通信的问题，也可以用 `Context` 实现跨层级数据共享。当项目变得更大时，考虑使用状态管理工具来集中处理共享状态。掌握这些技巧，将让你在构建复杂 React 应用时更加游刃有余。
