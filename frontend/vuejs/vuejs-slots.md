---
sidebar_position: 15
slug: /vuejs-slots
---

# Vue.js 插槽与作用域插槽

在构建 Vue 组件时，有时你会希望组件更具灵活性，让父组件可以传入特定内容。这个时候，“插槽（Slots）”就派上了用场。本节你将学会如何使用普通插槽和作用域插槽，让你的组件更具复用性与可配置性。



## 什么是插槽？

插槽（Slots）是 Vue 提供的一种内容分发机制，允许你在子组件中预留一些位置，由父组件填充内容。就像 HTML 标签的“内容部分”一样，插槽允许父组件自定义传入的结构，而不是被动接受固定的子组件布局。



## 默认插槽

默认插槽是最常见的一种插槽使用方式。你只需在子组件的模板中添加 `<slot />` 标签，父组件就可以向里面填入内容。

子组件：`BaseCard.vue`

```html showLineNumbers title="BaseCard.vue"
<template>
  <div class="card">
    <slot />
  </div>
</template>
```

父组件使用：

```html showLineNumbers title="App.vue"
<BaseCard>
  <h2>标题</h2>
  <p>这是卡片的内容。</p>
</BaseCard>
```

在渲染时，这些内容会替换掉 `<slot />` 所在的位置。



## 具名插槽

当你有多个插槽时，可以使用具名插槽来区分不同的内容区域。

子组件：

```html showLineNumbers title="BaseCard.vue"
<template>
  <header><slot name="header" /></header>
  <main><slot /></main>
  <footer><slot name="footer" /></footer>
</template>
```

父组件使用：

```html showLineNumbers title="App.vue"
<BaseCard>
  <template #header>
    <h1>自定义标题</h1>
  </template>

  <p>正文内容。</p>

  <template #footer>
    <small>页脚信息</small>
  </template>
</BaseCard>
```

:::tip

你也可以使用 `v-slot:header` 替代 `#header`，它们是等价的。

:::



## 作用域插槽

作用域插槽（Scoped Slots）允许子组件向插槽传递数据，让父组件可以动态使用这些数据。你可以把它理解为“从子组件提供数据，由父组件决定如何渲染”。

**示例：展示用户列表**

子组件：`UserList.vue`

```html showLineNumbers title="UserList.vue"
<template>
  <ul>
    <li v-for="user in users" :key="user.id">
      <slot :user="user" />
    </li>
  </ul>
</template>

<script setup>
const users = [
  { id: 1, name: 'Alice' },
  { id: 2, name: 'Bob' }
]
</script>
```

父组件使用：

```html showLineNumbers title="App.vue"
<UserList>
  <template #default="{ user }">
    <strong>{{ user.name }}</strong>
  </template>
</UserList>
```

这样一来，你就可以自由定义每个用户项的渲染方式。

:::tip

你也可以写成 `v-slot="{ user }"`，用的是相同的语法原理。

:::



## 简写语法

你可以用简写方式来绑定具名插槽和作用域插槽：

```html showLineNumbers
<!-- 完整写法 -->
<template v-slot:header>...</template>

<!-- 简写 -->
<template #header>...</template>

<!-- 默认作用域插槽的简写 -->
<UserList v-slot="{ user }">...</UserList>
```



## 插槽的默认内容

你也可以给插槽设置默认内容，以防父组件没有传入内容：

```html showLineNumbers
<slot>默认内容</slot>
```

这在构建可复用组件时特别有用。



## 使用注意事项

- 插槽只能用于子组件模板中；
- 一个组件可以包含多个具名插槽；
- 作用域插槽默认绑定在 `<slot>` 元素上，不影响组件的响应式；
- 插槽不是跨组件通信的方式，仅用于结构内容的插入与渲染控制。



## 小结

插槽让你可以在子组件中预留结构位置，由父组件自由插入内容；作用域插槽则进一步提升灵活性，让子组件提供数据，父组件决定内容如何呈现。掌握插槽机制后，你就能构建出更具扩展性和复用性的 Vue 组件结构。建议你在实际项目中多尝试应用插槽，会有不少收获！
