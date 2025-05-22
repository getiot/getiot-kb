---
sidebar_position: 20
slug: /vuejs-pinia
---

# Vue Pinia 状态管理

在 Vue 项目中，组件之间传递数据有时会变得复杂，特别是当多个组件需要共享同一份数据时。这时候就需要一个集中式的状态管理工具来帮你协调各方。**Pinia** 是 Vue 3 官方推荐的状态管理库，具有更简单的 API、更好的 TypeScript 支持，并且已经完全取代了 Vuex。

本篇文章将带你快速掌握 Pinia 的基本用法，包括安装、定义 Store、在组件中读取和修改状态等内容。



## 安装 Pinia

如果你使用的是 Vue 3 项目，可以通过以下命令安装 Pinia：

```bash
npm install pinia
```

安装完成后，需要在 Vue 应用中注册 Pinia：

```tsx showLineNumbers title="main.js 或 main.ts"
import { createApp } from 'vue'
import App from './App.vue'
import { createPinia } from 'pinia'

const app = createApp(App)
app.use(createPinia())
app.mount('#app')
```



## 创建一个 Store

在 Pinia 中，Store 是你用来存放状态的“仓库”。你可以为不同的功能模块创建多个 Store。

例如，创建一个名为 `counter` 的 Store 来管理计数器状态：

```tsx showLineNumbers title="stores/counter.js"
import { defineStore } from 'pinia'

export const useCounterStore = defineStore('counter', {
  state: () => ({
    count: 0
  }),
  actions: {
    increment() {
      this.count++
    }
  }
})
```

- `defineStore` 是定义一个 Store 的函数；
- 第一个参数 `'counter'` 是 Store 的唯一名称；
- `state` 是一个函数，返回初始状态；
- `actions` 是一组方法，用来修改状态或执行副作用操作。



## 在组件中使用 Store

要在组件中使用这个 Store，你可以像这样导入并调用：

```html showLineNumbers
<script setup>
import { useCounterStore } from '@/stores/counter'

const counter = useCounterStore()
</script>

<template>
  <div>
    <p>当前计数：{{ counter.count }}</p>
    <button @click="counter.increment">+1</button>
  </div>
</template>
```

在 `<script setup>` 中使用 Store 十分直观，直接调用就能访问状态和方法。



## 响应式原理

Pinia 中定义的 `state` 是响应式的，这意味着当你修改它时，界面会自动更新。比如：

```tsx showLineNumbers
counter.count += 5
```

页面中使用 `{{ counter.count }}` 的地方会自动重新渲染，无需手动刷新视图。



## 使用 getters（类似 Vuex 的计算属性）

如果你希望根据状态计算出一些派生数据，可以使用 getters：

```tsx showLineNumbers title="stores/counter.js"
export const useCounterStore = defineStore('counter', {
  state: () => ({
    count: 0
  }),
  getters: {
    doubleCount: (state) => state.count * 2
  }
})
```

在组件中：

```html showLineNumbers
<p>两倍计数：{{ counter.doubleCount }}</p>
```



## 支持多个 Store

你可以创建多个 Store 来管理不同模块的状态，例如：

```tsx showLineNumbers title="stores/user.js"
export const useUserStore = defineStore('user', {
  state: () => ({
    name: 'Alice',
    isLoggedIn: false
  }),
  actions: {
    login(name) {
      this.name = name
      this.isLoggedIn = true
    }
  }
})
```

然后在组件中同时使用：

```html showLineNumbers
<script setup>
import { useCounterStore } from '@/stores/counter'
import { useUserStore } from '@/stores/user'

const counter = useCounterStore()
const user = useUserStore()
</script>
```



## 使用 setup 模式定义 Store（更灵活）

除了 `options API` 模式外，Pinia 还支持更灵活的 `setup 模式`：

```tsx showLineNumbers title="stores/counter.js"
import { defineStore } from 'pinia'
import { ref, computed } from 'vue'

export const useCounterStore = defineStore('counter', () => {
  const count = ref(0)
  const double = computed(() => count.value * 2)
  function increment() {
    count.value++
  }

  return { count, double, increment }
})
```

这种方式更适合组合式 API 的开发风格，配合 TypeScript 使用体验更佳。



## 持久化存储

如果你希望状态在刷新后仍然保留，可以借助插件实现持久化，例如使用 [`pinia-plugin-persistedstate`](https://github.com/prazdevs/pinia-plugin-persistedstate)：

```bash
npm install pinia-plugin-persistedstate
```

然后在 `main.js` 中注册插件：

```tsx showLineNumbers
import { createPinia } from 'pinia'
import piniaPluginPersistedstate from 'pinia-plugin-persistedstate'

const pinia = createPinia()
pinia.use(piniaPluginPersistedstate)
```

在 Store 中启用：

```tsx showLineNumbers
export const useCounterStore = defineStore('counter', {
  state: () => ({ count: 0 }),
  persist: true
})
```



## 小结

Pinia 是 Vue 3 官方推荐的状态管理方案，它比 Vuex 更加轻量、简单、现代化，同时支持组合式 API 和良好的 TypeScript 支持。通过本文，你已经掌握了 Pinia 的基本用法，包括定义 Store、使用 state、actions 和 getters，以及更灵活的 setup 模式。掌握了这些知识后，你就可以在 Vue 项目中更优雅地管理全局状态，构建结构清晰、逻辑分明的前端应用。
