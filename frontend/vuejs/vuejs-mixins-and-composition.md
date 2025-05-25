---
sidebar_position: 21
slug: /vuejs-mixins-and-composition
authors: [luhuadong]
---

# Vue Mixins 与组件组合

当你的多个组件中存在重复逻辑时，你可能会想：“有没有办法复用这些代码？”本篇文章将带你了解 Vue 中的 **Mixins（混入）** 和 **组合式 API（Composition API）**，它们是实现代码复用的两种主要方式。你将学会如何使用 Mixins 封装可复用逻辑，也会了解到组合式 API 如何在现代 Vue 中提供更清晰、更灵活的组合逻辑方式。



## 什么是 Mixins？

Mixins 是一种 Vue 2 中常用的代码复用方式。它允许你将一个组件的部分逻辑提取到一个可复用的对象中，然后让其他组件“混入”这些逻辑。

**基本使用方式**

```tsx showLineNumbers title="mixins/loggerMixin.js"
export const loggerMixin = {
  created() {
    console.log(`组件 ${this.$options.name} 已创建`)
  },
  methods: {
    log(message) {
      console.log(`[${this.$options.name}]: ${message}`)
    }
  }
}
```

在组件中使用：

```html showLineNumbers
<script>
import { loggerMixin } from '@/mixins/loggerMixin.js'

export default {
  name: 'MyComponent',
  mixins: [loggerMixin],
  mounted() {
    this.log('组件已挂载')
  }
}
</script>
```

只要你使用了这个 mixin，它的 `created` 生命周期钩子和 `log` 方法就会被自动“混入”到你的组件中。



## Mixins 的优缺点

✅ **优点：**

- 简单直接，容易上手；
- 多个组件可以共享一套逻辑。

❌ **缺点：**

- **命名冲突**：多个 mixin 中的同名方法或数据可能冲突；
- **不清晰来源**：你在组件中调用的方法可能不是组件自己定义的，容易让人迷惑；
- **类型推导不友好**（尤其在 TypeScript 中）；

因此，Vue 3 推荐使用组合式 API 来替代 Mixins。



## 使用组合式 API 实现逻辑复用（推荐）

Vue 3 引入了 Composition API，它提供了一种更灵活、清晰的代码组织方式。你可以将可复用的逻辑封装为一个函数，然后在组件中“组合”使用。

**示例：封装一个 useLogger**

```tsx showLineNumbers title="composables/useLogger.js"
import { getCurrentInstance } from 'vue'

export function useLogger() {
  const instance = getCurrentInstance()

  function log(message) {
    console.log(`[${instance?.type.name}]: ${message}`)
  }

  return {
    log
  }
}
```

**在组件中使用：**

```html showLineNumbers
<script setup>
import { useLogger } from '@/composables/useLogger'

const { log } = useLogger()

log('组件正在加载...')
</script>

<template>
  <p>查看控制台日志</p>
</template>
```

相比 Mixins，组合式 API 有以下优势：

- 明确的依赖关系；
- 逻辑更易组合和拆分；
- 更好的类型推导；
- 避免命名冲突。



## Mixins 和组合式 API 对比

那什么时候用 Mixins，什么时候用组合式 API 呢？

| 场景                   | 建议方式                                     |
| ---------------------- | -------------------------------------------- |
| 你使用的是 Vue 2 项目  | 继续使用 Mixins，或迁移到组合式 API          |
| 你正在使用 Vue 3       | 推荐使用组合式 API                           |
| 项目中存在大量逻辑复用 | 使用组合式 API 可以更清晰地管理逻辑模块      |
| 组件功能非常简单       | Mixins 或组合式 API 都可以，根据团队习惯选择 |



## 如果你还在使用 Vue 2 怎么办？

Vue 2.7 开始支持 Composition API，如果你不能升级到 Vue 3，但仍想使用组合式 API，可以通过安装官方插件：

```bash
npm install @vue/composition-api
```

然后在入口文件注册：

```tsx showLineNumbers
import Vue from 'vue'
import VueCompositionAPI from '@vue/composition-api'

Vue.use(VueCompositionAPI)
```

这样你就能在 Vue 2 中体验 Composition API 的强大能力了。



## 小结

Mixins 是 Vue 早期用于逻辑复用的传统方式，但在 Vue 3 中已逐渐被 Composition API 取代。Mixins 简单易用，但存在命名冲突、来源不明等缺陷。相比之下，组合式 API 更现代化、模块化、类型安全，是构建大型 Vue 应用的更好选择。如果你正在使用 Vue 3，强烈建议你优先采用组合式 API 来组织和复用组件逻辑。掌握这些技巧，你将能构建出更加清晰、可维护的 Vue 应用结构。
