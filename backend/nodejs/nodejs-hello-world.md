---
sidebar_position: 4
slug: /nodejs-hello-world
---

# 第一个 Node.js 示例



本文将带领大家编写一个 Node.js 的 Hello World 示例程序，它将在本地创建一个 HTTP 服务器，接收请求，并返回 HTML 页面数据。

[hello.js](https://github.com/getiot/nodejs-courses/tree/main/hello-world) 代码如下：

```javascript
const http = require('http');
const port = 3000;

http.createServer(function(request, response) {
    response.writeHead(200, {'Content-Type': 'text/html'});
    response.end('<h1>Hello, World</h1>');
}).listen(port);

console.log(`Server running at http://localhost:${port}/`);
```

代码说明：

- 首先使用 `require` 导入所需要的模块 `http`，并定义端口号 3000。然后在 3000 端口启动一个 HTTP 服务器。
- 第5行 `response.writeHead` 设置返回 HTTP 头部信息，状态码 200 表示请求成功，返回数据内容的类型为 text/html。
- 第6行 `response.end` 表示发送 HTML 文档内容，输出一个 H1 标题。
- 最后使用 JavaScript 的模板字面量打印提示信息。

在 Shell 终端执行 `node hello.js` 启动程序，如下：

```bash
$ node hello.js
Server running at http://localhost:3000/
```

在浏览器打开 [http://localhost:3000/](http://localhost:3000/) 即可看到 **Hello, World**。

