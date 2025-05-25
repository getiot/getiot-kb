---
sidebar_position: 2
slug: /react-installation
---

# React 安装

本文将带你了解多种 React 安装方式，包括：直接引入 CDN 脚本、使用 `create-react-app` 脚手架、通过 Vite、Parcel、RSbuild 等现代构建工具进行安装。你将学会如何选择最适合自己的开发方式，并快速搭建 React 项目。

:::tip

你可以在 [React 官网](https://react.dev) 下载最新版。

:::



## 引用 JavaScript 链接

如果你只是想简单试用 React，或者用于教学、测试、嵌入式功能，可以直接在 HTML 文件中引入 React 的 CDN 脚本。

```html showLineNumbers {6-8}
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Hello React</title>
    <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
    <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
  </head>
  <body>
    <div id="root"></div>
    <script type="text/babel">
      const App = () => <h1>Hello React!</h1>;
      const root = ReactDOM.createRoot(document.getElementById("root"));
      root.render(<App />);
    </script>
  </body>
</html>
```

⚠️ 注意：在浏览器中使用 Babel 来编译 JSX 效率是非常低的，因此不建议在生产环境使用。

另外，上述 CDN 链接只适用于开发环境，不适用于生产环境。生产环境需要使用压缩处理后的依赖包，这样可以节约网络带宽，提高运行效率。压缩依赖包如下：

```html showLineNumbers
<script src="https://unpkg.com/react@18/umd/react.production.min.js" crossorigin></script>
<script src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js" crossorigin></script>
```

**优点：**

- 零配置，快速上手
- 不依赖构建工具

**缺点：**

- 性能差，代码不可压缩或优化
- 无模块化、无状态管理、无开发体验可言
- 不能用于大型项目



## 使用 create-react-app 工具

Create React App（CRA）曾经是 React 官方推荐的用于快速构建 React 开发环境的工具。它在内部使用 Babel 和 Webpack，用户不需要任何配置，也不需要了解它的任何细节。但由于启动速度和构建性能较差，且扩展性较差，**已不再是 React 团队推荐的最佳实践**。

⚠️ 注意：CRA 项目配置封装较深，修改较困难，不适合中大型项目。

create-react-app 依赖 [Node.js](/nodejs/nodejs-intro/)（Node 版本 8.10 以上，npm 版本 5.6 以上），步骤如下：

**1. 全局安装 create-react-app 工具**

```bash
npm install -g create-react-app
```

**2. 使用 create-react-app 工具创建项目**

```bash
create-react-app first-app
```

**3. 使用 `npm scripts` 运行该项目**

```bash
cd first-app
npm start    # 或者 yarn start
```

服务启动后会在浏览器自动打开 [http://localhost:3000](http://localhost:3000)，运行效果如下：

![第一个 React 应用](https://static.getiot.tech/react-first-app.png#center)



## 使用 Vite（官方推荐）

**Vite** 是当前 React 官方推荐的现代前端构建工具，基于原生 ESM 模块加载和 Rollup 构建，启动快、热更新快、配置灵活。

```bash
npm create vite@latest my-app -- --template react
cd my-app
npm install
npm run dev
```

Vite 项目支持 JSX、状态管理库（如 Redux、Zustand）等，适合现代 Web 开发。

**优点：**

- 启动快，构建快，体验好
- 支持热更新和 TypeScript
- 社区活跃，插件丰富



## 使用 Parcel（零配置打包器）

**Parcel** 是一个主打“零配置”的构建工具，不需要手动设置 webpack 或 babel，自动识别入口和依赖。

```bash
mkdir my-parcel-app && cd my-parcel-app
npm init -y
npm install react react-dom parcel
```

创建一个 `index.html` 和 `index.jsx`，Parcel 会自动打包并启动开发服务器。

**优点：**

- 无需配置，开箱即用
- 支持 JSX、TS、CSS 模块等

**缺点：**

- 插件生态不如 Vite 完善
- 社区活跃度略低



## 使用 RSbuild（字节跳动出品）

**[RSbuild](https://rsbuild.dev/)** 是字节跳动开源的现代 Web 构建工具，基于 Rspack 和 Rust 打造，兼顾性能和现代语法支持。

```bash
npm create rsbuild@latest my-app
cd my-app
npm install
npm run dev
```

**优点：**

- 启动快，构建速度极快
- 天然支持 React 和 TypeScript
- 类似 Vite，但构建性能更强

**缺点：**

- 新项目，生态仍在发展
- 文档相对简洁，需查阅示例



## 使用 Next.js（构建生产级 React 应用）

**[Next.js](https://nextjs.org/)** 是由 Vercel 开发的 React 框架，提供开箱即用的路由系统、服务端渲染（SSR）、静态站点生成（SSG）、API 路由、图像优化等功能。它已经成为构建生产级 React 应用的首选框架之一。

安装方式非常简单：

```bash
npx create-next-app@latest my-next-app
cd my-next-app
npm run dev
```

Next.js 默认使用文件系统路由，支持 TypeScript、ESLint、Tailwind CSS、App Router（现代 React 架构）等现代前端特性。

**优点：**

- 基于 React，功能更强大
- 自带路由、SSR/SSG、SEO 支持
- 适合构建中大型项目或商业应用

**缺点：**

- 对初学者较复杂，学习曲线陡于 Vite
- 框架本身较重，不适合非常轻量的项目



## 多种安装方式对比

|     安装方式     | 推荐程度  |               特点               |       适用场景        |
| :--------------: | :-------: | :------------------------------: | :-------------------: |
|     CDN 引入     |     ⭐     |      快速预览，无需构建工具      |      教学 / Demo      |
| Create React App | ⚠️（弃用） |        曾经流行，但已过时        |      小型旧项目       |
|     **Vite**     |    ⭐⭐⭐    |     官方推荐，构建快、体验好     |   新项目 / 学习首选   |
|      Parcel      |    ⭐⭐     |          零配置、轻量级          |       简单项目        |
|     RSbuild      |    ⭐⭐⭐    |      极致性能、Rust 构建器       |      高性能需求       |
|   **Next.js**    |    ⭐⭐⭐    | 基于 React，支持 SSR/SSG、路由等 | 商业项目 / 全栈开发者 |



## 小结

React 提供了多种安装方式，你可以根据项目规模、性能需求和团队习惯选择合适的工具。如果你计划构建简单的学习项目或组件库，推荐使用 **Vite 或 RSbuild**；如果你计划构建一个完整的网站或商业级 Web 应用，**Next.js 是非常优秀的选择**。它不仅扩展了 React 的能力，还提供了一站式的开发体验。不同的工具有不同的优势，你可以根据项目规模和目标自由选择。
