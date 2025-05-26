---
sidebar_position: 2
sidebar_label: 创建第一个 Nuxt 应用
slug: /nustjs-getting-started
authors: [luhuadong]
---

# 创建你的第一个 Nuxt 应用

在本节中，你将学习如何从零开始创建并运行一个 Nuxt.js 应用。我们将通过官方提供的命令行工具快速初始化项目，并了解目录结构与开发体验。



## 安装 Node.js 环境

Nuxt.js 基于 Node.js 运行，请先确认你已经安装了 Node.js（建议版本 ≥ 18）：

```bash
node -v
```

如果未安装，请参考《[Node.js 安装](/nodejs/nodejs-installation/)》教程。

:::tip

这里的 `nuxi` 是 Nuxt 官方提供的命令行工具，可以通过 `npx` 直接调用，**无需提前安装**。

如果你希望将 `nuxi` 安装为全局命令，可以通过下面命令安装：

```bash
npm install -g nuxi
```

:::



## 使用命令行创建 Nuxt 应用

Nuxt 官方提供了一个脚手架工具 `nuxi`，可以快速生成项目结构。

### 步骤 1：初始化项目

在终端中运行以下命令，创建一个新项目：

```bash
npx nuxi init my-nuxt-app
```

这将创建一个名为 `my-nuxt-app` 的目录，并包含基本的 Nuxt 项目结构。你可以根据自己的需要修改项目名字。

如果你在全局安装了 `nuxi` 命令，也可以直接使用 `nuxi init` 创建项目：

```bash
nuxi init my-nuxt-app
```

创建过程会询问你是否需要预装一些官方模块：

```bash
❯ Would you like to install any of the official modules?
◻ @nuxt/content – The file-based CMS with support for Markdown, YAML, JSON
◻ @nuxt/eslint – Project-aware, easy-to-use, extensible and future-proof ESLint integration
◻ @nuxt/fonts – Add custom web fonts with performance in mind
◻ @nuxt/icon – Icon module for Nuxt with 200,000+ ready to use icons from Iconify
◻ @nuxt/image – Add images with progressive processing, lazy-loading, resizing and providers support
◻ @nuxt/scripts – Add 3rd-party scripts without sacrificing performance
◻ @nuxt/test-utils – Test utilities for Nuxt
◻ @nuxt/ui – The Intuitive UI Library powered by Reka UI and Tailwind CSS
```

这些模块并非必选，但能为你的开发工作带来方便、增强功能。下面简单介绍这些模块的用途，你可以根据自己的需要决定是否安装。

1. `@nuxt/content`

   **功能**：基于文件系统的 CMS，支持 Markdown、YAML、JSON 文件读取。你可以用它构建博客、文档等内容驱动型网站，无需数据库。

   **适合人群**：写博客、建文档站点（如 VuePress、Docusaurus 的替代方案）。

   **新手建议**：如果你打算写 Markdown 内容或做内容管理，推荐勾选。否则可以先跳过。

2. `@nuxt/eslint`

   **功能**：整合 ESLint（JavaScript 和 TypeScript 的代码检查工具），自动检查代码风格和潜在错误。

   **适合人群**：任何想保持代码整洁、团队协作开发的人。

   **新手建议**：推荐勾选，它可以帮你保持代码风格一致。

3. `@nuxt/fonts`

   **功能**：优化网页字体的加载方式，支持自定义字体、Google Fonts 等，提升页面性能。

   **适合人群**：想在项目中使用个性化字体、设计讲究的项目。

   **新手建议**：非必需，默认字体够用时可以不选，后续再添加也不难。

4. `@nuxt/icon`

   **功能**：支持 Iconify 提供的 20 万+ 图标（如 FontAwesome、Material Icons 等），使用方式简单且性能优化良好。

   **适合人群**：想方便快捷地在项目中加入图标。

   **新手建议**：推荐勾选，图标是网站开发中常用的 UI 元素。

5. `@nuxt/image`

   **功能**：对图片进行性能优化（懒加载、自动压缩、大小裁剪等），支持本地和第三方图床（如 Cloudinary）。

   **适合人群**：对图片有性能要求的网站（如图片展示、相册、电商网站等）。

   **新手建议**：推荐勾选，有助于提高网站加载速度，尤其是图片较多时。

6. `@nuxt/scripts`

   **功能**：用于加载第三方脚本（如 Google Analytics、Chat 插件）时提供性能优化的方式。

   **适合人群**：需要引入广告、埋点、监控等外部脚本的网站。

   **新手建议**：如果暂时不使用第三方脚本，可不选，后期按需添加即可。

7. `@nuxt/test-utils`

   **功能**：为 Nuxt 项目提供测试工具（如组件测试、E2E 测试等）。

   **适合人群**：有自动化测试需求的开发者。

   **新手建议**：初学阶段可不勾选，等你熟悉基本开发流程后再尝试自动化测试。

8. `@nuxt/ui`

   **功能**：Nuxt 官方推出的 UI 组件库，基于 Tailwind CSS，组件丰富，样式优雅，使用方便。

   **适合人群**：希望快速构建界面、避免手写大量样式的人。

   **新手建议**：推荐勾选，它能帮你快速搭建出漂亮的页面界面，学习成本低。

如果你是初学者，不确定怎么选，我们推荐你可以勾选 `@nuxt/eslint`、`@nuxt/icon`、`@nuxt/image` 和 `@nuxt/ui` 试试。非内容站点不需要安装 `@nuxt/content`，如果未来你想添加这些模块，也可以随时手动安装，比如：

```bash
npm install @nuxt/content
```



### 步骤 2：安装依赖

进入项目目录并安装依赖：

```bash
cd my-nuxt-app
npm install
```

或使用 `yarn` / `pnpm`：

```bash
yarn install
# 或
pnpm install
```

### 步骤 3：启动开发服务器

运行开发环境：

```bash
npm run dev
```

你将看到如下输出：

``` bash
Nuxt 3 ready on http://localhost:3000
```

现在你可以在浏览器中访问 `http://localhost:3000`，看到默认欢迎页面。



## 项目结构简述

创建成功后，目录结构大致如下：

```bash showLineNumbers
my-nuxt-app/
├── app.vue          # 应用入口文件（可选）
├── nuxt.config.ts   # Nuxt 配置文件
├── pages/           # 页面文件夹（路由自动生成）
├── public/          # 静态资源目录
├── components/      # Vue 组件存放位置
├── server/          # Server API（可选）
├── assets/          # 样式和静态资源（如 CSS / SCSS）
└── ...              # 其他自动生成文件
```

Nuxt 的目录驱动（convention over configuration）特性可以极大地提升开发效率，后续章节将逐步介绍这些目录的作用。



## 示例：添加一个页面

在 `pages/` 下添加一个页面 `hello.vue`：

```html showLineNumbers title="pages/hello.vue"
<template>
  <h1>Hello Nuxt!</h1>
</template>
```

删除 `app.vue` 文件，或者将原来默认的修改为：

```html showLineNumbers {4} title="app.vue"
<template>
  <div>
    <NuxtRouteAnnouncer />
    <NuxtPage />
  </div>
</template>
```

然后访问 `http://localhost:3000/hello`，就能看到你刚创建的页面啦！



:::tip

Nuxt 会根据 `pages` 目录自动生成路由，无需其他配置。

:::



## 小练习

试着完成以下任务：

- 修改首页的欢迎文本。
- 创建一个新的页面 `about.vue`，显示“关于我们”。
- 在 `components/` 中创建一个组件，并在页面中使用它。



## 小结

你已经完成了第一个 Nuxt 项目的初始化与运行，并了解了其核心目录结构。接下来，你可以深入学习页面路由、组件使用、服务端 API 等内容。
