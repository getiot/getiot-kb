---
sidebar_position: 0
sidebar_label: Web 开发路线
slug: /ruby-web-intro
---

# Ruby Web 开发路线

Ruby Web 开发最著名的是 Ruby on Rails，但 Rails 不是唯一入口。对初学者来说，更稳的路线是先理解 Web 请求和响应，再学习 Rack、Sinatra，最后进入 Rails。

## 一个 Web 请求发生了什么

当你在浏览器访问一个页面时，大致过程是：

```text
浏览器发送 HTTP 请求
        ↓
Web Server 接收请求
        ↓
Ruby 应用处理请求
        ↓
Ruby 应用返回 HTTP 响应
        ↓
浏览器显示结果
```

Ruby Web 框架的工作，就是帮助你把请求映射到代码，并生成响应。

## Ruby Web 生态的层次

Rack：Ruby Web 应用和 Web Server 之间的基础接口。

Sinatra：轻量框架，适合小应用、内部工具、简单 API。

Rails：全功能框架，适合数据库驱动的复杂 Web 应用。

## 为什么不直接学 Rails

你当然可以直接学 Rails，但 Rails 一次性提供了太多东西：路由、控制器、视图、数据库、迁移、表单、测试、生成器。如果你没有 Web 基础，很容易只会照着命令跑，不理解发生了什么。

先理解 Rack 和 Sinatra，会让你更清楚：

- 路由是什么。
- 参数从哪里来。
- 响应如何返回。
- 框架替你做了哪些事。

## 学习建议

你可以按这个顺序学习：

1. 用 Rack 看清最小 Web 应用接口。
2. 用 Sinatra 写几个路由。
3. 理解 Rails MVC。
4. 学习 Rails 路由、控制器和视图。
5. 学习 Active Record 和数据库迁移。
6. 学习 RESTful API。

## 小结

Ruby Web 学习不要只背框架命令。你要先理解 HTTP 请求和响应，再看框架如何组织代码。

