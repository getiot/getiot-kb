---
sidebar_position: 4
authors: [luhuadong]
---

# Taro 项目结构与配置

在你开始使用 Taro 进行跨端开发之前，了解项目的整体结构和配置方式至关重要。本篇文章将带你熟悉 Taro 项目的目录布局，并深入讲解关键配置项，帮助你为后续的开发工作打下坚实的基础。



## 项目目录结构概览

Taro 项目的默认目录结构如下：

```bash
my-taro-app/
├── config/                      # 项目编译配置目录
│   ├── index.ts                 # 通用配置
│   ├── dev.ts                   # 开发环境配置
│   └── prod.ts                  # 生产环境配置
├── dist/                        # 编译输出目录
├── src/                         # 源码目录
│   ├── app.tsx                  # 应用入口文件
│   ├── app.config.ts            # 应用全局配置
│   ├── app.scss                 # 应用全局样式
│   └── pages/                   # 页面目录
│       └── index/               # 示例页面
│           ├── index.tsx        # 页面逻辑
│           ├── index.scss       # 页面样式
│           └── index.config.ts  # 页面配置
├── package.json                 # 项目依赖描述文件
├── tsconfig.json                # TypeScript 配置文件
└── project.config.json          # 小程序项目配置文件（如微信小程序）
```

其中，`src/` 目录用于存放应用的源代码，`config/` 目录用于配置项目的编译行为，`dist/` 目录则是编译后的输出结果。



## 配置文件详解

### `config/index.ts`

这是项目的主配置文件，包含了通用的编译配置。你可以在这里设置项目名称、设计稿宽度、源码目录、输出目录等。

```typescript
import { defineConfig } from '@tarojs/cli';

export default defineConfig({
  projectName: 'my-taro-app',
  date: '2025-04-30',
  designWidth: 750,
  deviceRatio: {
    640: 2.34 / 2,
    750: 1,
    375: 2,
    828: 1.81 / 2,
  },
  sourceRoot: 'src',
  outputRoot: `dist/${process.env.TARO_ENV}`,
  // 其他配置项...
});
```

此外，你还可以在这里配置插件、全局变量、路径别名等。

### `config/dev.ts` 和 `config/prod.ts`

这两个文件分别用于开发环境和生产环境的配置，主要用于覆盖 `index.ts` 中的部分配置。例如，你可以在 `dev.ts` 中设置：

```typescript
export default {
  env: {
    NODE_ENV: '"development"',
  },
  // 其他开发环境特有的配置...
};
```

而在 `prod.ts` 中设置：

```typescript
export default {
  env: {
    NODE_ENV: '"production"',
  },
  // 其他生产环境特有的配置...
};
```

这样可以根据不同的环境进行相应的配置调整。

### `app.config.ts`

这是应用的全局配置文件，用于定义页面路由、窗口表现等。例如：

```typescript
export default {
  pages: ['pages/index/index'],
  window: {
    backgroundTextStyle: 'light',
    navigationBarBackgroundColor: '#fff',
    navigationBarTitleText: 'Taro App',
    navigationBarTextStyle: 'black',
  },
};
```

你可以根据需要添加其他配置项，如 `tabBar`、`subPackages` 等。

### `project.config.json`

这是微信小程序的项目配置文件，用于设置小程序的项目名称、AppID、编译设置等。如果你需要兼容其他小程序平台，可以根据对应平台的要求添加相应的配置文件，例如：

- 百度小程序：`project.swan.json`
- 支付宝小程序：`mini.project.json`
- 字节跳动小程序：`project.tt.json`

这些配置文件的内容需遵循各自平台的规范。



## 小结

通过本篇文章，你了解了 Taro 项目的基本目录结构和关键配置文件的作用。熟悉这些内容将帮助你更高效地进行跨端开发。在后续的开发过程中，合理组织项目结构和配置，将为你的项目带来更好的可维护性和扩展性。
