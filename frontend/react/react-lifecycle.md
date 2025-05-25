---
sidebar_position: 11
sidebar_label: React 生命周期
slug: /react-lifecycle
authors: [luhuadong]
---

# React 生命周期（useEffect 钩子）

在 React 中，每个组件从创建到销毁，会经历一系列的阶段，这些阶段被统称为组件的**生命周期（Lifecycle）**。理解生命周期不仅有助于你更合理地组织组件逻辑，还能帮助你处理副作用、数据加载、定时器、清理操作等。

本文将带你认识函数组件和类组件的生命周期，并重点介绍如何在现代 React 中使用 `useEffect()` 管理副作用。



## 什么是组件的生命周期？

React 组件的生命周期可以划分为三个主要阶段：

1. **挂载阶段**（Mounting）：组件被创建并插入到 DOM 中。
2. **更新阶段**（Updating）：组件的 `props` 或 `state` 发生变化时重新渲染。
3. **卸载阶段**（Unmounting）：组件被从 DOM 中移除。

### 初始化阶段

- `constructor`：此函数用来做一些组件的初始化工作，比如定义 state 和 props。
- `componentWillMount`：此函数是在组件挂载到 DOM 节点前调用，可以在这个阶段修改初始定义的 state 和 props。
- `render`：页面渲染。
- `componentDidMount`：此函数是在组件挂载到 DOM 节点后调用。在此阶段可调取服务端接口数据，更新组件，也可以获取真实的 DOM 节点。这是 React 中最常用的生命周期。

### 更新阶段

- `componentWillReceiveProps`：此函数表示父组件渲染时，子组件也更新，可通过此函数来监听 props 和 state 的变化。
- `shouldComponentUpdate`：此函数可以判断当前 state 是否发生变化，如果没有发生变化，可在此返回 false，则不会重新渲染页面。因此在此期间可以做性能优化。
- `componentWillUpdate`：此函数在更新页面前调用。
- `render`：根据改变的 state 和 props 重新渲染页面。
- `componentDidUpdate`：此函数是组件已经完成更新，新的虚拟 DOM 节点已经完成挂载。

### 卸载阶段

- `componentWillUnmount`：此函数在组件被卸载前调用，可在此清除计时器及取消事件监听，还可以移除手动创建的 DOM 节点，避免内存泄漏。



## 函数组件生命周期（使用 Hook）

函数组件本身没有生命周期方法，但 React 提供了 Hook（钩子）机制来处理副作用，而最常用的就是 `useEffect`。它可以模拟类组件的 `componentDidMount`、`componentDidUpdate` 和 `componentWillUnmount` 等生命周期方法。

### useEffect 的基本语法

```tsx showLineNumbers
useEffect(() => {
  // 这里是副作用逻辑
  return () => {
    // 这里是清理函数（可选）
  };
}, [依赖项数组]);
```

参数解释：

- 第一个参数是一个函数，叫“副作用函数”。
- 这个副作用函数可以返回另一个函数，这个“返回函数”会在组件卸载或下一次副作用执行前运行（即清理副作用）。
- 第二个参数是一个“依赖数组”，用于控制副作用函数什么时候执行。

### 组件挂载

组件挂载示例（模拟 componentDidMount）：

```tsx showLineNumbers
import { useEffect } from 'react';

function MyComponent() {
  useEffect(() => {
    console.log('组件挂载完成');

    // 一些初始化代码，比如发送网络请求、设置事件监听器等
  }, []); // 依赖数组为空，副作用只在挂载时运行一次

  return <div>Hello</div>;
}
```

说明：

- 这个 `useEffect` 只会在组件首次挂载时执行一次。
- 空数组 `[]` 表示没有依赖，意味着“不要重复执行”。

### 组件更新

组件更新示例（模拟 componentDidUpdate）：

```tsx showLineNumbers
import { useState, useEffect } from 'react';

function Counter() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    console.log(`count 变化为：${count}`);
  }, [count]); // 只有当 count 改变时才执行副作用

  return (
    <button onClick={() => setCount(count + 1)}>
      点击了 {count} 次
    </button>
  );
}
```

说明：

- 每当 `count` 发生变化，`useEffect` 就会重新执行。
- 你可以把这个效果理解为：组件更新时做点事，但只针对特定的变量（比如 count）。

### 组件卸载

组件卸载示例（模拟 componentWillUnmount）：

```tsx showLineNumbers
import { useEffect } from 'react';

function Timer() {
  useEffect(() => {
    const id = setInterval(() => {
      console.log('每秒执行一次');
    }, 1000);

    // 返回清理函数：组件卸载时清除定时器
    return () => {
      clearInterval(id);
      console.log('组件卸载，定时器已清除');
    };
  }, []);

  return <p>定时器运行中...</p>;
}
```

说明：

- `useEffect` 的返回值是一个“清理函数”。
- 组件卸载时这个函数会被调用，常用于清除定时器、取消订阅等。



### 综合示例：挂载 + 更新 + 卸载

```tsx showLineNumbers
import { useState, useEffect } from 'react';

function Demo() {
  const [name, setName] = useState('React');

  useEffect(() => {
    console.log('组件挂载或 name 更新');
    document.title = `你好，${name}`;

    return () => {
      console.log('清理副作用，下一次执行 useEffect 前运行');
    };
  }, [name]);

  return (
    <input
      value={name}
      onChange={(e) => setName(e.target.value)}
      placeholder="请输入你的名字"
    />
  );
}
```

说明：

- 首次挂载时，打印“组件挂载或 name 更新”，并设置标题。
- 每次 `name` 改变时，会先运行清理函数，然后再执行副作用。
- 如果组件卸载，也会运行清理函数。



## 类组件生命周期（了解即可）

虽然现代 React 倡导函数组件，但你可能在老项目中看到类组件写法：

```tsx showLineNumbers
class MyComponent extends React.Component {
  // 1. 构造函数
  constructor(props) {
    super(props);
    this.state = { count: 0 };
    console.log('构造函数');
  }

  // 2. 挂载完成
  componentDidMount() {
    console.log('组件已挂载');
  }

  // 3. 组件更新
  componentDidUpdate(prevProps, prevState) {
    console.log('组件更新了');
  }

  // 4. 卸载前清理
  componentWillUnmount() {
    console.log('组件即将卸载');
  }

  render() {
    return <div>{this.state.count}</div>;
  }
}
```



## 什么时候用清理函数？

使用 `useEffect()` 时，推荐你总是思考是否需要清理资源，防止内存泄漏或逻辑错误。

常见场景包括：

- 清除 `setTimeout` / `setInterval`
- 移除事件监听器（如 `window.addEventListener`）
- 取消网络请求 / WebSocket / 订阅

示例：

```tsx showLineNumbers
useEffect(() => {
  const handler = () => console.log('滚动事件');
  window.addEventListener('scroll', handler);

  return () => {
    window.removeEventListener('scroll', handler);
  };
}, []);
```



## 类组件 vs 函数组件生命周期

| 生命周期阶段 |       类组件方法       |    函数组件 Hook 方式     |
| :----------: | :--------------------: | :-----------------------: |
|    初始化    |     `constructor`      | 初始化状态直接写在函数中  |
|    挂载后    |  `componentDidMount`   | `useEffect(() => {}, [])` |
|    更新后    |  `componentDidUpdate`  | `useEffect(..., [deps])`  |
|    卸载前    | `componentWillUnmount` | `useEffect` 返回清理函数  |



## 小结

React 生命周期描述了组件从创建、更新到销毁的全过程。在现代 React 中，主要通过 `useEffect()` 来模拟这些生命周期行为，合理使用它可以帮你处理副作用、订阅、清理资源等任务。虽然类组件的生命周期方法仍然存在，但函数组件配合 Hook 是现在的主流选择。掌握生命周期是深入理解 React 的关键一步。
