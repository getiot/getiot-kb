---
sidebar_position: 9
slug: /nodejs-express
---

# Node.js 后端框架 Express



Express 是 Node.js 生态中非常流行的一个后端框架，本文将演示如何使用 Express 开发一个简单的网站。



## Express 简介

Express.js 是一个快速、开放、极简的 Web 开发框架。从 Node.js 发布之初，Express 框架就存在了，至今已有十多年历史，是经历过时间考验的 Web 后端框架。开发者可以使用 Express 快速搭建一个具有完整功能的网站，而不仅仅是一个简单的网页。

简单来说，Express 框架本身是对 Node.js 中 HTTP 模块的进一步抽象和封装。这使得开发者可以不用关心 HTTP 的细节，直接上手进行页面和业务逻辑的开发。

- 项目官网：[https://expressjs.com](https://expressjs.com/)
- GitHub 地址：[expressjs/express](https://github.com/expressjs/express)

Express 的主要功能如下：

- 设置中间件来响应 HTTP 请求；
- 定义路由表执行不同的 HTTP 请求动作；
- 通过向模板传递参数动态渲染 HTML 页面。



## Express 示例

首先创建一个目录 express-demo，使用 `npm init` 初始化 Node.js 项目（参考 [Node 包管理器 npm](/nodejs/nodejs-npm/)）。如下：

```bash
mkdir express-demo
cd express-demo
npm init
```

执行 `npm init` 时需要填写一些项目信息，比如项目名称、版本、描述、作者等，如果暂时不想填写，可以一直按 Enter 键。执行完毕会生成一个 package.json 文件。

接着，我们还需要安装 Express，安装命令如下：

```bash
npm install express
```

现在，package.json 文件内容如下：

```json
{
  "name": "express-demo",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
    "express": "^4.17.2"
  }
}
```

默认的项目入口文件是 index.js，因此我们需要在 express-demo 目录下创建一个 index.js 文件。[Express 示例](https://github.com/getiot/nodejs-courses/tree/main/express-demo)代码如下：

```javascript
const express = require('express');

const app  = express();
const port = 3000;

// 设定根路由显示内容
app.get('/', (req, res) => res.send('Hello, Express!'));

// 监听端口
app.listen(port, () => console.log(`Example app listening on http://localhost:${port}`));
```

在 Shell 终端执行 `node index.js` 启动程序，如下：

```bash
$ node index.js 
Example app listening on http://localhost:3000
```

在浏览器打开 [http://localhost:3000/](http://localhost:3000/) 即可看到 **Hello, Express!**。



