---
sidebar_position: 3
sidebar_label: ToDo 应用数据存储与优化
authors: [luhuadong]
---

# Taro 项目实战：ToDo 应用 - 数据存储与优化

在上一节中，你已经实现了 ToDo 应用的基本功能：添加、勾选完成状态、删除事项等。本节将继续完善该应用，实现数据的本地存储功能，让你的待办事项在关闭 App 后仍然能被保存；同时，我们还会对交互体验和代码结构进行一些优化。

:::info 项目代码

ToDo 应用示例的完整代码可在 [GitHub](https://github.com/getiot/taro-courses/tree/main/todo-app) 获取。

:::



## 本地存储实现

Taro 提供了一套跨平台的本地存储 API，你可以使用 `Taro.setStorageSync` 和 `Taro.getStorageSync` 来保存和读取本地数据。

### 保存数据

每次待办事项列表发生变更时，你都应该将数据保存到本地：

```tsx showLineNumbers
import Taro from '@tarojs/taro'

// 保存数据
const saveTodosToStorage = (todos: TodoItem[]) => {
  Taro.setStorageSync('todoList', todos)
}
```

### 读取数据

在应用初始化时，从本地加载待办事项数据并更新状态：

```tsx showLineNumbers
// 初始化加载本地存储
useEffect(() => {
  const storedTodos = Taro.getStorageSync('todoList')
  if (storedTodos) {
    setTodos(storedTodos)
  }
}, [])
```

### 在修改待办事项后同步保存

你可以在添加、删除或切换完成状态后统一调用 `saveTodosToStorage(todos)`：

例如，在添加 todo 后：

```tsx showLineNumbers {4}
const addTodo = () => {
  ...
  setTodos([...todos, newTodo]);
  saveTodosToStorage([...todos, newTodo])
};
```

或者，你也可以通过 `useEffect` 监听 `todoList` 的变化：

```tsx showLineNumbers {5-7}
import { useState, useEffect } from 'react';

export default function Index () {
  ...
  useEffect(() => {
    saveTodosToStorage(todos)
  }, [todos])
  ...
}
```

这种方式更简洁、可靠，推荐使用。

:::tip

你在使用 `Taro.setStorageSync` 或 `Taro.setStorage` 时，其实是在调用小程序或 Web 端的**本地缓存机制**，它不是数据库，也不是永久保存的数据存储。

- 如果你只是做一个个人小工具，或者不需要登录、不涉及多设备同步，`Taro.setStorageSync` 足够用。
- 如果你的 ToDo 应用准备支持登录、多设备同步、数据统计、云备份等功能，那么更推荐用后端数据库或微信/阿里的云开发服务。
- 为提升用户体验，你也可以采用“**本地缓存 + 云同步**”的混合策略。

:::



## 用户体验优化建议

### 自动聚焦输入框

首先，你需要使用 `useRef` 来创建一个引用，并正确地绑定到组件上。然后就可以在添加事项后让输入框重新获得焦点，提升使用流畅度。

```tsx showLineNumbers {4,11}
import { useState, useEffect, useRef } from 'react';

export default function Index () {
  const inputRef = useRef<HTMLInputElement | null>(null)  // 创建引用
  ...
  
  return (
    <View className="container">
      <View className="input-area">
        <Input
          ref={inputRef}  // 绑定组件
          ...
        />
      </View>
    </View>
  )
}
```

添加完事项后调用 `inputRef.current?.focus()`：

```tsx showLineNumbers {4}
const addTodo = () => {
  ...
  setInputValue('');
  inputRef.current?.focus()
}
```

注意你需要通过 `useRef` 获取 input 引用。

### 空输入禁止添加

确保你已经处理了空字符串和空格情况：

```tsx showLineNumbers
if (!inputValue.trim()) return
```

### 使用唯一 ID

使用 `Date.now()` 在测试中够用，但在更复杂的项目中，可以考虑使用 `uuid` 等库来生成更安全的 ID。



## 代码结构优化建议

随着应用功能变多，把逻辑拆分成模块有助于可维护性。例如：

- `useTodo.ts`：封装增删改查逻辑和本地存储
- `TodoItem.tsx`：封装单条待办项组件
- `TodoInput.tsx`：封装输入框组件

在 Taro 中结构清晰的组件拆分同样适用，特别是在多页面项目中效果更明显。



## 错误处理建议

建议你在使用 `Taro.getStorageSync` 时加个 try-catch，防止数据异常导致程序崩溃：

```tsx showLineNumbers
try {
  const storedTodos = Taro.getStorageSync('todoList')
  if (storedTodos) {
    setTodoList(storedTodos)
  }
} catch (e) {
  console.warn('加载本地数据失败', e)
}
```



## 小结

在本节中，你学会了如何使用 Taro 提供的本地存储 API 来实现数据的持久化。你还学习了一些提高交互体验和维护性的小技巧。通过这些优化，ToDo 应用变得更加完整和实用。在下一节中，我们将介绍如何将你的应用打包并发布到多个平台，真正实现跨端部署。
