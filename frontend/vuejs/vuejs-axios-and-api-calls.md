---
sidebar_position: 23
slug: /vuejs-axios-and-api-calls
---

# Vue Axios 与 API 调用

在本篇文章中，你将学习如何在 Vue 应用中使用 [Axios](https://axios-http.com/) 发起 HTTP 请求，从远程 API 获取数据。你会了解到如何进行 GET、POST 等常见请求方式，并掌握如何处理响应数据、错误信息，甚至是封装 Axios 实例，以便在项目中更优雅地使用。



## 什么是 Axios？

Axios 是一个基于 Promise 的 HTTP 客户端，可以在浏览器和 Node.js 中运行。相比原生的 `fetch`，它提供了更直观的 API、请求和响应拦截器、自动转换 JSON 数据、取消请求等功能，是 Vue 项目中非常流行的网络请求工具。

Promise 对象是 JavaScript 的异步操作解决方案，为异步操作提供统一接口。它起到代理作用（proxy），充当异步操作与回调函数之间的中介，使得异步操作具备同步操作的接口。Promise 可以让异步操作写起来，就像在写同步操作的流程，而不必一层层地嵌套回调函数。



## 安装 Axios

如果你使用的是 Vue 3 + Vite 项目，可以通过以下命令安装：

```bash
npm install axios
```

或者使用 Yarn：

```bash
yarn add axios
```



## 基本使用示例

假设你要从一个公开 API 获取用户数据，可以这样写：

```html showLineNumbers
<script setup>
import axios from 'axios'
import { ref, onMounted } from 'vue'

const users = ref([])

onMounted(async () => {
  try {
    const response = await axios.get('https://jsonplaceholder.typicode.com/users')
    users.value = response.data
  } catch (error) {
    console.error('获取用户数据失败：', error)
  }
})
</script>

<template>
  <ul>
    <li v-for="user in users" :key="user.id">
      {{ user.name }}
    </li>
  </ul>
</template>
```

**说明：**

- `axios.get()`：发起 GET 请求。
- `response.data`：获取返回数据。
- `try...catch`：用于捕获请求中的错误。



## POST 请求示例

如果你需要向服务器提交数据，比如创建一个新用户，可以使用 `axios.post()`：

```tsx showLineNumbers
const newUser = {
  name: 'Alice',
  email: 'alice@example.com'
}

axios.post('https://jsonplaceholder.typicode.com/users', newUser)
  .then(response => {
    console.log('新用户已创建：', response.data)
  })
  .catch(error => {
    console.error('创建用户失败：', error)
  })
```



## 设置全局默认配置

你可以为 Axios 设置一些默认值，例如请求的基础路径或默认请求头：

```tsx showLineNumbers
import axios from 'axios'

axios.defaults.baseURL = 'https://api.example.com'
axios.defaults.headers.common['Authorization'] = 'Bearer token'
```



## 创建 Axios 实例（推荐方式）

在大型项目中，推荐你创建一个专属的 Axios 实例，这样更便于统一配置和管理。

```tsx showLineNumbers title="src/utils/http.js"
import axios from 'axios'

const http = axios.create({
  baseURL: 'https://api.example.com',
  timeout: 5000,
  headers: {
    'Content-Type': 'application/json'
  }
})

// 添加请求拦截器
http.interceptors.request.use(config => {
  // 可在此处添加 token 或日志
  return config
}, error => {
  return Promise.reject(error)
})

// 添加响应拦截器
http.interceptors.response.use(response => {
  return response.data
}, error => {
  console.error('请求出错：', error)
  return Promise.reject(error)
})

export default http
```

然后在组件中这样使用：

```tsx showLineNumbers
import http from '@/utils/http'

const data = await http.get('/users')
```



## 在组件中统一封装 API 请求

你也可以把 API 调用进一步封装成模块：

```tsx showLineNumbers title="src/api/user.js"
import http from '@/utils/http'

export const getUsers = () => http.get('/users')
export const createUser = (payload) => http.post('/users', payload)
```

组件中使用：

```tsx showLineNumbers
import { getUsers } from '@/api/user'

onMounted(async () => {
  const users = await getUsers()
  console.log(users)
})
```



## 错误处理建议

你可以结合 `try...catch` 语句或统一封装的 `errorHandler` 来处理错误，保证用户体验：

```tsx showLineNumbers
try {
  const result = await getUsers()
} catch (err) {
  // 显示错误通知
  alert('请求失败，请稍后重试')
}
```



## 使用 async/await 的最佳实践

- 尽量将请求封装为函数，简化组件中的逻辑；
- 使用 `async/await` 让异步逻辑更清晰；
- 用 `try...catch` 捕获异常，避免未处理的 Promise 报错。



## 小结

通过本篇内容，你掌握了如何在 Vue 项目中使用 Axios 发起 HTTP 请求，包括 GET 和 POST 方法、请求拦截器、封装实例等技巧。这不仅能帮你高效地获取或提交数据，也让你的代码结构更清晰，易于维护。在实际项目中，合理使用 Axios 是构建前后端交互的基础之一。
