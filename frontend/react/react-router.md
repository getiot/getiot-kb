---
sidebar_position: 15
slug: /react-router
authors: [luhuadong]
---

# React Router 入门

React 本身只专注于构建 UI，它并不内置路由系统。如果你想为应用添加“页面跳转”的功能，就需要借助第三方库 —— 最常用的就是 [`React Router`](https://reactrouter.com/)。本节将带你快速了解 React Router 的核心概念、基本用法，并通过简单示例学会构建一个多页面的 React 应用。



## 什么是 React Router？

React Router 是一套用于在 React 应用中实现客户端路由（SPA 单页应用）的库。它的目标是让你通过声明式的方式定义路由，让不同路径对应不同的组件页面，从而构建出多页面体验。

React Router 提供了 `react-router-dom` 包用于 Web 开发，包含了最常用的组件如 `BrowserRouter`、`Routes`、`Route` 和 `Link` 等。

React Router 社区活跃，版本更新频繁，从 v4 到 v6 已发展多年，已被无数开源项目和企业级应用验证。并且它采用 MIT License 开源许可证，可放心用于个人或商业用途。

虽然 React Router 并不是由 React 官方团队开发，但它是由经验丰富的社区开发团队 —— [Remix](https://remix.run) 团队（原 React Training）主导维护的。它已经发展多年，是目前最主流、最广泛使用的 React 路由库。

虽然 React Router 是最常用的路由库，但你也可以了解一些替代方案，如：

- Next.js：内置文件式路由，更适合 SSR 应用。
- Remix：React Router 背后的同一团队打造，强调 Web 标准。
- TanStack Router：类型安全、功能强大的新兴路由库。

但对于大多数常规项目来说，React Router 已经完全够用，并且是最安全稳妥的选择之一。



## 安装 React Router

使用 npm 或 yarn 安装最新版（目前为 React Router v6）：

```bash
npm install react-router-dom
```

或：

```bash
yarn add react-router-dom
```



## 基本示例

以下是一个最基础的 React Router 示例：

文件结构：

```bash
src/
├── App.jsx
├── Home.jsx
└── About.jsx
```

Home.jsx 文件：

```tsx showLineNumbers title="Home.jsx"
export default function Home() {
  return <h2>首页</h2>;
}
```

About.jsx 文件：

```tsx showLineNumbers title="About.jsx"
export default function About() {
  return <h2>关于我们</h2>;
}
```

App.jsx 文件：

```tsx showLineNumbers title="App.jsx"
import { BrowserRouter, Routes, Route, Link } from 'react-router-dom';
import Home from './Home';
import About from './About';

function App() {
  return (
    <BrowserRouter>
      <nav>
        <Link to="/">首页</Link> | <Link to="/about">关于</Link>
      </nav>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
```

你会看到页面顶部是导航链接，点击后路径会改变，页面组件随之切换，但不会刷新整个页面 —— 这就是 SPA 的路由体验。



## 常用组件说明

|       组件        | 作用说明                                          |
| :---------------: | ------------------------------------------------- |
| `<BrowserRouter>` | 路由容器，包裹整个 App                            |
|    `<Routes>`     | 包裹所有 `<Route>`，用于配置路由映射              |
|     `<Route>`     | 配置单个路由，`path` 为路径，`element` 为渲染组件 |
|     `<Link>`      | 用于跳转的链接，类似 `<a>`，但不会刷新页面        |
|  `useNavigate()`  | 编程式导航的 Hook，用于在代码中跳转路径           |



## 嵌套路由（Nested Routes）

你可以在一个路由中嵌套子路由，实现更复杂的页面结构：

```tsx showLineNumbers
<Route path="/dashboard" element={<Dashboard />}>
  <Route path="stats" element={<Stats />} />
  <Route path="settings" element={<Settings />} />
</Route>
```

在 `Dashboard` 组件中使用 `<Outlet />` 作为子路由的占位符：

```tsx showLineNumbers
import { Outlet } from 'react-router-dom';

export default function Dashboard() {
  return (
    <div>
      <h2>仪表盘</h2>
      <Outlet />
    </div>
  );
}
```



## 编程式导航

使用 `useNavigate` 可以在函数中执行跳转，比如表单提交后跳转到主页：

```tsx showLineNumbers
import { useNavigate } from 'react-router-dom';

function LoginForm() {
  const navigate = useNavigate();

  function handleLogin() {
    // 登录成功后跳转
    navigate('/');
  }

  return <button onClick={handleLogin}>登录</button>;
}
```



## 404 页面处理

在实际项目中，用户可能会访问一个不存在的地址。这时我们应该展示一个友好的 404 页面，而不是让页面空白或报错。React Router 提供了非常简单的方式来处理 404 页面 —— 使用 `path="*"` 配置。

在 `<Routes>` 中加一个“兜底路由”，通过设置 `path="*"`，来匹配所有未被其他路径匹配到的地址：

```tsx showLineNumbers {13}
import { Routes, Route } from "react-router-dom";
import Home from "./Home";
import About from "./About";
import NotFound from "./NotFound"; // 404 页面组件

function App() {
  return (
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/about" element={<About />} />

      {/* 兜底匹配的 404 页面 */}
      <Route path="*" element={<NotFound />} />
    </Routes>
  );
}
```

注意：上面的 `path="*"` 是一个通配符，匹配所有路径，**必须放在所有其他路由的最后**，否则可能会抢先匹配。

接着，你可以实现一个 `NotFound` 页面，添加如下内容，引导用户操作。

```tsx showLineNumbers
import { Link } from "react-router-dom";

function NotFound() {
  return (
    <div style={{ padding: "2rem", textAlign: "center" }}>
      <h1>404 - 页面未找到</h1>
      <p>你访问的页面不存在。</p>
      <Link to="/">返回首页</Link>
    </div>
  );
}
```

你还可以使用 `useNavigate()` 实现按钮跳转等功能，提供更好的用户体验。



## 小结

React Router 是构建多页面 React 应用的核心工具。通过 `BrowserRouter` 包裹应用，使用 `Routes` 和 `Route` 声明页面映射，再搭配 `Link` 或 `useNavigate` 实现页面跳转，你就可以轻松构建出具有路由功能的单页应用。掌握了基本用法后，你可以进一步探索嵌套路由、路由懒加载、动态参数等高级功能，为应用添加更多交互体验。
