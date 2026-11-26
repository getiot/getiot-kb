---
sidebar_position: 6
authors: [luhuadong]
---

# Taro 使用组件构建界面

在这一节中，你将学习如何使用 Taro 提供的内置组件来构建小程序界面。我们会介绍几种常见的 UI 组件，包括视图容器、文本、图片、按钮等，并展示它们在页面中的基本用法。通过这些内容，你将掌握如何用组件拼搭出完整的用户界面。



## 组件化开发理念

在 Taro 中，页面 UI 是由一个个组件组成的。组件类似于积木块，每一块负责特定的结构或功能。Taro 本身提供了一套与微信小程序标准对齐的跨平台组件 API，你可以在多个端上保持一致的使用体验。

Taro 的组件主要分为两类：

- **基础组件**：如 `View`、`Text`、`Image`、`Button` 等；
- **表单组件**：如 `Input`、`Picker`、`Checkbox` 等。



## View 和 Text 组件

最常用的容器类组件是 `View`，你可以把它理解为一个通用的块级容器（相当于 HTML 中的 `<div>` 标签）。而 `Text` 用于显示文本内容（相当于 HTML 中的 `span` 或 `p`）。

```tsx showLineNumbers
import { View, Text } from '@tarojs/components'

export default function Home() {
  return (
    <View style={{ backgroundColor: 'orange', padding: '20px' }}>
      <Text style={{ color: '#fff', fontSize: '20px' }}>欢迎使用 Taro！</Text>
    </View>
  )
}
```

样式可以使用内联形式，也可以通过样式表 `.scss` 引入。



## Image 组件

用于显示图片，可以通过 `src` 属性指定路径。

```tsx showLineNumbers
import { Image } from '@tarojs/components'

export default function Banner() {
  return (
    <Image
      src="https://example.com/banner.png"
      style={{ width: '100%', height: '200px' }}
      mode="widthFix"
    />
  )
}
```

Taro 支持多种 `mode` 属性，用于控制图片的裁剪和缩放行为，例如 `aspectFill`、`scaleToFill`、`widthFix` 等。



## Button 组件

用于交互操作的按钮：

```tsx showLineNumbers
import { Button } from '@tarojs/components'

export default function ActionButton() {
  const handleClick = () => {
    console.log('按钮被点击了')
  }

  return (
    <Button type="primary" onClick={handleClick}>
      点击我
    </Button>
  )
}
```

Taro 的按钮支持多种类型，包括 `primary`、`default`、`warn`，同时支持绑定事件，例如 `onClick`。



## 实践示例：构建一个首页

下面我们在之前创建的 `src/pages/home/index.tsx` 页面中，尝试组合使用多个组件，构建一个简单的首页界面。

修改 `index.tsx`，如下：

```tsx showLineNumbers title="src/pages/home/index.tsx"
import { View, Text, Image, Button } from '@tarojs/components'
import Taro from '@tarojs/taro'
import './index.scss'

export default function Home () {

  const handleClick = () => {
    Taro.showToast({
      title: '你点击了按钮',
      icon: 'success'
    })
  }

  return (
    <View className='home-container'>
      <Image
        className="home-banner"
        src="https://static.getiot.tech/getiot-banner-2020.webp"
        mode="widthFix"
      />
      <Text className="home-title">这是首页</Text>
      <Button className="home-button" type="primary" onClick={handleClick}>
        点我试试看
      </Button>
    </View>
  )
}
```

修改 `index.scss`，如下：

``` scss showLineNumbers title="src/pages/home/index.scss"
.home-container {
  background-color: orange;
  padding: 30px;
  text-align: center;
}

.home-banner {
  width: 100%;
  margin-bottom: 20px;
}

.home-title {
  font-size: 20px;
  color: #fff;
  margin-bottom: 20px;
}

.home-button {
  background-color: #fff !important;
  color: orange;
}
```

运行后，打开 `http://localhost:10086/#/pages/home/index` 网页，你将看到包含顶部横幅图片、欢迎文本、一个按钮的页面。点击按钮，你还可以看到按钮的反馈信息。现在你已经使用 Taro 的组件构建出了自己的第一个界面！

![使用组件构建的 Taro 页面](https://static.getiot.tech/taro-first-page-demo.webp#center)



## 小结

本节内容带你认识并实践了 Taro 中的常见组件用法，并通过一个实际页面案例将组件组合在一起构建出可交互的 UI。掌握组件的使用是 Taro 开发的核心之一，在后续学习中你将进一步了解组件之间如何协作、如何进行复用和抽象等内容。
