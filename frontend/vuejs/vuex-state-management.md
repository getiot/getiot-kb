---
sidebar_position: 18
slug: /vuex-state-management
authors: [luhuadong]
---

# Vuex 状态管理

在构建中大型 Vue 应用时，你会发现组件之间的数据传递变得越来越复杂。为了解决这个问题，Vue 提供了专门的状态管理库 —— Vuex。本篇文章将带你了解 Vuex 的核心概念、如何使用它来集中管理状态，以及实际开发中的应用方式。

:::tip

简单来说，Vuex 是一个“可控的全局状态管理模块”。如果你熟悉嵌入式开发，那么从 C/C++ 的角度来理解，Vuex 其实是**非常接近全局变量（global variable）+ 状态机管理模式**的组合。

:::



## 为什么需要 Vuex？

在 Vue 中，组件之间通过 props 和事件进行通信已经足够应对大多数情况。但当多个组件需要共享状态时，逐级传递会变得很麻烦。

Vuex 提供了一个集中式的状态管理模式，你可以把所有组件共享的状态抽取出来，统一存放和管理。

简而言之，Vuex 能帮助你：

- 管理多个组件共享的状态
- 实现可预测的数据流
- 提高项目的可维护性



## 安装 Vuex

Vuex 4 是专为 Vue 3 设计的版本。如果你还没安装，可以通过以下命令添加：

```bash
npm install vuex@4
```

然后在项目中创建一个 Vuex store，位于 store/index.js 文件：

```tsx showLineNumbers title="store/index.js"
// store/index.js
import { createStore } from 'vuex'

// 创建一个新的 Vuex store 实例
const store = createStore({
  // state 用来存储“共享数据”，所有组件都可以访问这里的数据
  state() {
    return {
      count: 0  // 这是我们要共享的状态：一个计数器
    }
  },

  // mutations 是“更改 state 的唯一推荐方式”，只能是同步操作
  mutations: {
    // 这是一个 mutation，它接收 state 作为第一个参数
    // 调用时会让 count 的值加 1
    increment(state) {
      state.count++
    }
  },

  // actions 用来处理异步操作，比如定时器或请求接口
  // 它们不能直接修改 state，而是通过 commit 调用 mutation
  actions: {
    asyncIncrement({ commit }) {
      // 延迟 1 秒后提交 increment mutation
      setTimeout(() => {
        commit('increment')
      }, 1000)
    }
  },

  // getters 类似于计算属性，用于根据 state 派生出一些状态
  getters: {
    // 返回 count 的两倍
    doubleCount(state) {
      return state.count * 2
    }
  }
})

// 把创建好的 store 导出，在 main.js 中挂载到应用上
export default store
```



## 在应用中挂载 Vuex

你需要在 Vue 应用中将 store 注册，例如：

```tsx showLineNumbers {3,7} title="main.js"
import { createApp } from 'vue'
import App from './App.vue'
import store from './store' // 引入我们刚才创建的 store

const app = createApp(App)

app.use(store)  // 将 store 安装到 app 实例中，所有组件都能使用
app.mount('#app')  // 挂载应用
```



## 在组件中使用状态

你可以通过 `useStore()` 组合式函数在组件中访问 Vuex store。

```html showLineNumbers
<script setup>
import { computed } from 'vue'
import { useStore } from 'vuex'

// 获取 store 实例
const store = useStore()

// 使用 computed 创建响应式的 count 值
const count = computed(() => store.state.count)

// 定义一个方法，通过 mutation 增加 count
const increment = () => {
  store.commit('increment')  // 提交 mutation
}
</script>

<template>
  <div>
    <p>计数器：{{ count }}</p>
    <button @click="increment">增加</button>
  </div>
</template>
```

**解释说明：**

- `useStore()`：这是组合式 API 中获取 Vuex 实例的方法（类似于选项式中的 `this.$store`）。
- `store.state.count`：访问全局共享状态。
- `store.commit('mutationName')`：提交一个 mutation 来修改状态。



## 异步更新状态（使用 actions）

如果你需要异步更新状态，比如发起网络请求，可以使用 `actions` 来处理这些异步逻辑。

```tsx showLineNumbers
actions: {
  asyncIncrement({ commit }) {
    setTimeout(() => {
      commit('increment')  // 在 1 秒后提交 mutation
    }, 1000)
  }
}
```

在组件中调用：

```tsx showLineNumbers
const asyncIncrement = () => {
  store.dispatch('asyncIncrement')  // 通过 dispatch 触发 action
}
```

**解释说明：**

- `actions` 不可以直接修改 state，它们负责“处理逻辑”，再通过 `commit` 触发 mutation。
- `dispatch` 是调用 action 的方式（类似 `commit` 但用于异步）。



## 使用 Getters 派生状态

有些状态是从现有状态中派生出来的，比如翻倍后的计数值。这时你可以使用 `getters`：

```tsx showLineNumbers
getters: {
  doubleCount(state) {
    return state.count * 2
  }
}
```

访问方式：

```tsx showLineNumbers
const doubleCount = computed(() => store.getters.doubleCount)
```

**解释说明：**

- `getters` 是计算得出的状态，适合放置“基于 state 派生的数据”。
- 和 `computed` 一样，它们是响应式的。



## 模块化你的 Store

随着状态越来越多，你可以将 store 拆成模块。

例如，有一个 counter 模块，位于 store/modules/counter.js：

```tsx showLineNumbers title="store/modules/counter.js"
export default {
  namespaced: true, // 使用命名空间，防止命名冲突
  state() {
    return {
      count: 0
    }
  },
  mutations: {
    increment(state) {
      state.count++
    }
  }
}
```

注册模块：

```tsx showLineNumbers title="store/index.js"
import counter from './modules/counter'

const store = createStore({
  modules: {
    counter
  }
})
```

在组件中访问模块状态：

```tsx showLineNumbers
// 使用模块状态
const count = computed(() => store.state.counter.count)
store.commit('counter/increment')  // 注意：使用命名空间调用
```

**解释说明：**

- 当你的 store 越来越大时，可以将其拆成多个模块，每个模块管理自己的一部分 state。
- 加上 `namespaced: true` 后，调用 mutation 或 action 时需要带上模块名。



## 总结关键点

|    概念     | 作用说明                                   |
| :---------: | :----------------------------------------- |
|   `state`   | 用于存储应用的全局状态                     |
| `mutations` | 同步地修改 state                           |
|  `actions`  | 异步处理逻辑，最后调用 mutation 修改 state |
|  `getters`  | 类似组件的计算属性，用于派生出新的状态     |
|  `modules`  | 拆分 store，模块化管理大型项目状态         |

虽然 Vuex 的 state 是“全局共享”的，但它做了严格限制，必须通过 `mutation` 或 `action` 来更改数据，这就像你嵌入式项目中的**状态机控制逻辑**：

- 避免并发修改（race condition）；
- 所有状态变更可追踪（就像带有 trace log 的状态机）；
- 状态变更的入口唯一、可测试。



## Vuex 和组合式函数一起用？

Vuex 和 Composition API 是可以很好配合的。但如果你喜欢使用更现代、轻量的状态管理方案，可以考虑 Pinia，它是 Vue 官方推荐的新一代状态管理库，API 更加简洁优雅，完全兼容 Vue 3。



## 小结

Vuex 是 Vue 官方提供的状态管理工具，适合中大型项目中统一管理共享状态。它基于集中式存储和严格的状态流转，帮助你构建可维护、结构清晰的应用。你学会了如何创建 store，使用 state、mutations、actions、getters，以及如何模块化管理状态。未来如果项目需要更轻量的方案，也可以考虑迁移到 [Pinia](/vue/vuejs-pinia/)。
