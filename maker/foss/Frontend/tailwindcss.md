---
sidebar_position: 4
sidebar_label: Tailwind CSS
slug: /tailwind
---

# Tailwind CSS

**Tailwind CSS** 是一个开源的实用类优先（Utility-First）的 CSS 框架，由 Tailwind Labs 于 2019 年发布。与传统的 CSS 框架（如 [Bootstrap](https://getbootstrap.com)）不同，Tailwind CSS 不提供预定义的组件，而是提供一系列原子化的 CSS 类，允许开发者直接在 HTML 中组合这些类来构建自定义的用户界面。

Tailwind CSS 的核心理念是通过提供低层级的样式工具，使开发者能够快速、灵活地构建完全定制化的设计，而无需离开 HTML。



## 主要特点

- **实用类优先**：Tailwind CSS 提供了大量的实用类，每个类对应一个特定的样式属性，如 `text-center`（文本居中）、`p-4`（内边距 1rem）、`bg-blue-500`（背景色）。开发者可以通过组合这些类来构建复杂的界面，而无需编写自定义 CSS。
- **高度可定制**：通过配置文件 `tailwind.config.js`，开发者可以自定义颜色、字体、间距、断点等，甚至可以扩展新的实用类，以满足项目的特定需求。
- **响应式设计**：Tailwind CSS 内置了响应式断点（如 `sm`、`md`、`lg`、`xl`、`2xl`），允许开发者使用类似 `md:text-lg` 的类名来为不同屏幕尺寸设置样式，从而轻松实现响应式布局。
- **状态变体支持**：支持多种状态变体，如 `hover:`、`focus:`、`active:`、`disabled:` 等，开发者可以使用这些前缀来定义元素在不同状态下的样式，例如 `hover:bg-blue-700`。
- **Just-in-Time（JIT）编译**：从 3.x 版本开始，Tailwind CSS 默认启用了 JIT 模式，实时根据项目中使用的类生成 CSS，显著减少了最终 CSS 文件的体积，并支持使用任意值的类名，如 `pt-[19.5px]`、`text-[#123456]`。
- **丰富的生态系统**：Tailwind CSS 拥有活跃的社区和丰富的生态系统，包括官方的 UI 组件库 [Tailwind UI](https://tailwindui.com/)、开源组件库 [HyperUI](https://www.hyperui.dev/)、[Flowbite](https://flowbite.com/) 等，帮助开发者快速构建美观的界面。



## 应用场景

- **快速原型设计**：Tailwind CSS 的实用类设计使得开发者可以快速搭建页面原型，验证设计理念。
- **定制化项目开发**：适用于需要高度定制化样式的项目，避免使用预定义组件带来的限制。
- **响应式 Web 应用**：内置的响应式断点和状态变体支持，使得开发响应式 Web 应用变得更加简单高效。
- **与现代前端框架集成**：Tailwind CSS 可以与 React、Vue、Angular 等现代前端框架无缝集成，提升开发效率。



## 使用示例

Tailwind CSS 是一个实用类优先的 CSS 框架，允许您直接在 HTML 中使用类名来快速构建界面。下面是一个简单的按钮示例：

```html showLineNumbers title="index.html"
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Tailwind CSS 示例</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body class="flex items-center justify-center h-screen bg-gray-100">
    <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
      点击我
    </button>
  </body>
</html>
```

在这个示例中，首先加载 Tailwind CSS 的 Play CDN，这样你就能够在 HTML 文件中直接使用 Tailwind 的实用类（utility classes）来快速构建界面，而无需进行任何构建步骤。接着添加一个 button 按钮，使用 Tailwind CSS 提供的实用类，实现设置背景色、悬停效果、字体样式、内边距和圆角等样式。



## 相关链接

- 官方网站：[https://tailwindcss.com](https://tailwindcss.com)
- GitHub 仓库：[https://github.com/tailwindlabs/tailwindcss](https://github.com/tailwindlabs/tailwindcss)
- 官方文档：[https://tailwindcss.com/docs](https://tailwindcss.com/docs)
- 在线演示平台：[https://play.tailwindcss.com](https://play.tailwindcss.com)
