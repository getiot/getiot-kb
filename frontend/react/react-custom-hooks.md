---
sidebar_position: 13
slug: /react-custom-hooks
authors: [luhuadong]
---

# React 自定义 Hook

React 中的 Hook（钩子）让你可以在函数组件中使用状态和副作用等特性。除了官方提供的基础 Hook（比如 `useState`、`useEffect` 等），你还可以编写自己的“自定义 Hook”，将重复使用的逻辑提取出来。这一篇文章会带你了解什么是自定义 Hook、怎么写、怎么用，以及它的实际应用场景。



## 什么是自定义 Hook？

自定义 Hook 是一个以 `use` 开头的 JavaScript 函数，它可以调用其他 Hook，并返回你想要暴露的值（比如状态、函数等）。自定义 Hook 的目标是**抽离通用逻辑**，提高代码复用性和可维护性。

假设你有一个页面中需要倒计时的功能，并且多个地方都用得到。那么你可以把它封装成一个 Hook：

```tsx showLineNumbers title="useCountdown.js"
import { useState, useEffect } from 'react';

function useCountdown(initialValue = 10) {
  const [count, setCount] = useState(initialValue);

  useEffect(() => {
    if (count <= 0) return;
    const timer = setTimeout(() => {
      setCount((prev) => prev - 1);
    }, 1000);

    return () => clearTimeout(timer); // 清理定时器
  }, [count]);

  return [count, setCount];
}

export default useCountdown;
```

这个 Hook 通过 `useState` 和 `useEffect` 实现了一个可复用的倒计时逻辑，并返回 `[count, setCount]`，你可以在组件中随时使用和控制。



## 如何使用自定义 Hook？

你可以像使用内置的 Hook 一样使用自定义 Hook，例如：

```tsx showLineNumbers
import useCountdown from './useCountdown';

function Timer() {
  const [count, setCount] = useCountdown(5);

  return (
    <div>
      <h2>倒计时：{count}</h2>
      <button onClick={() => setCount(10)}>重新开始</button>
    </div>
  );
}
```



## 自定义 Hook 的命名规则

- 必须以 `use` 开头，例如 `useForm`、`useScroll`、`useDarkMode`。
- 内部可以调用其他 Hook（比如 `useState`、`useEffect`）。
- 返回值可以是状态值、操作函数、对象等，根据需要设计。



## 应用场景举例

自定义 Hook 在很多场景下都非常有用，比如：

- 表单处理（`useForm`）
- 页面滚动监听（`useScroll`）
- 媒体查询响应式（`useMediaQuery`）
- 本地存储封装（`useLocalStorage`）
- 网络请求封装（`useFetch`）

通过封装逻辑，你可以避免在多个组件中复制粘贴相似的代码，让项目结构更清晰。



## 小结

自定义 Hook 是函数组件时代的一大利器，帮助你封装并复用逻辑。在你遇到多个组件中有重复代码、状态逻辑变得复杂时，自定义 Hook 都是一个值得考虑的解决方案。记住：Hook 其实就是函数，把“功能”变成函数，是你通往更高效 React 编程的捷径。
