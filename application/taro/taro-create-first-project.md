---
sidebar_position: 3
authors: [luhuadong]
---

# 创建第一个 Taro 项目

本文将带你动手创建第一个 Taro 项目。从使用 CLI 初始化项目，到项目结构解析，再到运行和预览，这一节会让你完成从“0”到“可运行”的第一步。



## 初始化项目

确保你已经全局安装了 `@tarojs/cli`，然后在命令行中执行以下命令：

```bash
taro init my-taro-app
```

`my-taro-app` 是你项目的文件夹名称，你可以自定义为任何你喜欢的名字。

接下来 CLI 会引导你进行一系列配置，例如：

- 项目名称
- 项目介绍
- 使用的框架（React / PReact / Vue3 / Solid）
- 是否使用 TypeScript
- CSS 预处理器（Sass / Less / Stylus）
- 包管理工具（yarn / pnpm / npm / cnpm）
- 编译工具（Webpack5 / Vite）
- 模板源（Gitee / GitHub / CLI 内置默认模板 / 自定义 / 社区优质模板源）
- 状态管理方案（MobX / Redux / Recoil / 不使用）
- 是否启用 ESLint / Prettier 等代码规范工具

建议选择：

- 框架：React
- 是否使用 TypeScript：是
- CSS 预处理器：Sass
- 状态管理：MobX（简单易用，适合初学者）

配置完成后，Taro CLI 会自动生成项目结构，并帮你安装依赖。

```bash
👽 Taro v4.0.12

Taro 即将创建一个新项目!
Need help? Go and open issue: https://tls.jd.com/taro-issue-helper

? 请输入项目介绍 我的第一个Taro项目
? 请选择框架 React
? 是否需要使用 TypeScript ？ Yes
? 是否需要编译为 ES5 ？ No
? 请选择 CSS 预处理器（Sass/Less/Stylus） Sass
? 请选择包管理工具 npm
? 请选择编译工具 Webpack5
? 请选择模板源 Gitee（最快）
✔ 拉取远程模板仓库成功！
...
✔ 初始化 git 成功
执行安装项目依赖 npm install, 需要一会儿...
...
✔ 安装项目依赖成功
创建项目 my-taro-app 成功！
请进入项目目录 my-taro-app 开始工作吧！😝
```



## 项目结构解析

初始化完成后，你会看到如下目录结构：

```bash
my-taro-app/
├── config/              # 各平台编译配置
├── src/                 # 项目源码目录
│   ├── pages/           # 页面文件
│   └── app.tsx          # 应用入口
├── project.config.json  # 微信小程序项目配置
├── package.json         # 项目信息及依赖
└── ...
```

其中 `src/pages` 是你放置页面组件的地方，Taro 默认会创建一个首页页面 `index`，你可以修改或添加更多页面。



## 运行项目

进入项目目录，执行以下命令：

```bash
cd my-taro-app
npm run dev:weapp
```

这个命令会启动开发服务器，并将代码编译为微信小程序格式。Taro 会自动在 `dist` 目录下生成小程序代码。

你可以使用 [**微信开发者工具**](/mp/wechat-miniprogram-devtools/) 打开 `dist` 目录，即可进行预览和调试。

你也可以构建其他平台，例如：

```bash
npm run dev:h5       # 运行 H5 版本
npm run dev:alipay   # 运行支付宝小程序版本
npm run dev:tt       # 运行抖音小程序版本
```

:::tip

如果你使用的是 pnpm 或 yarn，请将命令中的 `npm run` 替换为对应的命令，如 `pnpm dev:weapp`。

:::



### 开启压缩构建

当你运行 `npm run dev:weapp` 时，Taro 默认处于开发环境（`NODE_ENV=development`）。此时生成的文件不会进行压缩处理，目的是为了更快地编译、更方便地调试（例如更清晰的错误提示、保留源码注释等）。

但开发环境下生成的 JS、CSS 文件体积比较大，如果你在真机上预览，加载速度可能会比较慢，甚至受限于小程序体积上限。这时候，你可以通过设置 `NODE_ENV` 为 `production` 来开启压缩构建，例如：

```bash
NODE_ENV=production taro build --type weapp --watch
```

命令参数说明：

- `NODE_ENV=production`：设置为生产环境，启用代码压缩、Tree Shaking 等优化。
- `--type weapp`：构建微信小程序。
- `--watch`：持续监听文件改动，自动增量编译。

:::warning

Windows 用户无法直接使用 `NODE_ENV=production` 这种写法，你可以使用如下方式：

```bash
set NODE_ENV=production && taro build --type weapp --watch
```

:::

### 开启缓存功能

每次运行项目时，Taro CLI 都需要将源码编译为目标平台代码，这个过程涉及 Babel 转换、样式处理、模块打包等多个步骤。默认情况下，Taro 不会保存每次编译的中间结果。如果你频繁保存文件或重启开发服务，每次都要“从头开始”编译，浪费时间。

这时候，你可以在项目根目录下的 `config/index.ts` 中添加如下配置：

```typescript showLineNumbers
cache: {
  enable: true
}
```

这样做的好处是：Taro 会将中间构建结果缓存到本地，之后的编译速度会明显提升，特别是对于大型项目或多页面项目效果更明显。



### 避免覆盖 dist 目录

Taro 默认将所有平台的构建输出到 `dist/` 目录下的根路径，这会导致构建其他端时会覆盖 `dist/` 目录，造成不便。为了解决该问题，你需要设置 `outputRoot` 参数，配置每个平台独立的输出目录。例如：

```typescript showLineNumbers {4,8,14} title="config/index.ts"
const config = {
  // 通用配置
  sourceRoot: 'src',
  outputRoot: 'dist', // 默认输出目录

  // 小程序配置
  mini: {
    outputRoot: 'dist/weapp',
    // 其他配置...
  },

  // H5 配置
  h5: {
    outputRoot: 'dist/h5',
    // 其他配置...
  },

  // 其他平台配置...
};
```

在 Taro 新版本中，你还可以通过环境变量动态控制输出目录，这种配置方式会更加简洁。例如：

```typescript showLineNumbers {2}
const config = {
  outputRoot: `dist/${process.env.TARO_ENV}`,
  // 其他配置...
};
```



## 修改首页内容

打开 `src/pages/index/index.tsx`，你会看到类似如下的代码：

```tsx showLineNumbers {7}
import { View, Text } from '@tarojs/components'
import './index.scss'

export default function Index() {
  return (
    <View className="index">
      <Text>这是我的第一个 Taro 项目</Text>
    </View>
  )
}
```

你可以将其中的文字修改为自己的内容，保存后开发者工具会自动刷新。



## 添加页面路由

Taro 使用配置式路由。在 `src/app.config.ts` 中可以看到默认配置：

```typescript showLineNumbers
export default defineAppConfig({
  pages: [
    'pages/index/index'
  ],
  window: {
    navigationBarTitleText: '首页',
    backgroundTextStyle: 'light'
  }
})
```

如果你想添加一个新页面，例如 `about`，只需在 `src/pages` 下创建 `about/index.tsx`，然后将其路径加到 `pages` 数组中即可：

```typescript showLineNumbers
pages: [
  'pages/index/index',
  'pages/about/index'
]
```

保存后重新编译项目，就可以在开发者工具中看到新页面了。



## 小结

这一节中，你完成了第一个 Taro 项目的初始化、运行与修改。你不仅了解了项目的基本结构，还学会了添加页面和修改内容。接下来，你将继续学习组件、样式与路由跳转等核心功能，一步步构建自己的多端应用。
