---
sidebar_position: 12
slug: /vuejs-component-communication
---

# Vue.js 组件通信：Props

在构建 Vue 应用时，你通常会把界面拆分成多个组件。组件之间的通信是非常重要的内容，尤其是**父组件向子组件传递数据**的场景。本章将带你了解如何通过 **props** 实现组件之间的数据传递，掌握这一机制后，你就可以构建更加灵活和模块化的应用结构了。



## 什么是 Props？

在 Vue 中，**props（属性）** 是父组件用来向子组件传递数据的机制。你可以把它们理解为子组件的“参数”。

当你在模板中使用子组件时，通过设置属性就可以传递数据：

```html showLineNumbers title="父组件 App.vue"
<!-- App.vue -->
<template>
  <WelcomeMessage name="Vue 开发者" />
</template>

<script setup>
import WelcomeMessage from './components/WelcomeMessage.vue'
</script>
```

子组件中需要显式声明要接收哪些 props：

```html showLineNumbers title="子组件 WelcomeMessage.vue"
<!-- WelcomeMessage.vue -->
<template>
  <h1>你好，{{ name }}！</h1>
</template>

<script setup>
defineProps({
  name: String
})
</script>
```



## 使用 `defineProps` 声明 Props

在 `<script setup>` 中，你可以使用 `defineProps` 宏来声明你希望接收的 props 类型。例如：

```tsx showLineNumbers
const props = defineProps({
  title: String,
  count: Number,
  isActive: Boolean
})
```

这样你就可以直接在模板或逻辑中使用 `props.title`、`props.count` 等属性。

:::tip

如果你不写类型，Vue 也会正常运行，但添加类型可以让你的代码更可读、也更容易排查错误。

:::



## Props 的类型与默认值

除了简单的类型声明，你还可以为 props 设置默认值：

```tsx showLineNumbers
const props = defineProps({
  name: {
    type: String,
    default: '访客'
  },
  age: {
    type: Number,
    default: 18
  }
})
```

这表示如果父组件没有传入 `name` 或 `age`，子组件就会使用默认值 `'访客'` 和 `18`。



## 动态传值

你也可以将变量传给子组件的 props，而不仅限于静态字符串：

```html showLineNumbers title="App.vue"
<!-- App.vue -->
<template>
  <WelcomeMessage :name="userName" />
</template>

<script setup>
import WelcomeMessage from './components/WelcomeMessage.vue'

const userName = '小明'
</script>
```

注意这里用到了 `:`，表示绑定的是一个 JavaScript 表达式。



## 单向数据流

Vue 的 props 是**单向绑定**的，也就是说：

- **父组件 → 子组件**：数据可以正常传递；
- **子组件不能修改 props 的值**，否则 Vue 会在开发环境下发出警告。

如果你确实需要在子组件中修改某个值，应该先将这个值复制到本地的 `ref` 或 `reactive` 变量中。例如：

```html showLineNumbers
<script setup>
const props = defineProps({
  title: String
})

import { ref } from 'vue'
const localTitle = ref(props.title)
</script>
```



## 使用 `v-bind` 批量传递 Props

当你有多个数据需要作为 props 传递给子组件时，可以使用 `v-bind` 将整个对象“批量”绑定到子组件上，一次性传递多个 props。这样代码更简洁，逻辑也更清晰。

例如：假设你有一个用户信息对象 `user`，包含了 `name`、`age` 和 `email` 三个字段。

```html showLineNumbers title="App.vue"
<!-- App.vue -->
<template>
  <UserCard v-bind="user" />
</template>

<script setup>
import UserCard from './components/UserCard.vue'

const user = {
  name: '小明',
  age: 25,
  email: 'xiaoming@example.com'
}
</script>
```

在子组件中声明对应的 props：

```html showLineNumbers title="UserCard.vue"
<!-- UserCard.vue -->
<template>
  <div class="card">
    <h2>{{ name }}</h2>
    <p>年龄：{{ age }}</p>
    <p>邮箱：{{ email }}</p>
  </div>
</template>

<script setup>
defineProps({
  name: String,
  age: Number,
  email: String
})
</script>
```

通过 `v-bind="user"`，你一次性把 `user` 对象中的所有字段传给了子组件 `UserCard`，这比逐个传递更方便：

```html showLineNumbers
<!-- 不推荐写法：逐个传递 -->
<UserCard :name="user.name" :age="user.age" :email="user.email" />
```



## 验证 Props 类型

除了 `String`、`Number` 等基本类型，你也可以使用复杂类型如 `Array`、`Object`：

```tsx showLineNumbers
const props = defineProps({
  tags: Array,
  settings: Object
})
```

或者使用构造函数形式增强验证：

```tsx showLineNumbers
const props = defineProps({
  score: {
    type: Number,
    required: true
  }
})
```



## 只读的 Props

在 Vue 3 中，props 默认就是只读的。你不能在子组件中直接对 props 进行赋值操作。如果你尝试这么做，Vue 会抛出警告并建议你复制它们。



## 小结

通过本节的学习，你应该已经掌握了 Vue 中使用 props 从父组件向子组件传递数据的方法。记住，props 是单向数据流的基础，它有助于构建清晰、可维护的组件关系。在后续章节中，你将进一步学习子组件如何向父组件发送事件，实现更加完整的组件通信机制。
