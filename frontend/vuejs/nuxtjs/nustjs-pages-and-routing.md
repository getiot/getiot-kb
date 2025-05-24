---
sidebar_position: 3
slug: /nustjs-pages-and-routing
---

# Nuxt.js 页面与路由

在传统的 Vue 应用中，开发者需要手动配置 Vue Router 来管理页面跳转。而在 Nuxt.js 中，路由是**基于文件系统自动生成的**，你只需关注页面的编写，无需再手动配置路由，大大提高了开发效率。



## 页面与目录结构

在 Nuxt 中，所有放置在 `pages/` 目录下的 `.vue` 文件，都会被自动注册为路由页面。例如：

```bash showLineNumbers
pages/
├── index.vue         # →  /
├── about.vue         # →  /about
├── blog/
│   ├── index.vue     # →  /blog
│   └── [slug].vue    # →  /blog/:slug
```

Nuxt 会根据这些文件自动生成如下路由：

| 文件名                  | 路由路径      |
| ----------------------- | ------------- |
| `pages/index.vue`       | `/`           |
| `pages/about.vue`       | `/about`      |
| `pages/blog/index.vue`  | `/blog`       |
| `pages/blog/[slug].vue` | `/blog/:slug` |

:::tip

`[]` 表示动态路由参数，和 Vue Router 中的 `:param` 类似。

:::



## 创建一个页面

在 `pages/about.vue` 中添加如下内容：

```html showLineNumbers title="pages/about.vue"
<template>
  <div>
    <h1>关于我们</h1>
    <p>这是一个关于我们的页面。</p>
  </div>
</template>
```

然后在浏览器中访问 `http://localhost:3000/about`，你就能看到自动渲染的页面。



## 动态路由页面

要创建动态路由，如 `/blog/hello-nuxt`，只需在 `pages/blog/` 下新建 `[slug].vue`：

```html showLineNumbers title="pages/blog/[slug].vue"
<template>
  <div>
    <h1>文章详情：{{ slug }}</h1>
  </div>
</template>

<script setup lang="ts">
import { useRoute } from 'vue-router'

const route = useRoute()
const slug = route.params.slug
</script>
```

访问 `http://localhost:3000/blog/hello-nuxt`，你将看到动态路由效果。



## 嵌套路由（Nested Routes）

Nuxt 支持通过嵌套目录结构来创建嵌套路由。

结构如下：

```bash showLineNumbers
pages/
└── users/
    ├── index.vue         # → /users
    └── [id].vue          # → /users/:id
```

或者更进一步嵌套：

```bash showLineNumbers
pages/
└── users/
    └── [id]/
        ├── index.vue     # → /users/:id
        └── profile.vue   # → /users/:id/profile
```



## 导航链接（`<NuxtLink>`）

Nuxt 提供了 `NuxtLink` 组件（类似 Vue Router 的 `<router-link>`）用于页面间导航：

```html showLineNumbers
<template>
  <nav>
    <NuxtLink to="/">首页</NuxtLink> |
    <NuxtLink to="/about">关于</NuxtLink>
  </nav>
</template>
```

你也可以使用编程式导航：

```tsx showLineNumbers
const router = useRouter()
router.push('/about')
```



## 404 页面

在 `pages/` 目录下新建 `error.vue` 文件，用于自定义 404 和错误页面：

```html showLineNumbers title="pages/error.vue"
<template>
  <div>
    <h1>页面未找到</h1>
    <p>{{ error.statusCode }} - {{ error.message }}</p>
  </div>
</template>

<script setup>
defineProps(['error'])
</script>
```



## 小结

- Nuxt 的路由基于 `pages/` 目录自动生成，无需手动配置；
- 支持静态页面、动态路由、嵌套路由；
- 使用 `<NuxtLink>` 实现路由跳转；
- 可自定义错误页面。

下一节将介绍 Nuxt 的布局系统（Layouts），进一步提升页面复用性与结构管理能力。
