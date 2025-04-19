---
sidebar_position: 2
---

# React 安装



React 的安装方式有两种：① 直接引用 JavaScript 链接；② 使用 create-react-app 工具。

本教程使用了 React 的版本为 17.0.2，你可以在 [React 官网](https://reactjs.org) 下载最新版。



## 引用 JavaScript 链接

React 官方提供的 CDN 链接如下：

```html showLineNumbers
<script src="https://unpkg.com/react@17/umd/react.development.js" crossorigin></script>
<script src="https://unpkg.com/react-dom@17/umd/react-dom.development.js" crossorigin></script>
<!-- 生产环境中不建议使用 -->
<script src="https://unpkg.com/babel-standalone@6.15.0/babel.min.js"></script>
```

提示：在浏览器中使用 Babel 来编译 JSX 效率是非常低的，因此不建议在生产环境使用。

另外，上述 CDN 链接只适用于开发环境，不适用于生产环境。生产环境需要使用压缩处理后的依赖包，这样可以节约网络带宽，提高运行效率。压缩依赖包如下：

```html showLineNumbers
<script src="https://unpkg.com/react@17/umd/react.production.min.js" crossorigin></script>
<script src="https://unpkg.com/react-dom@17/umd/react-dom.production.min.js" crossorigin></script>
```

下面是一个简单的示例：

```html showLineNumbers
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <!-- 加载 React。-->
    <!-- 注意: 部署时，将 "development.js" 替换为 "production.min.js"。-->
    <script src="https://unpkg.com/react@17/umd/react.development.js" crossorigin></script>
    <script src="https://unpkg.com/react-dom@17/umd/react-dom.development.js" crossorigin></script>
    <script src="https://unpkg.com/babel-standalone@6.15.0/babel.min.js"></script>
</head>

<body>
    <div id="root"></div>

    <!-- 加载我们的 React 组件。-->
    <script type="text/babel">
      ReactDOM.render(
        <h1>Hello, world!</h1>,
        document.getElementById('root')
      );
    </script>
</body>

</html>
```



## 使用 create-react-app 工具

create-react-app 是 React 官方推荐的用于快速构建 React 开发环境的工具。它在内部使用 Babel 和 Webpack，用户不需要任何配置，也不需要了解它的任何细节。

create-react-app 依赖 [Node.js](/nodejs/nodejs-intro/)（Node 版本 8.10 以上，npm 版本 5.6 以上），步骤如下：

**1、全局安装 create-react-app 工具**

```bash
npm install -g create-react-app
```

**2、使用 create-react-app 工具创建项目**

```bash
create-react-app first-app
```

**3、使用 `npm scripts` 运行该项目**

```bash
cd first-app
npm start    # 或者 yarn start
```

服务启动后会在浏览器自动打开 [http://localhost:3000](http://localhost:3000)，运行效果如下：

![第一个 React 应用](https://static.getiot.tech/react-first-app.png#center)



---



```bash
npm start
    Starts the development server.

  npm run build
    Bundles the app into static files for production.

  npm test
    Starts the test runner.

  npm run eject
    Removes this tool and copies build dependencies, configuration files
    and scripts into the app directory. If you do this, you can’t go back!
```

