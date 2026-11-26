---
sidebar_position: 11
authors: [luhuadong]
---

# Taro 调用 API 与本地存储

在 Taro 中，你可以像在微信小程序中一样，调用各种内置 API，例如发起网络请求、获取设备信息、操作本地存储等。本章将带你了解如何使用 Taro 提供的 API，并通过具体示例掌握基本用法，帮助你更好地与系统能力或后端服务进行交互。



## Taro API 简介

Taro 对原生小程序 API 做了统一封装，提供了一套跨平台的 API 接口。你可以通过 `import Taro from '@tarojs/taro'` 引入 Taro 核心对象，然后调用其方法，例如：

```tsx showLineNumbers
import Taro from '@tarojs/taro'

Taro.getSystemInfo().then(res => {
  console.log(res)
})
```

API 通常都返回一个 Promise，使得异步操作更符合现代开发习惯。



## 网络请求：Taro.request

最常用的 API 之一就是发起网络请求。Taro 提供的 `Taro.request` 方法类似于浏览器的 `fetch` 或小程序的 `wx.request`，支持各种请求方法。

### 示例：GET 请求

```tsx showLineNumbers
import Taro from '@tarojs/taro'

Taro.request({
  url: 'https://api.example.com/user',
  method: 'GET',
  data: {
    id: 123
  }
}).then(res => {
  console.log('用户信息：', res.data)
})
```

### 示例：POST 请求

```tsx showLineNumbers
Taro.request({
  url: 'https://api.example.com/login',
  method: 'POST',
  data: {
    username: 'test',
    password: '123456'
  },
  header: {
    'content-type': 'application/json'
  }
}).then(res => {
  console.log('登录结果：', res.data)
})
```

### 错误处理

你可以使用 `try...catch` 或 `catch` 语句对请求失败进行处理：

```tsx showLineNumbers
try {
  const res = await Taro.request({ url: '...' })
  console.log(res)
} catch (err) {
  Taro.showToast({
    title: '请求失败',
    icon: 'none'
  })
}
```



## 常用 API 示例

除了请求接口，你还会经常用到以下 Taro API：

#### 获取系统信息

```tsx showLineNumbers
Taro.getSystemInfo().then(res => {
  console.log('设备信息：', res)
})
```

#### 获取当前定位

```tsx showLineNumbers
Taro.getLocation({ type: 'wgs84' }).then(res => {
  console.log('经纬度：', res.latitude, res.longitude)
})
```

#### 显示消息提示

```tsx showLineNumbers
Taro.showToast({
  title: '操作成功',
  icon: 'success',
  duration: 2000
})
```

#### 设置页面标题

```tsx showLineNumbers
Taro.setNavigationBarTitle({
  title: '我的页面'
})
```

#### 本地存储和读取

```tsx showLineNumbers
// 存储
Taro.setStorage({ key: 'token', data: 'abc123' })

// 读取
Taro.getStorage({ key: 'token' }).then(res => {
  console.log(res.data)
})

// 删除单个存储项
Taro.removeStorage({ key: 'token' })

// 清空所有本地存储
Taro.clearStorage()
```



## 使用 async/await 简化代码

你可以在支持 `async/await` 的环境下，用更清晰的方式调用 API：

```tsx showLineNumbers
const getUserInfo = async () => {
  try {
    const res = await Taro.request({ url: 'https://api.example.com/user' })
    console.log(res.data)
  } catch (err) {
    Taro.showToast({ title: '获取失败', icon: 'none' })
  }
}
```

注意：在使用 `await` 时必须处于 `async` 函数中。



## 开发提示

- 所有 Taro API 都是 Promise 风格，更加易于链式调用和错误处理。
- 如果你需要更高层封装的网络库（例如 axios），也可以配合使用，但需要注意兼容性和平台适配。
- 有些 API 只能在特定平台调用，比如某些仅支持微信或支付宝小程序的能力，建议先查阅官方文档确认支持情况。



## 小结

本章介绍了如何在 Taro 中调用内置 API，尤其是如何使用 `Taro.request` 发送网络请求。你还学习了如何操作本地存储、获取系统信息、调用界面提示等常用功能。掌握这些 API，你就能更好地与后端服务或系统能力对接，提升小程序的交互体验和功能完整度。
