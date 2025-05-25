---
sidebar_position: 17
slug: /react-deploy
authors: [luhuadong]
---

# React 项目构建与部署

在你完成了 React 项目的开发之后，下一步就是将它构建成可以上线运行的生产版本，并部署到服务器或云平台上，让用户能够访问你的应用。本章将带你了解 React 项目的构建流程，常用的构建工具配置，以及几种常见的部署方式，帮助你顺利将项目发布上线。



## React 项目构建简介

React 本身只是一个前端库，开发过程中你使用的是源码文件（JSX、ES6+ 等）。而浏览器只能理解经过编译和打包后的 JavaScript 文件。因此，构建（build）这个步骤就是将你的代码转换成浏览器可执行文件，通常包括：

- 转译 JSX 和 ES6+ 代码（使用 Babel）
- 模块打包（使用 Webpack、Vite 等工具）
- 压缩和优化代码，减小体积
- 生成静态资源文件（HTML、CSS、JS）

构建后生成的产物一般放在一个叫 `build` 或 `dist` 的目录下。



## 使用 create-react-app 构建

如果你使用了 `create-react-app`（CRA）创建项目，构建过程非常简单。

在项目根目录运行：

```bash
npm run build
```

CRA 会自动调用内部配置的 Webpack，进行代码打包和优化，生成生产环境可用的静态文件，默认输出到 `build` 文件夹。

构建完成后，你可以将 `build` 文件夹下的内容上传到你的服务器或静态托管平台。



## 使用 Vite 构建

如果你的项目是用 Vite 创建的，构建也非常便捷：

```bash
npm run build
```

Vite 会快速打包你的项目，输出到 `dist` 文件夹。Vite 构建速度快，适合中大型项目。



## 其他构建工具

- **Parcel**：零配置打包工具，支持 React，运行 `parcel build entry.js` 进行构建。
- **RSBuild**：较新的打包工具，支持高性能构建。

大多数现代构建工具都支持 React，选用时建议结合项目需求和团队习惯。



## 部署方式概览

### 静态托管服务

React 项目本质上是静态文件，可直接部署到：

- GitHub Pages
- Netlify
- Vercel
- 阿里云 OSS 静态网站托管
- 七牛云、腾讯云 COS 等对象存储

这类服务一般支持自动化构建和持续集成，适合前端项目。

### 传统 Web 服务器

你也可以将构建产物上传到 Apache、Nginx 等服务器目录，配置静态资源访问。

注意需配置路由重定向，防止刷新导致 404（如 Nginx 配置 `try_files`）。



## 简单的 Nginx 部署示例

假设构建产物放在 `/var/www/react-app`，Nginx 配置示例：

```nginx showLineNumbers
server {
  listen 80;
  server_name your-domain.com;

  root /var/www/react-app;
  index index.html;

  location / {
    try_files $uri /index.html;
  }
}
```

这里的 `try_files` 是为了支持 React Router 的前端路由，刷新时不会返回 404。



## 总结与建议

- 构建是 React 应用发布前必须的步骤，现代工具如 CRA 和 Vite 让构建非常简单。
- 部署时优先考虑静态托管服务，自动化和维护成本低。
- 使用传统服务器时注意配置前端路由的重定向。
- 对于复杂需求，可以结合后端服务器做接口代理、安全控制等。



## 注意事项

静态托管的网站可以通过前端 JavaScript 调用后端 API，比如支付接口、数据库访问、表单提交等，实现动态业务逻辑。但需要注意以下一些问题：

- **静态托管**

  SPA（单页应用）和 SSG（静态站点生成）适合纯静态托管，用户体验好，部署简单。但是 SSR（服务器端渲染）需要服务器支持，不能直接静态托管。

- **跨域问题（CORS）**

  前端调用外部 API 时，API 服务器需允许跨域请求，否则浏览器会阻止。

- **安全性**

  前端代码公开，敏感信息（API Key、密钥）不能写在前端，应通过后端代理或云函数调用。

- **支付等安全操作**

  支付操作通常需后端服务验证和处理，前端只调用支付 SDK 或跳转，确保流程和安全。



## 小结

React 项目的构建是将开发代码转换为浏览器可执行静态文件的过程。使用 create-react-app 或 Vite 等工具，可以轻松生成优化后的生产版本。部署方面，静态托管服务如 GitHub Pages、Netlify 是快速简便的选择；如果使用传统服务器，则需配置好前端路由的重定向，避免刷新导致页面无法访问。掌握构建与部署流程后，你就能将 React 应用顺利发布上线，让更多用户访问你的作品。
