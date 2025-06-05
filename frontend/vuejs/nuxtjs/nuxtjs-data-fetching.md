---
sidebar_position: 5
slug: /nuxtjs-data-fetching
authors: [luhuadong]
---

# Nuxt.js 数据获取与组合式 API

在这篇教程中，你将学习如何在 Nuxt.js 中使用组合式 API 获取数据。我们会介绍 Nuxt 提供的专属数据获取函数，比如 `useFetch` 和 `useAsyncData`，并带你理解它们和 Vue 的组合式 API（Composition API）是如何协同工作的。通过实际示例，你可以掌握如何在页面加载时从远程 API 拉取数据，并在组件中高效地响应式使用这些数据。



## 什么是组合式 API？

组合式 API（Composition API）是 Vue 3 引入的一种新的组件编写方式。相比于传统的 Options API（`data`, `methods`, `computed` 等分开写），组合式 API 更加灵活，适合模块化和重用逻辑。

你可以在组件中使用 `setup()` 函数，通过 `ref`, `reactive`, `computed` 等工具函数来管理状态和逻辑。

```html showLineNumbers
<script setup lang="ts">
import { ref } from 'vue'

const count = ref(0)
const increment = () => count.value++
</script>
```



## Nuxt 中的数据获取方式

在 Nuxt 3 中，获取远程数据有两个核心工具函数：

- `useFetch`：推荐用于页面组件（Page Components），能自动处理服务端渲染、缓存等。
- `useAsyncData`：功能更通用，可用于组件中任意地方，适合更复杂的数据处理需求。



## 使用 `useFetch` 获取页面数据

如果你在页面组件中需要获取外部 API 的数据，推荐使用 `useFetch`。这个函数默认支持 SSR，你不需要手动判断当前是客户端还是服务端。

```html showLineNumbers
<template>
  <div>
    <h1>用户列表</h1>
    <ul>
      <li v-for="user in data" :key="user.id">{{ user.name }}</li>
    </ul>
  </div>
</template>

<script setup lang="ts">
const { data, pending, error } = await useFetch('https://jsonplaceholder.typicode.com/users')
</script>
```

**说明**：

- `data` 是一个 `ref`，包含响应数据。
- `pending` 是加载状态。
- `error` 是请求出错时的错误对象。
- `await` 是可选的，你也可以不加，只不过要手动处理 `pending` 状态。



## 使用 `useAsyncData` 更灵活地获取数据

当你在组件中，或者想要复用数据逻辑时，可以使用 `useAsyncData`。

```html showLineNumbers
<script setup lang="ts">
const { data: posts, pending, error } = await useAsyncData('posts', () =>
  $fetch('https://jsonplaceholder.typicode.com/posts')
)
</script>

<template>
  <div>
    <h2>文章列表</h2>
    <div v-if="pending">加载中...</div>
    <ul v-else>
      <li v-for="post in posts" :key="post.id">{{ post.title }}</li>
    </ul>
  </div>
</template>
```

这里我们手动给数据设置了一个 key：`'posts'`，Nuxt 会自动对数据进行缓存。使用 `$fetch` 是 Nuxt 提供的轻量 HTTP 请求工具，基于 [ofetch](https://github.com/unjs/ofetch)。



## 注意 SSR 和客户端行为差异

- 如果在 `useFetch` 或 `useAsyncData` 中传入的是纯函数（不带副作用），Nuxt 会在 SSR 时提前获取数据，提升页面加载速度。
- 如果数据依赖用户交互或浏览器环境（比如 `window`、`localStorage`），建议只在客户端执行，配合 `process.client` 或 `onMounted()` 来处理。



## 搭配 Vue 组合式 API 使用数据

你也可以将数据逻辑封装为可复用的 composable：

```tsx showLineNumbers
// composables/useUsers.ts
export const useUsers = () => {
  return useAsyncData('users', () => $fetch('https://jsonplaceholder.typicode.com/users'))
}
```

在组件中使用：

```html showLineNumbers
<script setup lang="ts">
const { data: users } = await useUsers()
</script>
```

这样可以让你的数据获取逻辑更加清晰、模块化。



## 小结

在 Nuxt.js 中，推荐使用 `useFetch` 和 `useAsyncData` 来获取远程数据，它们与 Vue 3 的组合式 API 协作良好，并且支持 SSR、缓存、错误处理等特性。通过将数据逻辑抽离为 composables，你可以实现更好的代码复用和维护性。在你构建页面时，记得选择合适的数据获取方式，来提升应用性能与用户体验。
