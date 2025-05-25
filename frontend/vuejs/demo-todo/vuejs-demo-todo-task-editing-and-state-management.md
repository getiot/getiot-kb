---
sidebar_position: 4
sidebar_label: 任务编辑与状态管理
slug: /vuejs-demo-todo-task-editing-and-state-management
authors: [luhuadong]
---

# Vue.js 实现 ToDo 应用：任务编辑与状态管理

在前一步中，你已经完成了基本的任务添加与删除功能，现在我们将继续实现以下功能：

- **任务状态管理**（勾选完成 / 未完成）；
- **任务编辑**（双击文本进行修改）；
- **任务过滤显示**（通过两个复选框筛选“已完成”和“未完成”任务）；
- **为已完成任务添加删除线样式**。

我们依旧使用组件化思维，保持 `TodoInput.vue`、`TodoItem.vue` 和 `TodoFilter.vue` 的职责清晰。



## TodoFilter.vue：添加过滤器功能

首先，你需要在 src/components 目录中添加 TodoFilter.vue 文件（如果还没有）， `TodoFilter.vue` 组件用于切换当前任务视图的过滤状态。它会发出两个布尔值：`showCompleted` 和 `showPending`，分别代表是否显示“已完成”和“未完成”的任务。

示例代码：

```html showLineNumbers title="src/components/TodoFilter.vue"
<template>
  <div class="filters">
    <label>
      <input
        type="checkbox"
        :checked="showPending"
        @change="togglePending"
      />
      显示未完成
    </label>
    <label>
      <input
        type="checkbox"
        :checked="showCompleted"
        @change="toggleCompleted"
      />
      显示已完成
    </label>
  </div>
</template>

<script setup lang="ts">
/**
 * 接收外部父组件传入的两个布尔状态：
 * - showPending：是否显示未完成的任务
 * - showCompleted：是否显示已完成的任务
 */
defineProps<{
  showPending: boolean
  showCompleted: boolean
}>()

/**
 * 定义双向绑定所需的 emit 事件格式（使用 v-model 的语法糖形式）
 * - 'update:showPending'：当“未完成”复选框变动时通知父组件更新值
 * - 'update:showCompleted'：当“已完成”复选框变动时通知父组件更新值
 */
const emit = defineEmits<{
  (e: 'update:showPending', value: boolean): void
  (e: 'update:showCompleted', value: boolean): void
}>()

/**
 * 当用户勾选 / 取消勾选“未完成”复选框时，触发此函数
 */
const togglePending = (e: Event) => {
  emit('update:showPending', (e.target as HTMLInputElement).checked)
}

/**
 * 当用户勾选 / 取消勾选“已完成”复选框时，触发此函数
 */
const toggleCompleted = (e: Event) => {
  emit('update:showCompleted', (e.target as HTMLInputElement).checked)
}
</script>

<style scoped>
.filters {
  margin: 1em 0;
  display: flex;
  gap: 1em;
}
label {
  cursor: pointer;
  font-size: 14px;
}
</style>
```



## TodoItem.vue：支持编辑与状态切换

为了支持编辑和完成状态切换，我们在 `TodoItem.vue` 中添加以下逻辑：

```html showLineNumbers title="src/components/TodoItem.vue"
<template>
  <li :class="{ done: todo.done }">
    <!-- 勾选框：用于切换任务完成状态 -->
    <input
      type="checkbox"
      :checked="todo.done"
      @change="() => emit('toggle', todo.id)"
    />
    
    <!-- 展示模式：双击进入编辑模式 -->
    <span v-if="!isEditing" @dblclick="startEdit">{{ todo.text }}</span>
    
    <!-- 编辑模式：输入框编辑任务内容，按回车或失焦保存 -->
    <input
      v-else
      v-model="editText"
      @blur="submitEdit"
      @keyup.enter="submitEdit"
      @keyup.esc="cancelEdit"
      ref="inputRef"
    />
    
    <!-- 删除按钮 -->
    <button @click="() => emit('remove', todo.id)">删除</button>
  </li>
</template>

<script setup lang="ts">
import { ref, nextTick } from 'vue'

// 定义 props，接收父组件传入的 todo 对象
const props = defineProps<{
  todo: {
    id: number
    text: string
    done: boolean
  }
}>()

// 定义事件 emit 类型
const emit = defineEmits<{
  (e: 'toggle', id: number): void
  (e: 'remove', id: number): void
  (e: 'edit', payload: { id: number; text: string }): void
}>()

const isEditing = ref(false) // 控制是否处于编辑模式
const editText = ref('')     // 编辑框的文本
const inputRef = ref<HTMLInputElement | null>(null) // 引用输入框元素，用于聚焦

// 进入编辑模式
const startEdit = () => {
  isEditing.value = true
  editText.value = props.todo.text
  nextTick(() => inputRef.value?.focus()) // 下一个 tick 后聚焦输入框
}

// 提交编辑结果
const submitEdit = () => {
  if (editText.value.trim()) {
    emit('edit', { id: props.todo.id, text: editText.value.trim() })
  }
  isEditing.value = false
}

// 取消编辑（按 ESC）
const cancelEdit = () => {
  isEditing.value = false
}
</script>

<style scoped>
li {
  list-style: none;
  display: flex;
  justify-content: space-between;
  padding: 8px 0px;
  border-bottom: 1px solid #eee;
}
li button {
  padding: 4px 8px;
  font-size: 0.8rem;
}
/* 已完成任务样式：加删除线、灰色文字 */
.done span {
  text-decoration: line-through;
  color: #999;
}
</style>
```



## App.vue：整合状态管理

我们在 `App.vue` 中添加以下逻辑，实现任务过滤、编辑、状态切换的完整流程。

```html showLineNumbers {5-8,26} title="App.vue"
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
import { ref, computed } from 'vue'
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

const addTodo = (text: string) => {
  todos.value.push({
    id: Date.now(),
    text,
    done: false,
  })
}

// 切换任务完成状态
const toggleTodo = (id: number) => {
  const todo = todos.value.find((t) => t.id === id)
  if (todo) todo.done = !todo.done
}

const removeTodo = (id: number) => {
  todos.value = todos.value.filter((t) => t.id !== id)
}

// 编辑任务内容
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



## 演示效果

打开浏览器访问 `http://localhost:5173`，你将看到 Todo 应用的页面，你可以在这里进行添加或删除待办事项、设置事项状态、根据状态过滤显示，以及编辑事项等操作。

![Vue Todo 应用](https://static.getiot.tech/vue-todo-app-02.webp#center)



## 小结

本节中，你实现了对 ToDo 应用的状态管理功能，允许用户通过两个复选框筛选已完成和未完成的任务，并通过样式直观区分状态。你还为任务项增加了编辑功能，使用户可以通过双击进行修改。整个功能在结构上保持组件职责清晰，逻辑简单易懂，非常适合初学者学习 Vue 组件与状态管理的实践方式。下一步我们可以实现本地存储功能，保留刷新后的待办事项。
