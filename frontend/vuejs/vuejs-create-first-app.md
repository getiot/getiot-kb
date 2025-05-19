---
sidebar_position: 4
slug: /vuejs-create-first-app
---

# 创建第一个 Vue 应用

在上一节中你已经成功搭建了 Vue 的开发环境。这一节将带你从零开始，创建并运行你的第一个 Vue 应用。你会了解 Vue 项目的基本结构，掌握组件的创建与使用，并通过一个简单的页面体验 Vue 的开发流程。



## 初始化项目

在终端中运行以下命令来创建一个新项目（如果你还没创建过的话）：

```bash
npm create vue@latest
```

你也可以使用 pnpm 或 yarn：

```bash
pnpm create vue@latest
```

执行上述命令，会进入一个交互界面，提示你输入项目名称，并选择相应的配置项，例如是否启用 TypeScript、Vue Router、Pinia 等。新手建议保留默认选项，便于快速上手。

这里我们创建一个名为 `my-first-app` 的项目，并勾选 TypeScript：

```bash
$ npm create vue@latest
Need to install the following packages:
create-vue@3.16.4
Ok to proceed? (y) y


> npx
> create-vue

┌  Vue.js - The Progressive JavaScript Framework
│
◇  请输入项目名称：
│  my-first-app
│
◆  请选择要包含的功能： (↑/↓ 切换，空格选择，a 全选，回车确认)
│  ◼ TypeScript
│  ◻ JSX 支持
│  ◻ Router（单页面应用开发）
│  ◻ Pinia（状态管理）
│  ◻ Vitest（单元测试）
│  ◻ 端到端测试
│  ◻ ESLint（错误预防）
│  ◻ Prettier（代码格式化）
```

创建完成后，进入项目目录并安装依赖：

```bash
cd my-first-app
npm install      # 或者 pnpm install
```

然后启动开发服务器：

```bash
npm run dev      # 或者 pnpm dev
```

打开浏览器访问 `http://localhost:5173/`，你将看到 Vue 提供的欢迎页面。

![创建第一个 Vue 应用](https://static.getiot.tech/vue-my-first-app-1.webp#center)



## 理解项目结构

让我们来快速浏览一下项目的目录结构：

```bash
my-vue-app/
├── public/             # 静态资源目录
├── src/                # 源码目录
│   ├── assets/         # 图片、样式等资源
│   ├── components/     # Vue 组件目录
│   ├── App.vue         # 根组件
│   └── main.ts         # 应用入口
├── index.html          # 应用模板
├── vite.config.js      # Vite 配置文件
└── package.json        # 项目信息及依赖配置
```

重点关注两个文件：

- `main.ts`：Vue 应用的入口，挂载到 DOM。
- `App.vue`：Vue 的根组件，后续组件将嵌套在其中。



## 修改首页内容

打开 `src/App.vue` 文件，将默认内容替换为一个简单的欢迎信息：

```tsx showLineNumbers title="App.vue"
<template>
  <div class="container">
    <h1>你好，Vue！</h1>
    <p>这是你的第一个 Vue 应用。</p>
  </div>
</template>

<script setup>
// 暂无逻辑，先保留空脚本块
</script>

<style scoped>
.container {
  text-align: center;
  margin-top: 100px;
}
</style>
```

保存后，浏览器会自动刷新，页面上应该已经显示出新的内容。



## 创建一个组件

在 `src/components/` 目录下新建一个名为 `Hello.vue` 的文件：

```tsx showLineNumbers title="Hello.vue"
<template>
  <div class="hello">
    <p>欢迎使用 Vue 组件！</p>
  </div>
</template>

<script setup>
// 目前没有逻辑
</script>

<style scoped>
.hello {
  color: #42b983;
  font-weight: bold;
}
</style>
```

接着，在 `App.vue` 中引入并使用这个组件：

```tsx showLineNumbers {2,8} title="App.vue"
<script setup>
import Hello from './components/Hello.vue'
</script>

<template>
  <div class="container">
    <h1>你好，Vue！</h1>
    <Hello />
  </div>
</template>
```

保存后，浏览器会自动刷新，可以看到页面上显示的新内容，如下图所示。

![创建第一个 Vue 应用](https://static.getiot.tech/vue-my-first-app-2.webp#center)

至此，你已经完成了组件的创建和引入，这是 Vue 最基本也是最核心的开发方式。



## 小结

在这一节中，你完成了从创建项目到编写组件的全过程，正式迈出了 Vue 开发的第一步。你了解了 Vue 项目的结构，学会了如何编写和引入组件。在下一节中，我们将进一步探索 Vue 的响应式数据系统，让页面随数据动态更新。
