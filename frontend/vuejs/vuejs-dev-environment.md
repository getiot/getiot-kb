---
sidebar_position: 2
slug: /vuejs-dev-environment
authors: [luhuadong]
---

# Vue.js 开发环境

在正式开始开发 Vue 应用之前，你需要配置好本地开发环境。本节将带你了解 Vue 开发所需的基础工具，并介绍如何通过官方推荐的方式快速搭建 Vue 3 项目开发环境。你将学会使用 Node.js、包管理器（如 npm 或 pnpm）、Vue 官方工具（如 `create-vue` 和 `Vite`）进行项目初始化。



## 准备工作

在开始之前，请确保你的电脑中安装了以下工具：

### 安装 Node.js

Vue 3 需要依赖 Node.js 运行环境，建议安装 **Node.js 16.0 或更高版本**。你可以访问 [Node.js 官网](https://nodejs.org/) 下载安装包，具体下载和安装步骤可参考《[Node.js 安装](/nodejs/nodejs-installation/)》。如果你的系统安装了多个 Node.js 版本，推荐使用 [NVM](/nodejs/node-version-manager/) 工具进行管理。

安装完成后，在终端中运行以下命令，确认是否安装成功：

```bash
node -v
npm -v
```

你应该能看到 Node.js 和 npm 的版本号。

### 选择包管理器

Node.js 默认包含了 npm，但你也可以选择其他更高效的包管理器，比如：

- [pnpm](https://pnpm.io/)：更快、更节省磁盘空间，推荐使用。
- [yarn](https://yarnpkg.com/)：更人性化的包管理工具。

以安装 pnpm 为例：

```bash
npm install -g pnpm
```



## 创建 Vue 项目

Vue 官方推荐使用 [`create-vue`](https://github.com/vuejs/create-vue) 脚手架工具来创建 Vue 3 项目，底层使用了 **Vite** 构建工具。

### 使用 npm 创建项目

```bash
npm create vue@latest
```

或者使用 pnpm：

```bash
pnpm create vue@latest
```

执行命令后，终端会提示你输入项目名称，并选择配置项：

- 是否使用 TypeScript？
- 是否添加 Vue Router？
- 是否添加 Pinia（状态管理）？
- 是否使用 ESLint、Prettier 等工具？

你可以根据自己的需求自由选择。如果你只是想快速开始，可以全部选择默认项。



### 启动开发服务器

创建项目成功后，进入项目目录并启动开发服务器：

```bash
cd my-vue-app
pnpm install
pnpm dev
```

默认情况下，开发服务器会运行在 `http://localhost:5173/`，打开浏览器即可看到 Vue 应用的欢迎页面。



## VS Code：推荐的开发工具

虽然你可以使用任何代码编辑器开发 Vue 项目，但我们强烈推荐你使用 [Visual Studio Code](/vscode/)，并安装以下插件：

- **Volar**：Vue 3 的官方语法支持插件，支持 TypeScript。
- **TypeScript Vue Plugin (Volar)**：增强 Volar 的类型支持。
- **Prettier** 或 **ESLint**：用于代码格式化和规范检查。



## 小结

本节你学习了如何配置 Vue.js 的开发环境，包括安装 Node.js、选择包管理器、使用官方工具创建项目，并启动开发服务器。推荐使用 VS Code 搭配 Volar 插件提升开发体验。下一节你将编写第一个 Vue 组件，正式进入开发实战阶段！
