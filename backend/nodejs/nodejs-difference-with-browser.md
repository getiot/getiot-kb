---
sidebar_position: 10
slug: /nodejs-difference-with-browser
---

# Node.js 与浏览器的区别



虽然 Node.js 和浏览器都使用 JavaScript 作为其编程语言。不过，构建运行于浏览器中的应用程序与构建 Node.js 应用程序完全不同。尤其是一些关键的差异，使两者的开发体验相当不同。

大致来说，Node.js 与浏览器的区别有以下几点：

- 在浏览器中，大多数时候做的是与 DOM 或其他 Web 平台 API（例如 Cookies）进行交互。而这些东西在 Node.js 中是不存在的，它没有浏览器提供的 `document` 和 `window`，以及所有其他的对象。
- 同样，在浏览器中也不存在 Node.js 通过其模块提供的所有不错的 API，例如文件系统访问功能。
- 在 Node.js 中，可以控制运行环境。除非构建的是任何人都可以在任何地方部署的开源应用程序，否则你能知道会在哪个版本的 Node.js 上运行该应用程序。与浏览器环境（你无法选择访客会使用的浏览器）相比起来，这非常方便。这意味着，可以编写 Node.js 版本支持的所有现代的 ES6-7-8-9 JavaScript。由于 JavaScript 发展的速度非常快，但是浏览器发展得慢一些，并且用户的升级速度也慢一些，因此有时在 web 上，不得不使用较旧的 JavaScript / ECMAScript 版本。
- 可以使用 Babel 将代码转换为与 ES5 兼容的代码，再交付给浏览器，但是在 Node.js 中，则不需要这样做。
- 引入外部模块时，在 Node.js 中使用 `require()` 方式，而在浏览器中则使用 `import` 方式。前者属于 CommonJS 规范，后者属于 ES6 语法。

