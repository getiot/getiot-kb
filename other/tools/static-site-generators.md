---
sidebar_position: 21
slug: /static-site-generators
---

# 静态网站生成工具

静态网站生成工具（Static Site Generators，简称 SSGs），顾名思义，就是可以用来生成静态网站的工具。有了 SSGs 工具，无需掌握复杂的 HTML 和 CSS 技能，就可以迅速部署界面美观、功能强大的静态网站。

静态网站在功能上虽然无法与动态网站相比，但也是一种不错的内容管理方式，你可以将其打造成个人博客或个人知识库。当然，静态网站也支持多人协作。

本文介绍常见的开源静态网站生成器，包括：Jekyll、Hexo、Hugo、VuePress、MkDocs、Sphinx、Docsify、Astro 等等。排名不分先后，且持续更新。



## Jekyll

Jekyll 是用 [Ruby](https://www.ruby-lang.org/en/) 写的最受欢迎的开源静态生成工具之一。实际上，Jekyll 是 [GitHub 页面](https://pages.github.com/) 的引擎，它可以让你免费用 GitHub 托管网站。

你可以很轻松地跨平台配置 Jekyll，包括 Ubuntu。它利用 [Markdown](https://github.com/Shopify/liquid/wiki)、[Liquid](https://github.com/Shopify/liquid/wiki)（模板语言）、HTML 和 CSS 来生成静态的网页文件。如果你要搭建一个没有广告或推广自己工具或服务的产品页的博客网站，它是个不错的选择。

它还支持从常见的 CMS（内容管理系统Content management system）如 Ghost、WordPress、Drupal 7 迁移你的博客。你可以管理永久链接、类别、页面、文章，还可以自定义布局，这些功能都很强大。因此，即使你已经有了一个网站，如果你想转成静态网站，Jekyll 会是一个完美的解决方案。

- 项目官网：[https://jekyllrb.com](https://jekyllrb.com)
- GitHub 仓库：[https://github.com/jekyll/jekyll](https://github.com/jekyll/jekyll)



## Hexo

Hexo 是一个有趣的开源框架，基于 [Node.js](https://nodejs.org/en/)。像其他的工具一样，你可以用它搭建相当快速的网站，不仅如此，它还提供了丰富的主题和插件。

它还根据用户的每个需求提供了强大的 API 来扩展功能。如果你已经有一个网站，你可以用它的[迁移](https://hexo.io/api/migrator.html)扩展轻松完成迁移工作。

- 项目官网：[https://hexo.io](https://hexo.io)
- GitHub 仓库：[https://github.com/hexojs/hexo](https://github.com/hexojs/hexo)



## Hugo

Hugo 是另一个很受欢迎的用于搭建静态网站的开源框架。它是用 [Go 语言](https://golang.org/)写的。

它运行速度快、使用简单、可靠性高。如果你需要，它也可以提供更高级的主题。它还提供了一些有用的快捷方式来帮助你轻松完成任务。无论是组合展示网站还是博客网站，Hogo 都有能力管理大量的内容类型。

如果需要的话，你还可以将 Hugo 部署在 GitHub 页面或任何 CDN 上。

- 项目官网：[https://gohugo.io](https://gohugo.io)
- 官方文档：[https://gohugo.io/getting-started/](https://gohugo.io/getting-started/)
- GitHub 仓库：[https://github.com/gohugoio/hugo](https://github.com/gohugoio/hugo)



## Next.js

Next.js 在 StaticGen 上总排名第一位，足以说明它有多好用了。配置简单，服务端渲染，代码分离，SEO Friendly，内置零配置 TypeScript 支持等等优点。

而且世界一流的大厂们也都在用它做大型的网站，在 Next.js 的 [ShowCase](https://nextjs.org/showcase) 里面有腾讯、Uber、Hulu、Netlify、Nike 这些一流大厂。而且[腾讯新闻](https://xw.qq.com/)就是利用 Next.js 开发的。

这些都足以说明 Next.js 有多么的优秀！

不过，Next.js 是基于 React 框架开发的，所以你需要一些 React 的代码基础才能利用它搭建一个静态网站。

如果你是一个开发者的话，那么我强烈建议你试试用 Next.js 来搭建静态网站！

- 项目官网：[https://nextjs.org](https://nextjs.org)
- GitHub 仓库：[https://github.com/vercel/next.js](https://github.com/vercel/next.js)



## Gatsby

Gatsby 是一个越来越流行的开源网站生成框架。它使用 [React.js](https://reactjs.org/) 来生成快速、界面优美的网站。

几年前在一个实验性的项目中，我曾经非常想尝试一下这个工具，它提供的成千上万的新插件和主题的能力让我印象深刻。与其他静态网站生成工具不同的是，你可以使用 Gatsby 生成一个网站，并在不损失任何功能的情况下获得静态网站的好处。

它提供了与很多流行的服务的整合功能。当然，你可以不使用它的复杂的功能，或将其与你选择的流行 CMS 配合使用，这也会很有趣。

- 项目官网：[https://www.gatsbyjs.com](https://www.gatsbyjs.com)
- 官方文档：[https://www.gatsbyjs.com/docs/](https://www.gatsbyjs.com/docs/)
- GitHub 仓库：[https://github.com/gatsbyjs/gatsby](https://github.com/gatsbyjs/gatsby)



## VuePress

VuePress 是由 [Vue.js](https://vuejs.org/) 支持的静态网站生成工具，而 Vue.js 是一个开源的渐进式 JavaScript 框架。

如果你了解 HTML、CSS 和 JavaScript，那么你可以无压力地使用 VuePress。你应该可以找到几个有用的插件和主题来为你的网站建设开个头。此外，看起来 Vue.js 的更新一直很活跃，很多开发者都在关注 Vue.js，这是一件好事。

- 项目官网：[https://vuepress.vuejs.org](https://vuepress.vuejs.org)
- 官方文档：[https://vuepress.vuejs.org/guide/](https://vuepress.vuejs.org/guide/)
- GitHub 仓库：[https://github.com/vuejs/vuepress](https://github.com/vuejs/vuepress)



## Nuxt.js

Nuxt.js 使用了 Vue.js 和 Node.js，但它致力于模块化，并且有能力依赖服务端而非客户端。不仅如此，它的目标是为开发者提供直观的体验，并提供描述性错误，以及详细的文档等。

正如它声称的那样，在你用来搭建静态网站的所有工具中，Nuxt.js 可以做到功能和灵活性两全其美。他们还提供了一个 [Nuxt 线上沙盒](https://template.nuxtjs.org/)，让你不费吹灰之力就能直接测试它。

- 项目官网：[https://nuxtjs.org](https://nuxtjs.org)
- GitHub 仓库：[https://github.com/nuxt/nuxt.js](https://github.com/nuxt/nuxt.js)



## Docusaurus

Docusaurus 是一个有趣的开源静态网站生成工具，为搭建文档类网站量身定制。它还是 [Facebook 开源计划](https://opensource.facebook.com/)的一个项目。

Docusaurus 是用 React 构建的。你可以使用所有的基本功能，像文档版本管理、文档搜索和翻译大多是预先配置的。如果你想为你的产品或服务搭建一个文档网站，那么可以试试 Docusaurus。

- 项目官网：[https://docusaurus.io](https://docusaurus.io)
- 中文官网：[https://www.docusaurus.cn](https://www.docusaurus.cn)
- GitHub 仓库：[https://github.com/facebook/docusaurus](https://github.com/facebook/docusaurus)



## Eleventy

Eleventy 自称是 Jekyll 的替代品，旨在以更简单的方法来制作更快的静态网站。

它似乎很容易上手，而且它还提供了适当的文档来帮助你。如果你想找一个简单的静态网站生成工具，Eleventy 似乎会是一个有趣的选择。

- 项目官网：[https://www.11ty.dev](https://www.11ty.dev)
- GitHub 仓库：[https://github.com/11ty/eleventy](https://github.com/11ty/eleventy)



## Publii

Publii 是一个令人印象深刻的开源 CMS，它能使生成一个静态网站变得很容易。它是用 [Electron](https://www.electronjs.org/) 和 Vue.js 构建的。如果有需要，你也可以把你的文章从 WorkPress 网站迁移过来。此外，它还提供了与 GitHub 页面、Netlify 及其它类似服务的一键同步功能。

如果你利用 Publii 生成一个静态网站，你还可以得到一个所见即所得的编辑器。

- 项目官网：[https://getpublii.com](https://getpublii.com)
- GitHub 仓库：[https://github.com/GetPublii/Publii](https://github.com/GetPublii/Publii)



## Primo

Primo 是一个有趣的开源静态网站生成工具，目前开发工作仍很活跃。虽然与其他的静态生成工具相比，它还不是一个成熟的解决方案，有些功能还不完善，但它是一个独特的项目。

Primo 旨在使用可视化的构建器帮你构建和搭建网站，这样你就可以轻松编辑和部署到任意主机上。

- 项目官网：[https://primo.af](https://primo.af)
- GitHub 仓库：[https://github.com/primo-app/primo-desktop](https://github.com/primo-app/primo-desktop)



## MkDocs

MkDocs 是一个快速、简单、华丽的静态网站生成器，适用于构建项目文档。文档源文件以 Markdown 编写，并使用一个 YAML 文件来进行配置。MkDocs 生成完全静态的 HTML 网站，你可以将其部署到 GitHub pages、Amzzon S3 或你自己服务器上。

- 项目官网：[https://www.mkdocs.org](https://www.mkdocs.org)
- 中文文档：[https://markdown-docs-zh.readthedocs.io](https://markdown-docs-zh.readthedocs.io)
- GitHub 仓库：[https://github.com/mkdocs/mkdocs](https://github.com/mkdocs/mkdocs)



## Sphinx

Sphinx 是 Python 社区编写和使用的文档生成器。虽然它是用 Python 编写的，但是你可以将它用在其他环境。许多软件项目的文档都是采用 Sphinx 管理的，并且托管在 [readthedocs.org](https://readthedocs.org) 平台。

Sphinx 将一组 reStructuredText 源文件转换为各种输出格式，自动生成交叉引用、索引等，生成一个组织良好的、便于浏览和导航的 HTML 文件排列。另外，可以通过安装插件来支持 Markdown 语法。

- 项目官网：[https://www.sphinx-doc.org](https://www.sphinx-doc.org)
- 中文文档：[https://www.sphinx.org.cn](https://www.sphinx.org.cn)



## Docsify

Docsify 是一个动态生成文档网站的工具。不同于 GitBook、Hexo 的地方是它不会生成将 .md 转成 .html 文件，所有转换工作都是在运行时进行。

这将非常实用，如果只是需要快速的搭建一个小型的文档网站，或者不想因为生成的一堆 .html 文件“污染” commit 记录，只需要创建一个 index.html 就可以开始写文档而且直接部署在 GitHub Pages。

- 项目官网：[https://docsify.js.org](https://docsify.js.org)
- 中文文档：[https://docsify.js.org/#/zh-cn/](https://docsify.js.org/#/zh-cn/)



## Astro

Astro 是一个集多功能于一体的 Web 框架，它内置包含了你构建网站所需的一切。Astro 最早只是一个基于 JavaScript 语言的静态网站生成器，后来扩展到可以构建性能强大的动态 Web 应用程序。不变的是，Astro 一直专注于内容网站的构建。像博客、营销网站、电子商务网站这样的以内容驱动的网站，都可以使用 Astro 框架进行构建。

和其他大多数 SSG 框架不同，Astro 开创了一种新的前端架构 —— Islands（岛屿）。因此，Astro 与其他框架相比它减少了 JavaScript 的开销和复杂性。如果你需要一个加载速度快、具有良好 SEO 的网站，那么 Astro 就是你的选择。

- 项目官网：[https://astro.build](https://astro.build)
- 项目文档：[https://docs.astro.build](https://docs.astro.build)
- GitHub 仓库：[https://github.com/withastro/astro](https://github.com/withastro/astro)



## 参考

- [10 大静态网站生成工具 - Linux 中国](https://linux.cn/article-12671-1.html)
- [推荐3个超级好用的静态网站生成器：静态是一种新的动态](https://www.wanghuiblog.com/post/static-webiste-generator/)