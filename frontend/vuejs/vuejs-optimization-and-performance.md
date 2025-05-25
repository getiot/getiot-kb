---
sidebar_position: 24
slug: /vuejs-optimization-and-performance
authors: [luhuadong]
---

# Vue 项目优化与性能提升

在开发 Vue 应用的过程中，如果你不加注意性能优化，随着页面变复杂、组件数量变多，项目很容易变得缓慢甚至卡顿。本文会从多个角度出发，带你了解 Vue 项目中常见的优化手段，包括懒加载、组件缓存、列表优化、打包减小、异步组件、事件监听优化等。通过这些技巧，你可以有效提升项目的加载速度与响应性能。



## 1. 使用异步组件

Vue 支持使用 `defineAsyncComponent` 进行异步组件加载（Lazy Load Components），只在需要时才加载组件代码，减少初始打包体积。

```tsx showLineNumbers
import { defineAsyncComponent } from 'vue'

const MyComponent = defineAsyncComponent(() => import('./MyComponent.vue'))
```

如果你使用 `<script setup>`，也可以直接配合 `defineAsyncComponent` 使用：

```html showLineNumbers
<script setup>
import { defineAsyncComponent } from 'vue'

const LazyView = defineAsyncComponent(() => import('@/views/LazyView.vue'))
</script>

<template>
  <Suspense>
    <LazyView />
  </Suspense>
</template>
```



## 2. 路由懒加载

在 Vue Router 中实现懒加载（Route-Level Code Splitting）非常简单，通过 `import()` 语法可以为不同路由打包成独立的 chunk，只在用户访问该路由时才加载：

```tsx showLineNumbers
import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/about',
    component: () => import('@/views/About.vue')
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})
```



## 3. 使用 `v-once` 静态内容优化

当你确定某个组件中的内容不会变化时，可以使用 `v-once` 指令，让 Vue 跳过该节点的后续更新，提高渲染效率：

```html showLineNumbers
<h1 v-once>欢迎来到我的网站</h1>
```



## 4. 使用 `v-memo` 缓存渲染结果

如果你使用的是 Vue 3.3 或更高版本，可以用 `v-memo` 缓存部分模板的渲染结果。它比 `v-once` 更灵活，可以响应某些依赖变化后再重新渲染：

```html showLineNumbers
<div v-memo="[item.id]">
  {{ item.name }}
</div>
```



## 5. 使用 `keep-alive` 缓存动态组件

对于切换频繁的组件（如 tab 页），使用 `<keep-alive>` 可以缓存其状态，避免重复销毁和创建：

```html showLineNumbers
<keep-alive>
  <component :is="activeTabComponent" />
</keep-alive>
```



## 6. 虚拟滚动（Virtual Scrolling）

当你渲染一个超长列表（如上千条记录）时，建议使用虚拟滚动组件（如 [`vue-virtual-scroller`](https://github.com/Akryum/vue-virtual-scroller)），只渲染可见区域的 DOM 节点，显著提升性能。

安装：

```bash
npm install vue-virtual-scroller
```

使用示例：

```html showLineNumbers
<RecycleScroller :items="items" :item-size="40">
  <template #default="{ item }">
    <div class="item">{{ item.name }}</div>
  </template>
</RecycleScroller>
```



## 7. 事件监听优化（事件节流 / 防抖）

比如监听 `scroll` 或 `resize` 时，要避免函数频繁执行，可以使用节流（throttle）或防抖（debounce）来减少函数调用频率。可以使用 `lodash` 这样的库：

```tsx showLineNumbers
npm install lodash

import { debounce } from 'lodash'

const onScroll = debounce(() => {
  console.log('滚动事件触发')
}, 200)

window.addEventListener('scroll', onScroll)
```



## 8. 图片懒加载与压缩

对于图片资源，可以：

- 使用 [lazy loading](https://developer.mozilla.org/zh-CN/docs/Web/Performance/Lazy_loading)：

  ```html showLineNumbers
  <img src="image.jpg" loading="lazy" />
  ```

- 对图片进行压缩，例如使用 [ImageOptim](https://imageoptim.com/) 或在线工具；

- 在生产环境中使用 CDN 分发图片资源。



## 9. 使用生产构建优化打包体积

确保你在生产环境中构建项目时使用了压缩、tree-shaking、按需引入等方式：

```bash
vite build
```

在 `vite.config.js` 中可以开启 gzip 或 brotli 压缩（配合插件使用）：

```tsx showLineNumbers
import compression from 'vite-plugin-compression'

export default {
  plugins: [compression()]
}
```



## 10. 避免不必要的响应式

Vue 的响应式系统非常强大，但也要注意不要滥用。以下做法可以避免性能浪费：

- 不要对不需要响应的数据使用 `ref` 或 `reactive`；
- 使用 `shallowRef` 或 `shallowReactive` 避免深层嵌套对象造成性能问题；
- 使用 `markRaw` 跳过响应式转换：

```tsx showLineNumbers
import { markRaw } from 'vue'

const chartInstance = markRaw(new Chart(...))
```



## 小结

通过本篇文章，你学习了多种 Vue 项目的性能优化策略，包括懒加载、组件缓存、列表优化、图片压缩、事件监听优化等。这些技巧不仅可以提升用户体验，还能让你开发的 Vue 应用在生产环境中运行更加顺畅和高效。在实际项目中，你可以根据页面复杂度和数据量的不同，灵活选用合适的优化方案。
