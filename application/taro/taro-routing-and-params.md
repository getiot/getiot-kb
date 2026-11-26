---
sidebar_position: 10
authors: [luhuadong]
---

# Taro 页面路由与参数传递

在 Taro 应用中，你通常会将功能划分为多个页面。为了让用户在页面之间切换，你需要掌握页面路由的使用方法，以及如何在页面间传递参数。本章将介绍 Taro 的页面路由机制、跳转方式和参数获取方式，帮助你构建具有导航能力的应用结构。



## 页面配置

首先，你需要在项目的配置文件中声明页面路径。

假设你有两个页面：`pages/home/index.tsx` 和 `pages/detail/index.tsx`，你需要在 `src/app.config.ts` 中这样配置：

```tsx showLineNumbers title="src/app.config.ts"
export default defineAppConfig({
  pages: [
    'pages/home/index',
    'pages/detail/index'
  ]
})
```

配置完成后，Taro 就知道这些页面是你的应用入口，可以进行路由跳转。



## 页面跳转方式

Taro 提供了多种跳转 API，你可以根据场景选择：

| 方法                | 描述                               |
| ------------------- | ---------------------------------- |
| `Taro.navigateTo`   | 保留当前页面，跳转到新页面（常用） |
| `Taro.redirectTo`   | 关闭当前页面，跳转到新页面         |
| `Taro.switchTab`    | 切换到 tabBar 页面                 |
| `Taro.reLaunch`     | 关闭所有页面并跳转                 |
| `Taro.navigateBack` | 返回上一级页面                     |



## 示例：跳转并传参

在 `home` 页面中点击按钮跳转到 `detail` 页面，并传递参数：

```tsx showLineNumbers
import { View, Button } from '@tarojs/components'
import Taro from '@tarojs/taro'

export default function Home() {
  const handleClick = () => {
    Taro.navigateTo({
      url: '/pages/detail/index?id=123&name=Alice'
    })
  }

  return (
    <View>
      <Button onClick={handleClick}>查看详情</Button>
    </View>
  )
}
```



## 在目标页面获取参数

在 `detail` 页面中，你可以使用 Taro 的 `useRouter` Hook 获取传递过来的参数：

```tsx showLineNumbers
import { useRouter } from '@tarojs/taro'
import { View, Text } from '@tarojs/components'

export default function Detail() {
  const router = useRouter()
  const { id, name } = router.params

  return (
    <View>
      <Text>用户 ID：{id}</Text>
      <Text>用户姓名：{name}</Text>
    </View>
  )
}
```

注意：`router.params` 中的值始终是字符串类型，即使你传的是数字，也需要自己转换。



## 页面返回

当你想从子页面返回上一级页面时，可以使用：

```tsx showLineNumbers
Taro.navigateBack()
```

你也可以指定返回几级页面，例如返回两层：

```tsx showLineNumbers
Taro.navigateBack({ delta: 2 })
```



## 使用 switchTab 切换 tabBar 页面

如果你在 `app.config.ts` 中配置了 tabBar 页面，如：

```tsx showLineNumbers
tabBar: {
  list: [
    { pagePath: 'pages/home/index', text: '首页' },
    { pagePath: 'pages/profile/index', text: '我的' }
  ]
}
```

你只能使用 `Taro.switchTab` 进行跳转，不能用 `navigateTo` 或 `redirectTo`，否则会报错。

```tsx showLineNumbers
Taro.switchTab({ url: '/pages/profile/index' })
```



## 小结

本章介绍了 Taro 中页面路由的配置方法，以及如何使用 `navigateTo`、`redirectTo`、`switchTab` 等跳转 API 实现页面导航。你还学会了如何通过 URL 查询参数在页面之间传递信息，并使用 `useRouter` 获取参数。理解这些内容后，你就能灵活控制页面跳转和参数交互，为构建多页面小程序打下基础。
