---
sidebar_position: 6
slug: /nustjs-state-management
---

# Nuxt.js 状态管理（使用 Pinia）

Pinia 是 Vue 官方推荐的状态管理库，也已成为 Nuxt 3 默认支持的状态管理方案。在这篇文章中，你将学会如何在 Nuxt 项目中启用并使用 Pinia，轻松实现应用中的全局状态管理。



## 启用 Pinia

Pinia 是 Vue 生态中的现代状态管理库，它提供了简单直观的 API、优秀的类型推导支持，并且默认支持 Vue Devtools。相比于旧的 Vuex，Pinia 更轻量、易用、模块化。

从 Nuxt 3 开始，Pinia 已内置支持，默认可直接使用。也就是说，你只需创建 `stores` 目录，Nuxt 会自动安装和配置好 Pinia 插件，你无需手动引入或安装。

:::info 注意

如果没有安装自动安装 Pinia 插件，可以手动安装：

```bash
npm install @pinia/nuxt
```

并确保 `@pinia/nuxt` 插件已添加到 `modules`：

```tsx showLineNumbers title="nuxt.config.ts"
export default defineNuxtConfig({
  modules: ['@pinia/nuxt']
})
```

:::

创建目录：

```bash showLineNumbers
mkdir stores
```

然后在该目录下创建你的第一个 Store 文件，例如 `stores/counter.ts`：

```tsx showLineNumbers title="stores/counter.ts"
export const useCounter = defineStore('counter', () => {
  const count = ref(0)

  function increment() {
    count.value++
  }

  return { count, increment }
})
```



## 在组件中使用 Store

你可以在任何组件中直接使用这个 Store：

```html showLineNumbers
<script setup lang="ts">
const counter = useCounter()
</script>

<template>
  <div>
    <p>当前计数：{{ counter.count }}</p>
    <button @click="counter.increment">增加</button>
  </div>
</template>
```

**说明**：

- `useCounter()` 是我们在 `stores/counter.ts` 中定义的 Store。
- 所有状态和方法都可以响应式地在组件中使用。



## 响应式与持久化

Pinia 的 Store 是响应式的，你可以像使用普通变量一样双向绑定：

```html showLineNumbers
<input v-model="counter.count" />
```

如果你希望将状态持久化（例如保存到 localStorage），可以使用 [pinia-plugin-persistedstate](https://github.com/prazdevs/pinia-plugin-persistedstate)。

安装插件（可选）：

```bash showLineNumbers
npm install pinia-plugin-persistedstate
```

然后在 `plugins/pinia.ts` 中注册：

```tsx showLineNumbers title="plugins/pinia.ts"
import { defineNuxtPlugin } from '#app'
import piniaPluginPersistedstate from 'pinia-plugin-persistedstate'

export default defineNuxtPlugin((nuxtApp) => {
  nuxtApp.$pinia.use(piniaPluginPersistedstate)
})
```

在 store 中启用：

```tsx showLineNumbers
export const useCounter = defineStore('counter', () => {
  const count = ref(0)
  function increment() {
    count.value++
  }

  return { count, increment }
}, {
  persist: true
})
```



## Store 的模块化组织

每个 Store 文件是独立的模块，你可以根据实际业务划分多个 Store，例如：

- `stores/user.ts`：用户信息
- `stores/todo.ts`：待办事项
- `stores/theme.ts`：主题设置

命名规范通常使用 `useXxx` 格式，符合组合式 API 的风格。



## 小结

Pinia 是 Nuxt 3 推荐的状态管理方案，它集成简洁、类型安全、自动注入的特性，让你能够更轻松地管理应用状态。在 Nuxt 中使用 Pinia 十分简单，只需创建 `stores` 目录并定义你的 Store，然后即可在任意组件中使用。若有持久化需求，也可以通过插件轻松实现。
