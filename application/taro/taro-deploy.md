---
sidebar_position: 14
authors: [luhuadong]
---

# Taro 打包发布

在完成开发后，你就可以将 Taro 项目打包并发布到对应平台了。本篇将带你了解 Taro 项目的打包流程，涵盖多平台打包命令、构建配置、微信小程序与 H5 的发布方法，以及一些常见问题处理，帮助你顺利完成从开发到上线的最后一步。



## 准备工作

在打包前，请确保你已经完成以下准备：

- 所有功能已开发并测试完毕；
- 项目依赖已正确安装（执行过 `npm install` 或 `pnpm install`）；
- `config` 配置文件（如 `config/index.js`）中各平台的构建参数已设置妥当；
- 微信小程序开发者工具或其他目标平台工具已安装。



## Taro 构建命令

Taro 提供了多个打包构建命令，根据你目标平台的不同，命令略有差异。

#### 1. 小程序打包命令（WeApp）

```bash
npm run build:weapp
```

这个命令会将代码编译成微信小程序格式，输出到 `dist/weapp/` 目录下。

你也可以在开发环境下运行：

```bash
npm run dev:weapp
```

它会开启监听，方便调试。

#### 2. H5 打包命令

```bash
npm run build:h5
```

输出目录为 `dist/h5/`，你可以将这个目录部署到任意 Web 服务器（如 Nginx、GitHub Pages 等）。

#### 3. 其他平台构建命令

| 平台         | 命令                   |
| ------------ | ---------------------- |
| 支付宝小程序 | `npm run build:alipay` |
| 百度小程序   | `npm run build:swan`   |
| 字节小程序   | `npm run build:tt`     |
| QQ 小程序    | `npm run build:qq`     |
| React Native | `npm run build:rn`     |



## 自定义打包配置

你可以在 `config/index.ts` 中配置不同平台的构建参数，例如：

```tsx showLineNumbers
const config = {
  projectName: 'myApp',
  outputRoot: `dist/${process.env.TARO_ENV}`,
  weapp: {
    postcss: {
      autoprefixer: { enable: true },
      pxtransform: { enable: true }
    }
  },
  h5: {
    publicPath: '/',
    staticDirectory: 'static'
  }
}
```

通过 `process.env.TARO_ENV`，Taro 会自动将编译结果输出到指定平台目录。



## 微信小程序发布流程

Taro 编译后会生成小程序所需的 `.json`、`.wxml`、`.wxss` 和 `.js` 文件，你可以使用微信开发者工具打开 `dist/weapp` 目录进行预览和上传。

具体步骤如下：

1. 打开微信开发者工具；
2. 选择“打开小程序项目”；
3. 将 `dist/weapp` 目录作为项目目录导入；
4. 预览无误后，点击上传并提交审核。

:::tip

记得配置好 `project.config.json` 文件，如 `appid`、项目名称、编译设置等。

:::



## H5 发布流程

H5 项目打包完成后，会生成一个标准的前端项目目录结构（HTML、JS、CSS、图片等静态资源），你可以使用以下方式部署：

- 静态服务器（如 Nginx、Apache）；
- 云服务（如 Vercel、Netlify、腾讯云、阿里云）；
- GitHub Pages；
- Node.js + Express 自建服务（适合加接口的情况）。

示例：使用 Nginx 部署 H5

```nginx showLineNumbers
server {
  listen 80;
  server_name example.com;

  location / {
    root /path/to/dist/h5;
    index index.html;
    try_files $uri $uri/ /index.html;
  }
}
```



## 打包优化建议

为了让打包结果更轻量、运行更高效，推荐你注意以下几点：

- 使用 `TerserPlugin` 进行代码压缩（Taro 默认已开启）；
- 使用代码分包，按需加载模块；
- 图片压缩、字体精简，减少静态资源体积；
- 禁用调试日志（比如注释掉 `console.log`）；
- 对大型依赖库使用动态引入或 CDN 引入（H5）。



## 常见问题排查

#### 1. 构建失败

- 请确认 Node.js 版本与 Taro 要求兼容；
- 尝试删除 `node_modules` 和 `package-lock.json` 或 `pnpm-lock.yaml` 后重新安装依赖；
- 检查配置文件中是否有语法错误。

#### 2. 微信开发者工具无法打开 dist 目录

- 请确保你选择的是 `dist/weapp` 目录，而不是项目根目录；
- 如果开发者工具报错，可尝试重新构建一次。

#### 3. H5 页面白屏或样式错乱

- 检查 `publicPath` 是否配置正确；
- 确保构建后的资源路径与你部署目录一致。



## 小结

本篇教程带你了解了 Taro 的打包构建流程和跨平台发布方法，包括常用打包命令、自定义配置、微信小程序与 H5 的发布实践等。打包发布是 Taro 项目上线前的关键一步，熟悉这一流程后，你就能高效地将应用部署到多个平台，让更多用户使用你的应用。下一步建议你将项目发布到正式环境，亲自体验完整的跨平台开发流程。
