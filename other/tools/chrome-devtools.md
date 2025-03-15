---
sidebar_position: 35
slug: /chrome-devtools
---

# Chrome 开发者工具



在 Chrome 浏览器中按 `F12` 即可进入 Chrome 开发者工具，如果是 macOS 用户，则使用 `option` + `command` + `i` 组合键。

Chrome 开发者工具窗口如下：

![Chrome 开发者工具](https://static.getiot.tech/chrome-devtools.png#center)

Chrome 开发者工具中有多个不同的选项，不同的浏览器选项有所不同，但都有一些通用的选项。

- **Elements 选项**：查看当前页面的元素，最左侧的元素（DOM）按钮可以选择网页中的节点，然后在右侧的样式面板中可以修改该节点的一些属性、样式和代码，这些修改均会及时显示在页面中。
- **Console 选项**：用来调试 JavaScript，JavaScript 输出的所有内容（包括 `console.log()` 的输出）和报错信息都在该窗口中显示。不仅如此，在该选项卡的最下方可以执行任意的 JavaScript 代码。
- **Network 选项**：执行当前页面的监听任务，所有的请求将会出现在该选项的界面中，包括静态文件的请求、动态接口、AJAX 等异步请求（包含每次的请求头部、请求体及最终的返回内容）。如果进行翻页、刷新、重定向（30X系列重定向等）处理，会主动刷新页面。
- **Sources 选项**：查看网页的源代码，可以调试和更改 JavaScript、CSS 及图片等文件，支持断点操作和静态资源预览。不仅如此，在该选项的界面中可以查看 JavaScript 代码执行过程中中间变量的值。
- **Application 选项**：查看网页中的缓存和 Cookie。在左侧的节点选择面板中可以打开相应的内容，选择节点后在右侧可以进行该节点的删除或修改操作，这个操作可以更改 Cookie 或 HTML 5 中的缓存值。

