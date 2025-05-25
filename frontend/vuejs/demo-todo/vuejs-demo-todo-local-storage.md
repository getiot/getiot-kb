---
sidebar_position: 5
sidebar_label: 本地存储与数据持久化
slug: /vuejs-demo-todo-local-storage
authors: [luhuadong]
---

# Vue.js 实现 ToDo 应用：本地存储与数据持久化

在前面的步骤中，你已经实现了任务的添加、删除、编辑以及筛选。现在，我们来完成这款 ToDo 应用的最后一个关键功能 —— **本地存储与数据持久化**。通过使用浏览器的 `localStorage`，你可以在用户刷新页面后仍保留其任务记录。这对一个真正可用的待办事项应用来说非常重要。



## 实现思路

1. 在应用加载时读取本地存储中的数据初始化任务列表
2. 每当任务列表发生变化时，自动将其写入 localStorage 中



## 修改 App.vue：添加本地存储功能

我们只需要在 `App.vue` 文件中对 `todos` 的读取与写入进行封装。以下是完整代码，并加上关键注释说明。

```html showLineNumbers {23,38-53} title="src/App.vue"
<template>
  <div class="app">
    <h1>📋 我的 ToDo 应用</h1>
    <TodoInput @add="addTodo" />
    <TodoFilter
      v-model:showPending="showPending"
      v-model:showCompleted="showCompleted"
    />
    <ul>
      <TodoItem
        v-for="todo in filteredTodos"
        :key="todo.id"
        :todo="todo"
        @toggle="toggleTodo"
        @remove="removeTodo"
        @edit="editTodo"
      />
    </ul>
  </div>
</template>

<script lang="ts" setup>
import { ref, computed, watch, onMounted } from 'vue'
import TodoInput from './components/TodoInput.vue'
import TodoItem from './components/TodoItem.vue'
import TodoFilter from './components/TodoFilter.vue'

type Todo = {
  id: number
  text: string
  done: boolean
}

const todos = ref<Todo[]>([])
const showPending = ref(true)
const showCompleted = ref(true)

// 页面加载时从 localStorage 中恢复数据
onMounted(() => {
  const saved = localStorage.getItem('vue-todos')
  if (saved) {
    todos.value = JSON.parse(saved)
  }
})

// 每当 todos 发生变化，更新 localStorage
watch(
  todos,
  (newTodos) => {
    localStorage.setItem('vue-todos', JSON.stringify(newTodos))
  },
  { deep: true }
)

const addTodo = (text: string) => {
  todos.value.push({
    id: Date.now(),
    text,
    done: false,
  })
}

const toggleTodo = (id: number) => {
  const todo = todos.value.find((t) => t.id === id)
  if (todo) todo.done = !todo.done
}

const removeTodo = (id: number) => {
  todos.value = todos.value.filter((t) => t.id !== id)
}

const editTodo = ({ id, text }: { id: number; text: string }) => {
  const todo = todos.value.find((t) => t.id === id)
  if (todo) todo.text = text
}

const filteredTodos = computed(() => {
  return todos.value.filter((t) => {
    return (
      (t.done && showCompleted.value) ||
      (!t.done && showPending.value)
    )
  })
})
</script>

<style scoped>
.todo-app {
  max-width: 500px;
  margin: auto;
  padding: 1em;
  font-family: system-ui, sans-serif;
}
ul {
  padding: 0;
}
</style>
```



## 小贴士：localStorage 是什么？

`localStorage` 是浏览器提供的一种本地数据持久化机制，它以键值对形式存储字符串数据，**不会在页面关闭时清除**，适合用来保存用户的任务列表、设置偏好等信息。

常用 API 有：

- `localStorage.setItem(key, value)`：保存数据
- `localStorage.getItem(key)`：读取数据
- `localStorage.removeItem(key)`：删除某个数据
- `localStorage.clear()`：清空所有数据



## 效果演示

1. 你添加几个任务，然后刷新页面，它们会依然存在。
2. 编辑、删除、切换任务状态后，localStorage 中的内容也会随之更新。

你可以打开浏览器控制台，在「Application」→「Storage」→「Local Storage」中查看 `vue-todos` 键的内容。



## 小结

在本节中，你成功为 ToDo 应用添加了本地存储功能，通过 `localStorage` 实现了数据持久化。至此，一个基本但功能完善的 Vue3 + TypeScript 待办事项应用就构建完成了！

接下来，你可以尝试拓展功能，例如设置任务截止时间、拖动排序、批量操作、夜间模式等。掌握这些技巧将有助于你开发更复杂的前端应用。
