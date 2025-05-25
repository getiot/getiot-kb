---
sidebar_position: 4
slug: /react-first-app
---

# 创建第一个 React 项目

今天，我们将从零开始，带你创建并运行第一个 React 项目。你将学会项目结构的基本组成，如何启动开发服务器，以及如何在浏览器中看到自己的 React 页面。

对于刚刚入门 React 的朋友来说，最重要的第一步就是上手实战。与其死记 API，不如动手尝试。通过本篇教程，你将从零创建一个 React 项目，跑起第一个组件页面，为接下来的学习打好基础。



## 选择项目创建方式

[前面](/react/react-installation/)我们介绍的几种安装方式，这里我们推荐使用 **Vite** 来创建你的第一个 React 项目，原因如下：

- 快速构建，几乎秒启动
- 官方推荐，生态活跃
- 更贴近现代开发方式

当然，你也可以选择 CRA、Next.js、Parcel 或 CDN 方式。



## 使用 Vite 创建 React 项目

### 步骤 1：安装 Node.js

确保你的开发环境已经安装了 [Node.js](https://nodejs.org/)。推荐使用 LTS 版本。

安装完成后，在终端运行以下命令检查版本：

```bash
node -v
npm -v
```

### 步骤 2：使用 Vite 脚手架创建项目

打开终端，运行：

```bash
npm create vite@latest my-react-app -- --template react
```

这条命令的意思是：

- 使用 `vite` 创建项目
- 项目名称是 `my-react-app`
- 使用官方提供的 `react` 模板

系统会引导你完成初始化流程。

### 步骤 3：安装依赖并启动开发服务器

进入项目目录：

```bash
cd my-react-app
```

安装依赖：

```bash
npm install
```

启动开发服务器：

```bash
npm run dev
```

启动成功后，终端会显示一个本地地址（通常是 `http://localhost:5173`），用浏览器访问即可看到初始页面内容：

![创建第一个 React 项目](https://static.getiot.tech/my-react-app-01.webp#center)



## 项目结构解析

以下是典型的 Vite + React 项目目录结构：

```bash showLineNumbers
my-react-app/
├── node_modules/
├── public/
├── src/
│   ├── App.css
│   ├── App.jsx
│   ├── index.css
│   └── main.jsx
├── index.html
├── package.json
├── vite.config.js
```

重点文件说明：

- `src/main.jsx`：React 应用的入口文件
- `src/App.jsx`：主组件，默认展示“Vite + React”
- `index.html`：根 HTML 文件，包含挂载点 `<div id="root"></div>`
- `vite.config.js`：Vite 的配置文件



## 尝试修改页面内容

打开 `src/App.jsx`，你可以尝试修改以下内容：

```tsx showLineNumbers
function App() {
  return (
    <div>
      <h1>Hello React!</h1>
      <p>这是你第一个 React 项目 🎉</p>
    </div>
  )
}
```

保存后浏览器会自动刷新，马上就能看到更新后的页面。这就是 **热重载（HMR）** 的魔力。



## 小结

恭喜你成功跑起了第一个 React 项目！通过 Vite 这类现代工具，你能快速进入开发状态。项目结构清晰，代码热更新灵敏，未来不管是开发组件、页面还是构建完整应用，都可以基于这个结构继续扩展。
