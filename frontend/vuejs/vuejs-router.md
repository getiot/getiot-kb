---
sidebar_position: 19
slug: /vuejs-router
authors: [luhuadong]
---

# Vue Router 路由管理

在构建单页应用（SPA）时，Vue Router 是 Vue 官方提供的路由解决方案。通过它，你可以轻松实现组件与 URL 的映射、前进后退导航控制、嵌套路由等功能。本篇文章将带你从零了解 Vue Router 的基本用法，包括安装、配置、跳转、嵌套路由以及命名路由等常见功能。



## 安装 Vue Router

Vue Router 是一个独立的库，需要你手动安装。假设你使用的是 Vue 3 项目：

```bash
npm install vue-router@4
```

安装完成后，你就可以在项目中引入并配置它了。



## 创建路由配置

首先，你需要定义一组路由规则，这些规则决定了当用户访问特定 URL 时要加载哪个组件。

```tsx showLineNumbers title="router/index.js 或 router.js"
import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import About from '../views/About.vue'

const routes = [
  { path: '/', component: Home },
  { path: '/about', component: About }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
```

这里：

- `path` 表示 URL 路径；
- `component` 表示该路径下要渲染的 Vue 组件；
- `createWebHistory()` 使用 HTML5 History 模式，URL 没有 `#`。



## 在项目中挂载 Router

在 `main.js` 或 `main.ts` 中引入并使用你刚创建的 router 实例：

```tsx showLineNumbers
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

createApp(App).use(router).mount('#app')
```

这就把路由系统集成进了你的 Vue 应用中。



## 使用 `<router-view>` 显示路由组件

Vue Router 会根据当前 URL 渲染匹配的组件，但你必须在页面中放置一个占位标签：

```html showLineNumbers
<template>
  <div>
    <h1>我的应用</h1>
    <router-view></router-view>
  </div>
</template>
```

这个 `<router-view>` 就是所有路由组件的“出口”，当前路径对应哪个组件，就会在这里渲染哪个组件。



## 使用 `<router-link>` 实现跳转

你可以使用 `<router-link>` 标签代替传统的 `<a>` 标签来实现前端跳转：

```html showLineNumbers
<template>
  <div>
    <router-link to="/">首页</router-link>
    <router-link to="/about">关于</router-link>
  </div>
</template>
```

Vue Router 会自动拦截点击事件，避免页面刷新，并改变地址栏 URL。



## 编程式导航

除了使用 `<router-link>`，你也可以通过代码进行页面跳转，这种方式称为编程式导航：

```tsx showLineNumbers
this.$router.push('/about')
// 或
this.$router.push({ path: '/about' })
// 使用命名路由：
this.$router.push({ name: 'AboutPage' })
```

注意：在组合式 API 中，你需要通过 `useRouter()` 获取路由对象：

```tsx showLineNumbers
import { useRouter } from 'vue-router'

const router = useRouter()
router.push('/about')
```



## 命名路由

为了让路由跳转更方便、更易维护，你可以给路由命名：

```tsx showLineNumbers
const routes = [
  { path: '/', name: 'HomePage', component: Home },
  { path: '/about', name: 'AboutPage', component: About }
]
```

跳转时可以这样写：

```tsx showLineNumbers
router.push({ name: 'AboutPage' })
```



## 路由参数

你可以通过路径参数来传递数据。例如：

```tsx showLineNumbers
{ path: '/user/:id', component: User }
```

访问 `/user/42` 会把 `42` 传入组件中，在组件内你可以通过 `useRoute()` 获取：

```tsx showLineNumbers
import { useRoute } from 'vue-router'

const route = useRoute()
console.log(route.params.id)
```



## 嵌套路由（子路由）

路由可以嵌套，让你构建更复杂的视图结构。例如：

```tsx showLineNumbers
const routes = [
  {
    path: '/dashboard',
    component: Dashboard,
    children: [
      { path: 'profile', component: Profile },
      { path: 'settings', component: Settings }
    ]
  }
]
```

访问 `/dashboard/profile` 时，`Dashboard` 组件中的 `<router-view>` 会加载 `Profile` 组件。



## 重定向与 404 页面

你可以设置重定向：

```tsx showLineNumbers
{ path: '/home', redirect: '/' }
```

你也可以添加一个“通配符”来匹配所有未定义的路径，实现 404 页面：

```tsx showLineNumbers
{ path: '/:pathMatch(.*)*', name: 'NotFound', component: NotFound }
```



## 路由守卫（路由钩子）

你可以使用 `beforeEach` 钩子在路由跳转前做检查，例如判断是否登录：

```tsx showLineNumbers
router.beforeEach((to, from, next) => {
  if (to.meta.requiresAuth && !isLoggedIn()) {
    next('/login')
  } else {
    next()
  }
})
```



## 小结

Vue Router 是构建 Vue 单页应用中不可或缺的一部分。它让你能够根据 URL 自动切换组件视图，实现页面导航、路由嵌套、传参、守卫等功能。通过这篇教程，你了解了 Vue Router 的基本使用方法和常见技巧。在后续开发中，你可以灵活组合路由特性，打造结构清晰、用户体验良好的前端应用。
