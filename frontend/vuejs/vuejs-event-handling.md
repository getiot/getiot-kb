---
sidebar_position: 9
slug: /vuejs-event-handling
---

# Vue.js 事件处理

在这一章中，你将学习如何使用 Vue 的事件绑定功能处理用户交互，比如点击按钮、提交表单、按键输入等。我们将介绍常用的事件绑定语法、事件修饰符、按键修饰符以及如何传递参数。掌握这些内容后，你就能灵活响应用户的操作，让你的页面“动”起来。



## 基本的事件绑定

在 Vue 中，你可以使用 `v-on` 或其缩写 `@` 来监听 DOM 事件。

```tsx showLineNumbers
<button @click="count++">点击我</button>
```

这个例子中，点击按钮时会执行 `count++`，增加计数器。

你也可以绑定一个方法：

```tsx showLineNumbers
<template>
  <button @click="increment">加一</button>
</template>

<script setup>
import { ref } from 'vue'

const count = ref(0)

function increment() {
  count.value++
}
</script>
```

:::tip

使用 `<script setup>` 是 Vue 3 推荐的组合式写法，语法更简洁。

:::



## 事件对象

如果你需要访问原生事件对象（Event Object），可以通过参数获取它：

```tsx showLineNumbers
<button @click="handleClick">获取事件</button>

function handleClick(event) {
  console.log(event)
}
```



## 传递参数

你可以通过内联语法传递参数：

```tsx showLineNumbers
<button @click="say('Hello')">打招呼</button>

function say(message) {
  alert(message)
}
```

如果你既想传参数，又想访问事件对象，可以这样写：

```tsx showLineNumbers
<button @click="say('Hi', $event)">带事件对象</button>

function say(msg, event) {
  console.log(msg)
  console.log(event.type)
}
```



## 事件修饰符

Vue 提供了一些修饰符用于简化事件处理逻辑：

| 修饰符     | 作用                             |
| ---------- | -------------------------------- |
| `.stop`    | 等同于 `event.stopPropagation()` |
| `.prevent` | 等同于 `event.preventDefault()`  |
| `.capture` | 使用事件的捕获模式               |
| `.once`    | 只触发一次                       |
| `.self`    | 只在事件从自身触发时才触发处理器 |



#### **示例：阻止事件冒泡**

在网页中，当你对一个元素触发事件（比如点击按钮）时，这个事件不仅会在该元素上触发，还会**从这个元素向上“冒泡”到它的所有祖先元素**，依次触发它们绑定的同类事件处理函数 —— 这就叫“事件冒泡”（Event Bubbling）。

你可以把它想象成往水里丢一颗石子，气泡从水底向上升，一层一层经过父元素，直到最外层。

**举个例子：**

```tsx showLineNumbers
<div @click="handleParentClick">
  <button @click="handleChildClick">点击我</button>
</div>

function handleParentClick() {
  console.log('父元素被点击')
}

function handleChildClick() {
  console.log('子元素被点击')
}
```

现在，当你点击按钮时，你会看到控制台输出：

```bash showLineNumbers
子元素被点击
父元素被点击
```

也就是说，**你点击了子元素，但事件也“冒泡”到了父元素**，所以两个函数都被触发了。

**那么，该如何阻止冒泡？**

有时候你不希望父元素被触发（比如点击按钮时不想关闭父容器），这时你可以使用 Vue 的 `.stop` 修饰符来阻止事件冒泡：

```tsx showLineNumbers {2}
<div @click="parentClick">
  <button @click.stop="childClick">子元素</button>
</div>

function parentClick() {
  console.log('父元素点击')
}
function childClick() {
  console.log('子元素点击')
}
```



## 按键修饰符

对于键盘事件，你可以使用 `.enter`、`.esc`、`.tab` 等修饰符：

```tsx showLineNumbers
<input @keyup.enter="submit">
```

你还可以组合修饰符：

```tsx showLineNumbers
<input @keyup.ctrl.enter="submit">
```

这个例子中，只有在按下 `Ctrl + Enter` 的时候才会触发 `submit` 方法。



## 自定义事件名

你也可以监听自定义的事件名，比如：

```html showLineNumbers
<!-- 支持驼峰或短横线形式 -->
<MyComponent @my-event="handleCustomEvent" />
```

组件内触发方式为：

```tsx showLineNumbers
emit('my-event')
```

> 💡 自定义事件部分将在后续组件章节中详细讲解，这里只是简单提及。



## 小结

在 Vue 中，事件处理是实现交互功能的关键部分。你可以通过 `@event` 的方式轻松监听原生 DOM 事件，结合事件修饰符和按键修饰符来简化代码逻辑。你还可以传递参数和访问事件对象，甚至监听组合键操作。掌握这些技巧后，你就能编写出更加灵活、响应迅速的 Vue 应用。
