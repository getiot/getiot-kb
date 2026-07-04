---
sidebar_position: 36
slug: /go-web-frameworks
---

# Go 语言 Web 框架

本文收集并介绍一些常用的 Golang Web 框架，包括 gin、beego、echo、kit、fasthttp、fiber、go-zero 等等。



## gin

Gin 是一个用 Go 语言编写的 HTTP Web 框架。因其极简的框架和出色性能而被广泛使用，可以说是开发高性能 REST API 的最合适的 Golang 框架。如果你想要使用前端框架开发单页应用程序，那么可以使用 gin 为后端构建 REST API。gin 框架利用 HTTP 路由器来处理 Golang 流量，并且提供了丰富的文档，非常适合初学者。

Gin 框架的 API 与 martini 类似，但速度比它快近 40 倍！至于缺点的话，gin 最大的缺点就是不适合开发大型后端应用程序或企业级服务器复杂的功能。

GitHub 仓库：[https://github.com/gin-gonic/gin](https://github.com/gin-gonic/gin)



## beego

Beego 框架用于在 Golang 中快速开发 REST API、Web 应用程序和后端服务。它通常被视为类似于 Python 中的 Django Web 框架，并且包含 Golang 的特定功能，例如接口和结构嵌入。beego 是一个成熟的模型-视图-控制器（MVC）框架，不依赖于任何第三方库，它拥有自己的库和一个有助于查找代码更改的内置工具，称为 Bee Tool。

Beego 唯一的缺点是，由于它的功能太高、功能太广泛，所以不太适合初学者。

GitHub 仓库：[https://github.com/beego/beego](https://github.com/beego/beego)



## echo

echo 是 Golang 中另一个高性能、可扩展、极简的 Web 框架。它具有高度优化的 HTTP 路由器，动态内存分配为零，可以智能地确定路由的优先级。可用于构建强大且可扩展的 REST API，可以轻松地将其组织成组。它会自动安装来自 Let’s Encrypt 的 TLS 证书，并提供 HTTP/2 支持，从而提高速度并提供更好的用户体验。它还包含许多可供使用的内置中间件，开发人员甚至可以定义自己的中间件，可以在根、组或路由级别进行设置。

echo 支持 HTTP 请求负载的数据绑定，包括 JSON、XML 或表单数据。对于数据呈现，它包含一个用于发送各种 HTTP 响应的 API，包括 JSON、XML、HTML、文件和附件。模板可以使用任何模板引擎呈现，并具有自定义的中央 HTTP 错误处理。

使用 echo 框架的缺点是它仅由单个开发人员维护，代码更新频率较低。

GitHub 仓库：[https://github.com/labstack/echo](https://github.com/labstack/echo)



## go-kit 

go-kit 是用于在 Go 中构建微服务的编程工具包。它解决了分布式系统和应用程序体系结构中的常见问题，使得开发者可以专注于交付业务价值。

kit 框架提供了远程过程调用（RPC）安全性、系统可观察性和基础设施集成。它由多个相互关联的包组成，这些包共同形成了一个用于构建大型面向服务架构（SOA）的固定框架，并使 Golang 成为在任何组织中编写微服务的一流语言。它是为互操作性而设计的，开发人员可以自由选择最适合他们的数据库、组件、平台和架构。

使用 go-kit 的缺点是，由于其大量使用接口，使得向服务添加 API 的开销比较高。

GitHub 仓库：[https://github.com/go-kit/kit](https://github.com/go-kit/kit)



## fasthttp

Fasthttp 框架提供了快速的 HTTP 服务器和客户端 API，由于其优化机会的限制，该 API 被作为 net/http 的替代方案。fasthttp 针对速度进行了优化，可以在现代硬件上轻松处理超过 100K qps 和超过 1M 的并发保持连接。它还针对低内存使用量进行了优化，并通过 `RequestCtx.Hijack` 提供轻松的连接升级支持。

Fasthttp API 的设计能够扩展现有的客户端和服务器实现或从头开始编写自定义客户端和服务器实现。许多额外的有用信息都会暴露给请求处理程序，例如服务器和客户端地址、每个请求记录器、唯一的请求 ID 等。

由于 net/http 拥有更广泛的受众，因此它更可靠且经过测试。此外，由于 net/http 和 fasthttp 不兼容，开发人员常常发现很难从 net/http 迁移到 fasthttp。

GitHub 仓库：[https://github.com/valyala/fasthttp](https://github.com/valyala/fasthttp)



## fiber

Fiber 是一个受到 [Express](https://github.com/expressjs/express) 启发的 Web 框架，基于使用 Go 语言编写的最快的 HTTP 引擎 [Fasthttp](https://github.com/valyala/fasthttp) 构建。旨在通过零内存分配和高性能服务，使快速开发更加简便。

Fiber 提供了一个快速、简单且有效的方式来构建 Web 应用程序，它抽象了很多底层细节，允许开发者以极简的方法构建应用，同时保持了高性能。Fiber 被设计成易于上手，其 API 直观易用，这使得迁移现有的 Node.js（Express）项目变得非常简单。

GitHub 仓库：[https://github.com/gofiber/fiber](https://github.com/gofiber/fiber)



## go-zero

go-zero 是一个集成了各种工程实践的 Web 和 RPC 框架。通过弹性设计保障了大并发服务端的稳定性，经受了充分的实战检验。

go-zero 包含极简的 API 定义和生成工具 `goctl`，可以根据定义的 API 文件一键生成 Go、iOS、Android、Kotlin、Dart、TypeScript、JavaScript 代码，并可直接运行。

GitHub 仓库：[https://github.com/zeromicro/go-zero](https://github.com/zeromicro/go-zero)



## 更多

[Top Go Web Frameworks](https://github.com/mingrammer/go-web-framework-stars) 项目收集了许多 Go 语言相关的 Web 框架，可自行了解。
