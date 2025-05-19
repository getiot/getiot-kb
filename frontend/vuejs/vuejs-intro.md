---
sidebar_position: 1
slug: /vuejs-intro
---

# Vue.js 简介

Vue.js 是一款流行的开源 JavaScript 框架，用于构建现代 Web 用户界面。在本节中，你将了解 Vue.js 的核心理念、发展历程、与其他框架的对比，以及为什么它是前端开发的热门选择。通过阅读这篇文章，你将为后续的学习打下坚实基础。



## 什么是 Vue.js？

**Vue.js**（读作 /vjuː/，类似于 "view"）是一个用于构建用户界面的 **渐进式 JavaScript 框架**。它的设计理念是尽量小巧、灵活，并鼓励你逐步采纳其不同的功能模块。从简单的动态绑定，到组件化开发，再到配合路由和状态管理构建复杂单页应用（SPA），Vue 都能很好地胜任。

Vue 由尤雨溪（Evan You）于 2014 年创建，目前的稳定版本为 **Vue 3.x**，它基于现代 JavaScript 标准（如 ES Modules、Proxy 等）进行构建，并提供了 Composition API、Teleport、Fragment、Script Setup 等新特性，大幅提升了可维护性与性能。

Vue.js 是一个完全开源的项目，遵循 MIT License（MIT 许可证）。这意味着：

- 你可以免费地使用、修改、分发 Vue.js；
- 可以将其用于个人项目、商业项目，甚至闭源项目；
- 不需要为使用 Vue 支付任何授权费用。



## Vue 的核心特性

- **响应式数据绑定**（Reactivity）：当你修改数据时，视图会自动更新，无需手动操作 DOM。
- **组件化开发**：你可以将 UI 拆分为独立、可复用的组件，每个组件都有自己的模板、逻辑和样式。
- **模板语法**：基于 HTML 的模板语法，使得开发者能轻松描述 UI 结构。
- **渐进式设计**：你可以只引入 Vue 的核心功能，也可以进一步使用 Vue Router、Pinia 等工具构建大型应用。
- **轻量高效**：Vue 3 的核心包压缩后仅约 20 KB，性能优异。



## 与其他框架的对比

Vue、React、Angular 是目前最流行的三大前端框架，下表列出了它们之间的基本区别。

|     特性     |            Vue             |     React     |  Angular   |
| :----------: | :------------------------: | :-----------: | :--------: |
|   框架类型   |         渐进式框架         | 库（Library） |  完整框架  |
|   学习曲线   |            平缓            |     中等      |    陡峭    |
| 官方支持工具 | 丰富（CLI、Router、Pinia） | 部分依赖社区  | 全套工具链 |
|   模板语法   |         HTML 模板          |      JSX      | HTML + TS  |

Vue.js 的中文开发者非常多，上手难度较低、文档完善，非常适合前端新手入门。而且 Vue 社区活跃、生态完善，因此越来越多的企业选择使用 Vue 构建前端项目。



## Vue 3 与 Vue 2 的差异

虽然 Vue 2 仍被广泛使用，但 Vue 3 是未来的发展方向。以下是它们之间的一些主要差异：

- **性能更强**：Vue 3 利用 Proxy 实现响应式系统，性能更优。
- **Composition API**：相比 Vue 2 的 Options API，Vue 3 的 Composition API 更利于逻辑复用。
- **更好的 TypeScript 支持**：Vue 3 原生支持 TypeScript，类型推导更加完善。
- 更小的体积和更快的加载速度。

你可以将 Vue 3 与 Vue 2 看作是从“好”向“更好”的进化。



## Vue 的适用场景

Vue.js 不仅适用于传统的 Web 页面开发，还广泛应用于各类跨平台项目中。以下是一些典型的应用场景：

- **Web 前端开发**：Vue 最常见的用途是构建现代化的 Web 单页应用（SPA），如后台管理系统、博客、企业官网等。
- **桌面应用开发**：结合 [Electron](/electron/)，你可以使用 Vue 构建跨平台的桌面应用（如 VS Code）。
- **移动 App 开发**：通过 Ionic Vue 或 NativeScript Vue，你可以用 Vue 开发原生移动应用。
- **小程序开发**：配合 uni-app 或 [Taro](/taro/)，Vue 也可用于微信小程序、支付宝小程序、百度小程序等跨平台开发。



## 相关链接

- [Vue.js 项目官网（英文）](https://vuejs.org)
- [Vue.js 项目官网（中文）](https://cn.vuejs.org)
- [Vue.js GitHub 主页](https://github.com/vuejs/)

