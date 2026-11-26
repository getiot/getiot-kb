---
sidebar_position: 4
sidebar_label: ToDo 应用打包发布
authors: [luhuadong]
---

# Taro 项目实战：ToDo 应用 - 打包发布

在前面的章节中，你已经完成了 ToDo 应用的功能开发与数据存储。现在，是时候把项目打包并发布到目标平台了。本节将带你了解如何使用 Taro 将项目构建为不同平台（如 H5、微信小程序）可运行的版本，并进行调试和上线准备。

:::info 项目代码

ToDo 应用示例的完整代码可在 [GitHub](https://github.com/getiot/taro-courses/tree/main/todo-app) 获取。

:::



## 构建基础命令

Taro 提供了统一的构建命令，你可以通过下面的方式将项目打包成指定平台的代码：

```bash
# 构建 H5（Web 浏览器端）
npm run build:h5

# 构建微信小程序
npm run build:weapp

# 构建支付宝小程序
npm run build:alipay
```

这些命令的实质是运行 `taro build` 命令，并通过 `--type` 参数指定构建目标。你也可以直接这样写：

```bash
npx taro build --type weapp
```

构建后的文件会被输出到 `dist` 目录下的对应平台子目录，例如：

- H5 输出在：`/dist/h5`
- 微信小程序输出在：`/dist/weapp`

你可以在 `package.json` 中查看或修改这些脚本命令。



## 预览和调试

### H5 预览

如果你正在开发 Web 版本，可以运行以下命令以启动开发服务器：

```bash
npm run dev:h5
```

然后打开浏览器访问本地地址，例如：`http://localhost:10086`，就可以看到你的 ToDo 应用运行效果。

### 微信小程序预览

执行下面命令构建微信小程序版本：

```bash
npm run build:weapp
```

构建完成后，打开微信开发者工具，导入项目根目录下的 `dist/weapp` 文件夹，即可进行调试、真机预览、模拟器运行等。

注意事项：

- 项目配置的 `project.config.json` 文件也会被自动生成或保留，请确保 `appid` 和路径设置正确。
- 如果启用了 TypeScript，请确保开发者工具开启了增强编译模式。



## 构建优化建议

构建发布时，还可以使用一些优化参数：

```bash
npx taro build --type weapp --watch --env production
```

- `--watch`：监听文件改动自动重构（适用于开发阶段）。
- `--env production`：启用生产环境构建（会自动压缩、去除调试代码等）。

你也可以在 `config/index.ts` 中配置按平台区分的构建参数，比如开启 `mini.cssModules`、`esnextModules` 支持等。



## 发布上线

- **H5 项目**：构建出的 `/dist/h5` 文件夹就是可部署的静态网页内容。你可以部署到服务器（如 nginx）、GitHub Pages、Vercel、Netlify 等平台。
- **微信小程序**：通过微信开发者工具上传版本，提交审核通过后即可发布上线。
- **其他平台**：例如支付宝、百度、字节跳动小程序，同样通过对应平台的开发者工具上传 `dist` 中对应目录内容即可。



## 清理构建缓存

有时候你可能遇到构建后样式异常或内容不更新的问题，可以尝试清理缓存后重新构建：

```bash
# 删除 dist 目录
rm -rf dist

# 重新构建
npm run build:weapp
```



## 小结

本节介绍了如何将 Taro ToDo 应用构建为 H5 和小程序等不同平台的版本，并讲解了调试、构建优化和发布部署的过程。掌握打包发布流程是项目上线的最后一步，你可以灵活使用构建参数和开发者工具，将应用部署到 Web 或小程序平台，为用户提供便捷的访问方式。
