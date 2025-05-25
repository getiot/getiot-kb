---
sidebar_position: 14
slug: /vuejs-custom-events-and-modifiers
authors: [luhuadong]
---

# Vue.js 自定义事件与事件修饰符

在上一节中，你已经学会了如何使用 `emit` 让子组件向父组件发送事件。本节我们继续深入，来看看在 Vue 中如何自定义事件，以及 Vue 提供的一些自定义事件的修饰符（event modifiers），它们可以帮你更方便地控制事件的行为，尤其是在组件通信的过程中。



## 自定义事件

在 Vue.js 中，自定义事件是子组件向父组件发送消息的一种机制。当你希望子组件“通知”父组件某个动作发生了，就可以使用 `emit` 触发一个自定义事件，父组件再通过监听这个事件作出响应。

这是一种 **“从下向上”** 的通信方式：子组件发送事件，父组件接收并处理。

### 自定义事件的语法

在子组件中使用 `emit`：

```tsx showLineNumbers
const emit = defineEmits(['事件名称'])
emit('事件名称', 传递的数据)
```

在父组件中监听这个事件：

```html showLineNumbers
<子组件名 @事件名称="处理函数" />
```



### 示例：基础用法

子组件：`MyButton.vue`

```html showLineNumbers title="MyButton.vue"
<template>
  <button @click="handleClick">点击我</button>
</template>

<script setup>
const emit = defineEmits(['my-click'])

function handleClick() {
  emit('my-click', 'Hello from child!')
}
</script>
```

父组件：`App.vue`

```html showLineNumbers title="App.vue"
<template>
  <MyButton @my-click="handleMyClick" />
</template>

<script setup>
import MyButton from './components/MyButton.vue'

function handleMyClick(msg) {
  console.log('来自子组件的消息：', msg)
}
</script>
```

当你点击按钮时，子组件触发了名为 `my-click` 的自定义事件，并传递了一段消息给父组件。

### 传递多个参数

你也可以通过 `emit` 传递多个值，它们会作为参数依次传入事件处理函数：

```tsx showLineNumbers
emit('my-click', '参数1', 123)
```

父组件处理时：

```html showLineNumbers
<MyButton @my-click="(a, b) => console.log(a, b)" />
```

### 类型推断

如果你使用 TypeScript，还可以为 `defineEmits` 提供类型定义：

```tsx showLineNumbers
const emit = defineEmits<{
  (e: 'my-click', payload: string): void
}>()
```

这将帮助你在编写时获得参数类型检查和自动补全。



## 事件修饰符

经过前面的学习，你可能已经在处理原生 DOM 事件时使用过 `.stop`、`.prevent` 等修饰符。其实 Vue 也支持把这些修饰符用在组件的自定义事件上，比如你可以通过 `.stop` 阻止一个点击事件继续冒泡。这在某些嵌套组件中非常有用。下面将带你了解这些事件修饰符的作用，并结合示例讲解它们在组件通信中的应用。



### `.stop`：阻止事件冒泡

有时候，你的子组件内部有点击事件，同时父组件也绑定了点击事件。如果你不想让事件冒泡到父组件，就可以使用 `.stop` 修饰符。请看下面示例：

子组件：`MyButton.vue`

```html showLineNumbers title="MyButton.vue"
<template>
  <button @click="emit('click')">点击我</button>
</template>

<script setup>
const emit = defineEmits(['click'])
</script>
```

父组件：`App.vue`

```html showLineNumbers title="App.vue"
<template>
  <div @click="onParentClick">
    <MyButton @click.stop="onChildClick" />
  </div>
</template>

<script setup>
import MyButton from './components/MyButton.vue'

function onParentClick() {
  console.log('父组件被点击')
}

function onChildClick() {
  console.log('子组件被点击')
}
</script>
```

在上面的例子中，由于你使用了 `.stop`，子组件触发 `click` 时，父组件的 `onParentClick` 不会执行。



### `.prevent`：阻止默认行为

如果你的组件封装了一个 `<form>` 或 `<a>` 标签，点击时可能会触发页面刷新或跳转。这时你可以使用 `.prevent` 来阻止默认行为。例如：

```html showLineNumbers
<!-- 父组件 -->
<MyForm @submit.prevent="handleSubmit" />
```

`.prevent` 会阻止子组件提交表单的默认行为，相当于在子组件内部调用了 `event.preventDefault()`。

:::tip 注意

为了让 `.prevent` 生效，你需要确保子组件的事件是从某个原生事件中触发的，例如 `@submit="emit('submit')"` 是从 `<form @submit="...">` 中发出的。

:::



### `.once`：只监听一次事件

你可以使用 `.once` 修饰符，让事件监听器只触发一次。例如：

```html showLineNumbers
<MyButton @click.once="handleClickOnce" />
```

这个监听器会在第一次触发后自动移除，在组件通信中，如果你只想接收一次某个信号（比如“加载完成”），可以使用这个修饰符。



### `.capture` 和 `.self`

这两个修饰符在组件通信中用得不多，但还是简单介绍一下。

- `.capture`：使用事件的捕获模式，而不是默认的冒泡模式。
- `.self`：只当事件的 `target` 是绑定元素本身时才触发。

例如：

```html showLineNumbers
<MyModal @click.self="closeModal" />
```

上面的例子表示：只有当点击事件直接发生在 `<MyModal>` 本身，而不是它内部的元素上，才会触发 `closeModal`。



## 自定义事件修饰符的限制

在编写自定义事件时，你需要注意以下几点：

1. **修饰符只对 DOM 元素有意义时才生效**。如果子组件只是调用 `emit('custom-event')` 并不携带原始 DOM 事件，这些修饰符其实没什么作用。
2. Vue 的事件修饰符是绑定在**父组件的监听器上**，不是写在 `emit` 上的。也就是说，你不能在子组件中使用 `.stop`、`.prevent` 等修饰符。
3. 自定义事件**不能跨组件层级直接发送**（比如子 → 祖父），只能通过逐层向上传递，或者使用全局状态管理（如 Pinia）或 `provide/inject`。
4. 不同组件中，**事件名称是大小写敏感的**，建议统一使用 `kebab-case`（短横线命名）。



## 组合多个修饰符

你可以组合多个修饰符来增强事件的表现力：

```html showLineNumbers
<MyDialog @close.stop.prevent.once="handleClose" />
```

这个监听器表示：当子组件触发 `close` 事件时：

- 阻止冒泡（`.stop`）；
- 阻止默认行为（`.prevent`）；
- 只触发一次（`.once`）。



## 小结

自定义事件是 Vue 中组件通信的关键机制之一，它让子组件可以主动“通知”父组件发生了什么。你可以用 `emit` 触发事件，并在父组件中监听它。搭配 `.stop`、`.once` 等修饰符，你还能控制事件的传播行为。掌握自定义事件和修饰符的用法，可以帮助你写出更加健壮和易维护的 Vue 应用。
