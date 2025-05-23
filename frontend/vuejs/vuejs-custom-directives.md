---
sidebar_position: 22
slug: /vuejs-custom-directives
---

# Vue 自定义指令

在 Vue 中，指令（Directive）是一种非常实用的功能，它可以让你直接操作 DOM 元素。除了内置的指令（如 `v-model`、`v-if`、`v-for` 等），你还可以创建自己的 **自定义指令**，来实现特定的行为，比如自动聚焦、拖拽、懒加载等。

本文将带你了解自定义指令的基本语法、使用方式，以及在 Vue 3 中注册和封装指令的方法。



## 什么是指令？

Vue 的指令是带有 `v-` 前缀的特殊属性，作用是将某种行为“指令”给 DOM 元素。例如：

```html showLineNumbers
<input v-model="username" />
```

这个 `v-model` 指令帮你实现了数据双向绑定。

但如果 Vue 没有内置你需要的行为，就可以通过 **自定义指令** 来扩展 Vue 的能力。



## 自定义指令的基础用法

你可以通过 `app.directive()` 注册一个全局指令，或在组件内通过 `directives` 选项注册局部指令。

下面是一个全局自定义指令的例子：

**自动聚焦指令：`v-focus`**

```tsx showLineNumbers title="main.js"
import { createApp } from 'vue'
import App from './App.vue'

const app = createApp(App)

// 注册全局自定义指令 v-focus
app.directive('focus', {
  mounted(el) {
    el.focus()
  }
})

app.mount('#app')
```

**使用方式：**

```html showLineNumbers
<template>
  <input v-focus />
</template>
```

当这个组件挂载到页面上后，输入框会自动获取焦点。



## 指令的生命周期钩子

自定义指令支持多个生命周期钩子，你可以根据需要定义：

|    钩子函数     | 触发时机                     |
| :-------------: | ---------------------------- |
|    `created`    | 指令绑定元素时调用（一次性） |
|  `beforeMount`  | 元素插入到 DOM 前调用        |
|    `mounted`    | 元素插入到 DOM 后调用        |
| `beforeUpdate`  | 组件更新前调用（可能多次）   |
|    `updated`    | 组件更新后调用（可能多次）   |
| `beforeUnmount` | 卸载之前调用                 |
|   `unmounted`   | 卸载完成后调用               |

例如：

```tsx showLineNumbers
app.directive('logger', {
  mounted(el, binding) {
    console.log('指令绑定值：', binding.value)
  },
  updated(el, binding) {
    console.log('指令更新了，新的值：', binding.value)
  }
})
```



## 局部指令注册

你也可以在组件中注册局部指令：

```html showLineNumbers
<script>
export default {
  directives: {
    focus: {
      mounted(el) {
        el.focus()
      }
    }
  }
}
</script>

<template>
  <input v-focus />
</template>
```

这种方式适合只在当前组件中使用的指令，避免污染全局命名空间。



## 传递参数与修饰符

你可以通过指令的参数和修饰符来增强功能。例如：

```html showLineNumbers
<div v-my-dir:color.red="value"></div>
```

你可以在指令定义中读取这些值：

```tsx showLineNumbers
app.directive('my-dir', {
  mounted(el, binding) {
    console.log('绑定值：', binding.value)
    console.log('参数：', binding.arg)
    console.log('修饰符：', binding.modifiers)
  }
})
```

这个例子中，自定义指令 `v-my-dir:color.red="value"` 的语法中：

- `my-dir` 是指令名；
- `color` 是参数（arg）；
- `red` 是修饰符（modifier）；
- `value` 是绑定的值。

当这个指令绑定到 DOM 元素上时，`mounted` 钩子会被调用，并接收到两个参数：`el`（元素本身）和 `binding`（绑定信息对象）。

输出结果如下：

```bash showLineNumbers
绑定值： value
参数： color
修饰符： { red: true }
```



## 实战示例：实现拖拽功能

这个例子中，我们通过自定义指令的方式，给元素添加拖拽功能。你可以把它看作一个轻量级的 `v-draggable` 指令，实现点击拖动效果。

**完整代码如下：**

```tsx showLineNumbers
// 注册一个全局自定义指令 v-draggable
app.directive('draggable', {
  mounted(el) {
    el.style.position = 'absolute' // 设置元素为绝对定位（必须），这样它才能自由移动
    el.style.cursor = 'move'       // 设置鼠标样式为移动手型

    // 鼠标按下时触发
    el.onmousedown = function (e) {
      // 记录鼠标相对于元素左上角的偏移量
      const offsetX = e.clientX - el.offsetLeft
      const offsetY = e.clientY - el.offsetTop

      // 鼠标移动时触发
      document.onmousemove = function (e) {
        // 设置元素新的位置 = 当前鼠标位置 - 初始偏移
        el.style.left = `${e.clientX - offsetX}px`
        el.style.top = `${e.clientY - offsetY}px`
      }

      // 鼠标松开时取消移动事件
      document.onmouseup = function () {
        document.onmousemove = null
        document.onmouseup = null
      }
    }
  }
})
```

**说明：**

- `el.style.position = 'absolute'`：必须设置为 `absolute`，否则元素不能根据 left/top 改变位置；
- `onmousedown`：当鼠标按下时开始监听拖动；
- `onmousemove`：根据鼠标的位置实时更新元素的位置；
- `onmouseup`：鼠标松开时，移除事件监听器，避免内存泄漏；
- `offsetX` 和 `offsetY`：确保拖动时，鼠标始终保持在元素的点击点，而不是元素左上角；
- 你还可以在 `mounted` 中增加参数支持，比如限定拖动范围、启用/禁用等。

**使用方式：**

```html showLineNumbers
<template>
  <div v-draggable class="box">拖我一下</div>
</template>

<style>
.box {
  width: 100px;
  height: 100px;
  background: lightcoral;
  cursor: move;
}
</style>
```



## 小结

自定义指令是 Vue 中直接操作 DOM 的有力工具。当你遇到内置指令无法满足需求的场景时，自定义指令就能派上用场。通过生命周期钩子，你可以精准控制元素行为。虽然 Vue 鼓励使用组合式 API 来封装逻辑，但在处理底层 DOM 行为（如聚焦、拖拽、懒加载）时，自定义指令依然是非常高效的解决方案。掌握它，你将拥有更灵活的开发能力。
