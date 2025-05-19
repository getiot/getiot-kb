---
sidebar_position: 5
slug: /vuejs-template-syntax
---

# Vue.js 模板语法

模板语法是 Vue 最直观的一部分，它让你可以用 HTML 的写法快速构建动态界面。本节会带你认识 Vue 模板中的插值语法、指令、事件绑定、属性绑定等基本用法，让你在写页面时得心应手。



## 插值表达式

最常见的模板语法就是插值表达式（Text Interpolation），用于把 JavaScript 数据渲染到 HTML 页面上。例如：

```tsx showLineNumbers
<p>你好，{{ name }}</p>
```

你可以在 `{{ }}` 中使用简单的 JavaScript 表达式，比如：

```tsx showLineNumbers
<p>今天是 {{ new Date().toLocaleDateString() }}</p>
```

但不能在其中使用语句（如 `if`、`for` 等）。



## 指令

Vue 提供了丰富的指令（Directives），它们是带有 `v-` 前缀的特殊属性，用来在模板中执行特定操作。

#### **v-bind：属性绑定**

将 HTML 属性和 JavaScript 表达式绑定在一起。

```html showLineNumbers
<img v-bind:src="imageUrl" />
<!-- 简写形式 -->
<img :src="imageUrl" />
```

#### **v-on：事件绑定**

绑定 DOM 事件，例如点击按钮：

```html showLineNumbers
<button v-on:click="increment">点击</button>
<!-- 简写形式 -->
<button @click="increment">点击</button>
```

#### **v-model：双向绑定**

让表单输入和数据同步更新，非常适合输入框、下拉框等：

```html showLineNumbers
<input v-model="message" />
<p>你输入的是：{{ message }}</p>
```

#### **v-if / v-else-if / v-else：条件渲染**

根据条件显示或隐藏元素：

```html showLineNumbers
<p v-if="isLoggedIn">欢迎回来！</p>
<p v-else>请先登录</p>
```

#### **v-show：显示与隐藏（不销毁 DOM）**

```html showLineNumbers
<p v-show="isVisible">我是可见的</p>
```

`v-show` 会始终渲染元素，但通过 `display: none` 控制显示，适合频繁切换显示状态的场景。

#### **v-for：列表渲染**

用来遍历数组或对象：

```html showLineNumbers
<ul>
  <li v-for="(item, index) in items" :key="index">
    {{ index + 1 }} - {{ item }}
  </li>
</ul>
```



## 使用 JavaScript 表达式

模板语法支持你在插值和指令中使用任意合法的 JavaScript 表达式：

```tsx showLineNumbers
<p>{{ count + 1 }}</p>
<p>{{ isActive ? '激活中' : '未激活' }}</p>
```

但是不支持语句（如 `if`、`for` 等），这部分逻辑建议写在 `<script>` 中。



## 绑定 HTML（v-html）

有时候你希望输出的是 HTML，而不是纯文本，可以使用 `v-html`：

```tsx showLineNumbers
<div v-html="rawHtml"></div>
```

⚠️ 注意：使用 `v-html` 时要特别注意 XSS 安全问题，避免输出未经处理的用户输入内容。



## 绑定 class 和 style

Vue 提供了方便的语法来动态绑定 class 和 style：

```html showLineNumbers
<!-- 对象语法 -->
<div :class="{ active: isActive, 'text-danger': hasError }"></div>

<!-- 数组语法 -->
<div :class="[activeClass, errorClass]"></div>

<!-- style 绑定 -->
<div :style="{ color: activeColor, fontSize: fontSize + 'px' }"></div>
```

这些语法让你可以根据数据动态控制样式，无需手动拼接字符串。



## 模板中的注释

你可以使用 HTML 注释或 Vue 注释：

```html showLineNumbers
<!-- HTML 注释：会渲染到 DOM -->
<!-- 这是 HTML 注释 -->

<!-- Vue 注释：不会渲染到 DOM -->
<!--{{! 这是 Vue 模板注释 }}-->
```

建议在模板中使用 HTML 注释，保持一致性。



## 小结

本节介绍了 Vue 模板语法的核心内容，包括插值表达式、指令（如 `v-bind`、`v-on`、`v-model`、`v-if`、`v-for` 等）、绑定样式和事件等。掌握这些语法后，你就能用 Vue 构建出功能丰富、交互灵活的前端页面。接下来，我们将讲解响应式数据如何在页面中发挥作用，并引导你编写更复杂的逻辑。掌握这些基础后，你会发现 Vue 的开发体验非常自然且高效。
