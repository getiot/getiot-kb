---
sidebar_position: 1
slug: /react-intro
---

# React 简介

**React** 是一个用于构建用户界面的 JavaScript 库，由 Facebook 在 2013 年开源。与传统的前端框架不同，React 更关注于“视图”层（View），采用组件化开发的方式，鼓励开发者将 UI 拆分为一个个独立、可复用的小组件。开发者只需要对 HTML 和 JavaScript 有简单了解就可以使用 React 进行开发，因此广受前端开发者欢迎。

![](https://static.getiot.tech/img/subjects/React-logo_128px.png#center-100)



## React 发展历程

- 最初由 Facebook 的软件工程师 Jordan Walke 创建；
- 2011年部署于 Facebook 的 newsfeed；
- 2012年部署于 Instagram；
- 2013年5月[宣布](https://reactjs.org/blog/2013/06/05/why-react.html)开源；
- 如今，React 正在被腾讯、阿里等互联网厂商广泛使用。

:::tip

React、Vue、Angular 和 Svelte 是现在主流的四个 Web 前端框架，也被称为“前端框架的四驾马车”，从2024年 NPM 包下载量来看，React 框架依旧一骑绝尘，遥遥领先于其他三个框架。Vue 框架则处于第二的位置，而 Svelte 已连续三年超过 Angular，且增长趋势迅猛。

根据 [statista](https://www.statista.com/statistics/1124699/worldwide-developer-survey-most-used-frameworks-web/) 的调查数据，在2024年，有 39.5% 的开发者正在使用 React 框架，在所有前端框架中排名第一。

:::



## React 主要特点

- React 基于虚拟 DOM 快速渲染，性能优越，避免了频繁操作 DOM 导致的浏览器重绘和重排；
- React 非常简单、轻量级，只负责处理视图层，任何有 JavaScript 经验的开发者都可以快速上手；
- React 提供大量可重复使用的组件，开发者可以自由组合形成更复杂的组件。



## React 能做什么？

React 可以用于构建各种 Web 应用，尤其适合构建响应式、交互性强的单页应用（SPA，Single Page Application）。你可以用它开发博客、后台管理系统、电商网站、实时协作工具等。

React 也可以配合其他库使用，比如：

- **React Router**：处理前端路由，让你的应用支持页面跳转。
- **Redux / Zustand / Recoil**：处理复杂的状态管理。
- **Next.js**：支持服务端渲染（SSR）的 React 框架，适合 SEO 和性能优化场景。



## 为什么选择 React？

React 能够快速流行并成为主流框架之一，离不开以下几个原因：

1. **易学易用**：语法接近 JavaScript，学习曲线相对平缓。
2. **生态成熟**：有庞大的社区、丰富的第三方库和开发工具。
3. **性能优秀**：采用虚拟 DOM（Virtual DOM）优化页面更新效率。
4. **组件复用性强**：提高开发效率，降低维护成本。



## 前端框架的对比

|   特性   |        React        |        Vue        |      Angular      |       Svelte       |
| :------: | :-----------------: | :---------------: | :---------------: | :----------------: |
|   类型   |    库（Library）    | 框架（Framework） | 框架（Framework） | 框架（Framework）  |
| 学习曲线 |        适中         |       较低        |       较高        |        较低        |
| 语法风格 |     JSX、函数式     |     模板 + JS     |  TypeScript 重度  |  近似 HTML 的语法  |
| 状态管理 |  自选（如 Redux）   |   Vuex 或 Pinia   |  内建服务与 RxJS  |        内建        |
| 官方维护 | Meta（前 Facebook） |     Vue 团队      |      Google       | 独立开发者 + 社区  |
| 编译方式 |     运行时更新      |    运行时更新     |    运行时更新     |     编译期优化     |
|   性能   |        优秀         |       优秀        |       优秀        | 极优（无虚拟 DOM） |

Svelte 是一款相对较新的前端框架，与 React、Vue、Angular 不同的是，Svelte 在构建时将代码编译为高效的原生 JavaScript，无需在浏览器中加载运行时库。这使得 Svelte 的性能在某些场景下表现非常出色，特别适合性能敏感的小型应用或嵌入式组件开发。

React 则在灵活性和生态方面具有优势，适合构建中大型项目和有复杂需求的前端应用。



## 相关链接

- [React 官网（英文）](https://react.dev)
- [React 官方中文文档](https://zh-hans.reactjs.org)
- [React 代码仓库（GitHub）](https://github.com/facebook/react)


