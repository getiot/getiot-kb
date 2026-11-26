---
sidebar_position: 12
authors: [luhuadong]
---

# Taro 网络请求与数据加载

在开发 Taro 跨端小程序时，网络请求是获取远程数据的主要方式。无论你是从服务器获取文章列表，还是从接口读取用户信息，这一过程都离不开对接口的调用和数据的加载展示。本文将带你一步步掌握 Taro 中如何发起网络请求、如何加载数据以及如何处理请求结果。



## 使用 Taro.request 发起请求

Taro 提供了一个跨平台的请求 API —— `Taro.request`，它对小程序、H5、React Native 等环境做了统一封装，返回的是一个 Promise，非常适合配合 `async/await` 使用。

### 示例：GET 请求

```tsx showLineNumbers
import Taro from '@tarojs/taro'

Taro.request({
  url: 'https://api.example.com/posts',
  method: 'GET'
}).then(res => {
  console.log(res.data)
}).catch(error => {
  console.error('请求失败', error)
})
```

### 使用 async/await

你也可以使用更清晰的 `async/await` 方式：

```tsx showLineNumbers
const fetchPosts = async () => {
  try {
    const res = await Taro.request({
      url: 'https://api.example.com/posts',
      method: 'GET'
    })
    console.log(res.data)
  } catch (error) {
    Taro.showToast({
      title: '加载失败',
      icon: 'none'
    })
  }
}
```



## 在页面中加载数据

在 Taro 中，你可以在页面组件的生命周期中发起网络请求，比如在 `useEffect` 中（如果你使用的是 React 风格），或者在 `onLoad` 生命周期钩子中（使用类组件时）。

### 示例：函数组件加载数据

```tsx showLineNumbers
import { useEffect, useState } from 'react'
import Taro from '@tarojs/taro'

const PostList = () => {
  const [posts, setPosts] = useState([])

  useEffect(() => {
    const loadData = async () => {
      const res = await Taro.request({
        url: 'https://api.example.com/posts'
      })
      setPosts(res.data)
    }

    loadData()
  }, [])

  return (
    <View>
      {posts.map(post => (
        <View key={post.id}>{post.title}</View>
      ))}
    </View>
  )
}
```

### 示例：类组件中加载数据

```tsx showLineNumbers
import Taro from '@tarojs/taro'
import { Component } from 'react'

class PostList extends Component {
  state = {
    posts: []
  }

  componentDidMount() {
    Taro.request({
      url: 'https://api.example.com/posts'
    }).then(res => {
      this.setState({ posts: res.data })
    })
  }

  render() {
    return (
      <View>
        {this.state.posts.map(post => (
          <View key={post.id}>{post.title}</View>
        ))}
      </View>
    )
  }
}
```



## 加载中提示与错误处理

在用户体验方面，你应该为网络请求添加加载中提示，并对失败的请求做出友好提示。

**加载中状态**

```tsx showLineNumbers
const [loading, setLoading] = useState(true)

useEffect(() => {
  const loadData = async () => {
    try {
      const res = await Taro.request({
        url: 'https://api.example.com/posts'
      })
      setPosts(res.data)
    } catch (error) {
      Taro.showToast({
        title: '加载失败',
        icon: 'none'
      })
    } finally {
      setLoading(false)
    }
  }

  loadData()
}, [])

return (
  <View>
    {loading ? <Text>加载中...</Text> : posts.map(post => (
      <View key={post.id}>{post.title}</View>
    ))}
  </View>
)
```



## 统一封装请求逻辑

为了提升项目的可维护性和复用性，建议你将请求逻辑封装成一个独立模块。

**示例：创建 request 封装**

```tsx showLineNumbers
// src/utils/request.ts
import Taro from '@tarojs/taro'

export const request = (options) => {
  return Taro.request({
    ...options,
    header: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${Taro.getStorageSync('token') || ''}`,
      ...options.header
    }
  })
}
```

之后使用时只需：

```tsx showLineNumbers
import { request } from '@/utils/request'

const res = await request({
  url: 'https://api.example.com/posts'
})
```



## 小结

通过本篇内容，你学会了如何在 Taro 中使用 `Taro.request` 发起网络请求，如何在页面中加载并展示数据，以及如何进行错误提示和加载状态处理。掌握这些能力之后，你就可以轻松实现数据驱动的页面展示了。建议你在项目中逐步将请求逻辑进行封装，提高代码的复用性和可维护性。
