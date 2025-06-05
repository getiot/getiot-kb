---
sidebar_position: 7
slug: /nuxtjs-deploy
authors: [luhuadong]
---

# 构建和部署 Nuxt 应用

在完成 Nuxt 应用的开发之后，下一步就是将它构建并部署到线上环境。本文将带你了解如何构建 Nuxt 应用，并介绍几种常见的部署方式，包括静态托管、Node 服务器和常见平台如 Vercel 和 Netlify。



## 构建 Nuxt 应用

Nuxt 支持多种部署目标，包括 SSR（服务端渲染）和 SSG（静态生成）。你可以通过配置 `nuxt.config.ts` 中的 `ssr` 和 `nitro` 选项来控制构建行为。

### 默认构建（SSR）

如果你没有修改 `ssr` 配置，Nuxt 默认构建为服务端渲染（Server Side Rendering）模式。这适合需要动态内容的场景。

执行构建命令：

```bash
npm run build
```

构建完成后，会生成一个 `.output/` 目录，它包含可部署到服务器的产物。

启动生产服务器：

```bash
npm run start
```



### 静态站点构建（SSG）

如果你只需要部署为静态网站，可以启用静态站点生成：

**步骤 1：修改 `nuxt.config.ts`**

```tsx showLineNumbers title="nuxt.config.ts"
export default defineNuxtConfig({
  ssr: true,
  nitro: {
    preset: 'static'
  }
})
```

**步骤 2：运行生成命令**

```bash
npx nuxi generate
```

这会在 `./dist` 目录生成纯静态 HTML 和资源文件，可以直接上传到任何静态托管平台（如 GitHub Pages、Netlify、Vercel、OSS 等）。



## 常见部署方式

### 1. 部署到 Node.js 服务器（适用于 SSR）

如果你选择 SSR 模式，建议部署在支持 Node.js 的服务器上。

**构建：**

```bash
npm run build
```

**生产启动：**

```bash
npm run start
```

你可以将 Nuxt 应用通过 `pm2`、`systemd` 等工具守护运行。



### 2. 部署到 Vercel（推荐方式）

Vercel 是 Nuxt 官方推荐的部署平台。

**部署步骤：**

1. 前往 https://vercel.com 注册并登录。
2. 关联你的 Git 仓库（支持 GitHub、GitLab、Bitbucket）。
3. Vercel 会自动检测到你使用的是 Nuxt，并设置构建命令为：

```bash
npm install
npm run build
npm run start
```

你也可以部署为静态站点（SSG 模式），构建命令会自动变成：

```bash
npm run generate
```



### 3. 部署到 Netlify（适用于 SSG）

Netlify 适合部署使用 `nuxi generate` 命令生成的静态网站。

**设置参数：**

- 构建命令：`nuxi generate`
- 发布目录：`dist`



### 4. 部署到 GitHub Pages（适用于 SSG）

GitHub Pages 也可以托管 Nuxt 的静态站点。

**生成静态文件：**

```bash
npx nuxi generate
```

**使用 `gh-pages` 发布：**

```bash
npm install -D gh-pages
npx gh-pages -d dist
```

确保 `nuxt.config.ts` 中正确配置 `app.baseURL`：

```tsx showLineNumbers title="nuxt.config.ts"
export default defineNuxtConfig({
  app: {
    baseURL: '/你的仓库名/'
  }
})
```



## 常见问题解答（FAQ）

### 如何解决部署后的页面刷新 404 问题？

如果你使用静态站点部署，需要配置正确的路由回退规则：

- 在 Netlify 上，添加 `_redirects` 文件：

  ```bash
  /*    /index.html   200
  ```

- 在 GitHub Pages 上，确保开启 SPA 模式。



## 小结

在本篇中，你学习了如何构建和部署 Nuxt 应用，包括 SSR 和静态站点两种构建方式，以及部署到 Vercel、Netlify 和 GitHub Pages 等常见平台的方法。Nuxt 提供了灵活的构建选项，能够适应不同规模和类型的项目部署需求。你可以根据项目特性选择最适合的方式上线你的应用。下一步，你可以尝试配置 CI/CD 自动化部署流程，让发布更加高效。
