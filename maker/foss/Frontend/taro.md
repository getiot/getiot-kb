---
sidebar_position: 2
sidebar_label: Taro
slug: /taro
---

# Taro 多端统一开发框架

**Taro** 是由[京东·凹凸实验室](https://aotu.io)开发并开源的一款多端统一开发框架。它允许开发者使用一套代码（支持 React、Vue 语法）来编写应用，并能将代码编译为多种小程序（微信、支付宝、百度等）、H5 端应用，以及 React Native 等移动端平台。

Taro 致力于帮助开发者在不牺牲用户体验的前提下，大幅提升多端项目的开发效率和维护效率。



## 主要特点

- **多端编译支持**：一套代码，可以编译生成微信小程序、支付宝小程序、百度小程序、快应用、H5、React Native 等多端应用。
- **React 语法**：引入了 React 的组件化开发方式，支持 JSX、Hooks、State Management（状态管理）等特性。
- **支持多种前端框架**：自 Taro 3.x 版本起，Taro 还支持使用 Vue 进行开发，开发者可根据项目需求选择合适的技术栈。
- **丰富的生态体系**：
  - 官方插件市场（Taro Plugin Hub）
  - 丰富的 UI 组件库（如 taro-ui、nutui-react-taro）
  - 支持各种第三方小程序 SDK
- **灵活的配置能力**：通过 `config/index.js` 文件集中管理路由、页面配置、webpack 扩展等内容。
- **支持 TypeScript**：原生支持 TypeScript 开发，提升开发体验与项目可维护性。
- **优秀的 CLI 工具**：提供完善的脚手架，快速初始化、构建、发布项目。
- **跨端 API 抽象**：提供统一的 API 接口封装，如 `Taro.request`、`Taro.uploadFile`，无需针对每个平台单独适配。



## 应用场景

- 需要同时发布到多个小程序平台（微信、支付宝、百度、抖音等）以及 H5 的应用项目。
- 希望复用已有的 React 或 Vue 技术栈，快速开发小程序及多端应用的团队或个人。
- 多人协作、大型项目中需要统一编码规范、降低维护成本。
- 想要减少重复开发，提高不同平台间代码共用率的中大型前端项目。



## 相关链接

- 官方网站：[https://taro.zone](https://taro.zone)
- GitHub 仓库：[https://github.com/NervJS/taro](https://github.com/NervJS/taro)
- Taro 文档中心：[https://docs.taro.zone](https://docs.taro.zone)
- Taro UI 组件库：[https://taro-ui.jd.com](https://taro-ui.jd.com)
