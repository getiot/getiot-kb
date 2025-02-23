---
sidebar_position: 2
---

# jQuery 安装



## 下载 jQuery

有两个版本的 jQuery 可供下载：

- Production version - 用于实际的网站中，已被精简和压缩。
- Development version - 用于测试和开发（未压缩，是可读的代码）

这两个版本都可以从 [jquery.com](https://jquery.com/download/) 下载。

**提示**：你可以把下载文件放到与页面相同的目录中，这样更方便使用和调试。



## 将 jQuery 添加到网页

如需使用 jQuery，你需要下载 jQuery 库（会在下面为你讲解），然后把它包含在希望使用的网页中。

jQuery 库是一个 JavaScript 文件，你可以使用 HTML 的 `<script>` 标签引用它，如下：

```html
<head>
<script src="jquery.js"></script>
</head>
```

请注意，`<script>` 标签应该位于页面的 `<head>` 部分。

**提示**：你是否很疑惑为什么我们没有在 `<script>` 标签中使用 `type="text/javascript"` ？

在 HTML5 中，不必那样做了。JavaScript 是 HTML5 以及所有现代浏览器中的默认脚本语言！



## 通过 CDN 下载

如果你不希望下载并存放 jQuery，那么也可以通过 CDN（内容分发网络） 引用它。谷歌和微软的服务器都存有 jQuery，下面将详细介绍如何从谷歌或微软引用 jQuery。

### Google CDN

```html
<head>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js">
</script>
</head>
```

**提示：**通过 Google CDN 来获得最新可用的版本：

如果你观察上什么的 Google URL - 在 URL 中规定了 jQuery 版本 (1.8.0)。如果你希望使用最新版本的 jQuery，也可以从版本字符串的末尾（比如本例 1.8）删除一个数字，谷歌会返回 1.8 系列中最新的可用版本（1.8.0、1.8.1 等等），或者也可以只剩第一个数字，那么谷歌会返回 1 系列中最新的可用版本（从 1.1.0 到 1.9.9）。

### Microsoft CDN

```html
<head>
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.0.js">
</script>
</head>
```


提示：使用谷歌或微软的 jQuery，有一个很大的优势：

许多用户在访问其他站点时，已经从谷歌或微软加载过 jQuery。所有结果是，当他们访问你的站点时，会从缓存中加载 jQuery，这样可以减少加载时间。同时，大多数 CDN 都可以确保当用户向其请求文件时，会从离用户最近的服务器上返回响应，这样也可以提高加载速度。



## npm/Yarn 安装

jQuery 在 [npm](https://www.npmjs.com/) 上注册为一个软件包，因此，你可以使用 npm CLI 命令安装最新版本的 jQuery。如下：

```bash
npm install jquery
```

作为替代方案，你也可以使用 [Yarn](https://github.com/yarnpkg/yarn) CLI 命令：

```bash
yarn add jquery
```

这将在 `node_modules` 目录中安装 jQuery。 在 `node_modules/jquery/dist/` 中，你会找到一个未压缩版本、一个压缩版本和一个映射文件。

