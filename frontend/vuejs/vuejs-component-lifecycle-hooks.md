---
sidebar_position: 17
slug: /vuejs-component-lifecycle-hooks
---

# Vue.js 组件生命周期钩子

在这篇教程中，你将学习 Vue 组件的生命周期钩子函数，包括它们在组件创建、挂载、更新和卸载过程中的作用。掌握这些钩子函数能帮助你在合适的时机执行逻辑，比如发起请求、添加定时器、清理资源等。



## 什么是生命周期钩子？

Vue 组件从创建到销毁会经历一系列的阶段，这些阶段被称为**生命周期**（Lifecycle）。Vue 为你提供了对应的钩子函数（Hook Functions），让你可以在特定的时机插入逻辑代码。

在 Vue 3 中，推荐使用 Composition API 提供的生命周期钩子函数，例如 `onMounted()`、`onUpdated()`、`onUnmounted()` 等。



## 生命周期总览

下表列出 Vue 定义的生命周期阶段，以及 Composition API 提供的生命周期钩子函数。

| 生命周期阶段 |    对应钩子函数     | 说明                                 |
| :----------: | :-----------------: | ------------------------------------ |
|    创建前    |      `setup()`      | 组件初始化时执行，生命周期的起点     |
|    挂载前    |  `onBeforeMount()`  | DOM 尚未挂载到页面                   |
|   挂载完成   |    `onMounted()`    | DOM 已挂载，适合操作 DOM、发起请求   |
|    更新前    | `onBeforeUpdate()`  | 响应式数据变化，DOM 即将更新         |
|   更新完成   |    `onUpdated()`    | DOM 更新完成，可用于处理更新后的结果 |
|    卸载前    | `onBeforeUnmount()` | 组件即将卸载，适合做清理工作         |
|   卸载完成   |   `onUnmounted()`   | 组件已被销毁，一般用于资源释放确认   |
|   错误捕获   | `onErrorCaptured()` | 捕获子组件中的错误                   |



## 示例：常用生命周期钩子

```html showLineNumbers
<script setup>
import { ref, onMounted, onUpdated, onUnmounted } from 'vue'

const count = ref(0)

onMounted(() => {
  console.log('组件已挂载')
  // 比如可以在这里发起异步请求
})

onUpdated(() => {
  console.log('组件已更新')
})

onUnmounted(() => {
  console.log('组件已卸载')
})
</script>

<template>
  <div>
    <p>当前计数：{{ count }}</p>
    <button @click="count++">增加</button>
  </div>
</template>
```

你可以在控制台看到这些钩子在组件的不同阶段被触发。



## 使用 `onBeforeMount` 和 `onBeforeUpdate`

这两个钩子在实际开发中不如 `onMounted` 常用，但也很有用。它们适用于一些精细控制 DOM 前的逻辑。

```tsx showLineNumbers
onBeforeMount(() => {
  console.log('组件即将挂载')
})

onBeforeUpdate(() => {
  console.log('组件即将更新')
})
```



## 释放资源：`onUnmounted`

有些逻辑需要在组件销毁前清理，比如定时器、事件监听器、WebSocket 等。这时候可以在 `onUnmounted` 中释放资源，例如：

```tsx showLineNumbers
let timer = null

onMounted(() => {
  timer = setInterval(() => {
    console.log('定时任务运行中')
  }, 1000)
})

onUnmounted(() => {
  clearInterval(timer)
  console.log('定时器已清除')
})
```



## 捕获错误：`onErrorCaptured`

如果子组件抛出了未捕获的错误，你可以通过这个钩子来统一处理。

```tsx showLineNumbers
onErrorCaptured((err, instance, info) => {
  console.error('捕获到错误：', err)
  return false // 如果返回 true，错误会继续传播；返回 false 则阻止传播
})
```



## 生命周期钩子调用时机图示

```bash
setup()                  # 生命周期的起点
  ├── onBeforeMount()    # DOM 挂载前
  ├── onMounted()        # DOM 挂载完成
  ├── onBeforeUpdate()   # 响应式数据变更（DOM 即将更新）
  ├── onUpdated()        # 响应式数据变更（DOM 更新完成）
  ├── onBeforeUnmount()  # 组件卸载前
  └── onUnmounted()      # 组件卸载完成
```

:::tip

你也可以在 `<script setup>` 中使用 `watch()`、`watchEffect()` 等组合式函数配合生命周期钩子实现更强逻辑。

:::



## Options API 的写法

如果你使用 Options API，可以使用传统方式：

```tsx showLineNumbers
export default {
  mounted() {
    console.log('组件挂载完成')
  },
  updated() {
    console.log('组件更新完成')
  },
  unmounted() {
    console.log('组件已卸载')
  }
}
```

虽然 Vue 3 更推荐 Composition API，但理解 Options API 的写法也有助于你阅读旧代码或迁移项目。



## 小结

组件生命周期钩子是你开发 Vue 应用时必备的重要知识。它们让你可以在组件初始化、更新和销毁的不同阶段执行特定逻辑。推荐你优先使用 Composition API 中的 `onMounted`、`onUpdated`、`onUnmounted` 等钩子，以实现结构清晰、易于维护的代码结构。灵活运用这些钩子函数，可以让你的组件行为更加可控，也更容易调试和测试。
