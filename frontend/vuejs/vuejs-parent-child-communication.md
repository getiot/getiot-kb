---
sidebar_position: 13
sidebar_label: Vue.js 父子组件通信
slug: /vuejs-parent-child-communication
authors: [luhuadong]
---

# Vue.js 父子组件通信（发送事件）

在上一节中，你学习了如何通过 Props 让父组件向子组件传递数据。本节我们来介绍反向的数据流 —— **子组件如何向父组件发送事件**。

通过事件机制，你可以让子组件在发生某些操作（比如按钮点击、表单提交等）时通知父组件，让父组件作出相应的反应。这种机制是 Vue 中常见的一种**组件通信方式**。



## 基本用法：`emit` 方法

在 Vue 3 中，你可以使用 `defineEmits()` 函数定义子组件可以触发的事件，然后通过 `emit()` 方法发送事件。

**示例：点击按钮让父组件响应**

子组件：`MyButton.vue`

```html showLineNumbers title="MyButton.vue"
<template>
  <button @click="handleClick">点我</button>
</template>

<script setup>
const emit = defineEmits(['customClick'])

function handleClick() {
  emit('customClick') // 向父组件发送事件
}
</script>
```

父组件：`App.vue`

```html showLineNumbers title="App.vue"
<template>
  <MyButton @customClick="onChildClick" />
</template>

<script setup>
import MyButton from './components/MyButton.vue'

function onChildClick() {
  console.log('子组件触发了 customClick 事件')
}
</script>
```

你会发现，子组件通过 `emit('customClick')` 发出事件，父组件通过 `@customClick` 监听这个事件。



## 事件传参

你还可以通过 `emit` 给事件传递参数，让父组件能拿到更多上下文信息。

子组件传参：

```html showLineNumbers title="FormComponent.vue"
<template>
  <button @click="submit">提交</button>
</template>

<script setup>
const emit = defineEmits(['submitForm'])

function submit() {
  emit('submitForm', {
    name: '小明',
    age: 25
  })
}
</script>
```

父组件接收参数：

```html showLineNumbers title="App.vue"
<template>
  <FormComponent @submitForm="handleSubmit" />
</template>

<script setup>
import FormComponent from './components/FormComponent.vue'

function handleSubmit(payload) {
  console.log('接收到的表单数据：', payload)
}
</script>
```



## 定义事件类型

为了提高代码的类型安全，你可以给 `defineEmits` 添加类型声明：

```tsx showLineNumbers
const emit = defineEmits<{
  (e: 'submitForm', payload: { name: string; age: number }): void
  (e: 'cancel'): void
}>()
```

这样在你调用 `emit('submitForm', ...)` 的时候，IDE 会有类型提示，也能帮助你避免拼写错误或参数错误。



## 与原生 DOM 事件的区别

子组件发出的事件和 DOM 事件类似，但它们并不会冒泡到 DOM 层面。你只能在父组件模板中通过 `@事件名` 监听这些自定义事件。

如果你真的需要监听原生 DOM 事件（比如子组件的根元素是一个按钮），可以使用 `v-on="$attrs"` 或 `$attrs` 手动绑定。



## 使用 `$event` 接收值（语法糖）

当你监听子组件事件并传参时，`$event` 是默认传递的事件值：

```html showLineNumbers
<!-- 父组件模板 -->
<MyButton @customClick="handleClick($event)" />
```

这等价于：

```html showLineNumbers
<MyButton @customClick="payload => handleClick(payload)" />
```



## 子组件事件命名风格

虽然你可以随便起事件名，但官方建议使用 kebab-case 小写加中划线的风格，例如：

```tsx showLineNumbers
const emit = defineEmits(['update-count', 'submit-form'])
```

这样更符合 HTML 事件属性的命名习惯。



## 多级组件通信怎么办？

如果事件需要从更深层的组件向上“冒泡”，你需要手动在中间组件中继续转发事件。例如：

```tsx showLineNumbers
// 中间组件转发事件
<ChildComponent @submit="emit('submit', $event)" />
```



## 小结

在 Vue 中，子组件通过 `emit` 发出自定义事件，让父组件监听并响应。这是一种典型的“单向数据流”模式，既保持了组件的独立性，也方便了组件间的通信。你可以传递参数、使用类型检查，并通过命名规范提升可维护性。掌握这一机制后，你就可以更自如地设计组件的交互逻辑了。
