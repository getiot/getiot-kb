---
sidebar_position: 2
sidebar_label: 创建第一个 Nuxt 应用
slug: /nustjs-getting-started
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

然后访问 `http://localhost:3000/hello`，就能看到你刚创建的页面啦！



:::tip

Nuxt 会根据 `pages` 目录自动生成路由，无需手动配置。

:::



## 小练习

试着完成以下任务：

- 修改首页的欢迎文本。
- 创建一个新的页面 `about.vue`，显示“关于我们”。
- 在 `components/` 中创建一个组件，并在页面中使用它。



## 小结

你已经完成了第一个 Nuxt 项目的初始化与运行，并了解了其核心目录结构。接下来，你可以深入学习页面路由、组件使用、服务端 API 等内容。
