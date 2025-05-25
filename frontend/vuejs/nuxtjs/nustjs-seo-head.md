---
sidebar_position: 9
slug: /nustjs-seo-head
authors: [luhuadong]
---

# Nuxt.js SEO 与 Head 管理

为了让你开发的 Nuxt 应用在搜索引擎中获得更好的展示效果，你需要了解并善用 SEO（搜索引擎优化）和 HTML `<head>` 的管理。在 Nuxt 中，这项工作非常简单高效，你可以灵活地为每个页面设置标题、描述、关键词等信息，并支持动态内容更新。

本文将带你了解如何在 Nuxt 应用中管理页面的 `<head>` 元信息，提升 SEO 表现。你将学会如何设置页面标题、Meta 标签、Open Graph 标签等，并掌握如何使用 Nuxt 的 `useHead` 与 `definePageMeta` API 实现灵活的页面头部信息管理。



## 为什么要重视 SEO？

SEO（Search Engine Optimization）是指通过优化网页内容、结构与元信息，让网站更容易被搜索引擎抓取和收录，从而提高网站在搜索结果中的排名。一个页面良好的 SEO 通常依赖：

- 结构清晰的 HTML 标签（如 `<h1>`、`<nav>`）
- 合理的页面标题（`<title>`）
- 完善的 meta 信息（如描述、关键词、OG 标签等）
- 语义化的路由路径（如 `/blog/my-first-post`）

Nuxt 默认支持 SSR（服务端渲染）和 SSG（静态生成），非常适合做 SEO 优化。



:::info 什么是 OG 标签？

**OG 标签** 是 “Open Graph 标签” 的简称，它是一种标准的 HTML 元标签（Meta Tags），用于帮助社交媒体（如 Facebook、Twitter、微信等）在用户分享网页时，正确地读取并展示该网页的标题、描述、缩略图等信息。

Open Graph 协议最早由 Facebook 公司提出，用于优化网页在 Facebook 上的展示方式。现在已经被广泛应用于各种社交平台。

下表列出了常见的 OG 标签：

| 标签             | 含义                                |
| ---------------- | ----------------------------------- |
| `og:title`       | 网页标题（显示为主标题）            |
| `og:description` | 页面简短描述                        |
| `og:image`       | 缩略图 URL（分享时显示）            |
| `og:url`         | 当前页面的 URL 地址                 |
| `og:type`        | 内容类型（如 `article`、`website`） |

分享链接时，如果正确配置了 OG 标签，用户会看到一个完整的预览卡片，包括：

- 页面标题
- 一张封面图
- 页面描述
- 链接地址

如果没有设置，可能会显示错误的标题或没有图片，用户点击率也会降低。

:::



## 页面级 SEO 设置

### 使用 `useHead` 设置页面头部信息

在页面组件中，你可以使用 `useHead` 来动态设置 `<head>` 内容：

```html showLineNumbers
<script setup lang="ts">
useHead({
  title: '我的 Nuxt 博客首页',
  meta: [
    { name: 'description', content: '这是一个使用 Nuxt 构建的个人博客首页。' },
    { name: 'keywords', content: 'Nuxt,博客,Vue,SEO' },
    { property: 'og:title', content: '我的博客' },
    { property: 'og:description', content: '欢迎访问我的 Nuxt 博客。' },
    { property: 'og:type', content: 'website' },
  ]
})
</script>
```

这样生成的页面将包含这些元信息，有助于搜索引擎更好地识别你的页面内容。

### 使用 `definePageMeta` 设置标题

对于 Nuxt 3.9 以上版本，你还可以使用 `definePageMeta` 设置页面级别的元信息：

```html showLineNumbers
<script setup lang="ts">
definePageMeta({
  title: '关于我们',
  description: '这是关于我们页面的介绍'
})
</script>
```

如果你使用 `definePageMeta()` 设置了 `title` 和 `description`，Nuxt 会自动调用 `useHead()` 背后生成对应的 `<head>` 元信息，你通常不需要再手动调用 `useHead()` 设置这些字段。



## 默认全局 SEO 设置

如果你想为所有页面设置默认的 `<head>` 信息，比如统一的站点标题后缀或基础描述，可以在 `app.vue` 或插件中使用 `useHead` 设置：

```tsx showLineNumbers
// app.vue 或 plugins/meta.ts
useHead({
  titleTemplate: (titleChunk) => {
    return titleChunk ? `${titleChunk} - 我的站点` : '我的站点'
  },
  meta: [
    { name: 'author', content: '你的名字' },
    { name: 'viewport', content: 'width=device-width, initial-scale=1.0' }
  ]
})
```

这样每个页面的标题会自动加上统一的后缀，例如 “关于我们 - 我的站点”。



## 社交平台分享优化（Open Graph）

为了让你的网页在社交平台（如微信、QQ、Twitter、Facebook）分享时显示预览图和描述内容，你需要设置 Open Graph（OG） 标签：

```tsx showLineNumbers
useHead({
  meta: [
    { property: 'og:title', content: '文章标题' },
    { property: 'og:description', content: '文章描述' },
    { property: 'og:image', content: 'https://example.com/preview.jpg' },
    { property: 'og:url', content: 'https://example.com/post/123' },
    { property: 'og:type', content: 'article' },
  ]
})
```



## Nuxt SEO 模块（可选）

如果你希望使用更高级、更结构化的 SEO 支持，可以引入官方的 Nuxt SEO 模块（@nuxtjs/seo）或社区模块 `@nuxtjs/schema-org`：

```bash
npm install @nuxtjs/seo
```

然后在 `nuxt.config.ts` 中注册该模块：

```tsx showLineNumbers
export default defineNuxtConfig({
  modules: ['@nuxtjs/seo']
})
```

这个模块可以自动注入许多 SEO 相关配置，适合复杂项目使用。



## SEO 调试建议

为了确保 SEO 设置生效，可以使用以下工具检查页面内容：

- [Google Search Console](https://search.google.com/search-console/)
- [Lighthouse](https://developers.google.com/web/tools/lighthouse)（浏览器开发者工具内置）
- [Twitter Card Validator](https://cards-dev.twitter.com/validator)
- [Facebook Sharing Debugger](https://developers.facebook.com/tools/debug/)



## 小结

在 Nuxt 中管理页面的 Head 信息非常灵活，结合 `useHead` 和 `definePageMeta`，你可以为每个页面设置自定义的标题、描述、OG 标签等内容，从而有效提升 SEO 表现和社交分享体验。记得为重要页面配置独特的标题和元信息，这样更容易获得搜索引擎的关注和用户点击。借助 Nuxt 的 SSR 和静态生成能力，配合合理的 Head 设置，你的网站将更具专业感和搜索引擎友好性。
