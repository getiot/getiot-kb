---
sidebar_position: 1
sidebar_label: Vant
slug: /vant
---

# Vant 小程序 UI 组件库

**Vant** 是一个轻量、可靠的移动端组件库，由有赞前端团队于 2017 年开源。它提供了丰富的组件，旨在帮助开发者快速构建高质量的移动端应用。目前，Vant 官方提供了 Vue 2 版本、Vue 3 版本和微信小程序版本，并由社区团队维护 React 版本和支付宝小程序版本。



## 主要特点

- 🚀 性能极佳，组件平均体积小于 1KB（min+gzip）
- 🚀 80+ 个高质量组件，覆盖移动端主流场景
- 🚀 零外部依赖，不依赖三方 npm 包
- 💪 使用 TypeScript 编写，提供完整的类型定义
- 💪 单元测试覆盖率超过 90%，提供稳定性保障
- 📖 提供丰富的中英文文档和组件示例
- 📖 提供 Sketch 和 Axure 设计资源
- 🍭 支持 Vue 2、Vue 3 和微信小程序
- 🍭 支持 Nuxt 2、Nuxt 3，提供 Nuxt 的 [Vant Module](https://github.com/vant-ui/vant-nuxt)
- 🍭 支持主题定制，内置 700+ 个主题变量
- 🍭 支持按需引入和 Tree Shaking
- 🍭 支持无障碍访问（持续改进中）
- 🍭 支持深色模式
- 🍭 支持服务器端渲染
- 🌍 支持国际化，内置 30+ 种语言包



## 应用场景

Vant 适用于多种移动端开发场景，包括但不限于：

- **微信小程序开发**：通过 Vant Weapp 快速构建小程序界面。
- **Vue.js 项目**：在 Vue 2 或 Vue 3 项目中使用 Vant 组件。
- **多语言项目**：支持国际化，适合开发多语言应用。
- **电商、教育、金融等领域的移动端应用**：Vant 提供的组件能够满足这些领域的需求。

:::tip

如果你的项目仅针对微信小程序，且团队熟悉 Vue 技术栈，那么使用 **Vant Weapp** 组件库是一个非常值得推荐的选择。

:::



## 使用示例

### 在微信小程序中使用 Vant Weapp

1. **安装依赖**：

   ```bash
   npm install @vant/weapp -S --production
   ```

2. **配置项目**： 在 `app.json` 或 `page.json` 文件中引入需要的组件，例如按钮组件：

   ```json
   "usingComponents": {
     "van-button": "@vant/weapp/button/index"
   }
   ```

3. **使用组件**： 在 WXML 文件中使用引入的组件：

   ```xml
   <van-button type="primary">按钮</van-button>
   ```

4. **构建 npm**： 使用微信开发者工具构建 npm，生成 `miniprogram_npm` 目录。



### 在 Vue.js 项目中使用 Vant

1. **安装 Vant**：

   ```bash
   npm install vant
   ```

2. **全局引入**：

   ```javascript
   import Vue from 'vue';
   import Vant from 'vant';
   import 'vant/lib/index.css';
   Vue.use(Vant);
   ```

3. **局部引入**：

   ```javascript
   import { Button } from 'vant';
   import 'vant/lib/button/style';
   Vue.use(Button);
   ```

4. **使用组件**： 在模板中直接使用组件：

   ```html
   <van-button type="primary">按钮</van-button>
   ```



## 相关链接

- [Vant 代码仓库](https://github.com/youzan/vant)
- [Vant 文档中心](https://vant.pro/vant/)
- [Vant Weapp 代码仓库（微信小程序版）](https://github.com/youzan/vant-weapp)
- [Vant Weapp 文档中心（微信小程序版）](https://vant.pro/vant-weapp/)
