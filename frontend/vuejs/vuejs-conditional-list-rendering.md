---
sidebar_position: 8
slug: /vuejs-conditional-list-rendering
---

# Vue.js 条件渲染与列表渲染

在这篇文章中，你将学习如何使用 Vue 的 `v-if`、`v-else`、`v-show` 等指令来进行 **条件渲染**（Conditional Rendering），以及如何使用 `v-for` 来进行 **列表渲染**（List Rendering）。这两个功能是构建动态页面时不可或缺的一部分。无论是展示一段状态信息，还是循环渲染一组数据，掌握这些语法都能让你的 Vue 项目更加灵活和高效。



## 条件渲染

### `v-if` 指令

`v-if` 可以根据表达式的真假值来决定是否渲染某个元素：

```html showLineNumbers
<p v-if="visible">这段文字会在 visible 为 true 时显示</p>
```

如果 `visible` 为 `false`，该元素不会被渲染到 DOM 中。

你也可以使用 `v-else` 和 `v-else-if`：

```html showLineNumbers
<p v-if="type === 'A'">A 类型</p>
<p v-else-if="type === 'B'">B 类型</p>
<p v-else>未知类型</p>
```

:::info 注意

`v-else` 和 `v-else-if` 必须紧跟在 `v-if` 或 `v-else-if` 元素后面，不能有其他元素或空格隔开。

:::

### `v-show` 指令

`v-show` 和 `v-if` 的区别在于：

- `v-if` 是 **真正的条件渲染**，元素会在条件为 false 时从 DOM 中移除；
- `v-show` 是通过设置 `display: none` 来控制显示与隐藏，元素始终存在于 DOM 中。

```html showLineNumbers
<p v-show="visible">这段文字会显示或隐藏，但不会移除 DOM 元素</p>
```

:::tip

一般来说，如果你频繁切换显示状态，推荐使用 `v-show`；如果是一次性渲染或切换较少，使用 `v-if` 更合适。

:::



## 列表渲染

### 使用 `v-for` 渲染数组

你可以使用 `v-for` 来遍历数组，并渲染出多个元素：

```html showLineNumbers
<ul>
  <li v-for="item in items" :key="item.id">{{ item.name }}</li>
</ul>
```

在这个例子中：

- `items` 是一个数组；
- `item` 是每次迭代的元素；
- `:key` 是推荐写的，用于提高渲染性能。

例如：

```tsx showLineNumbers
const items = ref([
  { id: 1, name: '苹果' },
  { id: 2, name: '香蕉' },
  { id: 3, name: '橘子' }
])
```

### 获取索引

你也可以获取当前项的索引：

```tsx showLineNumbers
<li v-for="(item, index) in items" :key="item.id">
  第 {{ index + 1 }} 项：{{ item.name }}
</li>
```

### 遍历对象

`v-for` 还可以遍历对象的属性：

```tsx showLineNumbers
<ul>
  <li v-for="(value, key, index) in myObject" :key="key">
    {{ index }} - {{ key }}: {{ value }}
  </li>
</ul>
```

```tsx showLineNumbers
const myObject = ref({
  name: 'Vue',
  version: '3.x',
  type: '框架'
})
```



## 结合条件与列表渲染

你可以把 `v-if` 和 `v-for` 同时用在一个元素上，但要小心性能问题和优先级。

```tsx showLineNumbers
<li v-for="item in items" v-if="item.visible" :key="item.id">
  {{ item.name }}
</li>
```

这段代码的实际效果是：先循环 items，然后在每次循环中判断 `item.visible` 是否为真。

:::warning

如果你想在渲染前就过滤数据，推荐使用 computed 属性提前筛选，而不是在模板中混用 `v-if` 和 `v-for`。

:::



## 小结

通过 `v-if` 和 `v-show`，你可以灵活地控制元素是否显示；而 `v-for` 则可以帮助你高效地渲染列表数据。掌握它们之后，你就能轻松构建出根据数据动态变化的界面。别忘了合理使用 `key` 来优化渲染性能，尤其是在处理大型列表时。
