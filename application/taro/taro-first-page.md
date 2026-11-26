---
sidebar_position: 5
authors: [luhuadong]
---

# Taro 编写第一个页面

在完成了项目的初始化和配置之后，接下来你将学习如何在 Taro 中创建并编写第一个页面。本篇文章将指导你使用 TypeScript 和 React 编写一个简单的页面组件，并介绍相关的配置方法，帮助你迈出 Taro 开发的第一步。



## 创建新页面

Taro 提供了 CLI 工具来快速创建新页面。你可以使用以下命令在 `src/pages` 目录下生成一个名为 `home` 的页面：

```bash
taro create --name home
```

执行该命令后，Taro 会在 `src/pages/home/` 目录下生成以下文件：

- `index.tsx`：页面组件
- `index.scss`：页面样式
- `index.config.ts`：页面配置



## 编写页面组件

打开 `src/pages/home/index.tsx` 文件，编写你的第一个页面组件：

```tsx showLineNumbers
import { View, Text } from '@tarojs/components'
import { useLoad } from '@tarojs/taro'
import './index.scss'

export default function Home () {
  useLoad(() => {
    console.log('Page loaded.')
  })

  return (
    <View className='home'>
      <Text className="title">这是首页</Text>
    </View>
  )
}
```

在上述代码中，我们使用了 Taro 提供的跨平台组件 `View` 和 `Text` 来构建页面结构。你可以根据需要添加更多的组件和逻辑。



## 修改页面样式

在 `src/pages/home/index.scss` 中添加以下样式：

```scss showLineNumbers
.home {
  background-color: orange;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}

.title {
  color: white;
  font-size: 24px;
}
```

说明：

- 这种方式是最简单的样式使用方式，适合初学者。
- `className="home"` 传入的是字符串，对应的是全局样式作用域，多个页面使用同名类时可能会出现样式冲突。
- 如果项目变得复杂，建议考虑引入 CSS Modules 或其他样式隔离机制。



## 配置页面信息

在 `src/pages/home/home.config.ts` 文件中，你可以设置页面的导航栏标题等信息：

```typescript showLineNumbers
export default definePageConfig({
  navigationBarTitleText: '首页'
})
```

`definePageConfig` 是 Taro 提供的函数，用于定义页面的配置。你可以在这里设置导航栏的标题、背景色、文字颜色等属性。



## 注册页面路由

要使新创建的页面生效，需要在全局配置文件 `src/app.config.ts` 中注册该页面的路由：

```typescript showLineNumbers
export default defineAppConfig({
  pages: [
    'pages/index/index', 
    'pages/home/index'
  ],
  window: {
    backgroundTextStyle: 'light',
    navigationBarBackgroundColor: '#fff',
    navigationBarTitleText: 'Taro App',
    navigationBarTextStyle: 'black'
  }
});
```

确保页面路径与实际文件路径一致。Taro 会根据 `pages` 数组中的顺序来决定页面的加载顺序。



## 启动项目并预览页面

完成上述步骤后，你可以启动项目并预览新创建的页面：

```bash
npm run dev:weapp
```

然后，使用微信开发者工具打开项目根目录下的 `dist` 文件夹，即可预览小程序页面。



## 小结

通过本篇文章，你学习了如何在 Taro 项目中创建并编写一个新的页面组件，了解了页面组件的结构、配置方法以及如何注册路由。掌握这些基础知识将为你后续的 Taro 开发打下坚实的基础。
