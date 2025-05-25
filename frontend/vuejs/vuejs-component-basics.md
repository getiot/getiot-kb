---
sidebar_position: 11
slug: /vuejs-component-basics
authors: [luhuadong]
---

# Vue.js 组件基础

在本节中，你将学习 Vue.js 中最核心的概念之一：**组件**。组件让你可以将页面拆分为多个可复用的功能单元。通过掌握组件的定义、使用、嵌套和命名，你将能更加高效地构建结构清晰、可维护性强的 Vue 应用。



## 什么是组件？

在 Vue 中，**组件（Component）** 就是一个封装了 HTML 模板、JavaScript 逻辑和 CSS 样式的独立功能单元。你可以把组件看作是一个个乐高积木，组合起来就可以搭建出完整的界面。

例如，一个按钮、一个表单、一个导航栏，甚至整个页面都可以是组件。



## 创建你的第一个组件

在 Vue 3 中，推荐使用 `<script setup>` 语法来编写组件。下面是一个最简单的组件例子：

```html showLineNumbers
<!-- HelloWorld.vue -->
<template>
  <h1>Hello, {{ name }}!</h1>
</template>

<script setup>
import { ref } from 'vue'

const name = ref('Vue')
</script>
```

你可以通过 `ref` 定义响应式变量，在模板中使用这些变量来动态渲染内容。



## 在父组件中使用子组件

为了让组件在其他地方可用，你需要在父组件中引入并注册这个组件。使用 `<script setup>` 时，你只需要直接 `import` 即可，Vue 会自动帮你完成注册。

```html showLineNumbers
<!-- App.vue -->
<template>
  <HelloWorld />
</template>

<script setup>
import HelloWorld from './components/HelloWorld.vue'
</script>
```

:::tip

组件名建议使用 PascalCase（驼峰式大小写），例如 `HelloWorld`，这样在模板中可以用 `<HelloWorld />` 的方式使用。也可以用 kebab-case（小写短横线），例如 `<hello-world />`。

:::



## 组件是可组合的

组件之间可以进行嵌套。你可以在一个组件中引入另一个组件，实现复杂界面的组合。例如：

```html showLineNumbers
<!-- Layout.vue -->
<template>
  <HeaderBar />
  <MainContent />
  <FooterBar />
</template>

<script setup>
import HeaderBar from './HeaderBar.vue'
import MainContent from './MainContent.vue'
import FooterBar from './FooterBar.vue'
</script>
```

这种“组合式开发”方式能让你的项目结构更清晰，维护起来也更方便。



## 组件的命名规则

为了保持一致性和可读性，建议你遵循以下命名规范：

- 文件名使用 PascalCase，例如 `MyButton.vue`
- 模板中可以使用 PascalCase 或 kebab-case 引用组件
- 避免和 HTML 标签冲突（比如不要创建 `<input>` 同名组件）



## 组件的作用域

Vue 的组件是**封闭作用域**的，也就是说，每个组件都有自己的作用域。这意味着：

- 每个组件中的 `ref`、`reactive`、函数和样式默认只在本组件中生效
- 不会影响其他组件，避免了变量名冲突

你可以使用 `scoped` 样式确保组件样式不会污染到外部：

```html showLineNumbers
<style scoped>
h1 {
  color: blue;
}
</style>
```



## 组件的复用性

一旦你定义好一个组件，它就可以在项目中任何地方被复用。这正是组件的强大之处——**一次定义，多处使用**。

例如你可以在多个页面中反复使用同一个按钮组件 MyButton：

```html showLineNumbers
<!-- MyButton.vue -->
<template>
  <button class="my-btn"><slot /></button>
</template>

<style scoped>
.my-btn {
  background-color: #42b983;
  color: white;
  border: none;
  padding: 8px 16px;
}
</style>
```



## 小结

本节介绍了 Vue 组件的基础概念，包括组件的定义、使用方式、命名规则以及如何在父组件中嵌套子组件。通过组件化开发，你可以将应用拆分为更易维护和复用的模块，是构建大型 Vue 项目的基石。在接下来的内容中，你还将学到组件通信、props 和事件的使用方式。
