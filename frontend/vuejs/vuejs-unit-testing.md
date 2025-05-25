---
sidebar_position: 27
slug: /vuejs-unit-testing
authors: [luhuadong]
---

# Vue 项目单元测试

在 Vue 项目的开发中，编写单元测试是确保组件功能稳定、减少回归 bug 的重要手段。通过测试，你可以在不依赖浏览器界面的情况下验证组件逻辑是否正确。本文将带你了解如何使用现代工具（如 Vitest 和 Vue Test Utils）来编写和调试 Vue 单元测试。



## 什么是单元测试？

**单元测试（Unit Test）** 是指针对项目中最小可测试单元（如组件、函数）编写的自动化测试代码，确保这些模块行为正确。

在 Vue 项目中，单元测试一般会关注：

- 组件是否正常渲染
- props、emits 是否工作正常
- 事件、方法是否按预期执行
- 响应式数据是否正确更新



## 为什么需要测试 Vue 组件？

即使你手动在浏览器中测试了组件，如果之后某人改动了代码，仍可能引入 bug。而单元测试可以：

- 快速验证组件功能是否正常；
- 避免手动回归测试；
- 帮助你更安全地重构代码；
- 在 CI/CD 流水线中自动检查。



## 为什么推荐使用 Vitest？

当你选择在 Vue 项目中进行测试时，市面上常见的方案有 Vitest、Jest、Cypress 等。如果你的项目是基于 Vite + Vue 3 的，那么使用 Vitest + Vue Test Utils 是目前最佳的单元测试选择。

这种方式具有如下优势：

- 启动速度极快，几乎零等待；
- 能与你的 Vite 配置共享构建逻辑；
- API 和 Jest 高度兼容（可以平滑迁移）；
- 支持模块热更新，测试体验非常流畅。

例如，运行一个 Vitest 测试，基本上就是秒级完成，非常适合你频繁修改组件并立刻验证的工作流。

:::tip

**Vue Test Utils**（简称 VTU）是 Vue 官方推出的组件测试库，它提供用于挂载（mount）、操作和断言 Vue 组件的 API。而 **Vitest** 是一个轻量级、快速的测试运行器，功能类似于 Jest，但专为 Vite 项目设计。

也就是说，你可以用 Vue Test Utils 写测试逻辑，用 Vitest 来运行这些测试。

:::



## 搭建测试环境（Vitest + Vue Test Utils）

推荐使用 Vitest，它是一个速度非常快的 Vite 原生测试框架，并且兼容 Jest 的 API，易于上手。

**安装依赖**

```bash showLineNumbers
npm install -D vitest vue-test-utils @vue/test-utils jsdom
```

**配置 Vitest（vite.config.ts）**

```tsx showLineNumbers title="vite.config.ts"
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  test: {
    environment: 'jsdom', // 用于模拟 DOM 环境
    globals: true,        // 使用 describe / it / expect 等全局 API
    setupFiles: ['./vitest.setup.ts'] // 可选的测试初始化文件
  }
})
```



## 编写你的第一个测试用例

假设你有一个组件 `Hello.vue`：

```html showLineNumbers title="Hello.vue"
<template>
  <p @click="count++">点击了 {{ count }} 次</p>
</template>

<script setup>
import { ref } from 'vue'
const count = ref(0)
</script>
```

创建一个测试文件：`Hello.test.ts`

```tsx showLineNumbers title="Hello.test.ts"
import { mount } from '@vue/test-utils'
import Hello from './Hello.vue'

describe('Hello.vue', () => {
  it('初始文本应为 0 次', () => {
    const wrapper = mount(Hello)
    expect(wrapper.text()).toContain('点击了 0 次')
  })

  it('点击后计数应增加', async () => {
    const wrapper = mount(Hello)
    await wrapper.trigger('click')
    expect(wrapper.text()).toContain('点击了 1 次')
  })
})
```

然后运行测试：

```bash showLineNumbers
npx vitest
```



## 断言技巧与常见写法

Vitest 使用的是类似 Jest 的断言库，你可以使用：

```tsx showLineNumbers
expect(wrapper.text()).toBe('xxx')
expect(wrapper.find('p').exists()).toBe(true)
expect(wrapper.classes()).toContain('active')
expect(wrapper.emitted()).toHaveProperty('update')
```

对于复杂对象，使用 `.toMatchObject()`：

```tsx showLineNumbers
expect(data).toMatchObject({ name: 'Vue', version: 3 })
```



## 测试 Props、Emit 和插槽

#### 测试 Props：

```tsx showLineNumbers
const wrapper = mount(MyComponent, {
  props: {
    title: '欢迎'
  }
})
expect(wrapper.text()).toContain('欢迎')
```

#### 测试事件触发：

```tsx showLineNumbers
const wrapper = mount(MyComponent)
await wrapper.find('button').trigger('click')
expect(wrapper.emitted()).toHaveProperty('submit')
```

#### 测试插槽内容：

```tsx showLineNumbers
const wrapper = mount(MyComponent, {
  slots: {
    default: '<span>自定义内容</span>'
  }
})
expect(wrapper.html()).toContain('自定义内容')
```



## 如何调试测试用例

#### 使用 `console.log`

你可以在测试文件中添加日志输出：

```tsx showLineNumbers
console.log(wrapper.html())
```

#### 使用 `--ui` 启动交互界面调试（Vitest UI）

```bash showLineNumbers
npx vitest --ui
```

Vitest 会打开一个图形化界面，你可以逐个查看用例执行结果，还可以在失败时展开调试细节。

#### 使用断点调试

你可以在测试用例中写 `debugger`，然后使用 `node --inspect` 或在 VS Code 中打断点调试。

例如，在 `package.json` 添加调试脚本：

```json showLineNumbers
"scripts": {
  "test:debug": "node --inspect-brk ./node_modules/vitest/vitest.mjs"
}
```

然后在 VS Code 启动调试，配合断点分析测试逻辑。



## 提高测试效率的小技巧

- 使用 `test.only()` 或 `it.only()` 来仅运行指定测试用例。
- 使用 `beforeEach()` 和 `afterEach()` 管理重复逻辑。
- 使用 `mock` 来模拟依赖或接口，例如 `axios`。
- 对公共函数、逻辑提取并单独测试（纯函数更好测）。



## 小结

单元测试是保障 Vue 项目质量的重要工具。你可以借助 Vitest + Vue Test Utils 快速编写测试，覆盖组件的 props、事件、插槽等核心逻辑。同时，通过 `console.log`、断点和 Vitest UI 等手段进行调试，让测试更高效更直观。建议你从简单组件开始练习写测试，逐步建立测试驱动开发的意识。
