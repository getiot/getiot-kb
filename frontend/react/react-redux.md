---
sidebar_position: 16
slug: /react-redux
authors: [luhuadong]
---

# React 状态管理 Redux

随着 React 应用越来越复杂，组件之间传递数据会变得困难，尤其是多个组件共享状态时。Redux 是一个流行的状态管理库，它可以帮你将应用状态集中管理，提升代码的可维护性和可预测性。本文你将学会使用 Redux Toolkit 创建 Redux 状态，并结合 React 使用 `react-redux` 完成状态的读取与更新。



## 为什么需要 Redux？

React 本身是“组件驱动 + 单向数据流”的框架，小型应用使用组件内的 `useState` 足够。但当项目变大：

- 多个组件需要共享数据（如用户信息、购物车等）
- 组件嵌套层级很深（需要逐层传 props）
- 状态修改逻辑复杂（需要统一管理）

这时候，Redux 就派上用场了。



## Redux 是什么？

Redux 是一个**可预测状态容器**（predictable state container）。它通过以下特性让你的应用行为更清晰可控。

- 单一状态树（Single source of truth）
- 状态只读（State is read-only）
- 纯函数更新状态（Changes are made with pure functions）

虽然 Redux 并不是 React 官方推出的库，但它与 React 配合非常紧密，拥有官方绑定库 `react-redux`，并被广泛用于实际项目中。Redux Toolkit（RTK）是官方推荐的使用方式，极大简化了 Redux 的使用。

需要注意的是，Redux 的概念较多，对初学者有一定学习成本；对于小型项目来说可能显得过重。不过在大型项目或多人协作中，Redux 依然是一个稳定、可维护的状态管理解决方案。只要合理使用 Redux Toolkit，就可以在商业项目中放心使用 Redux。



## 核心概念 Slice

“切片”（slice）是 Redux Toolkit 中一个非常核心的概念，你可以把它理解为“状态和对应操作的一块独立区域”。

具体来说：

- Redux 应用的状态通常很大且复杂，我们会把它拆分成多个小块，每块管理自己的数据和逻辑。
- 每个“切片”就负责管理状态中的一部分（slice of state），以及对这部分状态的操作（reducers）。
- 它把**状态结构**和**修改状态的方法**放在一个地方，代码更清晰、更易维护。

举个简单比喻：

> 你把整个应用的状态看成一张大披萨，切片就是披萨上的一片。每片披萨都有自己的味道（状态内容）和吃法（操作方法）。Redux Toolkit 的 `createSlice` 就帮你准备好一片披萨和对应的吃法。

在代码里：

```tsx showLineNumbers
const counterSlice = createSlice({
  name: 'counter',         // 切片名字
  initialState: {          // 这片状态的初始值
    value: 0,
  },
  reducers: {              // 这片状态可以用什么方法来改变
    increment: (state) => {
      state.value += 1
    },
    decrement: (state) => {
      state.value -= 1
    }
  }
})
```

- `counterSlice` 管理的是“计数器”这块状态。
- 它同时包含了状态数据（`value`）和两个操作（`increment`、`decrement`）。

这样设计让你更容易按功能拆分代码，维护和扩展都方便很多。



## 使用 Redux Toolkit 快速开始

现代 Redux 官方推荐使用 Redux Toolkit，它简化了 Redux 的使用流程，避免样板代码。

### 1. 安装依赖

```bash
npm install @reduxjs/toolkit react-redux
```

### 2. 创建 Redux 状态模块（Slice）

```tsx showLineNumbers title="features/counter/counterSlice.ts"
import { createSlice } from '@reduxjs/toolkit'

// 创建一个切片（slice）
export const counterSlice = createSlice({
  name: 'counter',    // 切片名字
  initialState: {     // 这片状态的初始值
    value: 0,
  },
  reducers: {         // 定义这片状态可以用什么方法来改变
    increment: (state) => {
      state.value += 1
    },
    decrement: (state) => {
      state.value -= 1
    },
    incrementByAmount: (state, action) => {
      state.value += action.payload
    },
  },
})

// 导出 action 函数
export const { increment, decrement, incrementByAmount } = counterSlice.actions

// 导出 reducer
export default counterSlice.reducer
```

说明：

- `createSlice` 会自动生成 action 和 reducer，省去手动定义的麻烦。
- `state` 是当前状态，`action.payload` 是传入的新值。

### 3. 配置全局 store

```tsx showLineNumbers title="app/store.ts"
import { configureStore } from '@reduxjs/toolkit';
import counterReducer from '../features/counter/counterSlice';

export const store = configureStore({
  reducer: {
    counter: counterReducer,
  },
});
```

说明：

- `configureStore` 简化了 Redux 的配置方式。
- 将多个 slice 的 reducer 组合在一起。

### 4. 在根组件中注入 store

在入口文件中配置 Provider，使用 `<Provider>` 包裹根组件，使 Redux store 对整个应用生效。

```tsx showLineNumbers title="main.tsx"
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import { store } from './app/store';
import { Provider } from 'react-redux';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <Provider store={store}>
    <App />
  </Provider>
);
```

### 5. 在组件中使用 Redux 状态

```tsx showLineNumbers title="Counter.tsx"
import { useSelector, useDispatch } from 'react-redux';
import { RootState } from './app/store'; // 若使用 TypeScript
import { increment, decrement } from './features/counter/counterSlice';

function Counter() {
  const count = useSelector((state: RootState) => state.counter.value);
  const dispatch = useDispatch();

  return (
    <div>
      <p>当前计数：{count}</p>
      <button onClick={() => dispatch(decrement())}>-1</button>
      <button onClick={() => dispatch(increment())}>+1</button>
    </div>
  );
}
```

说明：

- `useSelector` 用于读取状态。
- `useDispatch` 用于分发 action（调用 reducer 修改状态）。



## Redux 的优缺点

|              优点              |           缺点           |
| :----------------------------: | :----------------------: |
|    状态集中管理、行为可预测    | 学习曲线比 `useState` 高 |
|        更利于调试与测试        |    小项目可能过度设计    |
| 与 DevTools 配合可调试时间旅行 |     有时代码略显冗长     |

Redux 更适用于中大型项目，特别是状态多、组件结构复杂的情况。如果你的状态很简单，可以使用 React 内置的 `Context` 和 `useReducer`，无需引入 Redux。



## 小结

Redux 是一个强大的状态管理工具，配合 Redux Toolkit 和 React Redux，可以让你快速构建可维护、可扩展的应用。虽然它不像 `useState` 那样简单直观，但在大型项目中能极大提升代码结构清晰度。下一节，我们将深入对比 Redux 与其他状态管理方案，帮助你根据实际场景做出选择。
