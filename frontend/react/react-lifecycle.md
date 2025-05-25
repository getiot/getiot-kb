---
sidebar_position: 11
slug: /react-lifecycle
authors: [luhuadong]
---

# React 生命周期

React 生命周期是指组件在运行过程中会经历的初始化、更新、卸载 3 个阶段，而每个阶段又有不同的生命周期，在 React 生命周期内可以通过钩子函数来完成不同的业务逻辑。



## 初始化阶段

- `constructor`：此函数用来做一些组件的初始化工作，比如定义 state 和 props。
- `componentWillMount`：此函数是在组件挂载到 DOM 节点前调用，可以在这个阶段修改初始定义的 state 和 props。
- `render`：页面渲染。
- `componentDidMount`：此函数是在组件挂载到 DOM 节点后调用。在此阶段可调取服务端接口数据，更新组件，也可以获取真实的 DOM 节点。这是 React 中最常用的生命周期。



## 更新阶段

- `componentWillReceiveProps`：此函数表示父组件渲染时，子组件也更新，可通过此函数来监听 props 和 state 的变化。
- `shouldComponentUpdate`：此函数可以判断当前 state 是否发生变化，如果没有发生变化，可在此返回 false，则不会重新渲染页面。因此在此期间可以做性能优化。
- `componentWillUpdate`：此函数在更新页面前调用。
- `render`：根据改变的 state 和 props 重新渲染页面。
- `componentDidUpdate`：此函数是组件已经完成更新，新的虚拟 DOM 节点已经完成挂载。



## 卸载阶段

- `componentWillUnmount`：此函数在组件被卸载前调用，可在此清除计时器及取消事件监听，还可以移除手动创建的 DOM 节点，避免内存泄漏。

