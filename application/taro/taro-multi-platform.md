---
sidebar_position: 13
authors: [luhuadong]
---

# Taro 跨平台适配

在 Taro 中开发的最大优势之一就是“跨平台能力”。只需一套代码，你就可以同时发布到微信小程序、H5、React Native、支付宝小程序等多个平台。但要想真正做到“写一次、跑多端”，你需要了解 Taro 提供的跨平台适配机制，并掌握一些最佳实践。本文将带你了解 Taro 如何实现跨平台适配，以及你该如何写出兼容性良好的代码。



## Taro 支持的平台有哪些？

Taro 支持的主流平台包括：

- 微信小程序（Weapp）
- 支付宝小程序（Alipay）
- 字节跳动小程序（TT）
- 百度小程序（Swan）
- QQ 小程序（QQ）
- H5（Web 端）
- React Native（移动端 App）
- 快应用（快手、华为等）

你只需通过配置文件来指定编译目标，无需为每个平台单独维护代码。



## 统一的组件与 API 抽象

Taro 抽象了小程序和 Web、原生 App 的差异，在组件层和 API 层进行了统一封装：

- 组件：你可以直接使用 Taro 提供的组件，比如 `<View>`、`<Text>`、`<Button>` 等，它们在不同平台上会被编译成对应平台原生的组件。
- API：比如 `Taro.request`、`Taro.navigateTo`、`Taro.showToast` 等 API，会自动适配不同平台的原生调用。

**示例：**

```tsx showLineNumbers
import Taro from '@tarojs/taro'
import { View, Button } from '@tarojs/components'

export default function Home() {
  const handleClick = () => {
    Taro.showToast({
      title: '操作成功',
      icon: 'success'
    })
  }

  return (
    <View>
      <Button onClick={handleClick}>点击提示</Button>
    </View>
  )
}
```



## 平台差异化处理方式

虽然 Taro 尽量统一了大多数接口，但有些平台之间仍存在差异。Taro 提供了以下几种方式帮助你做差异化处理。

### 使用 `TARO_ENV` 判断平台

你可以使用 `process.env.TARO_ENV` 来判断当前的平台，从而根据平台环境条件执行不同逻辑，或加载不同组件。例如：

```tsx showLineNumbers
if (process.env.TARO_ENV === 'weapp') {
  console.log('当前是微信小程序')
} else if (process.env.TARO_ENV === 'h5') {
  console.log('当前是 H5 页面')
}
```

### 使用条件编译

条件编译只会在编译阶段保留对应平台的代码，这种方法推荐在业务逻辑差异较大时使用。

```tsx showLineNumbers
// #ifdef h5
console.log('仅在 H5 上生效')
// #endif

// #ifdef weapp
console.log('仅在微信小程序上生效')
// #endif
```

### 使用平台特定的组件或包裹组件

如果某个平台有独特的组件（例如支付、地图等），你可以封装成子组件，并结合 `TARO_ENV` 动态渲染。



## 样式适配建议

不同平台对样式支持程度也有所不同，以下是一些样式适配建议：

- 使用 Taro 推荐的尺寸单位（如 `px`、`rpx`），不要使用 `vw`、`vh`。
- 使用 Flex 布局可以提升不同平台的一致性。
- 尽量使用内联样式或模块化样式（推荐 CSS Modules）。
- 注意字体大小、按钮点击区域等在不同平台的表现差异。



## 适配 React Native 的注意事项

Taro 对 RN 支持得比较好，但要注意以下事项：

- 一些 Web 专属 API（如 `window`、`document`）在 RN 中不可用。
- UI 表现和小程序可能存在明显差异，建议你在样式设计上留有一定弹性。
- Taro 编译到 RN 端时，依赖的是 React Native 本身的组件库，而不是小程序组件的模拟。



## 配置多端编译

你可以通过 `config/index.ts` 文件配置不同平台的构建设置，例如：

```tsx showLineNumbers
const config = {
  projectName: 'myApp',
  designWidth: 750,
  deviceRatio: {
    640: 1.17,
    750: 1,
    828: 0.905
  },
  // H5 配置
  h5: {
    publicPath: '/',
    staticDirectory: 'static',
    esnextModules: ['taro-ui']
  },
  // 微信小程序配置
  weapp: {
    postcss: {
      autoprefixer: {
        enable: true
      }
    }
  }
}
```

你也可以使用命令行直接构建目标平台：

```bash
# 编译到微信小程序
npm run dev:weapp

# 编译到 H5
npm run dev:h5
```



## 小结

通过本篇内容，你了解了 Taro 跨平台适配的原理和实践方法，包括统一组件与 API、条件编译、样式适配及平台差异处理等。只要你遵循 Taro 的最佳实践，就能更高效地开发出跨多个平台运行的应用。下一步建议你尝试将你的项目发布到两个平台上，亲自体验 Taro 的跨端能力。是否跨端成功，是验证你对 Taro 理解程度的重要一步。
