---
sidebar_position: 2
sidebar_label: Taro 开发环境
authors: [luhuadong]
---

# Taro 开发环境搭建

本文将带你完成 Taro 的开发环境搭建，包括 Node.js 的安装、Taro CLI 的初始化、开发工具的准备等。搭建完成后，你就可以开始创建第一个 Taro 项目了。



## 安装 Node.js

Taro 是基于 Node.js 的前端构建工具，因此你需要先安装 Node.js。推荐安装 LTS（长期支持）版本，稳定且兼容性好。

你可以访问 [Node.js 官网](https://nodejs.org/) 下载安装包，具体下载和安装步骤可参考《[Node.js 安装](/nodejs/nodejs-installation/)》。如果你的系统安装了多个 Node.js 版本，推荐使用 [NVM](/nodejs/node-version-manager/) 工具进行管理。

安装完成后，可以在终端中运行以下命令，检查是否成功：

```bash
node -v
npm -v
```

如果能输出版本号，说明安装成功。

:::tip

Taro CLI 支持 npm、yarn 和 pnpm，任选其一即可。

:::



## 安装 Taro CLI

Taro 提供了命令行工具 `@tarojs/cli`，用来创建、开发和构建项目。你可以通过 npm 安装它：

```bash
npm install -g @tarojs/cli
```

或者使用 yarn：

```bash
yarn global add @tarojs/cli
```

或者使用 pnpm（推荐更快的包管理器）：

```bash
pnpm add -g @tarojs/cli
```

安装完成后，运行以下命令验证：

```bash
taro -v
```



## 准备开发工具

### 推荐使用的 IDE

你可以使用任何你熟悉的编辑器，推荐使用 [Visual Studio Code](https://code.visualstudio.com/)，支持 TypeScript、React 和小程序开发插件。

### 小程序开发者工具

如果你想编译并预览小程序端，建议根据目标平台安装相应的官方开发者工具：

| 平台           | 工具下载链接                                                 |
| -------------- | ------------------------------------------------------------ |
| 微信小程序     | [https://developers.weixin.qq.com/miniprogram/dev/devtools/download.html](https://developers.weixin.qq.com/miniprogram/dev/devtools/download.html) |
| 支付宝小程序   | [https://opendocs.alipay.com/mini/ide/download](https://opendocs.alipay.com/mini/ide/download) |
| 百度智能小程序 | [https://smartprogram.baidu.com/docs/develop/devtools/download/](https://smartprogram.baidu.com/docs/develop/devtools/download/) |
| 抖音小程序     | [https://developer.open-douyin.com/docs/resource/zh-CN/mini-app/develop/download/](https://developer.open-douyin.com/docs/resource/zh-CN/mini-app/develop/dev-tools/developer-instrument/overview) |

你需要使用这些工具打开 Taro 编译后的 `dist` 目录，来查看真实运行效果。



## 安装 nvm 管理 Node.js 版本（可选）

开发过程中可能会遇到多个项目需要不同版本的 Node.js，推荐安装 `nvm` 来进行版本管理。

- macOS / Linux 推荐使用 [`nvm`](https://github.com/nvm-sh/nvm)
- Windows 用户可使用 [`nvm-windows`](https://github.com/coreybutler/nvm-windows)

使用示例：

```bash
nvm install 18
nvm use 18
```



## 初始化 Taro 项目前的准备

环境搭建完成后，你就可以使用以下命令来初始化项目：

```bash
taro init my-app
```

这个命令会引导你进行项目配置，包括使用 TypeScript 与否、选择的 UI 框架（React / Vue / Nerv）等。

:::tip

本教程后续将使用 React + TypeScript 作为默认配置，推荐你也选择相同的方案。

:::



## 小结

在这一节中，你成功完成了 Taro 开发环境的搭建，包括安装 Node.js、Taro CLI，以及相关的小程序开发工具。准备好这些工具后，你就可以着手创建第一个 Taro 项目，正式开始跨端开发之旅了。
