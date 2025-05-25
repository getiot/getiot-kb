---
sidebar_position: 8
slug: /nustjs-middleware-plugins
---

# Nuxt.js 中间件与插件

在开发 Nuxt 应用时，你可能会希望在页面渲染前执行一些逻辑，比如权限校验、跳转控制，或者在应用启动时注入一些全局功能。这时候就可以用到 Nuxt 的中间件（Middleware）和插件（Plugins）。本文将带你理解它们的用途，并教你如何在项目中正确使用它们。

在这篇文章中，你将学习：

- 中间件（Middleware）的基本概念和使用方法
- 插件（Plugins）的创建与注入机制
- 它们在实际项目中的常见使用场景



## 中间件（Middleware）

中间件是在页面组件渲染之前运行的一段逻辑，常用于访问控制、重定向、日志等场景。

### 使用方式一：定义全局中间件

你可以在 `middleware/` 目录下创建一个中间件文件，例如 `auth.ts`：

```tsx showLineNumbers title="middleware/auth.ts"
export default defineNuxtRouteMiddleware((to, from) => {
  const user = useUserStore()

  if (!user.isLoggedIn && to.path !== '/login') {
    return navigateTo('/login')
  }
})
```

中间件函数可以访问当前路由信息和上下文。你可以返回一个重定向，或者不返回任何内容。

要让它全局生效，需要在页面组件中使用：

```html showLineNumbers
<script setup>
definePageMeta({
  middleware: 'auth'
})
</script>
```

你还可以同时使用多个中间件：

```tsx showLineNumbers
definePageMeta({
  middleware: ['auth', 'log']
})
```

### 使用方式二：全局默认中间件

如果你希望某些逻辑在所有页面都执行，可以在 `nuxt.config.ts` 中设置 `router.middleware`，或者使用插件的方式组合。



## 插件（Plugins）

插件用于在应用初始化时注入全局功能，比如注册第三方库、封装工具函数、扩展 Vue 实例等。

### 创建插件

你需要在 `plugins/` 目录下创建一个插件文件，例如 `plugins/hello.ts`：

```tsx showLineNumbers title="plugins/hello.ts"
export default defineNuxtPlugin(nuxtApp => {
  console.log('插件初始化！')

  nuxtApp.provide('hello', () => '你好，我是插件注入的函数！')
})
```

### 使用插件提供的内容

你可以在组件中通过 `useNuxtApp()` 获取插件注入的内容：

```html showLineNumbers
<script setup lang="ts">
const { $hello } = useNuxtApp()
console.log($hello()) // 输出：你好，我是插件注入的函数！
</script>
```

### 配置插件运行环境（可选）

你可以通过文件命名指定插件仅在客户端或服务端运行：

- `hello.client.ts`：仅客户端运行
- `hello.server.ts`：仅服务端运行

你也可以在 `nuxt.config.ts` 中配置插件：

```tsx showLineNumbers title="nuxt.config.ts"
export default defineNuxtConfig({
  plugins: [
    '~/plugins/hello.ts'
  ]
})
```



## 常见场景示例

#### 登录拦截

使用中间件判断用户是否已登录，未登录则跳转到登录页。

#### 页面访问日志

在中间件中记录页面访问时间、用户信息等。

#### 全局注册第三方库

在插件中注册如 dayjs、axios、pinia 等，使其全局可用。

```tsx showLineNumbers title="plugins/axios.ts"
import axios from 'axios'

export default defineNuxtPlugin(nuxtApp => {
  const instance = axios.create({
    baseURL: 'https://api.example.com'
  })

  nuxtApp.provide('axios', instance)
})
```



## 注意事项

- 中间件不要做太复杂或异步的操作，避免影响页面加载。
- 插件推荐只用于初始化和注入，不要在里面直接操作 DOM 或组件状态。
- 插件注入的内容通过 `$xxx` 命名访问，例如 `$hello`、`$axios`。



## 小结

本篇你学习了如何在 Nuxt 应用中使用中间件和插件。中间件适用于页面渲染前的路由控制逻辑，而插件则更适合在应用初始化阶段注入全局功能。合理使用这两个工具，可以让你的 Nuxt 项目结构更加清晰、扩展性更强。在实际开发中，它们是构建中大型应用不可或缺的利器。
