---
sidebar_position: 9
authors: [luhuadong]
---

# Taro 状态管理与事件处理

在 Taro 开发中，你经常需要处理用户输入、更新页面数据、响应按钮点击等交互行为。本章将带你了解如何使用 React 的 `useState` 实现本地状态管理，并介绍事件绑定与处理的基本方法。



## 使用 useState 管理组件状态

Taro 基于 React，因此你可以直接使用 React Hooks 中的 `useState` 来管理组件内部状态。

**示例：点击按钮计数**

你可以在页面中添加一个按钮，每点击一次，就更新计数器的值。

```tsx showLineNumbers
import { useState } from 'react'
import { View, Button, Text } from '@tarojs/components'

export default function Counter() {
  const [count, setCount] = useState(0)

  return (
    <View>
      <Text>当前计数：{count}</Text>
      <Button onClick={() => setCount(count + 1)}>点击加一</Button>
    </View>
  )
}
```

说明：

- `useState(0)` 表示定义一个名为 `count` 的状态，初始值为 0。
- `setCount` 是更新状态的方法，每次点击按钮时会让 `count + 1`。
- 通过 `{count}` 绑定在 `<Text>` 中实现自动刷新。



## 事件处理基础

Taro 组件和原生 HTML 类似，事件名采用 camelCase 风格，例如 `onClick`、`onInput`、`onChange`。

**示例：处理输入框变化**

```tsx showLineNumbers
import { useState } from 'react'
import { View, Input, Text } from '@tarojs/components'

export default function InputExample() {
  const [value, setValue] = useState('')

  const handleInput = (e) => {
    setValue(e.detail.value)
  }

  return (
    <View>
      <Input type="text" value={value} onInput={handleInput} placeholder="请输入内容" />
      <Text>你输入的是：{value}</Text>
    </View>
  )
}
```

注意：

- `Input` 组件的输入值不能直接修改，需要受控绑定 `value` 和 `onInput`。
- `e.detail.value` 是获取输入内容的标准方式。



## 多个状态同时管理

你可以在一个组件中定义多个 `useState`，分别管理不同的数据。

```tsx showLineNumbers
const [name, setName] = useState('')
const [age, setAge] = useState(0)
```

或者，你也可以用一个 `useState` 搭配对象来统一管理多个字段：

```tsx showLineNumbers
const [form, setForm] = useState({ name: '', age: 0 })

const handleChange = (key, value) => {
  setForm({ ...form, [key]: value })
}
```



## Taro 常用事件名对照表

| 事件行为 | Taro 事件名 |
| :------: | :---------: |
| 点击事件 |  `onClick`  |
| 输入事件 |  `onInput`  |
| 变化事件 | `onChange`  |
| 表单提交 | `onSubmit`  |
| 获取焦点 |  `onFocus`  |
| 失去焦点 |  `onBlur`   |

你可以在 Taro 官方文档 中查看更多组件和事件的详细说明。



## 小结

在 Taro 中，你可以使用 React 的 `useState` 来管理组件的本地状态，结合 Taro 的事件系统实现丰富的交互行为。通过掌握状态更新和事件处理的基本方式，你就可以构建出响应用户操作的动态页面。这是实现高质量跨端小程序应用的基础技能之一。
