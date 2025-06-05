---
sidebar_position: 1
slug: /nuxtjs-intro
authors: [luhuadong]
---

# Nuxt.js 框架简介

**Nuxt.js** 是一个基于 Vue.js 的高层级框架，用于构建现代 Web 应用。它为 Vue 应用添加了很多实用的默认配置和目录结构规范，能够帮助你快速开发支持服务端渲染（SSR）、静态网站生成（SSG）、单页应用（SPA）等类型的 Vue 应用。

一句话总结：Nuxt 是 Vue 的“增强版”，为你处理好开发、构建和部署中常见的复杂问题。



## Nuxt 和 Vue 的关系

下图展示了 Nuxt 和 Vue 的关系：

```
  ┌────────────┐
  │  Vue.js    │ ← 渲染层库（响应式 + 组件化）
  └────┬───────┘
       │
       ▼
  ┌────────────┐
  │  Nuxt.js   │ ← 基于 Vue 构建的应用框架（SSR/SSG/Vite/路由/状态管理）
  └────────────┘
```



## Nuxt.js 的起源

2016年10月25日，Vercel 公司首次在 GitHub 发布了一个基于 React 的 Web 应用框架 —— **Next.js**，极大地推动了 React 在内容网站和 SEO 场景下的应用。

同年，法国的兄弟开发者 [Sébastien Chopin](https://github.com/atinux) 和 [Alexandre Chopin](https://github.com/alexchopin) 以及荷兰开发者 [Pooya Parsa](https://github.com/pi0) 等人深受 React 的 Next.js 框架启发，决定为 Vue 社区打造一个类似的 SSR 框架，于是有了 **Nuxt.js**。

Nuxt.js 首次发布时间是2016年10月26日，只比 Next.js 晚一天。很多人第一反应是：“Nuxt.js 怎么可能在一天内模仿 Next.js？” 来自 Nuxt.js 作者 Sébastien Chopin 的解释是这样的（可在早期博客、GitHub issue 和会议发言中找到）：

> 🗣 “我们从 2016 年 8 月就开始在构思和开发 Nuxt.js 原型。当时 Vue 社区没有很好的 SSR 解决方案，而我们希望打造一个类似 Next.js 的开发体验……我们是看到 Next 的预告或者理念文档后受到启发的，而不是它的源码。”

因此，Nuxt.js 并非“当天抄袭”发布，事实上是 Nuxt.js 的研发早于 Next.js 的正式发布，而二者在理念上不谋而合，属于几乎同期独立发展。Nuxt.js 在发布时也明确在其 README 中表达了对 Next.js 的感谢和致敬。

虽然 Nuxt.js 是由社区主导的开源项目，并非 Vue 官方推出的框架，但它得到了 Vue 官方的认可与支持，并在 Vue 社区中被广泛采用。后来，Nuxt 团队成立了 [NuxtLabs](https://nuxtlabs.com) 公司，持续维护和推进 Nuxt 生态系统的发展。



## SSR、SSG 和 SPA

SSR（服务器端渲染）、SSG（静态站点生成） 和 SPA（单页应用） 是当前 Web 前端开发的三种模式（也是流行趋势），这三种模式各自应用广泛、各有优势。

- **SSR** 是 Server-Side Rendering 的缩写，意思是：页面在服务器生成 HTML，再发送给客户端，适合 SEO 和首屏加载优化。
- **SSG** 是 Static Site Generation 的缩写，意思是：在构建时就生成好 HTML 文件，用户访问页面时直接从服务器读取这些静态 HTML，而不是动态渲染生成页面，加载速度快、部署简单。
- **SPA** 是 Single Page Application 的缩写，意思是：仅加载一次 HTML 后通过 JavaScript 动态更新内容，无需页面刷新，用户体验流畅。

三者的对比如下表所示：

| 模式 |             渲染时机             |  SEO   |          性能          |      使用场景      |
| :--: | :------------------------------: | :----: | :--------------------: | :----------------: |
| SPA  | 用户访问时，浏览器加载 JS 后渲染 |   差   |         首屏慢         |    后台管理系统    |
| SSR  |   用户访问时，服务器生成 HTML    |   好   | 首屏快，但服务器负载高 |    新闻、商品页    |
| SSG  |       构建时生成 HTML 文件       | 非常好 |          极快          | 博客、官网、文档站 |

:::tip

现代框架如 Nuxt.js（Vue）、Next.js（React）、SvelteKit 等，往往都支持这三种渲染模式，并鼓励开发者**根据页面实际需求灵活选择**（即所谓的“混合渲染”/Hybrid Rendering）。

:::



## Nuxt.js 的核心特性

| 特性                              | 描述                                                      |
| --------------------------------- | --------------------------------------------------------- |
| ✅ 页面驱动（Pages-based routing） | 自动根据 `pages/` 目录生成路由，无需手动配置 Vue Router   |
| ✅ 服务端渲染（SSR）支持           | 提高首屏加载速度，有利于 SEO                              |
| ✅ 静态站点生成（SSG）             | 类似 Next.js，可一键生成 HTML 文件并部署到静态服务器      |
| ✅ TypeScript 默认支持             | 项目初始化即支持 TypeScript 类型推导和 IDE 自动补全       |
| ✅ 组合式 API 与模块生态           | 支持 `setup()`，并提供大量官方模块（如 Axios、Auth、PWA） |
| ✅ 自动导入                        | 无需手动导入组件、Composable、Store 等                    |
| ✅ 灵活部署方式                    | 支持 Vercel、Netlify、Node、静态 CDN 等部署方式           |



## Nuxt 的定位与优势

相较于使用 Vue CLI 或 Vite 创建的 Vue 项目，Nuxt 帮你：

- **节省配置时间**：无需配置 Vue Router、Pinia、TypeScript、打包脚本等。
- **专注业务逻辑**：通过清晰的目录结构（如 `pages/`、`layouts/`、`plugins/`）组织代码。
- **适配不同部署需求**：只需切换配置即可从 SPA 模式切换到 SSR 或 SSG 模式。
- **构建更大型项目**：内置中间件、模块系统更适合中大型项目架构。



## Nuxt 的使用场景

Nuxt.js 可以用于构建各种类型的 Vue 应用，尤其适合以下场景：

- **内容型网站（如博客、文档站）**

  利用 Nuxt 的静态站点生成（SSG），可以预渲染所有页面，极大提升 SEO 和加载速度。

- **企业官网、展示型页面**

  Nuxt 支持多种部署方式，开发体验友好，且支持 Meta 标签、结构化数据配置。

- **中小型前后端一体的全栈项目**

  Nuxt 3 支持内置 API 路由，具备一定的后端能力，可以处理简单业务逻辑。

- **需要服务端渲染（SSR）的项目**

  适合电商平台、用户动态页面等 SEO 要求较高的场景。



:::info 不适合完全替代后端的场景 ⚠️

尽管 Nuxt 有 Server API，但它仍然是**轻量后端**。当你的项目需要：

- 文件上传 / 大规模数据处理
- WebSocket 实时通信
- 任务队列 / 缓存 / 高并发优化
- 微服务架构或复杂权限控制

你仍然需要搭建独立的后端服务，如：

- Node.js + Express/Koa
- NestJS（全功能 TypeScript 后端框架）
- Spring Boot、Go、Python Flask 等

:::



## Nuxt 版本选择

Nuxt.js 目前主要有两个大版本：Nuxt 2 和 Nuxt 3，两者区别如下：

|      特性       | Nuxt 2   | Nuxt 3                                        |
| :-------------: | -------- | --------------------------------------------- |
|    Vue 版本     | Vue 2    | Vue 3（Composition API）                      |
|    构建工具     | Webpack  | Vite（默认）                                  |
| TypeScript 支持 | 辅助支持 | 原生支持                                      |
|   Nitro 引擎    | ❌ 无     | ✅ 默认内置，跨平台部署（Node、Edge、Workers） |
|    模块系统     | 旧式模块 | 新模块规范（支持 ESM、tree shaking）          |

**推荐新项目使用 Nuxt 3**，它是未来的发展方向，性能更好，生态更现代。



## 相关链接

- [Nuxt.js 项目官网（英文）](https://nuxt.com)
- [Nuxt.js 项目官网（中文）](https://nuxtjs.org.cn)
- [Nuxt.js GitHub 主页](https://github.com/nuxt)
