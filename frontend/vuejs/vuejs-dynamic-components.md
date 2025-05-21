---
sidebar_position: 16
slug: /vuejs-dynamic-components
---

# Vue.js 动态组件与组件的复用

在 Vue 开发中，你经常会遇到这样一种需求：同一个位置需要渲染不同的组件，或者想要根据条件切换组件，而不是写很多 `v-if` 来控制。这时候你就可以使用动态组件功能。此外，组件的复用也是开发中提升效率和可维护性的重要手段。本文将带你了解 `动态组件` 和 `组件复用` 的基本用法与最佳实践。



## 什么是动态组件？

在 Vue 中，你可以通过 `<component>` 标签来渲染一个“动态”的组件。只需要将组件名称或组件对象赋值给 `:is` 属性，Vue 就会自动渲染对应的组件。

你可能会在以下场景中用到动态组件：

- **选项卡组件（Tabs）**：不同的 tab 显示不同的组件内容。
- **多步骤表单**：根据当前步骤渲染不同的表单页面。
- **内容编辑器插件**：可切换不同类型的输入组件。

**示例：根据按钮切换不同组件**

```html showLineNumbers
<script setup>
import Foo from './Foo.vue'
import Bar from './Bar.vue'
import { ref } from 'vue'

const currentComponent = ref('Foo')
</script>

<template>
  <button @click="currentComponent = 'Foo'">显示 Foo</button>
  <button @click="currentComponent = 'Bar'">显示 Bar</button>

  <component :is="currentComponent" />
</template>
```

在上面的示例中，`<component :is="currentComponent" />` 会根据变量 `currentComponent` 的值动态渲染 `<Foo />` 或 `<Bar />` 组件。

你也可以传入组件对象而非字符串：

```html showLineNumbers
<component :is="currentComponentObject" />
```



## 使用 `keep-alive` 缓存组件状态

当你在多个动态组件之间切换时，有时候你希望它们的状态保持不变，比如表单输入内容不被清空。你可以用 `<keep-alive>` 来缓存这些组件。

```html showLineNumbers
<keep-alive>
  <component :is="currentComponent" />
</keep-alive>
```

注意：只有被 `keep-alive` 包裹的组件才会被缓存，组件一旦被移除并重新挂载，状态会恢复初始。



## 组件复用的意义

组件复用指的是将通用逻辑或布局封装成一个可复用的 Vue 组件，避免重复代码。这不仅可以让你的代码更简洁，而且有助于维护和测试。

**示例：复用一个按钮组件**

```html showLineNumbers title="BaseButton.vue"
<!-- BaseButton.vue -->
<template>
  <button :class="type" @click="$emit('click')">
    <slot />
  </button>
</template>

<script setup>
defineProps({
  type: {
    type: String,
    default: 'primary'
  }
})
</script>
```

使用方式：

```html showLineNumbers
<BaseButton type="danger" @click="doDelete">删除</BaseButton>
<BaseButton type="success" @click="doSave">保存</BaseButton>
```

你可以通过 props 和 slot 的结合，让组件更具复用性和灵活性。



## 避免组件复用带来的副作用

如果你在同一页面上多次使用同一个组件，Vue 会根据每个组件实例维护独立的数据状态。但有时你会想要“重置”这些状态，这可以通过设置 `:key` 来实现强制重新渲染。

```html showLineNumbers
<YourComponent :key="someId" />
```

当 `someId` 改变时，组件会被销毁并重新创建。



## 动态组件 + 复用的实际案例

假设你正在开发一个“Tab 页”功能，不同的 Tab 对应不同的组件，你可以这样实现：

```html showLineNumbers
<script setup>
import TabHome from './TabHome.vue'
import TabProfile from './TabProfile.vue'
import TabSettings from './TabSettings.vue'
import { ref } from 'vue'

const currentTab = ref('home')
const tabComponents = {
  home: TabHome,
  profile: TabProfile,
  settings: TabSettings
}
</script>

<template>
  <button @click="currentTab = 'home'">主页</button>
  <button @click="currentTab = 'profile'">个人资料</button>
  <button @click="currentTab = 'settings'">设置</button>

  <keep-alive>
    <component :is="tabComponents[currentTab]" />
  </keep-alive>
</template>
```

在这个例子中：

- 你定义了三个子组件 `home`、`profile` 和 `settings`。
- 通过 `:is="tabComponents[currentTab]"`，你让 Vue 根据 currentTab 的值动态渲染组件。
- `tabComponents[currentTab]` 的值是 `TabHome`、`TabProfile` 或 `TabSettings`，分别对应组件名称。

这样一来，不仅组件是动态切换的，而且状态也得到了缓存，非常适合用于标签页、步骤表单等场景。



## 小结

动态组件和组件复用是 Vue 强大组件化能力的体现。你可以用 `<component :is="...">` 动态切换渲染组件，结合 `<keep-alive>` 保持状态；同时通过 props、slot 和 emit 等机制，实现可配置、灵活复用的组件结构。掌握这些技巧后，你将能构建出更加灵活、高效、可维护的 Vue 应用。
