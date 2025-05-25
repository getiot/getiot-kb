---
sidebar_position: 3
sidebar_label: 任务添加与删除
slug: /vuejs-demo-todo-task-addition-and-deletion
authors: [luhuadong]
---

# Vue.js 实现 ToDo 应用：任务添加与删除

在这一节中，你将学习如何通过拆分组件的方式，实现待办事项（ToDo）应用中最核心的功能 —— 添加与删除任务。我们将创建两个组件：

- `TodoInput.vue`：用于添加任务的输入框组件。
- `TodoItem.vue`：用于展示和删除每个任务的单个项组件。

项目结构如下：

```bash
src/
├── components/
│   ├── TodoInput.vue
│   └── TodoItem.vue
└── App.vue
```



## TodoInput.vue：任务输入组件

这个组件接收用户输入的任务，并通过 `add` 事件传递给父组件。

**代码示例：**

```html showLineNumbers title="src/components/TodoInput.vue"
<template>
  <div class="todo-input">
    <input
      v-model="newTask"
      @keyup.enter="submitTask"
      type="text"
      placeholder="请输入任务，按 Enter 添加"
    />
    <button @click="submitTask">添加</button>
  </div>
</template>

<script lang="ts" setup>
import { ref } from 'vue'

const newTask = ref('')

const emit = defineEmits<{
  (e: 'add', taskText: string): void
}>()

const submitTask = () => {
  const text = newTask.value.trim()
  if (text) {
    emit('add', text)
    newTask.value = ''
  }
}
</script>

<style scoped>
.todo-input {
  display: flex;
  gap: 8px;
  margin-bottom: 16px;
}
.todo-input input {
  flex: 1;
  padding: 8px;
}
.todo-input button {
  padding: 8px 16px;
}
</style>
```



## TodoItem.vue：任务项组件

这个组件展示一个任务，并提供“删除”按钮，支持通过 `remove` 事件通知父组件删除任务。

**代码示例：**

```html showLineNumbers title="src/components/TodoItem.vue"
<template>
  <li class="todo-item">
    <span>{{ todo.text }}</span>
    <button @click="emit('remove', todo.id)">删除</button>
  </li>
</template>

<script lang="ts" setup>
defineProps<{
  todo: {
    id: number
    text: string
  }
}>()

const emit = defineEmits<{
  (e: 'remove', id: number): void
}>()
</script>

<style scoped>
.todo-item {
  display: flex;
  justify-content: space-between;
  padding: 8px 0;
  border-bottom: 1px solid #eee;
}
.todo-item button {
  padding: 4px 8px;
}
</style>
```



## App.vue：组合逻辑

父组件管理任务列表，接收 `TodoInput` 的添加事件和 `TodoItem` 的删除事件。

```html showLineNumbers title="src/App.vue"
<template>
  <div class="app">
    <h1>📋 我的 ToDo 应用</h1>
    <TodoInput @add="addTodo" />

    <ul>
      <TodoItem
        v-for="todo in todos"
        :key="todo.id"
        :todo="todo"
        @remove="deleteTodo"
      />
    </ul>
  </div>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import TodoInput from './components/TodoInput.vue'
import TodoItem from './components/TodoItem.vue'

interface Todo {
  id: number
  text: string
}

const todos = ref<Todo[]>([])

const addTodo = (text: string) => {
  todos.value.push({
    id: Date.now(),
    text
  })
}

const deleteTodo = (id: number) => {
  todos.value = todos.value.filter(todo => todo.id !== id)
}
</script>

<style scoped>
.app {
  max-width: 500px;
  margin: 0 auto;
  padding: 20px;
}
</style>
```

启动项目：

```bash showLineNumbers
npm run dev
```

打开浏览器访问 `http://localhost:5173`，你将看到 Todo 应用的页面，你可以在这里添加或删除待办事项。

![Vue Todo 应用](https://static.getiot.tech/vue-todo-app-01.webp#center)



## 注意事项

本项目为了教学考虑，没有添加 views 和 router 等子目录，逻辑直接写在 `App.vue` 里（单页应用）。在实际项目开发中，如果需要扩展为多页面应用，可以再引入 `vue-router`，并将逻辑拆分到 `views/` 下，不要把所有逻辑都堆在 `App.vue` 里，避免变成“巨无霸组件”。



## 小结

通过将输入框和任务项分别封装成 `TodoInput.vue` 与 `TodoItem.vue`，你不仅实现了任务的添加与删除功能，还使项目结构更加清晰、易于维护。每个组件职责单一，利于后续扩展，比如添加“完成状态”、“编辑任务”等功能。
