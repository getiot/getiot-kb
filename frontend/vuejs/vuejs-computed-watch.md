---
sidebar_position: 7
slug: /vuejs-computed-watch
---

# Vue.js 计算属性与侦听器

在这篇文章中，你将学习 Vue 中的两个重要概念：计算属性（computed）和侦听器（watch）。它们都可以用来根据数据的变化执行某些逻辑，但适用场景有所不同。掌握它们能让你的组件更加高效、灵活，也能让模板代码更加简洁。



## 什么是计算属性？

当你需要基于已有数据计算出一个新值，并希望这个计算具有**缓存特性**时，计算属性（Computed）就是你的首选。相比在模板中直接写表达式，使用 computed 可以提高性能、提升可读性。

### 基本用法

```tsx showLineNumbers
<script setup>
import { ref, computed } from 'vue'

const firstName = ref('小明')
const lastName = ref('张')

const fullName = computed(() => {
  return `${lastName.value}${firstName.value}`
})
</script>

<template>
  <p>全名：{{ fullName }}</p>
</template>
```

在这个例子中，`fullName` 是一个计算属性。它依赖于 `firstName` 和 `lastName`，只要这两个值没变，`fullName` 的值就会被缓存，避免不必要的重复计算。

:::tip

`ref` 是 Vue 提供的一个响应式引用（reactive reference）函数，它能让一个普通的值变成响应式的。当你用 `ref` 包裹一个值后，Vue 就可以自动追踪这个值的变化，并在界面中进行更新。

例如前面创建了响应式变量 `firstName` 和 `lastName`，并设置了初始值。它们都是“ref 对象”，真实值存储在 `.value` 属性中。

:::



### 计算属性的 Getter 与 Setter

你还可以给计算属性定义 getter 和 setter，让它既能“读取”，也能“写入”。

```tsx showLineNumbers
<script setup>
import { ref, computed } from 'vue'

const firstName = ref('小明')
const lastName = ref('张')

const fullName = computed({
  get() {
    return `${lastName.value}${firstName.value}`
  },
  set(newValue) {
    const names = newValue.split(' ')
    lastName.value = names[0]
    firstName.value = names[1] || ''
  }
})
</script>

<template>
  <input v-model="fullName" />
  <p>姓：{{ lastName }}</p>
  <p>名：{{ firstName }}</p>
</template>
```

上面的代码展示了如何通过计算属性的 setter 来“反向”更新原始数据。



## 什么是侦听器？

侦听器（Watcher）适用于当你**需要在数据变化时执行异步操作或副作用**时，比如发起网络请求、访问本地存储等。Vue 提供了 `watch` 函数，让你可以响应式地监听一个或多个数据源的变化。

### 基本用法

```tsx showLineNumbers
<script setup>
import { ref, watch } from 'vue'

const keyword = ref('')

watch(keyword, (newVal, oldVal) => {
  console.log(`关键词从 "${oldVal}" 变为 "${newVal}"`)
})
</script>

<template>
  <input v-model="keyword" placeholder="输入搜索关键词" />
</template>
```

当 `keyword` 的值发生变化时，`watch` 会触发，并执行回调函数。



### 监听多个数据源

你可以监听多个数据源，只需传入一个数组：

```tsx showLineNumbers
<script setup>
import { ref, watch } from 'vue'

const a = ref(1)
const b = ref(2)

watch([a, b], ([newA, newB], [oldA, oldB]) => {
  console.log(`a: ${oldA} -> ${newA}, b: ${oldB} -> ${newB}`)
})
</script>
```

这在你需要组合监听多个响应式变量时非常有用。



### 立即执行与深度监听

`watch` 支持一些选项配置：

- `immediate: true`：立即执行一次回调
- `deep: true`：深度监听对象内部的属性变化

```tsx showLineNumbers
watch(obj, (newVal) => {
  console.log('obj changed:', newVal)
}, { deep: true, immediate: true })
```

⚠️ 注意：如果你监听的是响应式对象（如 ref 的对象或 reactive），默认不会追踪对象内部的变化，除非开启 `deep: true`。



## computed 和 watch 的选择建议

- 如果你只需要基于现有数据**生成新的值用于显示**，建议使用 `computed`。
- 如果你需要在数据变化时执行**异步请求、定时器、日志打印**等操作，则使用 `watch` 更合适。



## 小结

在这一章中，你学习了 Vue 中的计算属性（computed）和侦听器（watch）。前者用于根据已有数据计算新值，并具备缓存功能；后者适合在数据变化时执行副作用操作。两者功能类似但适用场景不同，合理选择可以让你的代码更加清晰高效。接下来，你将继续学习 Vue 的条件与列表渲染，解锁更多模板编程技巧。
