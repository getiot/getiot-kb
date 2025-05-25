---
sidebar_position: 10
slug: /vuejs-form-binding
authors: [luhuadong]
---

# Vue.js 表单输入绑定

在这一节中，你将学习如何使用 Vue.js 实现表单输入与数据之间的双向绑定。我们会介绍 `v-model` 指令的使用方法，以及它在文本框、复选框、单选按钮、下拉选择框等不同类型表单元素中的表现。掌握这些内容后，你就可以轻松地构建响应式的表单界面。



## 基础用法：v-model 实现双向绑定

在 Vue 中，最常用的表单绑定方式就是 `v-model` 指令。它可以让表单元素的值与组件中的数据保持同步（双向绑定）。

```html showLineNumbers
<template>
  <input v-model="message" placeholder="请输入内容" />
  <p>你输入的是：{{ message }}</p>
</template>

<script setup>
import { ref } from 'vue'

const message = ref('')
</script>
```

当你在输入框中输入内容时，`message` 的值会自动更新，页面也会实时反映你输入的内容。



## 多种输入类型的支持

### 单选按钮（radio）

```html showLineNumbers
<template>
  <label><input type="radio" value="A" v-model="picked" /> 选项 A</label>
  <label><input type="radio" value="B" v-model="picked" /> 选项 B</label>
  <p>你选择的是：{{ picked }}</p>
</template>

<script setup>
import { ref } from 'vue'

const picked = ref('')
</script>
```

### 复选框（checkbox）

```html showLineNumbers
<template>
  <label><input type="checkbox" v-model="isChecked" /> 是否同意</label>
  <p>是否勾选：{{ isChecked }}</p>
</template>

<script setup>
import { ref } from 'vue'

const isChecked = ref(false)
</script>
```

如果你绑定的是一个数组，复选框也可以实现多选：

```html showLineNumbers
<template>
  <label><input type="checkbox" value="Vue" v-model="checkedNames" /> Vue</label>
  <label><input type="checkbox" value="React" v-model="checkedNames" /> React</label>
  <label><input type="checkbox" value="Angular" v-model="checkedNames" /> Angular</label>
  <p>你选择了：{{ checkedNames }}</p>
</template>

<script setup>
import { ref } from 'vue'

const checkedNames = ref([])
</script>
```

### 下拉选择框（select）

```html showLineNumbers
<template>
  <select v-model="selected">
    <option disabled value="">请选择一个框架</option>
    <option>Vue</option>
    <option>React</option>
    <option>Angular</option>
  </select>
  <p>你选择的是：{{ selected }}</p>
</template>

<script setup>
import { ref } from 'vue'

const selected = ref('')
</script>
```

也支持多选：

```html showLineNumbers
<template>
  <select v-model="selectedFrameworks" multiple>
    <option>Vue</option>
    <option>React</option>
    <option>Angular</option>
  </select>
  <p>你选择的是：{{ selectedFrameworks }}</p>
</template>

<script setup>
import { ref } from 'vue'

const selectedFrameworks = ref([])
</script>
```



## 修饰符的使用

Vue 提供了多个修饰符来控制 `v-model` 的行为：

- `.lazy`：在 `change` 事件时更新，而不是 `input`
- `.number`：自动将输入值转为数字类型
- `.trim`：自动去除首尾空格

```html showLineNumbers
<input v-model.lazy="msg" />
<input v-model.number="age" />
<input v-model.trim="name" />
```



## 在组件中使用 v-model

当你封装一个组件并希望它支持 `v-model`，需要使用 `defineProps` 和 `emit` 事件。Vue 3 中，推荐使用 `modelValue` 和 `update:modelValue`：

```html showLineNumbers
<!-- CustomInput.vue -->
<template>
  <input :value="modelValue" @input="$emit('update:modelValue', $event.target.value)" />
</template>

<script setup>
defineProps(['modelValue'])
</script>
```

使用这个组件时：

```html showLineNumbers
<CustomInput v-model="inputValue" />
```

> 💡 关于组件的内容将在后续章节中详细讲解，这里只是简单提及。



## 小结

本节介绍了 Vue 中 `v-model` 的用法，包括在文本框、复选框、单选按钮和下拉框中的应用。你还学会了如何使用修饰符来处理输入行为，以及如何在自定义组件中实现 `v-model` 支持。掌握表单绑定，是你构建交互式 Vue 应用的重要一步。
