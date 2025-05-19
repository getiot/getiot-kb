---
sidebar_position: 6
slug: /vuejs-data-binding
---

# Vue.js 数据绑定

在 Vue 中，数据和视图之间的同步更新是一大核心特性。本章会带你了解 Vue 的数据绑定机制，包括单向绑定和双向绑定的使用方式与适用场景，帮助你轻松实现数据驱动的页面。



## 单向绑定

Vue 的数据绑定默认是**单向的**（One-way Binding），也就是从数据（JavaScript）到视图（DOM）。你可以使用 `{{ }}` 插值表达式，也可以使用指令来绑定属性。

#### **文本插值**

```html showLineNumbers
<p>{{ message }}</p>
```

上面这行代码会把组件中 `message` 的值渲染成纯文本内容。

#### **属性绑定**

你可以使用 `v-bind` 指令将数据绑定到 HTML 属性上：

```html showLineNumbers
<img v-bind:src="imageUrl" alt="图片描述" />
<!-- 简写形式 -->
<img :src="imageUrl" />
```

除了 `src`，你也可以绑定 `href`、`title`、`id` 等其他属性。



## 双向绑定

当你想要实现**输入与数据的双向同步**，可以使用 `v-model` 指令实现 **双向绑定**（Two-way Binding）。

```html showLineNumbers
<input v-model="username" />
<p>你输入的用户名是：{{ username }}</p>
```

`v-model` 的工作机制是：监听用户输入事件，并自动更新绑定的数据。



## `v-model` 适用的表单元素

Vue 的 `v-model` 可以用于多种表单控件：

- `<input>`：单行文本
- `<textarea>`：多行文本
- `<select>`：下拉选择
- `<input type="checkbox">`：复选框
- `<input type="radio">`：单选按钮

例如复选框：

```html showLineNumbers
<input type="checkbox" v-model="isChecked" />
<p>{{ isChecked }}</p>
```

或者单选按钮：

```html showLineNumbers
<input type="radio" v-model="picked" value="Option A" />
<input type="radio" v-model="picked" value="Option B" />
<p>你选择的是：{{ picked }}</p>
```



## 绑定 class 和 style

Vue 还支持通过数据绑定 `class` 和 `style`，实现动态样式切换。

#### **动态 class**

你可以用对象语法：

```html showLineNumbers
<div :class="{ active: isActive, 'text-danger': hasError }"></div>
```

或者数组语法：

```html showLineNumbers
<div :class="[baseClass, isActive ? 'active' : '']"></div>
```

#### **动态 style**

```html showLineNumbers
<div :style="{ color: activeColor, fontSize: fontSize + 'px' }"></div>
```

这些方式可以让你轻松根据数据状态切换样式，而不需要手动操作 DOM。



## `.lazy`、`.number` 和 `.trim` 修饰符

在使用 `v-model` 时，你还可以添加一些修饰符来改变默认行为：

- `.lazy`：输入框失去焦点时才更新数据
- `.number`：自动将输入值转为数字
- `.trim`：自动去除输入的首尾空格

示例：

```html showLineNumbers
<input v-model.lazy="msg" />
<input v-model.number="age" />
<input v-model.trim="keyword" />
```



## 深入理解响应式更新

Vue 使用响应式系统（reactivity system）追踪数据依赖，并在数据变化时自动更新视图。你不需要手动操作 DOM，Vue 会帮你完成这一切。

例如：

```tsx showLineNumbers
export default {
  data() {
    return {
      count: 0
    }
  },
  methods: {
    increment() {
      this.count++
    }
  }
}
```

每当你点击按钮触发 `increment()`，`count` 的值就会更新，页面上绑定的地方也会自动重新渲染。



## 小结

本章介绍了 Vue 的数据绑定机制，包括单向绑定（通过插值或 `v-bind`）、双向绑定（通过 `v-model`）以及如何动态绑定样式和类。Vue 的响应式特性使得数据变化可以自动反映到界面上，无需手动更新 DOM。掌握数据绑定的用法，将帮助你更高效地构建交互式前端应用。接下来，我们将深入了解 Vue 的响应式系统，探索其背后的工作原理。
