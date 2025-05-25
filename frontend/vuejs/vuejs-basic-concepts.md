---
sidebar_position: 4
slug: /vuejs-basic-concepts
authors: [luhuadong]
---

# Vue.js 基本概念

在上一节中你已经成功创建了第一个 Vue 应用。这一节我们将深入了解 Vue.js 的几个核心概念，包括响应式、模板语法、指令、组件和生命周期。这些是你学习和使用 Vue 的基础，只要掌握了这些内容，就能轻松构建结构清晰、逻辑分明的前端应用。



## 响应式系统

Vue 最强大的特性之一就是响应式系统（Reactivity）。当你修改数据时，页面会自动更新，无需手动操作 DOM。

例如：

```tsx showLineNumbers
import { ref } from 'vue'

const count = ref(0)
function increment() {
  count.value++
}
```

这里的 `ref(0)` 创建了一个响应式数据 `count`，当你修改 `count.value` 时，所有绑定到它的模板都会自动更新。



## 模板语法

Vue 使用类 HTML 的模板语法（Template Syntax）来声明式地将数据绑定到 DOM。

```tsx showLineNumbers
<template>
  <p>你好，{{ name }}！</p>
</template>

<script setup>
const name = 'Vue 学习者'
</script>
```

花括号 `{{ }}` 中的变量会被 Vue 渲染为响应式数据的值。



## 指令

Vue 模板中除了插值表达式，还有很多内置指令（Directives），例如：

- `v-bind`：绑定 HTML 属性
- `v-model`：双向绑定表单输入
- `v-if` / `v-else` / `v-else-if`：条件渲染
- `v-for`：列表渲染
- `v-on`：绑定事件监听器

示例：

```tsx showLineNumbers
<input v-model="message" />
<p>{{ message }}</p>

<button v-on:click="increment">增加</button>
```



## 组件系统

Vue 应用是由一个个组件（Component）组成的。组件可以是页面的一部分、一个按钮、一个列表，甚至是整个页面本身。

例如，下面是一个自定义的按钮组件 MyButton：

```tsx showLineNumbers title="MyButton.vue"
<template>
  <button @click="handleClick">点击我</button>
</template>

<script setup>
function handleClick() {
  alert('你好 Vue！')
}
</script>
```

在父组件中使用该组件，只需导入并在模板中写入 `<MyButton />` 即可。



## 生命周期

Vue 组件在创建、更新和销毁的过程中，会经历一系列生命周期钩子函数（Lifecycle Hooks），你可以在这些阶段执行相应的操作。

常用的生命周期钩子有 `onMounted`、`onUpdated`、`onUnmounted`，用法如下：

```tsx showLineNumbers
import { onMounted, onUpdated, onUnmounted } from 'vue'

onMounted(() => {
  console.log('组件已挂载')
})

onUpdated(() => {
  console.log('组件更新了')
})

onUnmounted(() => {
  console.log('组件被卸载了')
})
```

Vue 中的这些生命周期函数让你可以灵活地处理资源加载、定时器设置、网络请求等逻辑。



## 小结

通过这一节，你已经初步掌握了 Vue 的几个核心概念，包括响应式、模板语法、常用指令、组件系统和生命周期。这些都是 Vue 应用开发的基础。接下来，我们将深入学习模板语法，让你在写页面时更加得心应手。
