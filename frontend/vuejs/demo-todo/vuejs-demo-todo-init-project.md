---
sidebar_position: 2
sidebar_label: 搭建项目与页面结构
slug: /vuejs-demo-todo-init-project
---

# Vue.js 实现 ToDo 应用：搭建项目与页面结构

在开始写 ToDo 应用之前，你需要先搭建一个 Vue 项目开发环境。我们将使用 [Vite](https://vitejs.dev/) 来初始化 Vue 项目，因为它启动快、配置简单、构建迅速，非常适合学习和中小项目开发。



## 创建 Vue 项目

#### 1. 安装 Node.js（如尚未安装）

你需要先安装 [Node.js](https://nodejs.org/)。建议使用最新的稳定版本（例如 v18+）。安装完成后，在终端中输入以下命令确认是否成功：

```bash showLineNumbers
node -v
npm -v
```

#### 2. 使用 Vite 创建 Vue 项目

打开终端，执行以下命令：

```bash showLineNumbers
npm create vite@latest vue-todo-demo
```

接下来 Vite 会提示你选择框架类型：

```bash showLineNumbers
✔ Select a framework: › Vue
✔ Select a variant: › TypeScript
```

等待初始化完成后，进入项目目录并安装依赖：

```bash showLineNumbers
cd vue-todo-demo
npm install
```

#### 3. 启动开发服务器

启动项目：

```bash showLineNumbers
npm run dev
```

打开浏览器访问 `http://localhost:5173`，你将看到 Vite 的默认欢迎页面 🎉。



## 清理默认模板

为了方便你从零开始构建页面，现在可以先清除默认的模板内容。

打开 `src/App.vue`，把内容替换成一个简化版模板：

```html showLineNumbers
<template>
  <div class="app">
    <h1>📋 我的 ToDo 应用</h1>
  </div>
</template>

<script setup>
// 暂时不需要逻辑
</script>

<style scoped>
.app {
  max-width: 600px;
  margin: 2rem auto;
  padding: 1rem;
  font-family: Arial, sans-serif;
}
</style>
```

你现在应该在浏览器中看到一个简单的标题 “📋 我的 ToDo 应用”。



## 项目结构准备

接下来，为了保持结构清晰，我们来创建几个组件文件。

在 `src` 目录下新建一个 `components` 文件夹（如果没有）：

```bash showLineNumbers
mkdir src/components
```

然后创建以下组件文件（文件可以暂时留空）：

- `TodoInput.vue`：输入框组件（管理任务输入和添加逻辑）
- `TodoItem.vue`：单个待办项组件（渲染任务项、实现删除功能）
- `TodoFilter.vue`：过滤器组件（例如“全部 / 已完成 / 未完成”）

结构如下：

```bash showLineNumbers
src/
├── assets/              # 静态资源
├── components/          # Vue 组件目录
│   ├── TodoInput.vue
│   ├── TodoItem.vue
│   └── TodoFilter.vue
├── App.vue              # 根组件
└── main.ts              # 项目入口文件
```

你可以先在这些组件里写一句 `<template><div>组件名称</div></template>` 占位，后面会逐步补充内容。



## 小结

在本节中，你学会了如何使用 Vite 快速搭建 Vue 项目，并完成了页面结构的基本清理和组件目录的初步搭建。现在你已经为 ToDo 应用的正式开发打下了坚实的基础。在下一步中，你将开始实现添加待办事项的功能，一起继续加油吧！
