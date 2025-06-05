---
sidebar_position: 4
slug: /nuxtjs-layouts-and-components
authors: [luhuadong]
---

# Nuxt.js 组件与布局管理

在 Nuxt.js 中，组件（Components）和布局（Layouts）是构建大型 Vue 应用的关键模块。组件可以复用 UI 片段，布局用于统一结构化页面骨架，比如导航栏、侧边栏、页脚等。

本节将介绍如何在 Nuxt 应用中使用组件和布局，并给出实际使用示例。



## 组件（Components）

Nuxt 提供自动导入功能：你只需将组件文件放在 `components/` 目录中，即可在页面或其他组件中**直接使用组件名**，无需 `import`。

请看下面示例，首先创建一个通用按钮组件 `components/MyButton.vue`，如下：

```html showLineNumbers title="components/MyButton.vue"
<template>
  <button class="my-btn"><slot /></button>
</template>

<style scoped>
.my-btn {
  padding: 8px 16px;
  background-color: #007bff;
  border: none;
  color: white;
  border-radius: 4px;
  cursor: pointer;
}
.my-btn:hover {
  background-color: #0056b3;
}
</style>
```

在 `pages/index.vue` 页面中使用 MyButton 组件：

```html showLineNumbers title="pages/index.vue"
<template>
  <div>
    <h1>首页</h1>
    <MyButton>点击我</MyButton>
  </div>
</template>
```

:::tip

不需要使用 import 导入组件，只需命名匹配文件名即可。

:::



## 布局（Layouts）

Nuxt 的布局系统让你可以为不同页面设置不同的页面框架。默认布局为 `default.vue`，你也可以添加自定义布局，如 `admin.vue`。

### 创建默认布局

创建一个默认布局文件 `layouts/default.vue`，这样所有页面会默认使用 `default` 布局。

```html showLineNumbers title="layouts/default.vue"
<template>
  <div>
    <header>
      <h1>我的网站</h1>
    </header>
    <main>
      <slot />
    </main>
    <footer>
      <p>© 2025 我的名字</p>
    </footer>
  </div>
</template>

<style scoped>
header {
  background: #333;
  color: white;
  padding: 1em;
}
main {
  padding: 1em;
}
footer {
  background: #f1f1f1;
  padding: 1em;
  text-align: center;
}
</style>
```

如果遇到默认布局 `layouts/default.vue` 没有生效的问题，可能是由于 **页面中未启用布局系统** 或 **Nuxt 项目配置不完整** 导致的。请逐一检查以下原因：

1. 删除 `app.vue`（如果有）
2. 确保页面在 `pages/` 下，且有 `layouts/default.vue`
3. 不在页面里指定 `layout: false`
4. 重启开发服务器：有时候热更新不会自动生效



### 使用自定义布局

创建新布局：`layouts/admin.vue`

```html showLineNumbers title="layouts/admin.vue"
<template>
  <div>
    <nav>管理员导航</nav>
    <main>
      <slot />
    </main>
  </div>
</template>
```

页面中指定布局：`pages/admin.vue`

```html showLineNumbers title="pages/admin.vue"
<script setup>
definePageMeta({
  layout: 'admin'
})
</script>

<template>
  <h2>后台页面</h2>
</template>
```

:::tip

`definePageMeta` 是 Nuxt 提供的 Composition API，用于为页面设置元信息（如布局、SEO 选项等）。

:::



## 小结

本文介绍了在 Nuxt.js 中如何创建并导入组件，以及通过默认布局和自定义布局的使用。掌握在 Nuxt 应用中使用组件和布局，是构建复杂 Web 系统的重要基础。

| 功能       | 目录                  | 使用方式                           |
| ---------- | --------------------- | ---------------------------------- |
| 组件       | `components/`         | 自动导入，直接使用标签             |
| 默认布局   | `layouts/default.vue` | 所有页面默认使用                   |
| 自定义布局 | `layouts/xxx.vue`     | 在页面中通过 `definePageMeta` 指定 |



## 建议实践

- 创建一个 `Header.vue` 组件并添加到布局中
- 创建一个 `BlogLayout.vue` 用于博客页面
- 使用 `<slot name="footer" />` 实现具名插槽自定义页脚内容
